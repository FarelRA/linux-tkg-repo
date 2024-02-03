#!/bin/bash

# Function for formatted output
function msg2() {
  echo -e " \033[1;34m->\033[1;0m \033[1;1m$1\033[1;0m" >&2
}

# Get the script's directory
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Define supported kernel versions
supported_kernels=(
  6.8 6.7 6.6 6.5 6.4 6.1 5.15
  # EOL kernels
  6.3 6.2 6.0 5.19 5.18 5.17 5.16 5.14 5.13 5.12 5.11 5.9 5.8 5.7 5.4.230 5.10.135
)

# Define available Git mirrors for the Linux kernel
kernel_git_remotes=(
  ['kernel.org']='https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git'
  ['googlesource.com']='https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable'
  ['github.com']='https://github.com/gregkh/linux.git'
  ['torvalds']='https://github.com/torvalds/linux.git'
)

# Select a Git mirror, prioritizing user input and defaulting to github.com
if [[ -z "$_git_mirror" ]]; then
  echo "No Git mirror specified. Defaulting to github.com."
  _git_mirror="github.com"
fi

if [[ ! "${!kernel_git_remotes[@]}" =~ "$_git_mirror" ]]; then
  msg2 "Warning: Git mirror '$_git_mirror' not recognized. Using github.com."
  _git_mirror="github.com"
fi

# Fetch the latest tags for supported kernels
kernel_tags=$(git -c 'versionsort.suffix=-' \
  ls-remote --exit-code --refs --sort='version:refname' --tags "${kernel_git_remotes[$_git_mirror]}" '*.*' \
  | cut --delimiter='/' --fields=3)

# Create a map of kernel versions to their latest tags
declare -A kver_latest_tags_map
for kver in "${supported_kernels[@]}"; do
  kver_latest_tags_map[$kver]=$(echo "$kernel_tags" | grep -F "v$kver" | tail -1 | cut -c1-)
done

# Determine the latest stable kernel version
latest_kernel="${kver_latest_tags_map[${supported_kernels[0]}]}"
if [[ "$latest_kernel" == *rc* ]]; then  # Skip release candidates
  latest_kernel="${kver_latest_tags_map[${supported_kernels[1]}]}"
fi

# Output the latest kernel version to a file
echo "$latest_kernel" > "$SCRIPT_DIR/latest-kernel"