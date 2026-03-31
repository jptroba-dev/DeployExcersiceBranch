public class FutureDemo {
    
    public void invokeFutureCall(){
        String primitiveValue = 'Input to future method';
        List<String> listOfPrimitiveValue = new List<String>{primitiveValue};
        //Account accRec=[Select Id FROM Account Limit 1][0];
        //System.debug('accountList':accRec) ;
        
        futureMethod1(listOfPrimitiveValue);
        
        futureMethod2();
        futureMethod3();
    }

    @future
    public static void futureMethod1( List<String> inputParameter){
        System.debug('Inside futureMethod1');
        System.debug('inputParameter: ' + inputParameter);
        
    }
    
    
    @future
    public static void futureMethod2(){
        System.debug('Inside futureMethod2');
    }
    
    @future
    public static void futureMethod3(){
        System.debug('Inside futureMethod3');
    }
/*
FutureDemo fd = new FutureDemo();
fd.invokeFutureCall();

methods not excecute in order due are async
    */
    
    
}