public class HTMLStringWriter extends StringWriter{

        public override void printString(){
        System.debug('<p>This is the Html String</p>');
        
    }
}
/*
StringWriter sw1= new StringWriter();
sw1.printString();

HTMLStringWriter sw2= new HTMLStringWriter();
sw2.printString();
*/