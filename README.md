# Memory Verification Using UVM

## Overview
This project demonstrates the use of **Universal Verification Methodology (UVM) to verify a simple memory module. The goal is to showcase a verification environment where transactions, stimuli generation, monitoring, and result checking are handled in a structured way.

## Features
- **Memory module**               : A parameterized memory block supporting read and write operations.
- **UVM Environment**             : Includes UVM components such as sequencer, driver, monitor, scoreboard, and agent.
- **Randomized transactions**     : Uses randomization with constraints to generate diverse memory accesses.
- **Coverage-driven verification**: Provides functional coverage to ensure all memory addresses are tested.

## Project Structure

- **UVM**: Contains all the SystemVerilog source files, including the memory module, UVM classes, and interfaces.
- **RTL**: Includes the memory rtl code files .
  
## UVM Components
The following UVM components are used in this verification project:

1. **Sequence Item** (`my_sequence_item.sv`): Defines the structure of memory transactions (address, data, read/write control).
2. **Sequence**      (`my_sequence.sv`)     : Generates a stream of memory transactions with randomized data and control signals.
3. **Driver**        (`my_driver.sv`)       : Drives transactions to the Device Under Test (DUT) by interfacing with the memory.
4. **Monitor**       (`my_monitor.sv`)      : Passively observes memory transactions and captures signals for checking.
5. **Scoreboard**    (`my_scoreboard.sv`)   : Compares the expected results with actual outputs and logs successes/failures.
6. **Agent**         (`my_agent.sv`)        : Encapsulates the sequencer, driver, and monitor.
7. **Environment**   (`my_env.sv`)          : Combines all components into a verification environment.

