>- ⚠️ Do not forget to go through .nix and configuration.nix to edit and comment out (#) anything you don't want to setup!
>- ❗ mounts.nix can break your system! Be sure to replace it with yours or disable it!
Testing: 
Latest sfwbar	-working mostly (missing restore minimized windows)
Gamescope		-Working to launch Big Picture (noticably smoother gaming)
				-Not working from within steam (to fix)
To do:
Never stop learning, try to commit and doccument changes made to facilitate nix assimilation process. 
				-Need to add Windows VM declarative (if possible? currently manually adding via virt-manager)
				-Set-up NVIDIA PRIME to offload rendering using:
					-3070ti when no windows VM is running to the AMD 6600XT
					-decide if this should be via command or hooks

This is a work in progress from a new NixOS user thanks to IceDBorn's files for the help.
![image](https://user-images.githubusercontent.com/18453144/229330919-79494315-87a0-428c-a2b6-6365e35e94e3.png)


# Thank you @

```bash
 https://github.com/IceDBorn/IceDOS 
```
