# Prints the include path for the Python headers
from sysconfig import get_paths as gp

print(gp()['include'])
