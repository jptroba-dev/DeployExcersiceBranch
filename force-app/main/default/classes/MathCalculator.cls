public class MathCalculator {
    
        public static void doMath(Integer num1,Integer num2){

        
          add(num1,num2);
          substract(num1,num2);
            multiply(num1,num2);
            printOutput(num1,num2);
        
    }
 
   

    private static void add(Integer v1,Integer v2){
        
        system.Debug('Sum is: '+ (v1+v2));
        
    }
    private static void substract(Integer v1,Integer v2){
        
      system.Debug('subtract is: '+ (v1-v2));
      
  }
    
    private static void multiply(Integer m1, Integer m2){
        system.Debug('Multiply is: '+ (m1*m2));
        
    }
    
    private static void printOutput(Integer p1,Integer p2){
         system.Debug('product is: '+ ((p1*p2)+(p1+p2)));
                      
    }
    }