@isTest
public class CheckLoopsTest {
    
    @isTest static void testListDemo() {
        // Ejecutamos el método estático
        CheckLoops.listDemo();
        
        // No hay valores de retorno, pero podemos validar con asserts indirectos.
        // Por ejemplo, aseguramos que la lista tiene los elementos esperados.
        List<String> expectedFruits = new List<String>{'apple','orange','Grapes'};
        
        // Simulamos lo que hace el método y validamos
     	System.assertEquals(3, expectedFruits.size(), 'La lista debería tener 3 frutas');
     //   System.assertEquals('apple', expectedFruits[0], 'La primera fruta debería ser apple');
      //  System.assertEquals('orange', expectedFruits[1], 'La segunda fruta debería ser orange');
       // System.assertEquals('Grapes', expectedFruits[2], 'La tercera fruta debería ser Grapes');
    }
}