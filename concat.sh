for s in amazonpod tatsujin present
do
	echo ${s}
 	dviconcat -o kdd_${s}.dvi col/main_kdd_${s}_hontobira.dvi main_kdd_${s}.dvi col/main_kdd_${s}_col.dvi col/main_kdd_${s}_oku.dvi 
	dvipdfmx -f nxtpub-kddbookcls-haranoaji.map kdd_${s}.dvi
done
 
for s in keiyo
do
 	echo ${s}
 	dviconcat -o kdd_${s}.dvi col/main_kdd_${s}_hontobira.dvi main_kdd_${s}.dvi  col/main_kdd_${s}_col.dvi col/main_kdd_${s}_oku_keiyo.dvi 
 	dvipdfmx -f nxtpub-kddbookcls-haranoaji.map kdd_${s}.dvi
done

# 三省堂
for s in keiyo
do
	echo ${s}
	dviconcat -o kdd_sanseido.dvi col/main_kdd_${s}_hontobira.dvi main_kdd_${s}.dvi col/main_kdd_${s}_col.dvi col/main_kdd_${s}_oku.dvi 
	dvipdfmx -f nxtpub-kddbookcls-haranoaji.map kdd_sanseido.dvi
done

isbn=9784764960329
nnumber=N01234
mv kdd_amazonpod.pdf ${isbn}_paperback_interior.pdf
mv kdd_keiyo.pdf     ${isbn}_keiyo.pdf
mv kdd_sanseido.pdf  ${nnumber}.pdf
mv kdd_present.pdf   ${isbn}_present.pdf
mv kdd_tatsujin.pdf  ${isbn}_tatsujin.pdf
