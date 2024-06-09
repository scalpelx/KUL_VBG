#!/bin/bash
set -e

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
