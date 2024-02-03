
# Custom Frogging-Family's Kernel Builds

This repository provides mirrors and downloads for the Frogging-Family's Kernel, we compiled the Kernel from the official Frogging-Family's github repository, with minor modifications to the build files. You can add it as a repo (mirror) on your linux machine, and simply install the built packages, no need to build them yourself.

## Features

- Variety of Schedulers: Choose from Bore, EEVDF, PDS, and BMQ for optimal performance based on your specific workload and hardware.
- Easy Installation: Access builds directly through GitHub releases or add a custom repository to your package manager's mirror list for seamless integration.
- Supported Distros: Currently supports Arch Linux, Ubuntu, and Fedora, with potential for expansion.
- Automated Build Process: Streamlined build pipeline ensures timely updates and consistent quality.

## Supported Schedulers

- Bore: Prioritizes interactivity and responsiveness, ideal for desktop and latency-sensitive workloads.
- EEVDF: Optimized for energy efficiency and battery life, well-suited for mobile devices and power-conscious scenarios.
- PDS: Prioritizes performance and throughput, particularly for multi-core systems and heavy workloads.
- BMQ: Balanced scheduler offering a mix of performance and responsiveness, suitable for general-purpose usage.

*Notes: Test it yourself to get accurate results*

## Adding Repository

### Arch Linux

- Add this repository at the and of your `/etc/pacman.conf`
```
[linux-tkg]
Server = https://raw.githubusercontent.com/FarelRA/linux-tkg-repo/main/archlinux/x86_64
```

- Update your local database with `pacman -Syy`
- Install the kernel with `pacman -S` followed by package name (eg. `linux-tkg-bore` or `linux-tkg-eevdf`)

### Ubuntu


GitHub Releases: Download the pre-built kernel package and install it using your distro's package manager.
Repository: Add the repository to your system, then install the kernel package using your package manager.
3. Updating:

If using GitHub releases, download and install updated packages as needed.
If using the repository, update your system as usual to receive new kernel builds.

## Installation

Arch Linux: sudo pacman -Syu kernel-custom-scheduler (replace scheduler with the desired scheduler)
Ubuntu: sudo apt-get install linux-custom-scheduler (replace scheduler with the desired scheduler)
Fedora: sudo dnf install kernel-custom-scheduler (replace scheduler with the desired scheduler)
## Contributing

We welcome contributions! Please see the CONTRIBUTING.md file for guidelines.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Disclaimer

Use custom kernels at your own risk. We recommend creating backups and testing in a non-production environment before full deployment.

We hope you enjoy exploring these enhanced schedulers and their impact on your Linux experience!