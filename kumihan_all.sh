for s in amazonpod keiyo tatsujin present
do
	echo $s
	ptex2pdf -u -l -s -od '-z 3' main_kdd_$s.tex
	ptex2pdf -u -l -s -od '-z 3' main_kdd_$s.tex
	ptex2pdf -u -l -s -od '-z 3' main_kdd_$s.tex
	upmendex -r -c -g -s kddbook.ist -- main_kdd_$s
	ptex2pdf -u -l -s -od '-z 3' main_kdd_$s.tex
	ptex2pdf -u -l -s -od '-z 3' main_kdd_$s.tex
done
