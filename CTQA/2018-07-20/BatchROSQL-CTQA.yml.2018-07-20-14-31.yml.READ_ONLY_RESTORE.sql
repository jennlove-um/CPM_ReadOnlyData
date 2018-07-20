/****** initial count ******/

SELECT COUNT(*) FROM CTQA_USER.SAKAI_REALM_RL_FN;


INSERT INTO CTQA_USER.sakai_realm_rl_fn 
   SELECT * 
   FROM   CTQA_USER.sakai_realm_rl_fn_<DATESTAMP> SRRF 
   WHERE  EXISTS (
          SELECT 1 FROM (
           WITH 
     target_site_id
       AS (
                   (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = 'ImJustADummySiteIdStringHAHAYouCantFindMeEither')
           )           

,
      role_keys 
        AS (
        SELECT role_key AS role_key 
        FROM   CTQA_USER.sakai_realm_role 
        WHERE  role_name IN (
'Member','Observer','Organizer','Owner','Affiliate',
'Assistant','Instructor','Librarian','Student','access',
'maintain'
                             ))
,
      function_keys
        AS (
        SELECT function_key AS function_key
        FROM   CTQA_USER.sakai_realm_function
        WHERE  function_name IN (
'annc.delete.any','annc.delete.own','annc.new','annc.revise.any','annc.revise.own',
'calendar.delete.any','calendar.delete.own','calendar.import','calendar.new','calendar.revise.any',
'calendar.revise.own','chat.delete.any','chat.delete.channel','chat.delete.own','chat.new',
'chat.new.channel','content.delete.any','content.delete.own','content.hidden','content.new',
'content.revise.any','content.revise.own','content.all.groups','dropbox.maintain','mail.delete.any',
'mail.new','realm.del','realm.upd','realm.upd.own','site.upd',
'site.upd.site.mbrshp','site.upd.grp.mbrshp'
                                 ))
,
     site_realm_key 
       AS(
         SELECT CTQA_USER.sakai_realm.realm_key
         FROM CTQA_USER.sakai_realm,target_site_id
         WHERE CTQA_USER.sakai_realm.realm_id LIKE '%'||target_site_id.site_id||'%'
  )


   -- list grant rows to act on.
    SELECT SRRF_2.*
          FROM   CTQA_USER.sakai_realm_rl_fn_<DATESTAMP> SRRF_2,
                role_keys,function_keys,site_realm_key
          WHERE  SRRF_2.role_key = role_keys.role_key
             AND SRRF_2.function_key = function_keys.function_key
             AND SRRF_2.realm_key =  site_realm_key.realm_key
     -- name the table generate by the WITH
     ) SELECTED_KEYS
     -- now select the rows to delete
  WHERE SRRF.role_key = SELECTED_KEYS.role_key
    AND SRRF.realm_key = SELECTED_KEYS.realm_key
    AND SRRF.function_key = SELECTED_KEYS.function_key
 -- end exists
)

;
/****** final count ******/

SELECT COUNT(*) FROM CTQA_USER.SAKAI_REALM_RL_FN;

