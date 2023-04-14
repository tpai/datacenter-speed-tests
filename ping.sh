#!/bin/bash

printf "DigitalOcean Ping Test:\n\n"

# https://www.digitalocean.com/docs/platform/availability-matrix/
for DC in NYC1 NYC2 NYC3 SFO1 SFO2 SFO3 TOR1 LON1 FRA1 AMS2 AMS3 SGP1 BLR1
do
    printf "$DC: \t$(ping -i .2 -c 10 -q speedtest-$DC.digitalocean.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20
done


printf "\n\nLinode Ping Test:\n\n"

# https://www.linode.com/speed-test/
for DC in newark atlanta dallas fremont london frankfurt singapore tokyo2 syd1 toronto1 mumbai1
do
    printf "$DC: \t$(ping -i .2 -c 10 -q speedtest.$DC.linode.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20
done

printf "\n\nAWS Ping Test:\n\n"

# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html
for DC in us-east-1 us-east-2 us-west-1 us-west-2 ca-central-1 eu-north-1 eu-central-1 eu-west-1 eu-west-2 eu-west-3 eu-north-1 eu-south-1 ap-east-1 ap-northeast-1 ap-northeast-2 ap-south-1 ap-southeast-1 ap-southeast-2 sa-east-1 me-south-1 af-south-1
do
    printf "$DC: \t$(ping -i .2 -c 10 -q ec2.$DC.amazonaws.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20
done
