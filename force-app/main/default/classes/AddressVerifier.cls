public with sharing class AddressVerifier {
    private static final String BASE_URL = 'https://us-street.api.smarty.com/street-address';
    private static final String AUTH_ID = '6a70f9ca-37d2-f813-f367-6203bea9a2fa'; 
    private static final String AUTH_TOKEN = 'e9ClJ5rOyhpyrKb0aT67';

    public static List<Map<String,Object>> verifyAddress(String street, String city, String state, String zipcode) {
        List<Map<String,Object>> results = new List<Map<String,Object>>();
        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(
                BASE_URL +
                '?auth-id=' + AUTH_ID +
                '&auth-token=' + AUTH_TOKEN +
                '&street=' + EncodingUtil.urlEncode(street, 'UTF-8') +
                '&city=' + EncodingUtil.urlEncode(city, 'UTF-8') +
                '&state=' + EncodingUtil.urlEncode(state, 'UTF-8') +
                '&zipcode=' + EncodingUtil.urlEncode(zipcode, 'UTF-8') +
                '&candidates=10' +
                '&match=enhanced'
            );
            req.setMethod('GET');

            Http http = new Http();
            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                // Smarty devuelve un array de objetos JSON
                List<Object> response = (List<Object>) JSON.deserializeUntyped(res.getBody());

                for (Object obj : response) {
                    Map<String,Object> candidate = (Map<String,Object>) obj;
                    results.add(candidate);
                }
            } else {
                System.debug('Error en verificación: ' + res.getBody());
            }
        } catch (Exception e) {
            System.debug('Excepción: ' + e.getMessage());
        }
        return results;
    }
}