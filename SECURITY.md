# Security Policy

## Scope
This project contains kernel tracing modules. These run with high privilege.

## Safe Usage Rules
1. Prefer test VMs over production systems.
2. Keep probe handlers minimal.
3. Avoid unbounded loops in probe context.
4. Use no-fault reads for raw pointer inspection.
5. Unload modules after test runs.

## Reporting
For security concerns, open a private security advisory in GitHub Security tab or contact repository owner directly.

## Disclaimer
No warranty for production incidents caused by custom kernel modules.
