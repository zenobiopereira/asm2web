section .text
global _start

extern helloworld
extern byeworld
extern linebreaker
extern println
extern print
extern exit

_start:
  mov rsi, helloworld     ; String helloworld para RSI
  call println

  mov rsi, linebreaker
  call print

  mov rsi, byeworld
  call println

  call exit               ; go to exit namespace
