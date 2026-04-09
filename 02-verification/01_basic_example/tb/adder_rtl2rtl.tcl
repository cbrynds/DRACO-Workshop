set_fml_appmode DPV

set N 32
set SPEC_NAME "adder_behavioral"
set IMPL_NAME "adder"

proc compile_spec {} {
    global N SPEC_NAME
    create_design -name spec -top ${SPEC_NAME}
    vcs -sverilog -pvalue+N=${N} "../rtl/${SPEC_NAME}.sv"
    compile_design spec
}

proc compile_impl {} {
    global N IMPL_NAME
    create_design -name impl -top ${IMPL_NAME}
    vcs -sverilog -pvalue+N=${N} "../rtl/${IMPL_NAME}.sv"
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

