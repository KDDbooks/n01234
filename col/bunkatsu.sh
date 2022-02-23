for s in amazonpod keiyo tatsujin present
do
	echo $s
	echo dviselect -i main_kdd_${s}.dvi -o main_kdd_${s}_hontobira.dvi 1:2
	dviselect -i main_kdd_${s}.dvi -o main_kdd_${s}_hontobira.dvi 1:2
	dviselect -i main_kdd_${s}.dvi -o main_kdd_${s}_col.dvi 3
	dviselect -i main_kdd_${s}.dvi -o main_kdd_${s}_oku_keiyo.dvi 4
	dviselect -i main_kdd_${s}.dvi -o main_kdd_${s}_oku.dvi 6
done
