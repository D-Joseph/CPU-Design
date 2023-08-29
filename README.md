# CPU-Design
Designing a simple RISC-V CPU in Verilog.
# 1 Project Specifications
The project aims to design and develop a simple RISC computer including a RISC-style processor,
memory access, and I/O capabilities. The system was written in Verilog, designed in Quartus
II (Intel’s FPGA design software), tested through the hardware simulation software ModelSim,
and finally flashed onto the Cyclone chip of the DE0 board. The project was divided into four
phases, each adding additional functionality to the computer. The goal of the first phase was to
begin developing the computer’s datapath, and this was done using general-purpose registers, a
bidirectional bus, a memory data register (MDR), and a memory access register (MAR). Phase 1
also asked to develop an arithmetic logic unit (ALU), with basic functions including multiplication,
addition, shifting, etc. Phase 2 of the project introduced further functionality to the datapath with
a memory subsystem (the connection between the RAM, MDR and MAR), select and encode logic
(determines which instruction should execute), conditional branching logic, and I/O ports. In Phase
3 the control unit was developed. The control unit is at the heart of the processor, and its function
is to fetch instructions from memory and generate control signals as needed to ensure successful
execution. Finally, Phase 4’s main purpose was to move the program onto the board and test the
holistic operation of the computer. At each phase, thorough testing was completed to ensure that
all developed components operate as expected.

# 2 Project Design and Implementation
## 2.1 Datapath
The Datapath was implemented as the top-level entity in the project, serving as the main module
that connected all the other components. For the purposes of this project, it was called “CPUDe-
signProject.v”. The datapath contained instantiations for the general purpose and special registers,
the bus encoder and multiplexer, instruction and branch logic, the memory subsystem, the ALU
and control unit, and other modules that played certain roles in the dataflow/control of the CPU.
Each was instantiated with an appropriate name for easy identification, and wires were used to
interconnect all of them. The most important component of the datapath was the bus. The group
decided to stick with a 1-bus design to simplify the process. More of this will be discussed later on
in the report. The bus is the main path upon which data flows. When using a 1-bus architecture,
it is crucial to ensure that only one component is outputting data onto it at a time, to avoid data
being lost. The bus connected all of the critical components together, for example, allowing data to
flow from the MDR to a specific register.

To ensure that only one register was outputting onto the bus, the bus encoder and multiplexer
were used. The encoder’s role was to specify the register that was allowed to output its data onto
the bus through a control signal. Furthermore, the encoder uses one-hot encoding which ensures
that only one input is allowed to be enabled at a time. This further prevents two registers from
being enabled at once. As for the rest of the datapath, the group experimented with various imple-
mentations of register enable signal control, settling on the one found in the final phase screenshots.
This signal was controlled by the control unit and specified which registers would have their enable
pins set high. Additionally, the group decided to leave the incrementing of the program counter to
the datapath. It was attempted to perform this action in the ALU but an issue was encountered
with this, which will be discussed below.

For phases 1 and 2, the control signals used in each of the test benches had to be defined in the
datapath module. This made testing fairly complex as there were a large number of control signals
that had to be correctly defined and asserted for the test benches to work as expected. With the
inclusion of the control unit in Phase 3, testing was greatly simplified. Now, the group simply had
to create a test bench to establish the datapath with a few signals that would then allow the control
unit to run.

## 2.2 ALU
The purpose of the ALU is to perform all the arithmetic and logic operations. For some of the
operations, such as the logical AND, OR, NOT, and shifting, the group decided not to create sepa-
rate modules as they simply relied on Verilog’s built-in operators (this was done with approval from
the professor). All other operations, such as add, subtract, multiply, and divide, were developed
through custom modules. The adder consisted of a 4-bit carry-lookahead adder (CLA) instantiated
4 times to create a 16-bit CLA, which was then instantiated twice to create a 32-bit CLA. For the
subtraction, one number was negated and then inputted into the adder described previously to add
the negated value to the other one. For multiplication, the group implemented the Booth algorithm
with bit-pair recoding. For division, both the restoring and non-restoring versions were developed.
The ALU contains inputs for a clock, clear, and branch flag signal, along with inputs for the A and
B registers, opcode, and 64-bit output, with the upper and lower 32 bits connected to the ZHigh
and ZLow registers respectively.

The ALU was passed in an opcode, and whenever that changed, it was checked using a case state-
ment. Each operation was associated with its respective opcode, a list of which can be found in the
ALU as parameters. Once the opcode matched the specific operation, the output for the relevant
operation was stored in the respective bits of the output register, with, for example, the quotient of
division being stored in the lower 32 bits of C, and the remainder in the upper 32. Some operations
were combined into one case to help save space. These were instructions that used the same ALU
operations, such as load, loadi, store, and addi, since they all save the output of the addition module
to the C register.

## 2.3 Control Unit
For Phase 3, the goal was to implement a control unit to handle all of the control signals and
various operations of the CPU. The unit uses the opcode from the instruction register and the
clock signal to execute the control sequence based on the opcode. The group opted for the first
method of designing the control unit as it was easier to understand and develop, despite being more
computationally expensive. This first method involved states that were used for instruction fetching
and decoding, and then based on the fetched opcode, a specific next state was enabled, which
would perform the specified instruction. The fetch instructions were labelled as ‘fetch0’, ‘fetch1’ and
‘fetch2’. The group found that certain timing errors arose within the control unit, especially with
the memory reading/instruction fetching. To avoid these issues, and similarly to the Phase 1 and 2
test benches, delays were implemented between each state transition that ensured that each signal
was active for two clock cycles instead of one. This guaranteed that the data was properly stored
in the registers and that the memory functioned as expected. After the instruction was fetched,
the opcode was read and the next state was chosen by a switch statement. Then the appropriate
signals would be asserted to ensure that the operation ran as expected. To save some space, the
group merged certain control signals for operations into one. For example, the AND, SUB, OR, and
other arithmetic operations all used the same control signals in their control sequences, which made
merging possible. The group also opted to not have any idle cycles. This meant that after each
control sequence had reached its last step, it would go to the initial fetch state, instead of waiting
around and idling.

## 2.4 Memory Subsystem
The group had experimented with both a custom implementation for the RAM as well as the
megafunction RAM that was implementable through the Quartus Software. The RAM was simple,
containing lines for data in and out, a clock, address, and write enable. The RAM itself was a
512x32 register that stores all the data. To initialize the memory with the instructions for phases
2, 3 and 4, the RAM was preloaded using the “readmemh” command along with a .mif file. The
module was instantiated in the datapath and connected to the other memory components and the
bus.

The first step in creating the memory subsystem in the datapath was creating the MDR and an
associated multiplexer. This was responsible for choosing whether the MDR was loaded with the
bus contents or the RAM data out. The next component was the MAR, which was responsible for
the addressing of the RAM. It accepts an address from the bus, truncates it to 9 bytes, and then
sends that data to the RAM. As for the RAM itself, it accepted the MDR data out wire as its data
input, and the output from the MAR as its address input. The global clock signal was fed into it,
along with a write enable pin, and a wire to output the data. The one major issue with the RAM is
that it takes two clock cycles for it to read and output data, which presented issues during testing.
This was fixed by extending each cycle in the control unit to two clock cycles, instead of one. This
could have been addressed by using a clock divider for the RAM, but the group found that using
this method was more intuitive and easier to follow.

## 2.5 Instruction Decoding and Branch Logic (Select & Encode and CON FF)
The select and encode and CON FF logic are responsible for the instruction decoding and branching
logic. The select and encode logic accepts the output of the instruction register as its input and then
isolates the opcode, the constant value, and the registers that need to be enabled for both input and
output. First, the module uses a 4-to-16 encoder to determine which of the possible three registers
in the instruction, GrA, GrB and GrC are going to be outputting onto the bus. The logic also allows
for sign-extended C values, by fanning out the most significant bit of the 18-bit value to 32. Finally,
the logic also accepts Rin and Rout signals, which dictates which general purpose register either has
its enable pin set or which register puts data onto the bus.

The CON FF module is responsible for determining if certain conditions are met before allow-
ing a conditional branch to take place. The logic takes in the bottom two bits of the C2 field in the
instruction register (IR bits 19 and 20), the bus, and a control signal CONin. Based on the contents
of the register in the instruction and the value of the C2 bits, the logic determines if the conditions
are met for the specified conditional branch instruction. For example, if the C2 bits are 00, then
that specifies to branch if the value in the register is zero. The logic checks the contents of GrA, and
if it is 0, asserts a branch flag, which is then used by the ALU to increment the program counter to
the appropriate location (PC + 1 + C).

## 2.6 Revision to R0
Another aspect of the datapath that plays a key role in the operation of the CPU is the R0 register.
In the first phase, it simply acted like a general-purpose register. However, as load, store and other
instructions were added that needed to use R0, a revision was needed. The new R0 logic essentially
outputted either the value 0 onto the bus, if the BAOut signal was not asserted, or the contents
of R0 itself. Depending on the chosen register Rb in the instruction, the effective address/data is
either the constant C when Rb is R0, or the constant C plus the contents of the specified Rb register
when Rb is not R0. This helps support the various addressing modes of the Mini SRC.

# 3 Evaluation Results
The maximum frequency of operation in the simulation can be calculated as 1/clock period. Tech-
nically, the clock period that was used was 20 ns, however, as mentioned before, this caused an issue
in our control unit. A 20 ns period would match the 50 MHz signal of the DE0 chip. However, our
control unit adapted the code to essentially run each cycle on a 40 ns period, resulting in an effective
frequency of 25 MHz.

To further understand the maximum frequency, and get a more accurate result, we ran the Time-
Quest Timing Analysis. This gave us a lot of various parameters, but the main one that we focused
on was the Fmax results. The results, which can be seen below in Appendix A, show that the max
frequency varies based on which component the clock is connected to. For example, components
such as the BAOut signal is limited to 61.87 MHz, due to a hold time setup constraint. This is to
ensure that register setup and hold times are met and that meta-stability does not occur. The values
for Fmax are different depending on which simulation model the software uses, but the values are
relatively similar. The Fmax for the clock signal, using the ”Slow 1200mV 85C Model” was 151.49
MHz. These values are all theoretical, and, technically, the lowest frequency on this list would limit
the overall frequency. Seeing as the lowest value is around 50 MHz, it seems to indicate that the
design would be able to function on a DE0 or DE0-CV board.

The number of cycles per instruction ranges from 8 to 18, with the average being roughly 12.5.
This is a relatively high number, but this is due to each control sequence of the instruction taking
two clock cycles. Using the Quartus software and the internal tools, the pin and chip usage for all 4
phases was determined. Phase 1 used 25% and 30%, Phase 2 used 56% and 44%, and Phase 3 and
4 used 30% and 46%.

# 4 Discussion
Throughout the project, the group faced various issues that slowed down progress. Initially, there
was a large learning curve with using Quartus II. Although the software was explored in previous
courses, it was never used for a project of this size which meant that there was plenty to learn. A
similar issue occurred with ModelSim. Although it was introduced in a previous course, the lack of
knowledge of various features caused the testing for Phase 1 to take longer than expected. Through-
out the course of the project, the group discovered many shortcuts and features which expedited
the testing process. For example, one such issue was attempting to figure out how to display the
waveforms for certain registers. This was integral in ensuring in testing that the ALU operations
calculated values correctly and required significant tinkering before coming to a solution.

As the project progressed past Phase 1, the group had to decide on the overall architecture of
the project. A major consideration was proceeding with a 1-bus architecture, or opting to imple-
ment a 2- or even 3-bus organization. As both group members were not too experienced with Verilog
and general CPU design, it was decided to simply stick with a single bus. Furthermore, it was de-
termined that following the phase instructions would be easier as they were written considering a
single bus.

Another issue that the group faced was that of the program counter and the incrementing pro-
cess. Initially, it was attempted to have the ALU increment the PC, but this led to issues with
compilations and syntax. Significant time was spent attempting to find the root of the issue but
instead more problems surfaced. To avoid this, a module was made that would increment the PC
by 1 each time the incrementPC signal was asserted. It was determined that this worked best with
our implementation.

The final challenge that the team faced was that of the control unit timing issue which was briefly
mentioned in Section 2.3. This issue prevented the CPU from functioning as expected. Certain
control sequences needed two clock cycles for the correct functionality, such as the RAM and other
memory-related operations. To counteract this, a delay was added to include a second clock cycle
for each sequence. Between each state change, a #40 was added meaning that the sequence was
active for 40ns, or two cycles. When testing, everything functioned as expected. Additionally, to
ensure that this method was acceptable, the group consulted the professor, who approved of this
method.

# 5 Conclusions & Future Work
In the end, the group implemented an almost fully functioning RISC product. All of the expected
features were implemented, however, the hardware implementation of the product was unsuccessful.
The Phase 4 functional simulation, which was done on ModelSim, did function as expected with the
correct values being present in the registers and ports at the end of the program. The group was able
to implement the 7-segment display encoding code in Verilog, and the module did output values that
theoretically would have displayed the correct hex values on the board, however, the program did
not appear to function as expected when executed on the board. The lower two displays appeared
to show 00, instead of the final expected value of A5, and there appeared to be no indication of the
program running (via the mapped RUN LED). After attempting to diagnose the issue alone and
with the help of the TAs, the group simply ran out of time and decided to just demo the functional
simulation.

When looking at the results of the functional simulation, it was evident that there was potential
for the hardware implementation to work, if the group had more time to diagnose. The evaluation
results seem to indicate a good frequency of operation and efficient use of clock cycles.

After completing the project and looking back at all of the various phases, many potential im-
provements could have been made. For starters, finishing the hardware implementation would be
the number one priority given more time. There are also extra features that could have been added,
such as a 2- or 3-bus architecture, branch prediction, hazard detection and prevention and more.
Additionally, another improvement could be switching to a clock divider implementation rather than
Verilog delays. This would allow for more flexibility in the timing department and the opportunity
to easily adjust the frequency of operation, and in turn, potentially lower the average number of
cycles per instruction. The main goal is to try to make the design as efficient as possible in terms of
both speed and chip usage. With more time, that goal is achievable, but given the scope and time
of this project, it was definitely a success.
