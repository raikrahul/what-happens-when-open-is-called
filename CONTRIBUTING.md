# Contributing

## Scope
Contributions are accepted for trace drivers, userspace triggers, worksheets, and runbooks.

## Case Pack Format (Required)
Each new pack must include:
1. `driver.c`
2. userspace trigger (`.c` or `.S`)
3. worksheet markdown
4. runbook markdown
5. expected output snippet
6. failure-prediction list

## Non-negotiable Rules
1. Do not delete prior research/docs unless explicitly requested.
2. Keep commands reproducible on a clean machine.
3. Include kernel version and filesystem assumptions.
4. Include at least one negative test path.

## Pull Request Checklist
1. Build passes for affected targets.
2. Worksheet links to real files.
3. dmesg sample included for new probe workflow.
4. Safety notes included for kernel probes.
