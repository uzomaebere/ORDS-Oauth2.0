CREATE OR REPLACE PACKAGE BODY pkapi_00_oauth AS
	/**
  * ===========================================================<br/>
  *  PURPOSE : All Purpose <br/>
  *  SCHEMA:  <br/>
  *  Created By       : Uzoma Umemba <br/>
  *  Date Created     : 20-AUG-2018 <br/>
  *  Release Version  : 1.0 <br/>
  * ===========================================================<br/>
  * @headcom
  */
--Create roles and priviledges
	PROCEDURE pr_crt_rol is 
		v_roles owa.vc_arr;
		v_patterns owa.vc_arr;
	BEGIN
		ords_metadata.ords.create_role(p_role_name => 'portal_role');
		
		v_roles(1) := 'portal_role';
		v_patterns(1) := '/api-v2.0/core/rest/*';
		ords_metadata.ords.define_privilege(p_privilege_name => 'portal_privilege',
                        p_roles          => v_roles,
                        p_patterns       => v_patterns,
                        p_label          => 'Portal Access',
                        p_description    => 'Access to portal web services');
		ords_metadata.ords.create_privilege_mapping(p_privilege_name => 'portal_privilege',
                                p_patterns       => v_patterns);
		
		COMMIT;
	END pr_crt_rol;
	--
	--Client Credentials OAUTH 2.0 Method
	PROCEDURE pr_crt_clt IS 
	BEGIN
		ords_metadata.oauth.create_client(p_name => 'Client 1',
                      p_grant_type       => 'client_credentials',
					  p_origins_allowed => NULL,
					  p_owner			=> 'Portal',
                      p_description      => 'OAUTH2 Client for Portal',
					  p_redirect_uri    => NULL,
                      p_support_email    => 'support@neulogicsolutons.com',
					  p_support_uri     => NULL,
                      p_privilege_names  => 'PortalPrivilege');
		ords_metadata.oauth.grant_client_role(p_client_name => 'Client 1',
                          p_role_name   => 'portal_role');
		COMMIT;
	END pr_crt_clt;
	--
	--Implicit Grant OAUTH 2.0 Method
	--
	PROCEDURE pr_crt_imp_clt as
	Begin
		ords_metadata.oauth.create_client (
						p_name		=> 'Portal Client',
						p_grant_type      => 'implicit',
						p_owner           => 'Portal',
						p_description     => 'A client for portal',
						p_redirect_uri    => NULL,
						p_support_email   => 'support@neulogicsolutons.com',
						p_support_uri     => NULL,
						p_privilege_names => 'portal_privilege');
						
		ords_metadata.oauth.grant_client_role (
						p_client_name		=> 'Portal Client',
						p_role_name			=> 'portal_role');
		COMMIT;
	END pr_crt_imp_clt;
--
-- Delete metadata for client role mapping						
	PROCEDURE pr_del_clt as
	BEGIN
		ords_metadata.oauth.revoke_client_role (
						p_client_name		=> 'Portal Client',
						p_role_name			=> 'portal_role');
						
		ords_metadata.oauth.delete_client (
						p_name			=> 'Portal Client');
		COMMIT;
	END pr_del_clt;
--
END pkapi_00_oauth;
