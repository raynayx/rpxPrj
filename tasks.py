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

@task
def debug(c):
    """Debug with J-Link Edu Mini"""
    with c.cd("build"):
        c.run("JLinkGDBServer  -device RP2040_M0_1 -endian little -if SWD \
              -speed 4000 -ir -noLocalhostOnly -nologtofile",pty=True)
        # c.run("arm-none-eabi-gdb {}".format(EXE),pty=True)
        # c.run('kill $(pgrep JLinkGDBServer)',pty=True)


@task
def clean(c):
    """Clean all binaries build from project"""
    if os.name == 'nt':
        c.run("DEL /F /A /Q  build")
    else:
        c.run("rm -rf build/") 
    
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

@task(pre=[cmake])
def build(c):
    """Build the project"""
    with c.cd(BUILD_DIR):
        if os.name == 'nt':
            c.run("ninja -j16")
        else:
            c.run("ninja -j16")


@task(pre=[build])
def size(c):
    """Show size of the built binary file"""
    with c.cd(BUILD_DIR):
        c.run("clear")
        c.run("arm-none-eabi-size -Axt {}".format(EXE))

@task(pre=[build])
def flash(c):
    """Get ELF file and flash to device"""
    with c.cd(BUILD_DIR):
       c.run("JLinkExe ../{}".format(FLASH_SCRIPT))
       c.run("arm-none-eabi-size -G {}".format(EXE))
