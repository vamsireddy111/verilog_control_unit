# Control Unit (Mealy) – README
# Overview

The Control Unit is the brain of the processor. It decodes the instruction opcode and generates the required control signals to coordinate all components such as:

ALU
Register File
Data Memory
Program Counter

This design uses a Mealy-style Control Unit, where outputs depend on both:

Current inputs (opcode, flags)
Current state (if applicable)

# Objective

To design a Control Unit that:

Decodes opcode
Generates control signals
Drives datapath components efficiently

# Inputs & Outputs
 Inputs
opcode [2:0] → Operation type
zero → Flag from ALU (used for branching)
 Outputs
alu_op [2:0] → ALU operation select
reg_write → Enable register write
mem_read → Enable memory read
mem_write → Enable memory write
branch → Branch control signal

# Supported Instructions (Example ISA)
Opcode	Instruction	Operation
000	ADD	A + B
001	SUB	A - B
010	AND	A & B
011	OR	A | B
100	LOAD	Read from memory
101	STORE	Write to memory
110	BEQ	Branch if zero

# Working Principle
Instruction is fetched from Instruction Memory
Opcode is sent to Control Unit
Control Unit decodes opcode
Corresponding control signals are generated instantly
ALU / Memory / Registers act accordingly

# Why We Chose Mealy ✅
1) Faster Response

 Outputs change immediately when opcode changes

opcode → control signal (instant)

 No need to wait for next clock cycle
 Faster execution

2) Better for RISC Design

RISC processors aim for:

Simple instructions
Fast execution
Minimal cycles

 Mealy helps achieve:
 Faster decoding
 Reduced latency

 # Conclusion
This Control Unit:

Uses Mealy architecture for speed and efficiency
Directly maps opcode to control signals
Enables fast execution in RISC datapath
