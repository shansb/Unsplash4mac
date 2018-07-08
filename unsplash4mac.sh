#!/bin/bash


#欢迎语😁
welcome(){
	echo -n $USER"，"
	greeting=""
	hour=$(date +%H)
	if [[ hour -ge 22 ]];then
		greeting="夜深了。"
	elif [[ hour -lt 5 ]]; then
		greeting="要努力，但也要休息。"
	elif [[ hour -ge 5 && hour -lt 8 ]]; then
		greeting="又是元气满满的一天！^_^"
	elif [[ hour -ge 8 && hour -lt 11 ]]; then
		greeting="上午好。"
	elif [[ hour -ge 11 && hour -lt 13 ]]; then
		greeting="现在是中午啦。"
	elif [[ hour -ge 13 && hour -lt 17 ]]; then
		greeting="下午好呀。"
	elif [[ hour -ge 17 && hour -lt 19 ]]; then
		greeting="该吃顿可口的晚餐啦。"
	elif [[ hour -ge 19 && hour -lt 22 ]]; then
		greeting="不负才华"
	fi
	echo ${greeting}
}
# 显示菜单
showMenu(){
	welcome
	echo "----"
	echo "手动刷新"
	if [[ 2 -eq $1 ]]; then
		echo "SUBMENU|循环时间|1小时|2小时✓|4小时"
	elif [[ 4 -eq $1 ]]; then
		echo "SUBMENU|循环时间|1小时|2小时|4小时✓"
	else
		echo "1">setting
		echo "SUBMENU|循环时间|1小时✓|2小时|4小时"
	fi
	echo "帮助"
	echo "关于"
}
# 变更配置
changeCycleTime(){
	if [[ "2小时" = $1 ]]; then
		echo '2'>setting
	elif [[ "4小时" = $1 ]]; then
		echo '4'>setting
	else
		echo '1'>setting
	fi
}

# start
# 获取刷新时间
touch "setting"
cycleTime=$(cat setting)
# 获取上次的pid
touch "pid"
prePid=$(cat pid)
# 获取当前pid
currPid=$(ps -ef|grep Unsplash4mac|awk '{print $2}'|head -1)
# 确认是否启动应用首次执行
if [[ prePid -ne currPid ]]; then
	# 首次运行，记录pid，更换壁纸
	# echo "start app">>log
	echo ${currPid}>pid
	nohup at -f wallpaperChanger.sh now + 1 minutes >/dev/null &
	# bash ./wallpaperChanger.sh &

fi
# echo "continue">>log 
if [[ -z $1 ]]; then
	showMenu cycleTime
elif [[ "手动刷新" = $1 ]]; then
	bash ./wallpaperChanger.sh "1" &
elif [[ "帮助" = $1 ]]; then
	echo "ALERT:帮助|1.点击手动刷新可以即时更换壁纸2.点击循环时间可以选择程序的自动刷新时间"
elif [[ "关于" = $1 ]]; then
	echo "ALERT:关于|本程序壁纸源自unsplash.com。特别感谢Platypus这么优秀的打包应用。项目主页：wallpaper.imshan.top"
else
	changeCycleTime $1
fi
# echo "end">>log
exit 0