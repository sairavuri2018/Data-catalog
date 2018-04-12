OUT=$(curl https://demo4391077.mockable.io/catalog/getall)

instid=( $(jq -r '.[].instance_id' sout) )

expdate=( $(jq -r '.[].expirationDate'  sout) )

termdate=( $(jq -r '.[].terminationDate'  sout) )

purpose=( $(jq -r '.[].purpose'  sout) )

project=( $(jq -r '.[].project'  sout) )

environment=( $(jq -r '.[].environment'  sout) )

instanceowner=( $(jq -r '.[].instance_owner' sout) )

n=${#instid[@]}

echo "$n"

for ((i=0;i<n;i++))

do

#echo "aws ec2 create-tags --resources "${arr[$i]}" --tags Key=Term_date,Val$

echo "aws ec2 create-tags --resources "${instid[$i]}" --tags '[ {\"Key\": \"Term_date\", \"Value\":\""${termdate[$i]}"\"},{\"Key\": \"EXP_date\", \"Value\":$

done
