# print all files (in the current workdir) that end in ".JPG" to stdout

for i in $(ls *.JPG)
#for i in ABC.JPG DEF.JPG
#for i in $(ls)
	# here we use command substitution with the "basename" utility
	# first strip the ".jpg" from the original file name and replace it by ".JPG"
	do 
		#mv "$i" "`basename $i .JPG`.jpg"
		mv "$i" "`echo $i | tr "[:upper:]" "[:lower:]"`"
		
done
