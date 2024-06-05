public interface ICalloutConfigService {
	ICalloutConfigService setApiId(Id apiId);
	ICalloutConfigService setApiName(String apiName);
	ICalloutConfigService setEndpointParameter(String key, String value);
	ICalloutConfigService setHeaderParameter(String key, String value);
	ICalloutConfigService setJsonBodyParameter(String key, String value);

	ICalloutService getCalloutService();
}
