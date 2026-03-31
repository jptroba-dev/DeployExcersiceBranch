import { LightningElement, wire } from 'lwc';
import getContactList from '@salesforce/apex/ApexDemo.getContactList';
import getAccountList from '@salesforce/apex/ApexDemo.getAccountList';

export default class firstLwcAPD extends LightningElement {
  greeting = 'Hi bro !';
  
  inputText = '';
result;
error;
//@api - communication from parent to child component 
//@track removed from latest release 20
  @wire(getContactList) contacts({error, data}) {
  if (data) {
    this.result = data;
    this.error = undefined;
    window.console.log('contact records:', data);
  } else if (error) {
    this.error = error;
    this.result = undefined;
    window.console.log('contact error:', error);
  }
}
  ; //wire service to call apex method and get data from server side


  handleClick(event) {
    this.inputText = event.target.value;
    window.console.log('event.target: ', event.target);
  }
  handleSubmit() {  
  alert('Button clicked!');
  getAccountList().then(result => {
    this.result = result;
    this.error = undefined;
    window.console.log('account records:', result);
  })
  .catch(error => {
    this.error = error;
    this.result = undefined;
    window.console.log('account error:', error);
  });

}
}