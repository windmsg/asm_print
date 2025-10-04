/*
 * MIT License
 *
 * Copyright (c) 2025 windmsg
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include "asm_print.h"

.global  print_s
.global  print_r
.align 4
.section .text, "ax"

uart_send:
    ldr REG_TX_STATE, =TX_STATE
    ldr REG_TX_STATE, [REG_TX_STATE]
    tst REG_TX_STATE, TX_BUSY
    bne uart_send
    strb REG_DATA_W, [REG_TX_BUF]
    ret

print_s:
    mov REG_RET, x30
    mov REG_TMP, REG_ARG1
    mov REG_CNT, #0
    ldr REG_TX_BUF, =TX_BUF

loop:
    ldrb REG_DATA_W, [REG_TMP, REG_CNT]
    cmp REG_DATA_W, #0
    beq done
    bl uart_send
    add REG_CNT, REG_CNT, #1
    b loop

done:
    mov x30, REG_RET
    ret

print_r:
    mov REG_RET, x30
    mov REG_TMP, REG_DATA
    mov REG_CNT, #60
    ldr REG_TX_BUF, =TX_BUF

    mov REG_DATA_W, #48
    bl uart_send

    mov REG_DATA_W, #120
    bl uart_send

print_loop:
    lsr REG_DATA, REG_TMP, REG_CNT
    and REG_DATA, REG_DATA, #0xF

    add REG_DATA, REG_DATA, #48
    cmp REG_DATA, #57
    bls send_char                       /* '0' - '9' */
    add REG_DATA, REG_DATA, #7          /* 'A' - 'F' */

send_char:
    bl uart_send
    cmp REG_CNT, #0
    beq done_r
    sub REG_CNT, REG_CNT, #4
    b print_loop

done_r:
    mov REG_DATA_W, #10                 /* '\n' */
    bl uart_send
    mov x30, REG_RET
    ret

