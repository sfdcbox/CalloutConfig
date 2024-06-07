# Callout Config

The Callout Config is a framework concept aimed at optimizing all callouts within an organization. Its purpose is to minimize redundancy and enhance maintainability, thereby ensuring scalability and flexibility.

It's intended to complement Named Credentials and doesn't propose any alternatives to the features provided by Named Credentials.
    
## Usage/Examples

![image](https://github.com/sfdcbox/CalloutConfig/assets/9331676/fcb8dff6-535b-404b-bde9-b85bbab54566)
![image](https://github.com/sfdcbox/CalloutConfig/assets/9331676/640b1f7a-90d6-4b0c-acd7-350315884167)

### To directly fetch a value from response // like a token from auth endpoint
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
