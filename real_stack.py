import gdb
import re

regs = None

output = gdb.execute("bt", to_string=True)
for line in output.splitlines():
    m = re.search(r"regs=(0x[0-9a-f]*)", line)
    if m:
        regs = m.group(1)
        break

if regs:
    gdb.execute("set $orig_eip = $eip", to_string=True)
    gdb.execute("set $orig_ebp = $ebp", to_string=True)

    gdb.execute("set $_regs = (regs_t *){}".format(regs), to_string=True)
    gdb.execute("set $eip = $_regs->r_eip", to_string=True)
    gdb.execute("set $ebp = $_regs->r_ebp", to_string=True)
    gdb.execute("bt")
    
    gdb.execute("set $eip = $orig_eip", to_string=True)
    gdb.execute("set $ebp = $orig_ebp", to_string=True)
