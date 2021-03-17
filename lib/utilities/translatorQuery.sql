-- SQLite
SELECT *
FROM TranslationPivot tp
    JOIN Phrase eng ON phrase_id_english = eng.phrase_id
    JOIN Phrase loc ON phrase_id_local = loc.phrase_id
WHERE (eng.phrase = 'mayad nga aga' OR loc.phrase = 'mayad nga aga' )
    AND loc.language_id LIKE '%';



-- SELECT phrase_id
-- FROM Phrase
-- WHERE phrase = 'good morning';

-- -- english to local
SELECT tp.translation_id, loc.phrase_id, loc.phrase, loc.language_id
FROM TranslationPivot tp
    JOIN Phrase eng ON phrase_id_english = eng.phrase_id
    JOIN Phrase loc ON phrase_id_local = loc.phrase_id
WHERE (eng.phrase = 'good morning');



-- -- local to english
SELECT tp.translation_id, eng.phrase_id, eng.phrase, eng.language_id
FROM TranslationPivot tp
    JOIN Phrase eng ON phrase_id_english = eng.phrase_id
    JOIN Phrase loc ON phrase_id_local = loc.phrase_id
WHERE (loc.phrase = 'mayad nga aga' AND eng.language_id = 0);

-- SELECT phrase_id_english, phrase_id_local
-- FROM TranslationPivot tp
--     JOIN Phrase eng ON phrase_id_english = eng.phrase_id
--     JOIN Phrase loc ON phrase_id_local = loc.phrase_id
-- WHERE (eng.phrase = 'mayad nga aga' OR loc.phrase = 'mayad nga aga' )
--     AND loc.language_id LIKE '%';

-- SELECT *
-- FROM Phrase
-- WHERE phrase_id IN ((
--     SELECT phrase_id_english
--     FROM TranslationPivot tp
--     JOIN Phrase eng ON phrase_id_english = eng.phrase_id
--     JOIN Phrase loc ON phrase_id_local = loc.phrase_id
-- WHERE (eng.phrase = 'mayad nga aga' OR loc.phrase = 'mayad nga aga' )
--     AND loc.language_id LIKE '%'    
--     ),(SELECT phrase_id_local
-- FROM TranslationPivot tp
--     JOIN Phrase eng ON phrase_id_english = eng.phrase_id
--     JOIN Phrase loc ON phrase_id_local = loc.phrase_id
-- WHERE (eng.phrase = 'mayad nga aga' OR loc.phrase = 'mayad nga aga' )
--     AND loc.language_id LIKE '%'));


SELECT *
FROM Phrase
WHERE phrase_id IN (
    SELECT phrase_id_english
FROM TranslationPivot tp
    JOIN Phrase eng ON phrase_id_english = eng.phrase_id
    JOIN Phrase loc ON phrase_id_local = loc.phrase_id
WHERE (eng.phrase = 'mayad nga aga' OR loc.phrase = 'mayad nga aga' )
    AND loc.language_id LIKE '%'
    );



SELECT tp.translation_id, loc.phrase_id, loc.phrase, loc.language_id, lang.language
FROM TranslationPivot tp
    JOIN Phrase eng ON phrase_id_english = eng.phrase_id
    JOIN Phrase loc ON phrase_id_local = loc.phrase_id
    JOIN Language lang ON loc.language_id = lang.language_id
WHERE (eng.phrase = 'good morning');

SELECT tp.translation_id, eng.phrase_id, eng.phrase, eng.language_id, lang.language
FROM TranslationPivot tp
    JOIN Phrase eng ON phrase_id_english = eng.phrase_id
    JOIN Phrase loc ON phrase_id_local = loc.phrase_id
    JOIN Language lang ON loc.language_id = lang.language_id
WHERE (loc.phrase = 'ma-ayong aga' AND loc.language_id = 3);