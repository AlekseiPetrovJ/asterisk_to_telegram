SELECT

        COUNT(DISTINCT uniqueid) AS "Количество разных звонков:"
FROM
        cdr
WHERE
        calldate > DATE_SUB(NOW(), INTERVAL 8 HOUR)
        AND did = '3479258822'
        AND disposition='ANSWERED';

SELECT

        SUM(duration)/60 AS "Длительность, мин:"
FROM
        cdr
WHERE
        calldate > DATE_SUB(NOW(), INTERVAL 8 HOUR)
        AND did = 'XXXXXXXXXX'
        AND disposition='ANSWERED';
