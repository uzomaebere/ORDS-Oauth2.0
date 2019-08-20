CREATE OR REPLACE PACKAGE pkapi_00_oauth AS 

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

	PROCEDURE pr_crt_rol;
	PROCEDURE pr_crt_clt;
	--
	--Implicit OAUTH 2.0
	PROCEDURE pr_crt_imp_clt;
	--Delete client role
	PROCEDURE pr_del_clt;
END pkapi_00_oauth;