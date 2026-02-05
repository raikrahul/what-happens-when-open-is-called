savedcmd_check_offsets.mod := printf '%s\n'   check_offsets.o | awk '!x[$$0]++ { print("./"$$0) }' > check_offsets.mod
