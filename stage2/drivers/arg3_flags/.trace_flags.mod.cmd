savedcmd_trace_flags.mod := printf '%s\n'   trace_flags.o | awk '!x[$$0]++ { print("./"$$0) }' > trace_flags.mod
