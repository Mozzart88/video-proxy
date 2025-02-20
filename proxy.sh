#!/bin/bash
in_folder=$1
out_folder=$2

key=$TG_API_KEY
user_id=$TG_CHAT_ID

for file in $in_folder/*.MP4; do
	filename=$(basename "$file")
	filename_noext="${filename%.MP4}"
	echo "$file -> $out_folder/$filename"
	curl https://api.telegram.org/bot$key/sendMessage -H 'Content-Type: application/json' -d "{\"chat_id\": $user_id, \"text\": \"Starting: $filename\"}"
	ffmpeg -i "$file" -vf "scale=1280:-1" -c:v libx264 -crf 23 -preset ultrafast -c:a aac "$out_folder/$filename"
	curl https://api.telegram.org/bot$key/sendMessage -H 'Content-Type: application/json' -d "{\"chat_id\": $user_id, \"text\": \"Done: $filename\"}"
	temp=($(cat /sys/class/thermal/thermal_zone0/temp))
	if (( temp > 56000 )); then
		echo "sleeping..."
		while (( temp > 56000 )); do
			sleep 15
			temp=($(cat /sys/class/thermal/thermal_zone0/temp))
		done
	fi
done

res=($(ls -1 $out_folder))
files="${res[@]}"
curl https://api.telegram.org/bot$key/sendMessage -H 'Content-Type: application/json' -d "{\"chat_id\": $user_id, \"text\": \"Done:\n$files\"}"

