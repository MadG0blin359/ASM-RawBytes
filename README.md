# ASM-RawBytes

🚀 Assembly Language Codes and Games Repository 💻💡 #CodeNinja #ASM

Welcome to **ASM-RawBytes**, a collection of assembly language programs designed for low-level programming enthusiasts, computer science students, and anyone eager to understand how computers process instructions at the hardware level. This repository features NASM (Netwide Assembler) codes specifically crafted for **DOSBox NASM x86 format** to demonstrate essential concepts such as memory manipulation, arithmetic operations, control flow, and direct hardware interfacing.

## Table of Contents

- [Introduction](#introduction)
- [Folder Structure](#folder-structure)
- [Features](#features)
- [Core Concepts](#core-concepts)
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [How to Run](#how-to-run)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Assembly language provides unparalleled control over the system’s hardware and operations, making it both powerful and challenging. This repository offers hands-on examples to help you learn assembly programming through practical code snippets. Each example is well-documented to aid your understanding.

## Folder Structure
I've structured the repository to make it easy to navigate and locate specific assignments or practice sets.
- **`Games/`**: Contains simple game projects in various languages for testing programming skills in game development.
- **`Practice ASM/`**: A collection of subfolders with assembly language exercises.
  - **`Arithmetic Operations/`**: Programs demonstrating basic arithmetic operations (addition, subtraction, multiplication, etc.) in assembly.
  - **`CMPs & JMPs/`**: Exercises focusing on comparison (CMP) and jump (JMP) instructions in assembly.
  - **`Display Memory/`**: Programs that show how to display and manipulate memory locations in assembly.
  - **`Interrupts/`**: Examples of using interrupts in assembly for system-level operations.
  - **`Logical Operations/`**: Programs demonstrating logical operations (AND, OR, NOT, XOR) in assembly.
  - **`Stack/`**: Exercises on stack operations (push, pop) and memory management.
  - **`String Operations/`**: Programs for string manipulation techniques, like searching and modifying strings in assembly.
- **`Tools/`**: Utility programs and scripts for compiling, debugging, or running assembly code.

## Features

- **Low-level programming examples** with direct hardware interaction.
- **Optimized solutions** for complex problems using assembly logic.
- Clean, structured code for better readability and learning.

## Core Concepts  

This repository covers a wide variety of key assembly programming concepts, including:  

- **Arithmetic Operations:** Addition, subtraction, multiplication, and division using registers and memory.  
- **Logical Operations:** AND, OR, XOR, and NOT operations.  
- **Branching:** Conditional jumps (`JE`, `JNE`, `JB`, `JA`) for decision-making logic.  
- **Stack Operations:** Pushing and popping values for temporary storage.  
- **String Manipulation:** Processing and displaying ASCII strings.  
- **Display Memory Manipulation:** Direct manipulation of video memory (`0xB800`) for text display.  
- **Interrupts:** BIOS and DOS interrupt calls (`int 10h`, `int 21h`) for hardware communication.  

## Getting Started

1. Clone the repository to your local machine using:
```bash
git clone https://github.com/MadG0blin359/ASM-RawBytes
```
2. Navigate to the Repository Folder:
```bash
cd ASM-RawBytes
```

## Prerequisites  

- **NASM (Netwide Assembler):** Install from [https://www.nasm.us/](https://www.nasm.us/)  
- **DOSBox:** A DOS emulator to run your assembly programs.  
- Basic knowledge of x86 assembly language.  


## How to Run  

1. **Assemble the code:**  
   ```bash
   nasm program.asm -o program.com
   ```
2. **Run the program in AFD:**  
   ```bash
   afd program.com
   ```
3. **Run the 'Display Memory' programs in DOSBox:**  
   ```bash
   program.com
   ```

## Contributing

If you encounter any issues, have suggestions, or wish to contribute additional practice problems, please feel free to create a pull request or open an issue. Contributions are immensely appreciated!

## License

This repository is licensed under the [MIT License](https://github.com/MadG0blin359/ASM-RawBytes/blob/main/LICENSE).
