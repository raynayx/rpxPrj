import os

# Invoke breaks with Python 3.11. The workaround is to import inspect and do the following
import inspect
if not hasattr(inspect, 'getargspec'):
    inspect.getargspec = inspect.getfullargspec

from invoke import Collection, task

ROOT_DIR = os.path.dirname(__file__)
PROJECT_DIR = os.path.join(".")
BUILD_DIR = os.path.join("./build")
EXE="firmware.elf"
FLASH_SCRIPT="flash.jlink"
DEBUG_SCRIPT="debug.jlink"
JLINK_ID=""

#Change the following to match the MCU you're targeting
TOTAL_FLASH = 2*1024*1024
TOTAL_RAM = 256*1024

@task
def debug(c):
    """Debug with J-Link Edu Mini"""
    with c.cd("build"):
        c.run("JLinkGDBServer -device RP2040_M0_1 -endian little -if SWD -speed 4000 \
                                -ir -noLocalhostOnly -nologtofile",pty=True)
        # c.run("arm-none-eabi-gdb {}".format(EXE),pty=True)
        # c.run('kill $(pgrep JLinkGDBServer)',pty=True)


@task
def clean(c):
    """Clean all binaries build from project"""
    if os.name == 'nt':
        c.run("DEL /F /A /Q  build")
    else:
        c.run("rm -rf build/*".format(EXE)) 
    
@task
def test(c):
    """Run all unit tests"""


@task
def cmake(c):
    """Generate Makefile from CMakefile"""
    if not (os.path.exists(BUILD_DIR)):
        c.run("mkdir -p {}".format(BUILD_DIR))
    with c.cd(BUILD_DIR):
        c.run("cmake -G Ninja ..")

@task
def size(c):
    """Show size of the built binary file"""
    with c.cd(BUILD_DIR):
        sec_sizes = c.run("arm-none-eabi-size {}"
        .format(EXE),hide=True).stdout.splitlines()[1].split()
        text, data, bss, dec, hex_, fname  = sec_sizes

        used_flash = int(text) + int(data)
        used_ram = int(data) + int(bss)
        size_print_region(used_flash,TOTAL_FLASH,"Flash")
        size_print_region(used_ram,TOTAL_RAM,"RAM")

@task(pre=[cmake],post=[size])
def build(c):
    """Build the project"""
    with c.cd(BUILD_DIR):
        if os.name == 'nt':
            c.run("ninja -j16")
        else:
            c.run("ninja -j16")
        

@task(pre=[build], post=[size])
def flash(c):
    """Get ELF file and flash to device"""
    with c.cd(BUILD_DIR):
       c.run("JLinkExe ../{}".format(FLASH_SCRIPT))



# function to print used storage resources
RED = '\033[31m'
GREEN = '\033[32m'
RESET = '\033[0m'
def size_print_region(size,max_size,name):
    percent= ((100*size)/max_size)
    print(f"{RED}{name}{RESET} used: {GREEN}{size}{RESET} out of {RED}{max_size}{RESET} ({int(percent)}%)")
