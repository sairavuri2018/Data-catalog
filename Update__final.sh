OUT=$(curl https://demo9159024.mockable.io/getall)

instid=( $(jq -r '.[].instance_id' <<< "$OUT") )

expdate=( $(jq -r '.[].expirationDate' <<< "$OUT") )

termdate=( $(jq -r '.[].terminationDate'  <<< "$OUT") )

purpose=( $(jq -r '.[].purpose'  <<< "$OUT") )

project=( $(jq -r '.[].project'  <<< "$OUT") )

environment=( $(jq -r '.[].environment'  <<< "$OUT") )

instanceowner=( $(jq -r '.[].instance_owner' <<< "$OUT") )

n=${#instid[@]}

echo "$n"

for ((i=0;i<n;i++))

do

#echo "aws ec2 create-tags --resources "${arr[$i]}" --tags Key=Term_date,Val$

echo "aws ec2 create-tags --resources "${instid[$i]}" --tags '[ {\"Key\": \"Term_date\", \"Value\":\""${termdate[$i]}"\"},{\"Key\": \"EXP_date\", \"Value\":\""${expdate[$i]}"\"}, {\"Key\": \"purpose\", \"Value\":\""${purpose[$i]}"\"}, {\"Key\": \"project\", \"Value\":\""${project[$i]}"\"}, {\"Key\": \"instance_owner\", \"Value\":\""${instanceowner[$i]}"\"}, {\"Key\": \"environment\", \"Value\":\""${environment[$i]}"\"}]'" | bash -

done