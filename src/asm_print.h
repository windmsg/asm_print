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

.section .data
msg1:    .asciz "print strings\n"
msg2:    .asciz "X0: "
msg3:    .asciz "CNTFRQ_EL0: "

#define TX_BUF             0x09000000  /* uart tx buffer register */
#define TX_STATE           0x09000018  /* uart status register */
#define TX_BUSY            0x20        /* TX busy flag */

#define REG_ARG1           x9
#define REG_TX_BUF         x10
#define REG_TX_STATE       x11
#define REG_RET            x12
#define REG_DATA           x13
#define REG_DATA_W         w13
#define REG_CNT            x14
#define REG_TMP            x15

.macro PRINT_STRING arg1
    ldr REG_ARG1, =\arg1
    bl  print_s
.endm

.macro PRINT_REG arg1
    mov REG_DATA, \arg1
    bl  print_r
.endm

.macro PRINT_SYS arg1
    mrs REG_DATA, \arg1
    bl  print_r
.endm

