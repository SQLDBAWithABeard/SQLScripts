-- A script to set up DAtabase mail alerting and operators for SQL Server Severity Errors 016 to 025 and 823,824,825
/*
CTRL + H and replace
##accountname## - with Account Name
##EmailAddress## - with Email Address
##displayname## - With display Name
##replytoaddress## - with reply to address
##mailserver## - with mail server
##profilename## - with profile name
##Operator## - Operator Name - also sets as teh default operator
##OperatorEmail## - Operator Email
*/

EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'AccountRetryAttempts', @parameter_value=N'1', @description=N'Number of retry attempts for a mail server'
EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'AccountRetryDelay', @parameter_value=N'60', @description=N'Delay between each retry attempt to mail server'
EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'DatabaseMailExeMinimumLifeTime', @parameter_value=N'600', @description=N'Minimum process lifetime in seconds'
EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'DefaultAttachmentEncoding', @parameter_value=N'MIME', @description=N'Default attachment encoding'
EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'LoggingLevel', @parameter_value=N'2', @description=N'Database Mail logging level: normal - 1, extended - 2 (default), verbose - 3'
EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'MaxFileSize', @parameter_value=N'1000000', @description=N'Default maximum file size'
EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'ProhibitedExtensions', @parameter_value=N'exe,dll,vbs,js', @description=N'Extensions not allowed in outing mails'

IF NOT EXISTS(
SELECT 1
FROM msdb.dbo.sysmail_profileaccount pa
JOIN msdb.dbo.sysmail_profile p ON pa.profile_id = p.profile_id
JOIN msdb.dbo.sysmail_account a ON pa.account_id = a.account_id
WHERE p.name = '##profilename##' AND a.name = '##accountname##'
)
BEGIN
	EXEC msdb.dbo.sysmail_add_account_sp @account_name=N'##accountname##', 
		@email_address=N'##EmailAddress##', 
		@display_name=N'##displayname##', 
		@replyto_address=N'##replytoaddress##', 
		@description=N'Mail account for Database Mail',
		@mailserver_name = '##mailserver##'
	EXEC msdb.dbo.sysmail_add_profile_sp @profile_name=N'##profilename##', 
		@description=N'Profile used for database mail for SQL DBA Alerts - automated - Thanks Rob Sewell @SQLDBAWithABeard - https://sqldbawithabeard.com'
	EXEC msdb.dbo.sysmail_add_profileaccount_sp @profile_name=N'##profilename##', @account_name=N'##accountname##', @sequence_number=1
	EXEC msdb.dbo.sysmail_add_principalprofile_sp @principal_name=N'guest', @profile_name=N'##profilename##', @is_default=1
END

-- Add an operator
IF NOT EXISTS(
	SELECT '1'
FROM msdb..sysoperators
WHERE name = '##Operator##' AND email_address = '##OperatorEmail##'
)
BEGIN
EXEC msdb.dbo.sp_add_operator @name=N'##Operator##', 
		@enabled=1, 
		@pager_days=0, 
		@email_address=N'##OperatorEmail##'
END

EXEC master.dbo.sp_MSsetalertinfo @failsafeoperator=N'##Operator##', @notificationmethod=1;

EXEC msdb.dbo.sp_set_sqlagent_properties @email_save_in_sent_folder=1, @databasemail_profile=N'##profilename##', @use_databasemail=1;

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Severity 014'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Severity 014', @message_id=0, @severity=14, @enabled=1, @delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000';
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 014',  @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Severity 016'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Severity 016', @message_id=0, @severity=16, @enabled=1, @delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000';
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 016',  @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Severity 017'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Severity 017', @message_id=0, @severity=17, @enabled=1, @delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000';
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 017',  @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Severity 018'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Severity 018', @message_id=0,  @severity=18, @enabled=1, @delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000';
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 018',  @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Severity 019'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Severity 019', @message_id=0, @severity=19, @enabled=1, @delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000';
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 019',  @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Severity 020'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Severity 020', @message_id=0, @severity=20, @enabled=1, @delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000';
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 020',  @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Severity 021'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Severity 021', @message_id=0, @severity=21, @enabled=1, @delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000';
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 021',  @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Severity 022'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Severity 022', @message_id=0, @severity=22, @enabled=1, @delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000';
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 022',  @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Severity 023'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Severity 023', @message_id=0, @severity=23, @enabled=1, @delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000';
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 023',  @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Severity 024'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Severity 024', @message_id=0,  @severity=24,@enabled=1,@delay_between_responses=60, @include_event_description_in=1,@job_id=N'00000000-0000-0000-0000-000000000000';
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 024',  @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Severity 025'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Severity 025',@message_id=0,@severity=25,@enabled=1,@delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000';
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 025',  @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Error Number 823'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Error Number 823', @message_id=823, @severity=0, @enabled=1, @delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000'
EXEC msdb.dbo.sp_add_notification @alert_name=N'Error Number 823',  @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Error Number 824'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Error Number 824', @message_id=824,@severity=0,@enabled=1,@delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000'
EXEC msdb.dbo.sp_add_notification @alert_name=N'Error Number 824', @operator_name=N'##Operator##', @notification_method = 7;
END

IF NOT EXISTS (
	SELECT 1
	FROM msdb.dbo.sysalerts
 WHERE name = N'Error Number 825'
)
BEGIN
EXEC msdb.dbo.sp_add_alert @name=N'Error Number 825', @message_id=825, @severity=0, @enabled=1, @delay_between_responses=60, @include_event_description_in=1, @job_id=N'00000000-0000-0000-0000-000000000000'
EXEC msdb.dbo.sp_add_notification @alert_name=N'Error Number 825',  @operator_name=N'##Operator##', @notification_method = 7; 
END 