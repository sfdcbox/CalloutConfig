public virtual class CalloutService implements ICalloutService {
	static final String NEWLINERETURN = '\n\r';

	HttpRequest request;
	HttpResponse response;
	private static ICalloutService instance;

	public CalloutService() {
		request = new HttpRequest();
	}

	public static ICalloutService newInstance() {
		if (instance == null) {
			instance = (ICalloutService) new CalloutService();
		}
		return instance;
	}

	public ICalloutService setEndPoint(String endPoint) {
		request.setEndpoint(endpoint);
		return this;
	}

	public ICalloutService setHeader(String attribute, String value) {
		request.setHeader(attribute, value);
		return this;
	}

	public ICalloutService setContentType(String value) {
		request.setHeader('Content-Type', value);
		return this;
	}

	public ICalloutService setAuthorization(String value) {
		request.setHeader('Authorization', value);
		return this;
	}

	public ICalloutService setBody(String body) {
		request.setBody(body);
		return this;
	}

	public ICalloutService setMethod(String method) {
		request.setMethod(method);
		return this;
	}

	public ICalloutService send() {
		response = new Http().send(request);
		return this;
	}

	public ICalloutService doPost() {
		request.setMethod('POST');
		response = new Http().send(request);
		return this;
	}

	public ICalloutService doGet() {
		request.setMethod('GET');
		response = new Http().send(request);
		return this;
	}

	public HttpRequest getRequest() {
		return request;
	}

	public HttpResponse getResponse() {
		return response;
	}

	private String getStringFromJson(String jsonString, String token) {
		Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(
			jsonString
		);
		return responseMap.containsKey(token)
			? (String) responseMap.get(token)
			: null;
	}

	public String getJSONRespStringByKey(String token) {
		return getStringFromJson(response.getBody(), token);
	}

	public String getJSONRespFirstStringByKey(String token) {
		List<Object> objects = (List<Object>) JSON.deserializeUntyped(
			response.getBody()
		);
		return getStringFromJson(JSON.serialize(objects[0]), token);
	}

	public ICalloutService log() {
		try {
			Log__c log = new Log__c();
			log.Generated_Date_Time__c = System.now();
			log.Response_StatusCode__c = response.getStatusCode();
			log.Response_Status__c = response.getStatus();
			insert log;

			Attachment attachment = new Attachment();
			attachment.Body = Blob.valueOf(
				request.toString() +
					NEWLINERETURN +
					'BODY : ' +
					NEWLINERETURN +
					request.getBody() +
					NEWLINERETURN +
					response.toString() +
					NEWLINERETURN +
					'BODY : ' +
					NEWLINERETURN +
					response.getBody()
			);
			attachment.Name =
				'API_Call_' +
				System.now().format('yyyy_MM_dd_hh_mm_ss') +
				'.txt';
			attachment.ParentId = log.Id;
			insert attachment;
		} catch (Exception e) {
			// TODO
		}
		return this;
	}
}
