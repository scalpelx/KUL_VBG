#!/bin/bash
set -e

# Define the expected location of the mounted license file
LICENSE_MOUNTED_PATH="$FREESURFER_HOME/license.txt"

# Define the target locations for the license file
FREESURFER_LICENSE_PATH="/usr/local/freesurfer/license.txt"
FASTSURFER_LICENSE_PATH="/opt/FastSurfer/license.txt"

# Check if the FreeSurfer license file is mounted
if [ ! -f "$LICENSE_MOUNTED_PATH" ]; then
  echo "Error: FreeSurfer license file not found. Please mount the license file using the -v option."
  echo "Example: docker run -v /path/to/license.txt:/usr/local/freesurfer/license.txt radwankul/kul_vbg_mint:latest"
  exit 1
fi

# Copy the license file to the target locations
cp "$LICENSE_MOUNTED_PATH" "$FASTSURFER_LICENSE_PATH"

# Source the environment variables
source /etc/profile.d/freesurfer.sh
source /etc/profile.d/fsl.sh
source /etc/profile.d/ants.sh
source /etc/profile.d/mrtrix3_path.sh
source /etc/profile.d/kul_vbg.sh

# Activate the FastSurfer conda environment
source /opt/conda/etc/profile.d/conda.sh


# Execute the command provided as arguments
exec "$@"
