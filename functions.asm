section .text

extern linebreaker

global exit
exit:
  mov rax, 60
  mov rdi, 0
  syscall

global print
print:
  ; Imprime uma string no stdout
  ; Recebe string no RSI
  ; Retorna string no RAX (Retorno padrão)
  push rax                ; Salva valor origial de RAX na STACK
  push rsi                ; Salva valor origial de RSI na STACK
  call strlen             ; Tamanho da string no RAX
  pop rsi                 ; Retorna valor origial de RSI da STACK

  mov rdi, 1              ; file handler 1 = stdout
  mov rdx, rax            ; RDX armazena tamanho da string e RAX é o valor de retorno do strlen
  mov rax, 1              ; Syscall write (0x01)
  syscall                 ; stdout call
  pop rax                 ; Retornar valor original de RAX da STACK
  ret

global println
println:
  push rsi                ; Salva valor origial de RSI na STACK
  call print              ; Chama strlen e retorna tamanho da string no RAX
  mov rsi, linebreaker    ; Adiciona ao RSI o linebreaker
  call print              ; Calcula novamente o tamanho da string com linebreaker
  pop rsi                 ; Valor inicial do RSI é devolvido da stack
  ret

global strlen
strlen:
  ; Calc comprimento de string até 0x00
  ; para ser calculada string vem no RSI
  ; tamanho retornado em RAX
  push rbx                ; Salva valor origial de RBX na STACK
  mov rbx, 0              ; Inicializa contador para 0 (já que RAX é utilizado pelo LODSB)

global loopstart
loopstart:
  mov rax, 0              ; Para garantir a integridade do registrador quando for lido pelo LODSB
  ; while *RSI != 0; RBX++; RSI++
  lodsb                   ; Lê bite em RSI e grava no AL (Lower register of EAX - 8 bits from Right  -)
  test ax, ax             ; Checa se AL == (0x00) -> ZF setado pra 1 se TRUE
  jz loopout              ; flag ZL = zero flag, é setada
  inc rbx                 ; incrementa registrador RBX
  jmp loopstart

global loopout
loopout:
  mov rax, rbx
  pop rbx                 ; Retorna valor origial de RBX da STACK
  ret
