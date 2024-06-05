@isTest
private class CalloutConfigServiceTest {
	@TestSetup
	static void makeData() {
		API__c api = new API__c(
			Name = 'Geocoding API',
			Method__c = 'GET',
			Endpoint__c = 'https://geocode.maps.co/search'
		);
		insert api;
		insert new Parameter__c(
			API__c = api.Id,
			Use__c = 'Endpoint',
			Key_Custom__c = 'testkey',
			Value_Custom__c = 'testvalue'
		);
	}

	@IsTest
	static void testEndpoint() {
		Test.startTest();
		IAPICalls geoCode = APICalls.newInstance()
			.setApiName('Geocoding API')
			.setEndpointParameter('q', 'illinois')
			.prepare();
		Test.stopTest();
		System.assert(
			geoCode.getRequest()
				.getEndpoint()
				.startsWith('https://geocode.maps.co/search'),
			'Did not start with expected endpoint'
		);
		System.assert(
			geoCode.getRequest().getEndpoint().contains('q=illinois'),
			'Did not add dynamic endpoint parameter'
		);
		System.assert(
			geoCode.getRequest().getEndpoint().contains('testkey=testvalue'),
			'Did not add parameter record endpoint parameter'
		);
	}

	@IsTest
	static void testCall() {
		Test.setMock(HttpCalloutMock.class, new APICallsTestMocker());
		Test.startTest();
		IAPICalls geoCode = APICalls.newInstance()
			.setApiName('Geocoding API')
			.setEndpointParameter('q', 'illinois')
			.prepare()
			.send();
		Test.stopTest();
		System.assertEquals(
			geoCode.getResponse().getStatusCode(),
			200,
			'Did not receive expected status code'
		);
	}
}
