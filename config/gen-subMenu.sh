for i in 2 3 4 5 6 7 8 9 10 11
do

cp subMenu-tab1.json subMenu-tab$i.json
sed -i "s/1/$i/g" subMenu-tab$i.json

done
