@isTest
global class CalloutConfigServiceTestMock implements HttpCalloutMock {
	// Implement this interface method
	global HTTPResponse respond(HTTPRequest req) {
		HttpResponse res = new HttpResponse();
		res.setHeader('Content-Type', 'application/json');
		res.setBody(
			'[{"place_id":299490468,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"relation","osm_id":122586,"boundingbox":["36.9701313","42.5083736","-91.5130518","-87.0199244"],"lat":"40.0796606","lon":"-89.4337288","display_name":"Illinois, United States","class":"boundary","type":"administrative","importance":0.8438031120373645},{"place_id":296460391,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"way","osm_id":421432911,"boundingbox":["32.7227421","32.7236182","-96.8053702","-96.8050123"],"lat":"32.723180150000005","lon":"-96.80519125000001","display_name":"Illinois, South Denley Drive, Dallas, Dallas County, Texas, 75216, United States","class":"railway","type":"station","importance":0.3644313097683034}]'
		);
		res.setStatusCode(200);
		return res;
	}
}
