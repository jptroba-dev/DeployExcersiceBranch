import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
//message = 'Hello from Parent Component';

handleClick() {
    this.message = 'Button Clicked! Message updated in Parent Component';
    this.template.querySelector('c-child-component').childComp(this.message);
    //
}
handleEvent(event) {
let key = event.detail.key;
let value = event.detail.value;
this.message = `Received from child - Key: ${key}, Value: ${value}`;
console.log(' ', this.message);
/*
    const { key, value } = event.detail;
    alert(`Key: ${key}, Value: ${value}`);
    this.message = `Received from child - Key: ${key}, Value: ${value}`;
*/
}
}