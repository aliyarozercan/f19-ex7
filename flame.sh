#!/bin/bash

export FSLTCLSH=/usr/local/fsl/bin/fsltclsh
        cd /input/derivatives

       	for d in `ls -d sub-*.feat`; do
		featregapply $d
		done 

		fslmerge -t level2/cope1 sub-*.feat/reg_standard/stats/cope1.nii.gz

		fslmerge -t level2/varcope1 sub-*.feat/reg_standard/stats/varcope1.nii.gz

		fslmerge -t level2/mask sub-*.feat/reg_standard/mask.nii.gz
		
		fslmaths level2/mask -Tmin level2/mask

		dof=$(cat sub-TD901.feat/stats/dof) 

		cd level2/
		fslmaths cope1 -mul 0 -add $dof -mul mask dof

		rm design.txt
		rm group.txt
		for d in `ls -d ../sub-*.feat`; do
		echo '1' >> group.txt
		echo '1' >> design.txt
		done

		for f in *.txt; do
		Text2Vest $f ${f%.txt}.mat
		done

		for i in 1; do flameo --cope=cope${i} --vc=varcope${i} --dvc=dof --mask=mask --ld=cope${i}.feat --dm=design.mat --cs=group.mat --tc=contrast.mat --runmode=flame1; done
 