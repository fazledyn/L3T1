instruction_count = 1
label_dictionary = {}

temp_input_file = open("TempInput.txt",'w')
with open('instructions.asm') as input_file:
    for line in input_file:
        splitted = line.split()
        if splitted[0] == "push":
            if len(splitted[1]) == 3:       #push register_name
                temp_input_file.write("sw " + splitted[1] + ", 0($sp)\n")
                temp_input_file.write("subi" + " $sp, $sp, 1\n")
            else:
                temp_input_file.write("lw $t5, " + splitted[1]  + "\n")      #temporary register $t5
                temp_input_file.write("sw " + "$t5, 0($sp)\n" )
                temp_input_file.write("subi" + " $sp, $sp, 1\n")
        elif splitted[0] == "pop":          #pop register_name
            temp_input_file.write("addi $sp, $sp, 1\n")
            temp_input_file.write("lw " + splitted[1] + ", 0($sp)\n")
        else:
            temp_input_file.write(line)

    temp_input_file.close()

with open('TempInput.txt') as input_file:
    for line in input_file:
        if line[-2:] == ':\n':
            label_name = line[0:-2]
            label_dictionary[label_name] = instruction_count
        else:
            instruction_count = instruction_count + 1

instruction_count = instruction_count - 1

current_instruction_count = 0

output_file = open("MachineCodes.bin",'w')
output_file.write("v2.0 raw\n")

def operand_checking(operand):
    if operand == "$zero,":
        output_file.write("7")
    elif operand == "$sp," or operand == "$sp)":
        output_file.write("6")
    else:
        third_character = operand[2]
        output_file.write(third_character)

def constant_print(constant,bit_length):
    decimal = int(constant)
    if decimal < 16 and bit_length == 8:
        output_file.write("0")
    hexa = hex(decimal)
    hex_string = str(hexa)
    output_file.write(hex_string[2:])

def tohex(val, nbits):
    hexa = hex((val + (1 << nbits)) % (1 << nbits))
    hex_string = str(hexa)
    trimmed_hex_string = hex_string[2:]
    if len(trimmed_hex_string) == 1:
        output_file.write("0")
    output_file.write(trimmed_hex_string)


with open('TempInput.txt') as input_file:
    for line in input_file:
        splitted = line.split()
        opcode = splitted[0]
        if opcode == "add":    #R type instruction
            output_file.write("1")
            operand_checking(splitted[2])
            operand_checking(splitted[3])
            operand_checking(splitted[1])
            output_file.write("0")
            output_file.write("\n")
        elif opcode == "addi":      #I type instruction
            output_file.write("3")
            operand_checking(splitted[2])
            operand_checking(splitted[1])
            constant_print(splitted[3], 8)
            output_file.write("\n")
        elif opcode == "sub":           #R type instruction
            output_file.write("c")
            operand_checking(splitted[2])
            operand_checking(splitted[3])
            operand_checking(splitted[1])
            output_file.write("0")
            output_file.write("\n")
        elif opcode == "subi":          #I type instruction
            output_file.write("b")
            operand_checking(splitted[2])
            operand_checking(splitted[1])
            constant_print(splitted[3], 8)
            output_file.write("\n")
        elif opcode == "and":           #R type instruction
            output_file.write("e")
            operand_checking(splitted[2])
            operand_checking(splitted[3])
            operand_checking(splitted[1])
            output_file.write("0")
            output_file.write("\n")
        elif opcode == "andi":            #I type instruction
            output_file.write("7")
            operand_checking(splitted[2])
            operand_checking(splitted[1])
            constant_print(splitted[3], 8)
            output_file.write("\n")
        elif opcode == "or":        #R type instruction
            output_file.write("2")
            operand_checking(splitted[2])
            operand_checking(splitted[3])
            operand_checking(splitted[1])
            output_file.write("0")
            output_file.write("\n")
        elif opcode == "ori":       #I type instruction
            output_file.write("d")
            operand_checking(splitted[2])
            operand_checking(splitted[1])
            constant_print(splitted[3], 8)
            output_file.write("\n")
        elif opcode == "sll":       #R type instruction
            output_file.write("5")
            output_file.write("0")
            operand_checking(splitted[2])
            operand_checking(splitted[1])
            constant_print(splitted[3],4)
            output_file.write("\n")
        elif opcode == "srl":       #R type instruction
            output_file.write("9")
            output_file.write("0")
            operand_checking(splitted[2])
            operand_checking(splitted[1])
            constant_print(splitted[3], 4)
            output_file.write("\n")
        elif opcode == "nor":           #R type instruction
            output_file.write("0")
            operand_checking(splitted[2])
            operand_checking(splitted[3])
            operand_checking(splitted[1])
            output_file.write("0")
            output_file.write("\n")
        elif opcode == "sw":                #I type instruction
            output_file.write("4")
            base = splitted[2].split('(')
            operand_checking(base[1])
            operand_checking(splitted[1])
            constant_print(base[0], 8)
            output_file.write("\n")
        elif opcode == "lw":            #I type instruction
            output_file.write("a")
            base = splitted[2].split('(')
            operand_checking(base[1])
            operand_checking(splitted[1])
            constant_print(base[0], 8)
            output_file.write("\n")
        elif opcode == "beq":           #I type instruction
            output_file.write("8")
            operand_checking(splitted[1])
            operand_checking(splitted[2])
            target_instruction_count = label_dictionary[splitted[3]]
            address = target_instruction_count - current_instruction_count - 2
            tohex(address,8)
            output_file.write("\n")
        elif opcode == "bneq":           #I type instruction
            output_file.write("f")
            operand_checking(splitted[1])
            operand_checking(splitted[2])
            target_instruction_count = label_dictionary[splitted[3]]
            address = target_instruction_count - current_instruction_count - 2
            tohex(address, 8)
            output_file.write("\n")
        elif opcode == "j":              #J type instruction
            output_file.write("6")
            decimal_ins = label_dictionary[splitted[1]]
            constant_print(decimal_ins,8)
            output_file.write("0")
            output_file.write("0")
            output_file.write("\n")

        if line[-2:] != ':\n':
           current_instruction_count = current_instruction_count + 1













