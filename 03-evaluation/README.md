# Digital Design Workshop 3: Evaluation

In this workshop, we will physically implement the four designs for our LSOR specification and compare the power, performance, and area implications of each design.

## Instructions

### Design Setup

1. Set the default parameter of each module to N=32 in order to synthesize a 32b design. It is important that the top module name matches the name of the file in which it is located. If you did not have the chance to implement each design, you may use the design files provided under `01-design/rtl`.

### Copy Designs
2. Copy the RTL files of each LSOR design into `synthesis_32b/<design_name>/data/rtl` 

### Launch the Tool
3. Navigate inside the copied directory and run

`rtl_shell -f pareto_synthesis.tcl -x "set DESIGN_NAME <top module name>"`

This will launch the RTL Architect tool and begin pareto curve generation. The script will exit RTLA automatically once complete.

**Note**: By default, this script is configured to read in SystemVerilog files. Change line 18 of `scripts/run_synthesis.tcl` if you are synthesizing Verilog or VHDL files, or change the design syntax to SystemVerilog.

**Note**: Synthesis runs may take some time to complete. To run RTLA in a persistent terminal in case the SSH session gets disconnected, use the `tmux` command. 

`tmux new -s <session name>`

### Plot Results
4. After synthesis completes, generate area-delay and power-delay curves using the command

```bash
python plot_results.py \
  -i synthesis_32b \
  -d designs.yaml \
  -o plots \
  -t "LSOR Designs (32b)" -r
```

This will produce two plots and a JSON file with the PPA information from each synthesis run.

### Repeat for 64b

5. Repeat instructions 1-4 for synthesizing the 64b LSOR designs.