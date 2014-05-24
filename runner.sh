for i in $(ls config/*.json)
do
ruby parseData.rb $i
done
