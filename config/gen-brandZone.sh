for i in 2 3 4 5
do

cp brandZone-tab1.json brandZone-tab$i.json
sed -i "s/1/$i/g" brandZone-tab$i.json

done
