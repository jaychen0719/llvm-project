; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=arm-eabi %s -o - | FileCheck %s -check-prefix=CHECK -check-prefix=CHECK-LE
; RUN: llc -mtriple=armeb-eabi %s -o - | FileCheck %s -check-prefix=CHECK -check-prefix=CHECK-BE

define i64 @f0(i64 %A, i64 %B) {
; CHECK-LE-LABEL: f0:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    lsrs r3, r3, #1
; CHECK-LE-NEXT:    rrx r2, r2
; CHECK-LE-NEXT:    subs r0, r0, r2
; CHECK-LE-NEXT:    sbc r1, r1, r3
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-BE-LABEL: f0:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    lsrs r2, r2, #1
; CHECK-BE-NEXT:    rrx r3, r3
; CHECK-BE-NEXT:    subs r1, r1, r3
; CHECK-BE-NEXT:    sbc r0, r0, r2
; CHECK-BE-NEXT:    mov pc, lr

  %tmp = bitcast i64 %A to i64
  %tmp2 = lshr i64 %B, 1
  %tmp3 = sub i64 %tmp, %tmp2
  ret i64 %tmp3
}

define i32 @f1(i64 %x, i64 %y) {
; CHECK-LE-LABEL: f1:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    lsl r0, r0, r2
; CHECK-LE-NEXT:    subs r1, r2, #32
; CHECK-LE-NEXT:    movpl r0, #0
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-BE-LABEL: f1:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    lsl r0, r1, r3
; CHECK-BE-NEXT:    subs r1, r3, #32
; CHECK-BE-NEXT:    movpl r0, #0
; CHECK-BE-NEXT:    mov pc, lr

  %a = shl i64 %x, %y
  %b = trunc i64 %a to i32
  ret i32 %b
}

define i32 @f2(i64 %x, i64 %y) {
; CHECK-LE-LABEL: f2:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    rsb r3, r2, #32
; CHECK-LE-NEXT:    lsr r0, r0, r2
; CHECK-LE-NEXT:    subs r2, r2, #32
; CHECK-LE-NEXT:    orr r0, r0, r1, lsl r3
; CHECK-LE-NEXT:    asrpl r0, r1, r2
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-BE-LABEL: f2:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    rsb r2, r3, #32
; CHECK-BE-NEXT:    lsr r1, r1, r3
; CHECK-BE-NEXT:    orr r1, r1, r0, lsl r2
; CHECK-BE-NEXT:    subs r2, r3, #32
; CHECK-BE-NEXT:    asrpl r1, r0, r2
; CHECK-BE-NEXT:    mov r0, r1
; CHECK-BE-NEXT:    mov pc, lr

  %a = ashr i64 %x, %y
  %b = trunc i64 %a to i32
  ret i32 %b
}

define i32 @f3(i64 %x, i64 %y) {
; CHECK-LE-LABEL: f3:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    rsb r3, r2, #32
; CHECK-LE-NEXT:    lsr r0, r0, r2
; CHECK-LE-NEXT:    subs r2, r2, #32
; CHECK-LE-NEXT:    orr r0, r0, r1, lsl r3
; CHECK-LE-NEXT:    lsrpl r0, r1, r2
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-BE-LABEL: f3:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    rsb r2, r3, #32
; CHECK-BE-NEXT:    lsr r1, r1, r3
; CHECK-BE-NEXT:    orr r1, r1, r0, lsl r2
; CHECK-BE-NEXT:    subs r2, r3, #32
; CHECK-BE-NEXT:    lsrpl r1, r0, r2
; CHECK-BE-NEXT:    mov r0, r1
; CHECK-BE-NEXT:    mov pc, lr

  %a = lshr i64 %x, %y
  %b = trunc i64 %a to i32
  ret i32 %b
}
