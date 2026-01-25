# Fortify Static Code Analyzer – Linux Commands

## Installation
```bash
./Fortify_SCA_and_Apps_Linux.run # Enterprise installer
```

## Basic Scan
```bash
# 1. Clean
sourceanalyzer -b mybuild -clean
# 2. Translate
sourceanalyzer -b mybuild javac *.java
# 3. Scan
sourceanalyzer -b mybuild -scan -f results.fpr
```

## Report Generation
```bash
# Report usually generated from Audit Workbench or via BIRT report command.
# The scan produces results.fpr which contains provided results.
```
