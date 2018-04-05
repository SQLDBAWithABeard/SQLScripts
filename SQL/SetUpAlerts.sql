-- A script to set up DAtabase mail alerting and operators for SQL Server Severity Errors 016 to 025 and 823,824,825
/*
CTRL + H and replace
##accountname## - with Account Name
##EmailAddress## - with Email Address
##displayname## - With display Name
##replytoaddress## - with reply to address
##mailserver## - with mail server
##profilename## - with profile name
##Operator## - Operator Name
##OperatorEmail## - Operator Email
*/



EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'AccountRetryAttempts', @parameter_value=N'1', @description=N'Number of retry attempts for a mail server'
EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'AccountRetryDelay', @parameter_value=N'60', @description=N'Delay between each retry attempt to mail server'
EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'DatabaseMailExeMinimumLifeTime', @parameter_value=N'600', @description=N'Minimum process lifetime in seconds'
EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'DefaultAttachmentEncoding', @parameter_value=N'MIME', @description=N'Default attachment encoding'
EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'LoggingLevel', @parameter_value=N'2', @description=N'Database Mail logging level: normal - 1, extended - 2 (default), verbose - 3'
EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'MaxFileSize', @parameter_value=N'1000000', @description=N'Default maximum file size'
EXEC msdb.dbo.sysmail_configure_sp @parameter_name=N'ProhibitedExtensions', @parameter_value=N'exe,dll,vbs,js', @description=N'Extensions not allowed in outgoing mails'
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

-- Add an operator to the 
USE [msdb]
GO
EXEC msdb.dbo.sp_add_operator @name=N'##Operator##', 
		@enabled=1, 
		@pager_days=0, 
		@email_address=N'##OperatorEmail##'
GO



USE [msdb]  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Severity 014',  

@message_id=0,  

@severity=14,   

@enabled=1,  

@delay_between_responses=60,  

@include_event_description_in=1,  

@job_id=N'00000000-0000-0000-0000-000000000000';  

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 014',  @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Severity 016',  

@message_id=0,  

@severity=16,   

@enabled=1,  

@delay_between_responses=60,  

@include_event_description_in=1,  

@job_id=N'00000000-0000-0000-0000-000000000000';  

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 016',  @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Severity 017',  

@message_id=0,  

@severity=17,  

@enabled=1,  

@delay_between_responses=60,  

@include_event_description_in=1,  

@job_id=N'00000000-0000-0000-0000-000000000000';  

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 017',  @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Severity 018',  

@message_id=0,  

@severity=18,  

@enabled=1,  

@delay_between_responses=60,  

@include_event_description_in=1,  

@job_id=N'00000000-0000-0000-0000-000000000000';  

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 018',  @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Severity 019',  

@message_id=0,  

@severity=19,  

@enabled=1,  

@delay_between_responses=60,  

@include_event_description_in=1,  

@job_id=N'00000000-0000-0000-0000-000000000000';  

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 019',  @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Severity 020',  

@message_id=0,  

@severity=20,  

@enabled=1,  

@delay_between_responses=60,  

@include_event_description_in=1,  

@job_id=N'00000000-0000-0000-0000-000000000000';  

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 020',  @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Severity 021',  

@message_id=0,  

@severity=21,  

@enabled=1,  

@delay_between_responses=60,  

@include_event_description_in=1,  

@job_id=N'00000000-0000-0000-0000-000000000000';  

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 021',  @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Severity 022',  

@message_id=0,  

@severity=22,  

@enabled=1,  

@delay_between_responses=60,  

@include_event_description_in=1,  

@job_id=N'00000000-0000-0000-0000-000000000000';  

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 022',  @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Severity 023',  

@message_id=0,  

@severity=23,  

@enabled=1,  

@delay_between_responses=60,  

@include_event_description_in=1,  

@job_id=N'00000000-0000-0000-0000-000000000000';  

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 023',  @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Severity 024',  

@message_id=0,  

@severity=24,  

@enabled=1,  

@delay_between_responses=60,  

@include_event_description_in=1,  

@job_id=N'00000000-0000-0000-0000-000000000000';  

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 024',  @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Severity 025',  

@message_id=0,  

@severity=25,  

@enabled=1,  

@delay_between_responses=60,  

@include_event_description_in=1,  

@job_id=N'00000000-0000-0000-0000-000000000000';  

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 025',  @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Error Number 823',  

@message_id=823,  

 @severity=0,  

 @enabled=1,  

 @delay_between_responses=60,  

 @include_event_description_in=1,  

 @job_id=N'00000000-0000-0000-0000-000000000000' 

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Error Number 823',  @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Error Number 824',  

 @message_id=824,  

 @severity=0,  

 @enabled=1,  

 @delay_between_responses=60,  

 @include_event_description_in=1,  

 @job_id=N'00000000-0000-0000-0000-000000000000' 

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Error Number 824', @operator_name=N'##Operator##', @notification_method = 7;  

GO  

EXEC msdb.dbo.sp_add_alert @name=N'Error Number 825',  

 @message_id=825,  

 @severity=0,  

 @enabled=1,  

 @delay_between_responses=60,  

 @include_event_description_in=1,  

 @job_id=N'00000000-0000-0000-0000-000000000000' 

GO  

EXEC msdb.dbo.sp_add_notification @alert_name=N'Error Number 825',  @operator_name=N'##Operator##', @notification_method = 7;  

GO 
