Set($rtname, 'www.example.com/rt'); 
Set($Organization, 'www.example.com'); 
 
Set($OwnerEmail , 'rt-owner@example.com'); 
Set($CorrespondAddress , 'rt-reply@example.com'); 
Set($CommentAddress , 'rt-comment@example.com'); 
 
Set($Timezone , 'Europe/London'); # obviously choose what suits you 
 
Set($LogToSyslog    , 'error'); 
Set($LogToFile      , 'debug'); 
 
Set($DatabaseType, 'mysql'); # e.g. Pg or mysql 
# These are the settings used when creating the RT database, 
# You MUST set these to what you chose then. 
Set($DatabaseUser , 'rtuser'); 
Set($DatabasePassword , 'rtpwd'); 
Set($DatabaseName , 'rtdb'); 
Set($DatabaseServer, 'mysqlserver'); 
# THE WEBSERVER: 
Set($WebPath , "/rt"); 
Set($WebBaseURL , "http://www.example.com"); 
 
Set($UseFriendlyFromLine , 1); 
Set($FriendlyFromLineFormat , "\"IT Manager via RT\" <rt-owner\@example.com>"); 
 
Set($UseTransactionBatch , 1); 
 
1; 

