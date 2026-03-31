public class CheckWhile {

	public static void listDemo(){
    	list<String> fruits= new  list<String>();
        fruits.add('apple');   //0
        fruits.add('orange');
        fruits.add('Grapes');   //2

        Integer size = fruits.size();
        Integer i=10;  // initialize condition
        do{ // entry condition
         	//String fruitName = fruits.get(i);
            //System.debug(fruitName);
            System.debug('Execute once');
            i++;
        } while (i < size );

    }
    
    public static void setDemo(){
        Set<String>  fruitSet = new Set<String>(); 
        fruitSet.add('apple');   //0
        fruitSet.add('orange');
        fruitSet.add('Grapes');         
        
             for (String fruit:fruitSet){     /// friut name of iteratable
            System.debug(fruit);
        }  
    }
    
        public static void mapDemo(){
        Map<String,String>  countryToCodeMap = new map<String,String>(); 
        countryToCodeMap.put('Mexico','MX');   //0
        countryToCodeMap.put('USA','US');
        countryToCodeMap.put('India','IN');         
      
        /* how to obtain
        method to iterate maps
            keyset - set<string>
            values - list<string>
        */
            
         Set<String> keySet = countryToCodeMap.keySet();   
            
             for (String key:keySet){     /// friut name of iteratable
            String value = countryToCodeMap.get(key);
            System.debug('Key = '+key+' value = '+ value);         
        	}  
         
             for (String val:countryToCodeMap.values()){     /// friut name of iteratable
            
            System.debug('value = '+ val);         
        	}   
            
    }
    
}