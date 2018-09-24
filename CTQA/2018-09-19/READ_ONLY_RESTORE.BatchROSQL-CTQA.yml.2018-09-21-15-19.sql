/****** initial count ******/

SELECT COUNT(*) FROM CTQA_USER.SAKAI_REALM_RL_FN;

INSERT INTO CTQA_USER.sakai_realm_rl_fn 
   SELECT * 
   FROM   CTQA_USER.SAKAI_REALM_RL_FN_18091917 SRRF 
   WHERE  EXISTS (
          SELECT 1 FROM (
           WITH 
     target_site_id
       AS (
                   (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '07d54a12-2530-4f2f-a220-b0a31e418f51')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '659d544e-f9b4-4745-84e1-3a4453d7e58e')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '5364ef04-3947-4efe-961f-2a2f44b5a41b')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = 'a9685e1a-d0a8-4e3f-9276-bacbd4b3b682'))           ,
      role_keys 
        AS (
        SELECT role_key AS role_key 
        FROM   CTQA_USER.sakai_realm_role 
        WHERE  role_name IN (
'Member','Observer','Organizer','Owner','Affiliate',
'Assistant','Instructor','Librarian','Student')),
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
'site.upd.site.mbrshp','site.upd.grp.mbrshp','asn.delete','asn.grade','asn.new',
'asn.revise','asn.submit','assessment.createAssessment','assessment.deleteAssessment.any','assessment.deleteAssessment.own',
'assessment.editAssessment.any','assessment.editAssessment.own','assessment.publishAssessment.any','assessment.publishAssessment.own','assessment.questionpool.create',
'assessment.questionpool.delete.own','assessment.questionpool.edit.own','assessment.submitAssessmentForGrade','assessment.takeAssessment','assessment.template.create',
'assessment.template.delete.own','assessment.template.edit.own','disc.delete.any','disc.delete.own','disc.new',
'disc.new.topic','disc.revise.any','disc.revise.own','lessonbuilder.upd')),
     site_realm_key 
       AS(
         SELECT CTQA_USER.sakai_realm.realm_key
         FROM CTQA_USER.sakai_realm,target_site_id
         WHERE CTQA_USER.sakai_realm.realm_id LIKE '%'||target_site_id.site_id||'%')
   -- list grant rows to act on.
    SELECT SRRF_2.*
          FROM   CTQA_USER.SAKAI_REALM_RL_FN_18091917 SRRF_2,
                role_keys,function_keys,site_realm_key
          WHERE  SRRF_2.role_key = role_keys.role_key
             AND SRRF_2.function_key = function_keys.function_key
             AND SRRF_2.realm_key =  site_realm_key.realm_key
     -- name the table generate by the WITH
     ) SELECTED_KEYS;

/****** final count ******/

SELECT COUNT(*) FROM CTQA_USER.SAKAI_REALM_RL_FN;

