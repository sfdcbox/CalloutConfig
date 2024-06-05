public with sharing class CalloutConfigService implements ICalloutConfigService {
	Id apiId;
	String apiName;
	ICalloutService service;
	Map<String, String> endPointParameters;
	Map<String, String> headerParameters;
	Map<String, String> jsonBodyParameters;

	public static ICalloutConfigService newInstance() {
		return (ICalloutConfigService) new CalloutConfigService();
	}

	public ICalloutConfigService setApiId(Id apiId) {
		this.apiId = apiId;
		initialize();
		return this;
	}

	public ICalloutConfigService setApiName(String apiName) {
		this.apiName = apiName;
		initialize();
		return this;
	}

	void initialize() {
		this.endPointParameters = new Map<String, String>();
		this.headerParameters = new Map<String, String>();
		this.jsonBodyParameters = new Map<String, String>();
	}

	public ICalloutConfigService setEndpointParameter(
		String key,
		String value
	) {
		this.endPointParameters.put(key, value);
		return this;
	}

	public ICalloutConfigService setHeaderParameter(String key, String value) {
		this.headerParameters.put(key, value);
		return this;
	}

	public ICalloutConfigService setJsonBodyParameter(
		String key,
		String value
	) {
		this.jsonBodyParameters.put(key, value);
		return this;
	}

	public ICalloutService getCalloutService() {
		API__c api = getAPI();
		this.service = CalloutService.newInstance()
			.setEndPoint(api.Endpoint__c)
			.setMethod(api.Method__c);
		prepareParameters(api);
		addEndpointParameters();
		addHeaderParameers();
		addBodyParameters();
		return this.service;
	}

	@TestVisible
	void prepareParameters(API__c api) {
		for (Parameter__c p : [
			SELECT
				Id,
				Use__c,
				Value_Encrypted__c,
				Key__c,
				Key_Custom__c,
				Value__c,
				Value_Custom__c
			FROM Parameter__c
			WHERE API__c = :api.Id
			WITH SECURITY_ENFORCED
		]) {
			switch on p.Use__c {
				when 'Endpoint' {
					this.endPointParameters.put(
						p.Key__c ?? p.Key_Custom__c,
						p.Value__c ?? p.Value_Encrypted__c ?? p.Value_Custom__c
					);
				}
				when 'Header' {
					this.headerParameters.put(
						p.Key__c ?? p.Key_Custom__c,
						p.Value__c ?? p.Value_Encrypted__c ?? p.Value_Custom__c
					);
				}
				when 'Body' {
					this.jsonBodyParameters.put(
						p.Key__c ?? p.Key_Custom__c,
						p.Value__c ?? p.Value_Encrypted__c ?? p.Value_Custom__c
					);
				}
				when else {
					Logger.info(
						'Invalid Parameter Type with record Id : ' + p.Id
					);
				}
			}
		}
	}

	void addEndpointParameters() {
		if (this.endPointParameters.isEmpty())
			return;

		String endpoint = this.service.getRequest().getEndpoint();

		if (!endpoint.contains('?')) {
			endpoint += '?';
		}

		for (String s : this.endPointParameters.keySet()) {
			String operator = endpoint.endsWith('?') ? '' : '&';
			endpoint += operator + s + '=' + this.endPointParameters.get(s);
		}

		this.service.setEndPoint(endPoint);
	}

	void addHeaderParameers() {
		if (this.headerParameters.isEmpty())
			return;

		for (String s : this.headerParameters.keySet()) {
			this.service.setHeader(s, this.headerParameters.get(s));
		}
	}

	void addBodyParameters() {
		if (this.jsonBodyParameters.isEmpty())
			return;

		this.service.setBody(JSON.serialize(this.jsonBodyParameters));
	}

	API__c getAPI() {
		return [
			SELECT Id, Name, Endpoint__c, Method__c
			FROM API__c
			WHERE Id = :apiId OR Name = :apiName
		];
	}
}
