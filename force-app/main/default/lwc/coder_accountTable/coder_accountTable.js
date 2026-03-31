import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/coder_AccountController.getAccounts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const COLUMNS = [
    { label: 'Account Name', fieldName: 'Name', type: 'text', sortable: true },
    { label: 'Type', fieldName: 'Type', type: 'text', sortable: true },
    { label: 'Industry', fieldName: 'Industry', type: 'text', sortable: true },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Website', fieldName: 'Website', type: 'url' },
    { 
        label: 'Annual Revenue', 
        fieldName: 'AnnualRevenue', 
        type: 'currency',
        typeAttributes: { currencyCode: 'USD', minimumFractionDigits: 2 }
    },
    { 
        label: 'Created Date', 
        fieldName: 'CreatedDate', 
        type: 'date',
        typeAttributes: {
            year: 'numeric',
            month: 'short',
            day: '2-digit'
        }
    }
];

export default class CoderAccountTable extends LightningElement {
    accounts = [];
    columns = COLUMNS;
    isLoading = true;
    hasError = false;
    errorMessage = '';

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        this.isLoading = false;
        if (data) {
            this.accounts = data;
            this.hasError = false;
            this.errorMessage = '';
        } else if (error) {
            this.hasError = true;
            this.errorMessage = 'Error loading accounts: ' + (error.body?.message || error.message);
            this.accounts = [];
            this.showErrorToast();
        }
    }

    get hasData() {
        return this.accounts && this.accounts.length > 0;
    }

    showErrorToast() {
        const evt = new ShowToastEvent({
            title: 'Error',
            message: this.errorMessage,
            variant: 'error',
            mode: 'sticky'
        });
        this.dispatchEvent(evt);
    }
}