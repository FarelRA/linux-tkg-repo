
# Custom Frogging-Family's Kernel Builds

This repository provides mirrors and downloads for the Frogging-Family's Kernel, we compiled the Kernel from the official Frogging-Family's github repository, with minor modifications to the build files. You can add this as a repo (mirror) on your linux machine, and simply install the built packages, no need to build them yourself.

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

## Installation

### Arch Linux

Add the repository to your system, then install the kernel package using your package manager.

- Add the repo GPG key

``` bash
pacman-key --recv-key EABAB7D6EDEBF294 --keyserver keyserver.ubuntu.com
pacman-key --lsign-key EABAB7D6EDEBF294
```

- Add this line at the and of your `/etc/pacman.conf`

``` conf
[linux-tkg]
Server = https://raw.githubusercontent.com/FarelRA/linux-tkg-repo/main/archlinux/main/x86_64
```

- Update your local database with `pacman -Syy`
- Install the kernel with `pacman -S` followed by package name (eg. `linux-tkg-bore` or `linux-tkg-eevdf`)

*Update your system as usual to receive new kernel builds.*

### Debian/Ubuntu

***Notes: The Ubuntu repository feature is not yet completed.***

Add the repository to your system, then install the kernel package using your package manager.

- Add this line at the end of your `/etc/apt/sources.list`

``` conf
deb [trusted=yes] https://raw.githubusercontent.com/FarelRA/linux-tkg-repo/main/debian/main/x86_64 ./
```

- Update apt package database with `apt-get update`
- Install the kernel with `apt-get install` followed by package name (eg. `linux-tkg-bore` or `linux-tkg-eevdf`)

*Update your system as usual to receive new kernel builds.*

### Fedora

***Notes: Fedora repository temporarily disabled due to the size of the built kernel exceeding the GitHub file size limit.***

***Notes: The Fedora repository feature is not yet completed.***

Add the repository to your system, then install the kernel package using your package manager.

- Create `/etc/yum.repos.d/linux-tkg.repo` file and add this line

``` conf
[linux-tkg]
name=linux-tkg Repository
baseurl=https://raw.githubusercontent.com/FarelRA/linux-tkg-repo/main/fedora/main/x86_64
gpgcheck=0
priority=0
enabled=1
```

- Update package database with `dnf check-update`
- Install the kernel with `dnf install` followed by package name (eg. `linux-tkg-bore` or `linux-tkg-eevdf`)

*Update your system as usual to receive new kernel builds.*

### By GitHub Releases

Download the pre-built kernel package from GitHub Releases and install it using your distro's package manager.

- Arch Linux: `pacman -U /package/folder/kernel_package.tar.zst`
- Ubuntu: `dpkg -i /package/folder/kernel_package.deb`
- Fedora: `dnf install /package/folder/kernel_package.rpm`

*Replace `/package/folder/kernel_package` with the your downloaded package path*

*With this method you have to download and install updated kernel packages manually.*

## Contributing

We welcome contributions! Please see the CONTRIBUTING.md file for guidelines.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Disclaimer

Use custom kernels at your own risk. We recommend creating backups and testing in a non-production environment before full deployment.
