echo -n "Type serviceCommand: "
read serviceCommand

dirName=$(basename $(pwd))
cp template.service $dirName.service

sed -i "s|serviceName|$dirName|g" $dirName.service
sed -i "s|serviceUser|$USER|g" $dirName.service
sed -i "s|serviceDirectory|$(pwd)|g" $dirName.service
sed -i "s|serviceCommand|/bin/sh $dirName.sh|g" $dirName.service

echo 'cd `dirname $0`' > $dirName.sh
echo $serviceCommand >> $dirName.sh

cp $dirName.service /etc/systemd/system/
systemctl --system daemon-reload
systemctl enable $dirName.service
systemctl restart $dirName.service