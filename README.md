# Unsplash4Mac

### 实现方式

- 通过shell实现自动刷新和手动刷新功能
- 通过Platypus打包

### 使用方式

1. 打开mac的atrun命令：`sudo launchctl load -w  /System/Library/LaunchDaemons/com.apple.atrun.plist`

2. 调整at命令的时区：

   `sudo launchctl unload -F /System/Library/LaunchDaemons/com.apple.atrun.plist`

   `sudo launchctl load -F /System/Library/LaunchDaemons/com.apple.atrun.plist`

3. 打开app

4. 点击app

### 截图

![](https://github.com/shansb/Unsplash4mac/blob/master/screenshot.png?raw=true)

### 已知问题

- 每次打开软件需要点击一次才能启动定时任务 - -！