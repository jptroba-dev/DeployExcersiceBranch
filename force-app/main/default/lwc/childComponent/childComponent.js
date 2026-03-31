import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api message;

    @api childComp(name){
        alert(name);
        this.message = name;
    }

    handleClick() {
        //create customEvent
        // if single value on details: 'value'
        const event = new CustomEvent('btnclick', {
            detail: {
                key: '001HSGHSGD',
                value: 'apex Course'
            }
        });
        this.dispatchEvent(event);
    }
}