public interface ICalloutConfigService {
	ICalloutConfigService setApiId(Id apiId);
	ICalloutConfigService setApiName(String apiName);
	ICalloutConfigService setEndpointParameter(String key, String value);
	ICalloutConfigService setHeaderParameter(String key, String value);
	ICalloutConfigService setAuthorization(String value);
	ICalloutConfigService setJsonBodyParameter(String key, String value);

	ICalloutService makeCall();

	ICalloutService getCalloutService();
}
