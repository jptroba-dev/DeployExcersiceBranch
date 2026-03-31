@RestResource(urlMapping='/accounts/*')
global class AccountAPI {
    
    @HttpGet
    global static List<AccountResponse> getAccounts() {
        List<AccountResponse> response = new List<AccountResponse>();
        
        List<Account> accounts = [
            SELECT Id, Name, AccountNumber 
            FROM Account 
            LIMIT 100
        ];
        
        for (Account acc : accounts) {
            response.add(new AccountResponse(acc.Name, acc.AccountNumber));
        }
        
        return response;
    }

    @HttpPost
    global static CreateAccountResponse createAccount() {
        // Leer body JSON
        RestRequest req = RestContext.request;
        // Compatibilidad: en Apex usa requestBody (Blob) y conviértelo a String
        String body = (req.requestBody == null) ? null : req.requestBody.toString();
        if (String.isBlank(body)) {
            RestContext.response.statusCode = 400;
            return new CreateAccountResponse(null, 'Empty body', false);
        }
        // Deserializar
        CreateAccountRequest payload;
        try {
            payload = (CreateAccountRequest) JSON.deserialize(body, CreateAccountRequest.class);
        } catch (Exception e) {
            RestContext.response.statusCode = 400;
            return new CreateAccountResponse(null, 'Invalid JSON: ' + e.getMessage(), false);
        }
        // Validaciones mínimas
        if (payload == null || String.isBlank(payload.Name)) {
            RestContext.response.statusCode = 400;
            return new CreateAccountResponse(null, 'Name is required', false);
        }
        // Crear cuenta
        Account acc = new Account(
            Name = payload.Name,
            AccountNumber = payload.AccountNumber,
            Phone = payload.Phone
        );
        try {
            insert acc;
            RestContext.response.statusCode = 201; // Created
            return new CreateAccountResponse(acc.Id, null, true);
        } catch (DmlException d) {
            RestContext.response.statusCode = 400;
            return new CreateAccountResponse(null, 'DML error: ' + d.getDmlMessage(0), false);
        } catch (Exception ex) {
            RestContext.response.statusCode = 500;
            return new CreateAccountResponse(null, 'Unexpected error: ' + ex.getMessage(), false);
        }
    }
    
    global class AccountResponse {
        public String accountName;
        public String accountNumber;
        
        public AccountResponse(String name, String acctNumber) {
            this.accountName = name;
            this.accountNumber = acctNumber;
        }
    }

    global class CreateAccountRequest {
        public String Name;
        public String AccountNumber;
        public String Phone;
    }
    global class CreateAccountResponse {
        public Id id;
        public String message;
        public Boolean success;
        public CreateAccountResponse(Id id, String message, Boolean success) {
            this.id = id;
            this.message = message;
            this.success = success;
        }
    }
}