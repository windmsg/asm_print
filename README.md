# asm_print

`asm_print` is a lightweight assembly printing utility for the **ARM64** platform.
It provides macros to print strings, general-purpose registers, and system registers directly from assembly code — useful for debugging in bare-metal environments.

---

## Features

1. **`PRINT_STRING`** – Print a string
   **Usage:** `PRINT_STRING msg`
   The label `msg` must be defined as a string in `asm_print.h`.

2. **`PRINT_REG`** – Print the value of a general-purpose register (hex format)
   **Usage:** `PRINT_REG x0`

3. **`PRINT_SYS`** – Print the value of a system register (hex format)
   **Usage:** `PRINT_SYS CNTFRQ_EL0`

---

## Configuration

- You can configure which **general-purpose registers** and **UART register addresses** are used in `asm_print.h`.
- Make sure the **general-purpose registers** used by `asm_print` do **not overwrite important values** in the program being debugged.

---

## Demo

A working example is provided in the `demo/` directory.
You can build and run it using **QEMU for AArch64**.

```bash
make
./run_qemu.sh

