#!/bin/bash
for i in men food cosmetic interior-3c-living
do
cp newArrival-lady.json newArrival-$i.json
echo $i
sed -i "s/lady/$i/g" newArrival-$i.json


if [ "men" == $i ]; then
   sed -i "s/editorialAd/editorialAd3/g" newArrival-$i.json
elif [ "food" == $i ]; then

   sed -i "s/editorialAd/editorialAd1/g" newArrival-$i.json
elif [ "cosmetic" == $i ]; then

   sed -i "s/editorialAd/editorialAd4/g" newArrival-$i.json
elif [ "interior-3c-living" == $i ]; then

   sed -i "s/editorialAd/editorialAd2/g" newArrival-$i.json
else
   echo ""
fi


done
