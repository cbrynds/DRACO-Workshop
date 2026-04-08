TEMPLATE = "rtl/lsor_case_statement_template.sv"
DESIGN = "rtl/lsor_case_statement.sv"

def rom_generator(N):
    cases = []

    for i in range(N):
        x = ""
        x += ((N-1-i) * "?")
        x += ("1" if (i < (N-1)) else "?")
        x += ("0" * i)
        print(x)

        output = ("{x[" + f"{N-1}:{i+1}],{i+1}'b0" + "}") if (i < (N-1)) else (f"{N}'b0")
        line = f"\t\t\t{N}'b{x}: x_no_lso = " + f"{output};\n"
        cases.append(line)
        print(line)

    with open(TEMPLATE, 'r') as f:
        content = f.read()
    
    cases_str = ''.join(cases)
    content = content.replace('%CASES', cases_str)
    content = content.replace('%N', str(N))
    
    with open(DESIGN, 'w') as out:
        out.write(content)
    
rom_generator(32)