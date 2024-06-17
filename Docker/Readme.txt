This is a user guide for building the docker image to run KUL_VBG
Please cite the following publication if you're using this software in your research
Ahmed M. Radwan, Louise Emsell, Jeroen Blommaert, Andrey Zhylka, Silvia Kovacs, Tom Theys, Nico Sollmann, Patrick Dupont, Stefan Sunaert,
Virtual brain grafting: Enabling whole brain parcellation in the presence of large lesions,
NeuroImage,
Volume 229,
2021,
117731,
ISSN 1053-8119,
https://doi.org/10.1016/j.neuroimage.2021.117731.
(https://www.sciencedirect.com/science/article/pii/S1053811921000082)
Abstract: Brain atlases and templates are at the heart of neuroimaging analyses, for which they facilitate multimodal registration, enable group comparisons and provide anatomical reference. However, as atlas-based approaches rely on correspondence mapping between images they perform poorly in the presence of structural pathology. Whilst several strategies exist to overcome this problem, their performance is often dependent on the type, size and homogeneity of any lesions present. We therefore propose a new solution, referred to as Virtual Brain Grafting (VBG), which is a fully-automated, open-source workflow to reliably parcellate magnetic resonance imaging (MRI) datasets in the presence of a broad spectrum of focal brain pathologies, including large, bilateral, intra- and extra-axial, heterogeneous lesions with and without mass effect. The core of the VBG approach is the generation of a lesion-free T1-weighted image, which enables further image processing operations that would otherwise fail. Here we validated our solution based on Freesurfer recon-all parcellation in a group of 10 patients with heterogeneous gliomatous lesions, and a realistic synthetic cohort of glioma patients (n = 100) derived from healthy control data and patient data. We demonstrate that VBG outperforms a non-VBG approach assessed qualitatively by expert neuroradiologists and Mann-Whitney U tests to compare corresponding parcellations (real patients U(6,6) = 33, z = 2.738, P < .010, synthetic-patients U(48,48) = 2076, z = 7.336, P < .001). Results were also quantitatively evaluated by comparing mean dice scores from the synthetic-patients using one-way ANOVA (unilateral VBG = 0.894, bilateral VBG = 0.903, and non-VBG = 0.617, P < .001). Additionally, we used linear regression to show the influence of lesion volume, lesion overlap with, and distance from the Freesurfer volumes of interest, on labeling accuracy. VBG may benefit the neuroimaging community by enabling automated state-of-the-art MRI analyses in clinical populations using methods such as FreeSurfer, CAT12, SPM, Connectome Workbench, as well as structural and functional connectomics. To fully maximize its availability, VBG is provided as open software under a Mozilla 2.0 license (https://github.com/KUL-Radneuron/KUL_VBG).
Keywords: Lesioned brain parcellation; Brain MRI lesion-filling; Brain MRI lesion-inpainting; Gliomas; Clinical imaging

The Dockerfile contains the recipe for building the VBG docker image
This dockerfile builds by default with NVIDIA GPU drivers and CUDA toolkit
The analysis should still work without GPU if it's not available
We also use the dev branch of the KUL_VBG repo on github by default
If you'd like to build with a different branch of KUL_VBG, please change line 145

To build the docker image follow these steps in a linux terminal, assuming BASH:
1- Copy your freesurfer license file to the local KUL_VBG_docker folder, same folder as the KUL_VBG_Dockerfile with the name freesurfer_license.txt
2- Download the fslinstaller.py from the FMRIB website and place it in the same folder
3- Copy prebuilt ANTs to ./ANTs (preferably from same or similar OS, e.g. mint21 or ubuntu20)
3- cd /KUL_VBG_docker_folder
4- sudo docker build -f KUL_VBG_Dockerfile -t kul_vbg_mint .
5- wait till it's finished
6- Run the resulting built image using:

* If no NVIDIA GPU available
docker run -it --rm -v /usr/local/KUL_apps/freesurfer/license.txt:/usr/local/freesurfer/license.txt -v $(pwd)/data:/data kul_vbg_mint

* If NVIDIA GPU available
docker run --gpus all -it --rm -v /usr/local/KUL_apps/freesurfer/license.txt:/usr/local/freesurfer/license.txt -v $(pwd)/data:/data kul_vbg_mint

** Replace $(pwd)/data with the path you have your data in.
** In principle, the docker image can be used to run any command of the installed software
** See KUL_VBG.sh -h for details on how to use KUL_VBG.sh, also KUL_VBG_cook_template.sh -h
** KUL_synth_pats_4VBG.sh has to be run from within the container
** This can be done by logging into the container from terminal:
docker run -it --rm -v $(pwd)/data:/app     kul_vbg_mint /bin/bash
