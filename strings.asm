section .data

global helloworld
helloworld:
  db `Hello World`, 0

global byeworld
byeworld:
  db `Good Bye, World...`, 0

global linebreaker
linebreaker:
  db `\n`, 0
