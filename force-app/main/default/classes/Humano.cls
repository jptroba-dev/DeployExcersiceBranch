public class Humano {
    
    public static Account[] acc= [select name from account where id= '0016g00002dQNw8AAG'];
    
    public static void Saludar(string saludo){
        system.debug(saludo + acc);
            
    }
    }