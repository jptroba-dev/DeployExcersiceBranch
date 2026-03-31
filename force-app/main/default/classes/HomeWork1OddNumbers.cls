public class HomeWork1OddNumbers {
    
    /* write an apex program to store all the odd numbers in a list starting from 1 to 20,  
only numbers stored at even positions in the list should be added to get ther sum 
which should be output to the debug log */

     Public static void GetOddNumbers(){
		Integer i= 1;
        Integer j= 1;
		Integer finalSum = 0; 
 
		List<Integer> myList=new List<Integer>();
		List<Integer> myOddList=new List<Integer>();
		
        	while(i<20){
    			if(Math.mod(i,2)==0){
            
    			}else{ 
            	myList.add(i);
				} 
    			i++;
				}	

system.debug(myList);
         
         		while(j<myList.size()){
    			if(Math.mod(j,2)==0){
               system.debug(myList[j]);
                
            	finalSum = finalSum + myList[j];
    			}
    			j++;
				}	
         
        
 system.debug(finalSum);   
         
       //HomeWork1OddNumbers.GetOddNumbers();
         }
         
  

}