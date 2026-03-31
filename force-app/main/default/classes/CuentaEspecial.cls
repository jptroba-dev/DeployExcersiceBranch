public class CuentaEspecial extends Cuenta { 
    public void aplicarBonificacion(Integer bono) { 
        // Aquí se puede acceder porque es una subclase 
        ajustarSaldo(bono); 
        System.debug('El saldo es' + saldo);
        
    } 

}