#!/bin/bash

printf "\n\nAWS HTTPS Ping Test:\n\n"

# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html
for DC in af-south-1 ap-east-1 ap-northeast-1 ap-northeast-2 ap-northeast-3 ap-south-1 ap-south-2 ap-southeast-1 ap-southeast-2 ap-southeast-3 ap-southeast-4 ca-central-1 eu-central-1 eu-central-2 eu-north-1 eu-south-1 eu-south-2 eu-west-1 eu-west-2 eu-west-3 me-south-1 me-central-1 sa-east-1 us-east-1 us-east-2 us-gov-east-1 us-gov-west-1 us-west-1 us-west-2
do
    printf "$DC: \t$(curl -o /dev/null -s -w %{time_total}\\n https://ec2.$DC.amazonaws.com/ping | xargs -I {} echo "{} * 1000" | bc) ms\n" | expand -t 20
done

# https://github.com/GoogleCloudPlatform/gcping/blob/main/bin/prefer-ipv4.sh
printf "\n\nGCP HTTPS Ping Test:\n\n"

for DC in asia-east1 asia-east2 asia-northeast1 asia-northeast2 asia-northeast3 asia-south1 asia-south2 asia-southeast1 asia-southeast2 australia-southeast1 australia-southeast2 europe-central2 europe-north1 europe-southwest1 europe-west1 europe-west12 europe-west2 europe-west3 europe-west4 europe-west6 europe-west8 europe-west9 me-central1 me-west1 northamerica-northeast1 northamerica-northeast2 southamerica-east1 southamerica-west1 us-central1 us-central1 us-east1 us-east4 us-east5 us-south1 us-west1 us-west1 us-west2 us-west3
do
    printf "$DC: \t$(curl -o /dev/null -s -w %{time_total}\\n https://$DC-run.googleapis.com | xargs -I {} echo "{} * 1000" | bc) ms\n" | expand -t 20
done

get_name() {
    domains='{ "speedtestwe": "West Europe", "speedtestsea": "Southeast Asia", "speedtestea": "East Asia", "speedtestnsus": "North Central US", "speedtestne": "North Europe", "speedtestscus": "South Central US", "speedtestwus": "West US", "speedtesteus": "East US", "speedtestjpe": "Japan East", "speedtestjpw": "Japan West", "speedtestcus": "Central US", "speedtesteus2": "East US 2", "speedtestozse": "Australia Southeast", "speedtestoze": "Australia East", "speedtestukw": "West UK", "speedtestuks": "South UK", "speedtestcac": "Canada Central", "speedtestcae": "Canada East", "speedtestwestus2": "West US 2", "speedtestwestindia": "West India", "speedtesteastindia": "South India", "speedtestcentralindia": "Central India", "speedtestkoreacentral": "Korea Central", "speedtestkoreasouth": "Korea South", "speedtestwestcentralus": "West Central US", "speedtestfrc": "France Central", "speedtestsan": "South Africa North", "speedtestuaen": "UAE North", "speedtestden": "Germany North", "speedtestchn": "Switzerland North", "speedtestchw": "Switzerland West", "azspeednoeast": "Norway East", "speedtestnea": "Brazil", "speedtestesc": "Sweden Central", "azurespeedtestwestus3": "West US 3", "speedtestqc": "Qatar Central", "speedtestplc": "Poland Central" }'
    echo "$domains" | grep -Eo "\"$1\":\s*\"[^\"]+\"" | awk -F ': ' '{print $2}' | tr -d '"'
}

printf "\n\nAzure HTTPS Ping Test:\n\n"

# https://github.com/richorama/AzureSpeedTest2/blob/master/lib/locations.js
# https://github.com/richorama/AzureSpeedTest2/blob/master/lib/speed-test.js#L21
for DC in speedtestwe speedtestsea speedtestea speedtestnsus speedtestne speedtestscus speedtestwus speedtesteus speedtestjpe speedtestjpw speedtestcus speedtesteus2 speedtestozse speedtestoze speedtestukw speedtestuks speedtestcac speedtestcae speedtestwestus2 speedtestwestindia speedtesteastindia speedtestcentralindia speedtestkoreacentral speedtestkoreasouth speedtestwestcentralus speedtestfrc speedtestsan speedtestuaen speedtestden speedtestchn speedtestchw azspeednoeast speedtestnea speedtestesc azurespeedtestwestus3 speedtestqc speedtestplc
do
    printf "$(get_name $DC): \t$(curl -o /dev/null -s -w %{time_total}\\n https://$DC.blob.core.windows.net/cb.json | xargs -I {} echo "{} * 1000" | bc) ms\n" | expand -t 20
done
