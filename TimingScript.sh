#!/bin/sh
echo -n ,
for((j=2;j<21;j++))
do
	echo -n "$j",
done
echo -e "\r"
for((j=5;j<21;j++))
do
	echo -n "$j",
	for((i=2;i<j-1;i++))
	do
		a.out "$j" "$i"
	done
	echo -e "\r"
done
exit 0
