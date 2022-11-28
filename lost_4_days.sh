СhatID=
BotToken=

Text=`mysql -uuser asteriskcdrdb  < /home/user/bin/lost_4_day.sql`
Date=`echo  $(date +"%y-%m-%d %T")`
if [ -z "$Text" ]
    then

        echo 1 >> /dev/null

    else

		curl -s -X POST "https://api.telegram.org/$BotToken/sendMessage" -F chat_id="$СhatID" -F text="Пропущеные за 4 дня <b>$Date</b>. $Text" -F parse_mode="HTML"

fi
