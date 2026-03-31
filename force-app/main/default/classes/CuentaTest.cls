@isTest
private class CuentaTest extends Cuenta{
    @isTest static void testBonificacion() {
        CuentaEspecial ce = new CuentaEspecial();
        ce.aplicarBonificacion(10);
        System.assertEquals(10, ce.saldo);
    }
}