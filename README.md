# COAL Cryptography Project

## Overview
This project, developed as the final project for a Computer Organization and Assembly Language (COAL) course at FAST NUCES, implements four cryptographic algorithms in Assembly language using the Irvine32 library. It includes the Vigenere Cipher, Diffie-Hellman Key Exchange, ROT13, and Rail Fence Cipher, demonstrating low-level programming and cryptographic concepts.

## Features
- **Algorithms**:
  - **Vigenere Cipher**: Encrypts text using a keyword-based polybius square.
  - **Diffie-Hellman Key Exchange**: Computes public and shared keys for secure key exchange (fixed prime=23, base=5).
  - **ROT13**: Applies a Caesar cipher with a fixed shift of 13.
  - **Rail Fence Cipher**: Encrypts text in a two-rail zigzag pattern.
- **User Interface**: Console-based menu to select and run each algorithm.
- **Input/Output**: Accepts user input for text/keys and displays encrypted results or computed keys.

## Prerequisites
- MASM (Microsoft Macro Assembler) with Irvine32 library.
- Windows operating system (Irvine32 is Windows-specific).
- Visual Studio or another MASM-compatible assembler environment.

## Installation
1. Clone or download the repository.
2. Obtain the Irvine32 library from [Kip Irvine’s website](http://kipirvine.com/asm/) or your course resources.
3. Place Irvine32 files in the same directory as `crypto.asm` or configure your assembler to include them.
4. Set up MASM in Visual Studio or your preferred assembler environment.

## Usage
1. Assemble and run `crypto.asm` using MASM on Windows.
2. At the menu, select an option (1–5):
   - 1: Vigenere Cipher (enter text and key to encrypt).
   - 2: Diffie-Hellman Key Exchange (enter private keys for Alice and Bob).
   - 3: ROT13 (enter text to encrypt/decrypt).
   - 4: Rail Fence Cipher (enter text to encrypt with two rails).
   - 5: Exit.
3. Follow prompts to input data and view results.
4. Press any key to return to the menu.

## File Structure
- `crypto.asm`: Main Assembly script with cryptographic algorithms and menu logic.
- `README.md`: This documentation file.

## Implementation Details
- **Vigenere Cipher**: Shifts alphabetic characters using a repeating key, mapped via a precomputed table.
- **Diffie-Hellman**: Implements modular exponentiation for key exchange with hardcoded prime (23) and base (5).
- **ROT13**: Shifts characters by 13 positions using the Vigenere table.
- **Rail Fence Cipher**: Arranges text in a fixed two-rail pattern, printing rows sequentially.
- **Irvine32 Library**: Handles console I/O (e.g., `WriteString`, `ReadDec`).

## Limitations
- **Error Handling**: Limited validation (e.g., no checks for non-alphabetic input or negative numbers).
- **Flexibility**: Rail Fence Cipher is fixed to two rails; Diffie-Hellman uses static prime/base.
- **Portability**: Windows-specific due to Irvine32 dependency.
- **Documentation**: Code lacks extensive comments, though procedures are self-contained.

## Future Improvements
- Add input validation for non-alphabetic or invalid inputs.
- Support variable rails in Rail Fence Cipher and configurable prime/base in Diffie-Hellman.
- Include detailed inline comments for clarity.
- Rewrite in a cross-platform language (e.g., C) for broader accessibility.

## Acknowledgments
Developed as the final project for a COAL course to explore Assembly programming and cryptography. It leverages the Irvine32 library and course concepts.

## License
Licensed under the MIT License. See the [LICENSE](LICENSE) file for details. Note: The Irvine32 library has separate licensing terms (typically educational use); ensure compliance when redistributing.
