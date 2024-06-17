# Callout Config (Beta)

The Callout Config is a framework concept to optimize all apex callouts within an organization. Its goals are to minimize the overall code needed for callouts, eliminate code redundancy, and enhance both maintainability and scalability.

It's intended to complement Named Credentials and doesn't propose any alternatives to the features provided by Named Credentials. Named credentials can further be configured in to this framework to make things more configurable and secure.
This allows to securely configure parameters to Endopint, header and body beyond what is configured in Named Credentails.


## Documentation

CalloutService - this class is where we request is created, callout is made, resopse is captured. This is where all the parsing methods will be added which can be used by all callouts. This is not dependent on the other class and can be used directly without using the CalloutConfigService class

CalloutConfigService - this class creats CalloutService from the configurations created.
this can handle Named Credentails cnfigured in to the configuration objects 

OBJECTS:
Note: Custom Metadata Types can also be used instead of Custom Objects, but using Custom Objects allows to configure secure data as well (As of today encripted fields are not supported in Custom Metadata Types)

    1. Api__c - Coming soon...

    2. Parameter__c - Coming soon...

## Usage/Examples With Named Credentials 
Bitly token External Credentail

![image](https://github.com/sfdcbox/CalloutConfig/assets/9331676/80561d45-4be2-484d-bcd5-ab41f0e93019)

Bitly token Named Credentail

![image](https://github.com/sfdcbox/CalloutConfig/assets/9331676/3c71ed64-d498-4763-9140-13db32450c43)

Bitly token configured with the Named Credentail

![image](https://github.com/sfdcbox/CalloutConfig/assets/9331676/e284dac5-c53e-40a0-bd3b-6f66d76ef3c1)

Bitly token body configired as a parameter with Named Credentail merge fields

![image](https://github.com/sfdcbox/CalloutConfig/assets/9331676/e246274b-8efe-4e53-8519-d7e3f8720601)

Bitly url shorten endpoint configured directly in to API object and its two header parameters configured as related Parameters

![image](https://github.com/sfdcbox/CalloutConfig/assets/9331676/59201684-ed32-4654-925f-79beece2c6ff)


### Sample Code

    String long_url = 'https://www.sfdcbox.com/2022/11/looping-of-asynchronousapex-calls-from.html';
    // To make call for getting access token
    String token = CalloutConfigService.newInstance('Bitly Token').makeCall().getResponse().getBody();
    // To make call for getting shortened url for a long url
    ICalloutService service = CalloutConfigService.newInstance('Bitly Shorten')
                                                    .setAuthorization('Bearer '+token)
                                                    .setJsonBodyParameter('long_url', long_url)
                                                    .makeCall();
    if(service.getResponse().getStatusCode() == 200){
        System.debug(service.getJSONRespStringByKey('link'));
    }

    ..........
    OUTPUT
    18:07:19.99 (966585749)|USER_DEBUG|[10]|DEBUG|https://bit.ly/4c3jL1X


## Usage/Examples Without Named Credentials 
![image](https://github.com/sfdcbox/CalloutConfig/assets/9331676/fcb8dff6-535b-404b-bde9-b85bbab54566)
![image](https://github.com/sfdcbox/CalloutConfig/assets/9331676/640b1f7a-90d6-4b0c-acd7-350315884167)

### To directly fetch a value from response

    String type = CalloutConfigService.newInstance()
                            .setApiName('Geocoding API')
                            .setEndpointParameter('q', 'illinois')
                            .getCalloutService()
                            .doPost()
                            .getStringFromFirstOfJsonListBody('type');

### To validate response and read response values

    ICalloutService service = CalloutConfigService.newInstance()
                            .setApiName('Geocoding API')
                            .setEndpointParameter('q', 'illinois')
                            .getCalloutService()
                            .doPost();
    if(service.getResponse().getStatusCode() == 200){
        System.debug(service.getJSONRespFirstStringByKey('lat'));
        System.debug(service.getJSONRespFirstStringByKey('lon'));
    }else{
        //Handle failure
    }
