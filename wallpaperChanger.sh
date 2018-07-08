#!/bin/bash

changeWallpaper(){
	#XXX 获取显示器尺寸，这里应该要进行List循环来获取多个显示器的分辨率
	height=$(system_profiler SPDisplaysDataType | grep Resolution|awk '{print $4}')
	width=$(system_profiler SPDisplaysDataType | grep Resolution|awk '{print $2}')
	url="https://source.unsplash.com/random/"${width}"x"${height}
	savePath=$(pwd)"/wallpaperCache/"
	rm -rf ${savePath}
	mkdir -p ${savePath}
	name=$(date +%y%m%d%H%M%S)
	#TODO 需要关闭
	# echo "changeWallpaper @ "${name} >> log
	name=${name}".jpg"
	dest=${savePath}${name}
	curl --silent -Lo ${dest} ${url}
	# 设置壁纸
	osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"${dest}\""			
}
#TODO 需要关闭
# touch "log"
if [[ 1 -eq $1 ]]; then
	# echo "refresh" >> log
	changeWallpaper
else
	# 创建本次循环的id
	id=$(date +%y%m%d%H%M%S)
	# 写入文件
	touh "id"
	echo ${id}>id
	# 获取循环时间
	cycleTime=$(cat setting)
	# pid
	prePid=$(cat pid)
	while [[ true ]]; do
		currId=$(cat id)
		# 获取当前pid
		currPid=$(ps -ef|grep Unsplash4mac|awk '{print $2}'|head -1)
		if [[ id -eq currId && prePid -eq currPid ]]; then
			changeWallpaper
			# echo "sleep" >> log
			# echo $[${cycleTime}*3600] >> log
			sleep $[${cycleTime}*3600]
		else
			# echo "exit" >> log
			exit 0
		fi
	done
fi
