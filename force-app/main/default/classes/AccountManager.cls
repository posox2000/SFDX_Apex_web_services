@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accountIdpath = request.requestURI.substringBeforeLast('/contacts');
        //System.debug('AccountManager:accountIdpath=>'+accountIdpath);

        String accountId = accountIdpath.substring(accountIdpath.lastIndexOf('/')+1);
        //System.debug('AccountManager:accountId=>'+accountId);

        if(accountId=='')
            return null;          
        return [SELECT Id,Name,(select id,name from contacts)FROM Account WHERE id = :accountId].get(0);
    }
}