If you're setting up the environment by hand, be sure to check the following prerequisites:
- Install arm-none-eabi toolchain,cmake, ninja, git
- When using JLink, install JLink server 
    - When using openOCD, install openocd server
- (optional) Install [Invoke](https://www.pyinvoke.org/installing.html), inside a Python environment(recommended) or globally.  

If you're using the [RPX](https://github.com/raynayx/rpxContainer) docker image all these would have been setup.

# Linux
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

## VS Code Dev Container
- Be sure to setup Docker as required for your platform.
- Install the `dev container by Microsoft` or the `Remote dev pack` extensions in VS Code.
- After the project has been setup, launch it inside VS Code
- VS Code will recognize the `.devcontainer` directory and 
prompt you to build it.
- Be sure to point the `dockerfile` key in the `devcontainer.json` file to the location of the [RPX `Dockerfile`](https://github.com/raynayx/rpxContainer) on your computer.
- The dev container extension will build the image, and open your project in the reloaded the VS Code window.


### Building the project
To build the project, run the following Invoke commands defined in the `tasks.py` file in the root of the project directory:
```bash
invoke build
```
### Flashing the project
To flash the built firmware, make sure your programmer in this case, Segger JLink is connected and passed through to the docker container.
Then run:
```bash
invoke flash
```

You can use `inv` instead of `invoke`. The defined tasks that depend on each other are run when required.
You can therefore run `inv flash` without running `inv build` first. Invoke will run it automagically.

### Visual debugging with VS Code(Cortex Debug extension)
- Click on the `Run and Debug` button
- Click on the `Start Debugging` button or press `F5`
- Show here:
<video src="https://github.com/user-attachments/assets/1d022889-8f8c-42bd-8c4a-9c33c71aed86" controls="controls"></video>

<!-- # Windows
- If PowerShell execution is disabled, run:
    `Set-ExecutionPolicy RemoteSigned` in a PowerShell terminal with administrative privileges
-  -->



