public class Demo2 {

    String helloWorldString; //instance member variable
    private static final String DEFAULT_STRING; //constant - static member variables
    
    static{
        DEFAULT_STRING = 'Hello World'; // static initializer block runs only once when class is loaded
    }
    
    public Demo2(){ 			//constructor 
        this(DEFAULT_STRING);
    }
    
    public Demo2(String stringToDisplay){  //overloader constructor
        this.helloWorldString = StringToDisplay;
    }
    
     public void printOut(){ //method
        system.debug('Display txt: '+ helloWorldString);
    }
    public Static void printOut1(){ //method
        system.debug('Display from static metod');
    }
    
    
}

/*
Demo2 d2 = new Demo2();
d2.printOut();

Demo2.printOut1();
*/