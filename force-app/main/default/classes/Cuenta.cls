public virtual class Cuenta { 
    protected Integer saldo; 
    
    public Cuenta() {
        saldo = 0;
    }
    
    protected void ajustarSaldo(Integer monto) { 
        saldo += monto; 
    } 
}