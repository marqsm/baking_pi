
.globl GetCurrentTimestamp
GetCurrentTimestamp:
    push    {lr}
    ldr     r2,=0x20003004      // Timer memory location
    ldrd    r0,r1,[r2,#4]       // timestamp distributed, lower 8 bytes in r0, hi 4 in r1
    pop     {pc}
    // get starting timestamp


.globl Wait
Wait:
    push    {lr}
    ldr     r3, =500000  // 500.000 microseconds = 0.5 seconds

    // get ending time
    bl      GetCurrentTimestamp
    add     r3, r0      // current time + delay -> ending time
    endTime .req r3

    currentTime .req r0
waitLoop$:
    bl      GetCurrentTimestamp
    // subtract starting times from current time
    // if >= delay, we are done
    cmp     endTime, currentTime
    bhi     waitLoop$

    .unreq  endTime
    .unreq  currenTime
    pop      {pc}



