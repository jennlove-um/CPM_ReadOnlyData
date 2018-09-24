/****** Run the deletion ******/

DELETE FROM CTQA_USER.sakai_realm_rl_fn WHERE (role_key, realm_key, function, key) in (SELECT role_key, realm_key, function_key from CTQA_USER.SAKAI_REALM_RL_FN_T_18091917);

/****** final count ******/

SELECT COUNT(*) FROM CTQA_USER.SAKAI_REALM_RL_FN;
