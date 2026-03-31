import { LightningElement } from 'lwc';

export default class Ldsdemo extends LightningElement {

    handleError(event) {
        alert('Error: ', event.detail);
    }

    handleSuccess(event) {
        alert('Record created successfully: ', event.detail);
    }

    handleSubmit(event) {
        alert('Record submitted: ', event.detail);
    }
}