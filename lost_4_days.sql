#EXPLAIN
SELECT
        MAX(lc.calldate) AS "Дата",
        lc.src AS "Номер",
        lc.dst AS "Получатель",
        lc.duration AS "Длительность, сек"

FROM
        cdr as lc

LEFT JOIN
        cdr as rptc  #repeatcall Клиенты сами нам перезвонили
ON
        RIGHT (lc.src,10) = RIGHT (rptc.src, 10) #RIGHT -сравниваем только последние 10 символов номера телефона
        AND rptc.lastapp = "Dial"
        AND rptc.disposition = "ANSWERED"
        AND rptc.duration > 12
#       AND rptc.calldate >= lc.calldate
        AND rptc.calldate >= DATE_SUB(NOW(), INTERVAL 4 DAY)

LEFT JOIN
        cdr as cb   #callback Мы перезвонили
ON
        RIGHT (lc.src, 10) = RIGHT (cb.dst, 10)
        AND cb.lastapp = "Dial"
        AND cb.disposition = "ANSWERED"
        AND cb.duration > 12
        #AND cb.calldate >= lc.calldate
        AND cb.calldate >=  DATE_SUB(NOW(), INTERVAL 4 DAY)

WHERE
        lc.calldate > DATE_SUB(NOW(), INTERVAL 4 DAY) #ДатаВремя звонка за 10 часов назад от текущего времени
        AND lc.did = "XXXXXXXXX" #Звонок на номер получатель
        AND LENGTH(  lc.src ) >3
        AND ((lc.lastapp <> "Dial"  AND lc.disposition = "ANSWERED") OR (lc.lastapp = "Dial"  AND lc.disposition <> "ANSWERED")) #Пропущенный
        AND rptc.calldate IS NULL #Клиент после этого не перезвонил
        AND cb.calldate IS NULL #Мы после этого не перезвонили
GROUP BY lc.src
ORDER BY lc.calldate DESC

;
