##############################
#.SYNOPSIS
# Runs the SQL Script to install SQL Alerts 16-25 and 823,824,825 as well as database mail and operator
#
#.DESCRIPTION
# Gets the script from github and fills in teh generalised values with the parameters
#
#.PARAMETER Instance
# Instance to run the script against
#
#.PARAMETER accountname
# The DBMail account name
#
#.PARAMETER EmailAddress
# The DBMail email from address
#
#.PARAMETER displayname
# The DBNail displayname
#
#.PARAMETER replytoaddress
#The DBMail email reply to address
#
#.PARAMETER mailserver
# The DBMail mailserver
#
#.PARAMETER profilename
#The DBMail profile name
#
#.PARAMETER Operatorname
# The operator name
#
#.PARAMETER OperatorEmail
# the operator email address for receiving the alerts
#
#.EXAMPLE
# SetUpSQLAlerts.ps1 -Instance Instance -accountname DBATeam -EmailAddress DBAAlerts@thebeard.local -displayname DBATeam -replytoaddress TheDBATeam@TheBeard.Local -mailserver mail.TheBeard.Local -profilename DBATeam -Operatorname 'The DBA Team' -OperatorEmail TheDBATeam@TheBeard.Local 
#
#.NOTES
# Uses dbatools - dbatools.io
# Rob Sewell @SQLDBAWithABeard - https://sqldbawithabeard.com
##############################

param(
    [string]$Instance,
    [string]$accountname,
    [string]$EmailAddress,
    [string]$displayname,
    [string]$replytoaddress,
    [string]$mailserver,
    [string]$profilename,
    [string]$Operatorname,
    [string]$OperatorEmail

)

$SQLALertsscript = 'https://raw.githubusercontent.com/SQLDBAWithABeard/SQLScripts/master/SQL/SetUpAlerts.sql'

$SQL = (Invoke-WebRequest -UseBasicParsing -Uri $SQLALertsscript).Content

$SQL = $SQL.Replace('##accountname##', $accountname).Replace('##EmailAddress##', $EmailAddress).Replace('##displayname##', $displayname).Replace('##replytoaddress##', $replytoaddress).Replace('##mailserver##', $mailserver).Replace('##profilename##', $profilename).Replace('##Operator##',$Operatorname).Replace('##OperatorEmail##',$OperatorEmail)

Invoke-DbaSqlQuery -SqlInstance $Instance -Database msdb -Query $SQL
