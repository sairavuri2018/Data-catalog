checking(){

        EXP=$1
        DATE=`date +"%D"`
        #EXP=$($EXP +"%m%d%y")
        EXP=$(date -d $EXP +"%m%d%Y")
        TODAY=$(date --date yesterday +"%m%d%Y")
        #TODAY=$(date +"%Y%m%d")
         echo $EXP
         echo $TODAY
        if [[ "$TODAY" > "$EXP" ]]; then
               aws ec2 terminate-instances --instance-ids $INSTANCE_ID
echo "tes"
fi


}

process(){

        echo $TAGS | jq -c '.[]' | while read TAG; do

                FLAG="false"
                if [ "$(echo $TAG | jq -r '.Key')" = "terminate_date" ]; then
                        EXP=`echo $TAG | jq -r '.Value'`
                        FLAG="true"

                fi

                if [ "$FLAG" = "true" ]; then
                       checking $EXP
fi
        done

}

# List all the instances in the region
RESERVATIONS=`aws ec2 describe-instances | jq -c '.'`

echo $RESERVATIONS | jq -c '.Reservations[]' | while read INSTANCES; do

        #Iterate over instances
        echo $INSTANCES | jq -c '.Instances[]' | while read INSTANCE; do

                INSTANCE_ID=`echo $INSTANCE | jq -r '.InstanceId'`
                TAGS=`echo $INSTANCE | jq -c '.Tags'`

#echo $TAGS
#echo $INSTANCE_ID
process
        done
done

