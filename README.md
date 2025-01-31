If you're setting up the by hand, be sure to check the following prerequisites:
- Install arm-none-eabi toolchain,cmake, ninja, git
- When using JLink, install JLink server 
    - When using openOCD, install openocd server
- (optional) Install [Invoke](https://www.pyinvoke.org/installing.html), inside a Python environment(recommended) or globally.  

If you're using the [RPX](https://github.com/raynayx/rpxContainer) docker image all these would have been setup.

## Linux
### Creating a new project
Run the following in the bash terminal to create a new project:
```bash
source path/to/rpxPrj/create_prj.sh path/to/new/project/name
```

### Setting up the project
Run the following inside the newly created project directory
to setup the project directory structure:
```bash
source ./setup_env.sh
```



## Windows
- If PowerShell execution is disabled, run:
    `Set-ExecutionPolicy RemoteSigned` in a PowerShell terminal with administrative privileges
- 



