savedcmd_trace_filename.mod := printf '%s\n'   trace_filename.o | awk '!x[$$0]++ { print("./"$$0) }' > trace_filename.mod
