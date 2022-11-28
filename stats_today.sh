СhatID=
BotToken=

Text=`mysql -uuser asteriskcdrdb  < /home/user/bin/stats_today.sql`
Date=`echo  $(date +"%y-%m-%d %T")`
freehd=`df -H | grep "/dev/sda2" | awk '{print $4}'`
FText=`echo -e '\n'$Text '\n'Cвободного места на диске: $freehd `
curl -s -X POST "https://api.telegram.org/$BotToken/sendMessage" -F chat_id="$СhatID" -F text="Статистика <b>$Date</b>. $FText" -F parse_mode="HTML"
