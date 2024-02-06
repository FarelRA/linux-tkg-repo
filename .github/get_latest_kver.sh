#!/bin/bash

# Function for formatted output
function msg2() {
  echo -e " \033[1;34m->\033[1;0m \033[1;1m$1\033[1;0m" >&2
}

# Get the script's directory
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Get kernel versions list from the official linux-tkg repo
source <(\
  curl https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-config/prepare | \
  grep -E '^_(current|eol)_kernels=\('\
)

# Combine extracted variables into a single array
supported_kernels=("${_current_kernels[@]}" "${_eol_kernels[@]}")

# Define available Git mirrors for the Linux kernel
typeset -Ag kernel_git_remotes
kernel_git_remotes=(
  ["kernel.org"]="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git"
  ["googlesource.com"]="https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable"
  ["github.com"]="https://github.com/gregkh/linux.git"
  ["torvalds"]="https://github.com/torvalds/linux.git"
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
typeset -Ag kver_latest_tags_map
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