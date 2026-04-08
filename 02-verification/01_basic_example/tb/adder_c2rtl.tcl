set_fml_appmode DPV

set N 32
set SPEC_NAME "adder"
set IMPL_NAME "adder"

proc compile_spec {} { 
    global SPEC_NAME
    create_design -name spec -top DPV_wrapper -cov 
    cppan -I. "../cpp/${SPEC_NAME}.cpp"
    compile_design spec  
}

proc compile_impl {} {
    global N
    create_design -name impl -top adder
    vcs -sverilog -pvalue+N=${N} "../rtl/adder.sv"
    compile_design impl
}

proc make {} { 
    if {[compile_spec] == 0} { 
        puts "Failure in compiling the specification model." 
    } 
    if {[compile_impl] == 0} { 
        puts "Failure in compiling the implementation model." 
    } 
    if {[compose] == 0} { 
        puts "Failure in composing the design." 
    } 
}

proc global_assumes {} {
    global N

    map_by_name -inputs -specphase 1 -implphase 1
    map_by_name -outputs -specphase 1 -implphase 1

    assume spec.x(1) < (1 << ${N})
    assume spec.y(1) < (1 << ${N})
    assume spec.cin(1) < 2
}

proc ual {} {
    global_assumes
}

proc run_main {} {
    set_user_assumes_lemmas_procedure "ual"

    solveNB P1
    proofwait
    listproof
}

make
run_main

