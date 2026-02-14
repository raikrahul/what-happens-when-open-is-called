.intel_syntax noprefix
.global _start

.section .rodata
path_missing:
  .asciz "/home/r/Desktop/what-happens-when-open-is-called/kernel/user/stage3/case17_do_filp_open_deep_trace/missing_case17_raw_syscall.txt"

.section .text
_start:
  /* openat(AT_FDCWD=-100, path, O_RDONLY=0, mode=0) */
  mov rax, 257          /* __NR_openat */
  mov rdi, -100         /* AT_FDCWD */
  lea rsi, [rip + path_missing]
  mov rdx, 0            /* O_RDONLY */
  mov r10, 0            /* mode */
  syscall

  /* exit(status): if openat failed -> 0, else close fd and return 1 */
  cmp rax, 0
  jl open_failed

  /* close(fd) */
  mov rdi, rax
  mov rax, 3            /* __NR_close */
  syscall

  mov rdi, 1
  jmp do_exit

open_failed:
  mov rdi, 0

do_exit:
  mov rax, 60           /* __NR_exit */
  syscall
