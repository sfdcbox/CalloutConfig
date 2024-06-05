String short_url;
String long_url = 'https://www.sfdcbox.com/2022/11/looping-of-asynchronousapex-calls-from.html';
Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint('https://api-ssl.bitly.com/v4/shorten');
request.setMethod('POST');
request.setHeader('Content-Type', 'application/json');
request.setHeader('Accept', 'application/json');
request.setHeader('Authorization', 'Bearer '+token);
request.setBody('{"long_url":"'+long_url+'"}');
HttpResponse response = http.send(request);
if (response.getStatusCode() != 201) {
    System.debug('shortening failed: ' + response.getStatusCode() + ' ' + response.getStatus());
} else {
    Map<String, Object> bitlyResponseMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
    short_url =  (String)bitlyResponseMap.get('link');
}
System.debug('short_url  ' + short_url);

    String clientId = 'eb411c01e909e604d45d444ff6509168e714f21e';
    String clientSecret = '73f6e34aaa8982bfc502b99dca3619d30ba36493';
    String userName = 'sfdc.gsk@gmail.com';
    String password = 'gsk@301AKS';
    String auth = EncodingUtil.base64Encode(Blob.valueof(clientId + ':' + clientSecret));
    String body = 'grant_type=password&username='+userName+'&password='+password;
    ICalloutService service = CalloutService.newInstance()
                            .setEndPoint('https://api-ssl.bitly.com/oauth/access_token')
                            .setAuthorization('Basic '+auth)
                            .setContentType('application/x-www-form-urlencoded')
                            //.setHeader('Accept', 'application/json')
                            .setBody(body)
                            .doPost();
    System.debug('>>>>>  ' +service.getResponse().getBody());
                 String token = service.getStringBodyToken('access_token');
    System.debug('token  ' + token);




    String long_url = 'https://www.sfdcbox.com/2022/11/looping-of-asynchronousapex-calls-from.html';
    String token = 'effbd8d27a4d2dfdfc1c9d53e1fc531caaa2e3b5';
    String body = '{"long_url":"'+long_url+'"}';
    String shortUrl = CalloutService.newInstance()
                            .setEndPoint('https://api-ssl.bitly.com/v4/shorten')
                            .setAuthorizationBearer(token)
                            .setContentType('application/json')
                            .setHeader('Accept', 'application/json')
                            .setBody(body)
                            .doPost()
                            .getStringBodyToken('link');
    System.debug('shortUrl  ' + shortUrl);



    ICalloutService service = APICalls.newInstance()
                            .setApiName('Geocoding API')
                            .setEndpointParameter('q', 'illinois')
                            .getCalloutService();

        service.doPost();
        if(service.getStatusCode() == )
        .getStringBodyToken();

		.send()
		.getResponse()
		.getBody()

        String resp = '[{"place_id":299490468,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"relation","osm_id":122586,"boundingbox":["36.9701313","42.5083736","-91.5130518","-87.0199244"],"lat":"40.0796606","lon":"-89.4337288","display_name":"Illinois, United States","class":"boundary","type":"administrative","importance":0.8438031120373645},{"place_id":296460391,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"way","osm_id":421432911,"boundingbox":["32.7227421","32.7236182","-96.8053702","-96.8050123"],"lat":"32.723180150000005","lon":"-96.80519125000001","display_name":"Illinois, South Denley Drive, Dallas, Dallas County, Texas, 75216, United States","class":"railway","type":"station","importance":0.3644313097683034},{"place_id":38990997,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"relation","osm_id":9641750,"boundingbox":["25.2082628","25.2099886","55.146577","55.1482732"],"lat":"25.2091807","lon":"55.14743258186529","display_name":"Illinois, Dubai, United Arab Emirates","class":"place","type":"islet","importance":0.35000999999999993},{"place_id":280876876,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"way","osm_id":401201557,"boundingbox":["31.986622","31.9872906","-102.1394576","-102.1384211"],"lat":"31.98710035","lon":"-102.13883116078999","display_name":"Illinois, Midland, Midland County, Texas, United States","class":"landuse","type":"residential","importance":0.3000099999999999},{"place_id":295337577,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"way","osm_id":1132544567,"boundingbox":["34.6784925","34.6794142","-98.6999648","-98.6993017"],"lat":"34.67891685","lon":"-98.69966204978167","display_name":"Illinois, Comanche County, Oklahoma, United States","class":"natural","type":"water","importance":0.3000099999999999},{"place_id":299221639,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"way","osm_id":508285525,"boundingbox":["38.886445","38.887663","-90.1589413","-90.158875"],"lat":"38.887663","lon":"-90.1589413","display_name":"Illinois, Alton, Madison County, Illinois, 62002, United States","class":"highway","type":"residential","importance":0.20000999999999994},{"place_id":331661046,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"way","osm_id":21930167,"boundingbox":["42.2729362","42.2750662","-88.2283382","-88.2274912"],"lat":"42.2749387","lon":"-88.2282752","display_name":"Illinois, Burtons Bridge, McHenry County, Illinois, 60014, United States","class":"highway","type":"residential","importance":0.20000999999999994},{"place_id":299646094,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"way","osm_id":21995720,"boundingbox":["37.97104","37.97228","-90.001628","-89.999036"],"lat":"37.971696","lon":"-90.000239","display_name":"Illinois, Randolph County, Illinois, 62261, United States","class":"highway","type":"track","importance":0.20000999999999994},{"place_id":4557036,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"way","osm_id":99189114,"boundingbox":["-31.4734317","-31.4733605","-64.2374918","-64.2332503"],"lat":"-31.4734128","lon":"-64.2347698","display_name":"Illinois, Santa Isabel 1ª Sección, Cordoba, Municipio de Córdoba, Pedanía Capital, Departamento Capital, Córdoba, X5017, Argentina","class":"highway","type":"residential","importance":0.20000999999999994},{"place_id":284790769,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"way","osm_id":305899799,"boundingbox":["34.4646044","34.4663251","-118.1758902","-118.1758876"],"lat":"34.4646044","lon":"-118.1758902","display_name":"Illinois, Paris, California, 93510, United States","class":"highway","type":"residential","importance":0.20000999999999994}]';
        List<Object> obejcts = (List<Object>) JSON.deserializeUntyped(resp);
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(
			JSON.serialize(obejcts[0])
		);
        System.debug(responseMap.get('lat'));