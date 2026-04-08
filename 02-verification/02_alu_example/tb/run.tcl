set_fml_appmode DPV

proc compile_spec {} { 
  create_design -name spec -top DPV_wrapper 
  cppan -I. ../cpp/alu.cpp  
  compile_design spec  
} 

proc compile_impl {} { 
  create_design -name impl -top alu -clock clk -reset reset  
  vcs -sverilog ../rtl/multiplier.sv ../rtl/alu.sv 
  compile_design impl 
}

proc global_assumes {} { 
  map_by_name -inputs -specphase 1 -implphase 1 

  # Assume that all ALU operations are valid except multiplication.
  assume command_range = spec.command(1) < 6
  # assume command_range = spec.command(1) < 6 || (spec.command(1) == 6 && spec.size(1) == 0)
}

proc ual {} {
    global_assumes

    # Test if the result is correct when data is valid and the ALU is performing a 16-bit operation.
    lemma result_equal_small = impl.valid(1) && impl.size(1) == 0 -> impl.result(3)[15:0] == spec.result(1)[15:0] 

    # Test if the result is correct when data is valid and the ALU is performing a 32-bit operation.
    lemma result_equal_big = impl.valid(1) && impl.size(1) == 1  -> impl.result(3) == spec.result(1) 

    # Test if the signal flags are correct when data is valid.
    lemma signal_equal = impl.valid(1) -> impl.signal(3)[1:0] == spec.signal(1)[1:0] 
} 
 
set_user_assumes_lemmas_procedure "ual"
compile_spec
compile_impl
compose
solveNB P1
proofwait
listproof