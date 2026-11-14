-- W2 POSSE課題：index.html の区画7〜11と同じ結果を返す SQL を書く
-- 書いた SQL は db コンテナの psql（docker compose exec db psql -U posse -d timetable）で実行し、
-- 表示が index.html の区画と一致することを確かめてから書くこと
-- 曜日（day）は数字のまま返してよい

-- 区画7：すべての授業と教室の情報（科目コードの順）
timetable=# SELECT
timetable-#     courses.code,
timetable-#     courses.name,
timetable-#     courses.room,
timetable-#     rooms.building,
timetable-#     rooms.capacity
timetable-# FROM courses
timetable-# LEFT JOIN rooms
timetable-#     ON courses.room = rooms.code
timetable-# ORDER BY courses.code;


-- 区画8：曜日ごとの授業数（曜日の順）
SELECT day, COUNT(*) AS total_classes
FROM courses
GROUP BY day
ORDER BY day;

-- 区画9：建物ごとの授業数と合計単位（建物名の順）

timetable=# SELECT
timetable-#     rooms.building,
timetable-#     COUNT(*) AS total_classes,
timetable-#     SUM(courses.credits) AS total_credits
timetable-# FROM courses
timetable-# INNER JOIN rooms
timetable-#     ON courses.room = rooms.code
timetable-# GROUP BY rooms.building
timetable-# ORDER BY rooms.building;
-- 区画10：授業を3つ以上担当している教員（授業数の多い順、同数なら名前の順）
timetable=# SELECT teacher, COUNT(*) AS total_classes
timetable-# FROM courses
timetable-# WHERE teacher IS NOT NULL
timetable-# GROUP BY teacher
timetable-# HAVING COUNT(*) >= 3
timetable-# ORDER BY total_classes DESC, teacher ASC;

-- 区画11：授業が1つも入っていない教室（教室コードの順）
timetable=# SELECT rooms.code, rooms.building, rooms.capacity
timetable-# FROM rooms
timetable-# LEFT JOIN courses
timetable-#     ON rooms.code = courses.room
timetable-# WHERE courses.id IS NULL
timetable-# ORDER BY rooms.code;
