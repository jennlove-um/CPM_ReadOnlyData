
SELECT *   FROM ( 
WITH
     excluded_site_id 
       AS (
               (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = 'ImJustADummySiteIdStringHAHAYouCantFindMe')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = 'f2867e81-4954-4c27-ab55-fc9dd545bcf8')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = 'd9254f6e-e201-4a83-9bda-9ef015a5dbc4')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '306c663b-faaa-4b4e-95a5-30eeb198dcf6')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = 'ef72a1a9-300d-41fa-9f5f-1f8aa40afcfa')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '3b25802e-99d6-4c67-a86e-6ad4e0a25e94')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = 'f85d2cde-22b2-4f87-9698-b61fd51b8eef')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '103560c1-409b-4efc-b7e6-e0a6f2a562fb')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '49e65c6d-8021-41ee-b10d-925f44f24dc8')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '1114447865716-19816380')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '1116357771173-20150707')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '1065049660132-200130')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '0143bc53-cd85-4785-bff8-ea91de2b51ee')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '1097931068569-2883089')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '1098215494414-2923710')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '1110561025582-18753263')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '1097008430519-2671320')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '6ce84fb8-f1c0-4a1f-9e46-4e2a92026379')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '34e68708-d56e-4fc2-a8f1-66519a8993c3')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '1092982617998-1527222')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '1094761206623-1975519')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '6136d20e-5efe-4c40-987d-a6d538501e28')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '23877706-c7db-4999-8b03-879291f7347b')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '3e324a8f-526d-4761-b433-cadfda2020e3')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '198249f5-4085-45fb-80e9-973e20f0b52c')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '0190840f-0226-4f4a-a277-2d57e50168e7')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '31a5da74-aea3-4b30-a31e-f2bd08e911f3')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '83fa69bc-6f3b-473d-bdd8-119b2652df46')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = 'fe189c68-2bff-4703-a56d-ce76dbdca12b')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = 'fa1b7c3d-5334-47cc-ac07-0aaa057de981')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = 'e3e047ef-fb41-4fe1-b06a-fb9177c4a9d1')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '99e7b97d-cdcb-443a-870a-ef2bea5869fc')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '2dcbca62-101a-488a-915d-6f9cf9ed4471')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '4f26b210-1dad-496c-9ad2-ce9c8ad6c002')
 UNION  (SELECT site_id FROM   CTQA_USER.sakai_site  WHERE  site_id = '1094761206623-1975519')
  )
,
      candidate_site_id 
        AS (
            SELECT site_id
            FROM
                  CTQA_USER.sakai_site
            WHERE
                CTQA_USER.sakai_site.type IN ('specialized_project')
            )
,
     target_site_id
       AS (
          SELECT candidate_site_id.site_id FROM candidate_site_id
          LEFT OUTER JOIN excluded_site_id
          ON candidate_site_id.site_id = excluded_site_id.site_id
          WHERE excluded_site_id.site_id is null
           )           

select CURRENT_TIMESTAMP AS ACTION_TIME, SITE_ID AS SITE_ID, 'ACTION_LOG_LIST' AS ACTION_TAKEN from dual,target_site_id 
)
;
