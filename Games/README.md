---

# Ping Pong Game : NASM Assembly Language 

🚀 Assembly Language Codes and Games Repository 💻💡 #CodeNinja #ASM

Welcome to [ASM-RawBytes](https://github.com/MadG0blin359/ASM-RawBytes), a collection of assembly language programs designed for low-level programming enthusiasts, computer science students, and anyone eager to understand how computers process instructions at the hardware level. This repository features NASM (Netwide Assembler) codes specifically crafted for **DOSBox NASM x86 format** to demonstrate essential concepts such as memory manipulation, arithmetic operations, control flow, and direct hardware interfacing.

---

## 📃 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Controls](#controls)
- [How to Run](#how-to-run)
- [Game Instructions](#game-instructions)
- [Technical Details](#technical-details)
- [Author](#author)
- [Contact](#contact)

---

## 🕹️ Overview  
This project is a **Ping Pong Game** developed in NASM Assembly language, featuring a simple yet engaging multiplayer experience. With intuitive controls and multiple features, it showcases low-level programming concepts in action.

---

## ✨ Features  
- **Main Menu**: Start the game or exit from a user-friendly menu interface.  
- **Multiplayer Mode**: Two-player gameplay with separate paddle controls.  
- **Custom Winning Score**: Set your own winning score for each match.  
- **Pause Option**: Pause the game anytime by pressing **P**.  
- **Game Score Display**: Scores are dynamically updated and displayed during the game.  
- **Game Replay**: Replay option available after the game ends.  

---

## 🎮 Controls  

| **Player** | **Keys** |
|------------|----------|
| Left Paddle (Player 1) | **W** (Up), **S** (Down) |
| Right Paddle (Player 2) | **Up Arrow** (Up), **Down Arrow** (Down) |
| Pause Game | **P** |

---

## 🚀 How to Run  
1. Install NASM assembler and DOSBox if not already installed.  
2. Assemble the game in DOSBox using the following command:

   ```bash
   nasm pong.asm -o pong.com
   ```
   ```bash
   pong.com
   ```

---

   ## 📋 Game Instructions  
- **Main Menu**: Select your desired option to start or exit.  
- **Custom Winning Score**: Set the winning score when prompted before starting the game.  
- **Gameplay**:  
  - Control the paddles using **W/S** for Player 1 and **Arrow Keys** for Player 2.  
  - The first player to reach the custom winning score wins.  
- **Pause/Resume**: Press **P** to pause and resume the game.  
- **Game Replay**: After the game, choose to replay or exit.  

---

## 🛠️ Technical Details  
- Developed entirely in **NASM Assembly Language**.  
- Uses **keyboard interrupts** for responsive controls.  
- Efficient memory handling for real-time score updates and game states.  

---

## ✒ Author  
Developed by **Shawaiz Shahid**.

---

## 📧 Contact

For any inquiries or collaboration opportunities, please contact:

- shawaizshahid312+github@gmail.com
