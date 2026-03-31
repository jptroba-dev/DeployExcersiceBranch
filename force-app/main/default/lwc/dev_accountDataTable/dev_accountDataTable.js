import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/dev_AccountController.getAccounts';
import searchAccounts from '@salesforce/apex/dev_AccountController.searchAccounts';

const columns = [
    { label: 'Account Name', fieldName: 'Name', type: 'text' },
    { label: 'Industry', fieldName: 'Industry', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Website', fieldName: 'Website', type: 'url' },
    { label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency' }
];

export default class Dev_accountDataTable extends LightningElement {
    accounts = [];
    allAccounts = [];
    columns = columns;
    searchTerm = '';
    isLoading = false;

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.allAccounts = data;
            this.accounts = data;
        } else if (error) {
            console.error('Error loading accounts:', error);
        }
    }

    handleSearchChange(event) {
        this.searchTerm = event.target.value.toLowerCase().trim();
        this.performSearch();
    }

    performSearch() {
        if (this.searchTerm === '') {
            this.accounts = this.allAccounts;
        } else {
            this.accounts = this.allAccounts.filter(account =>
                account.Name.toLowerCase().includes(this.searchTerm)
            );
        }
    }

    get hasAccounts() {
        return this.accounts.length > 0;
    }

    get noAccountsMessage() {
        return this.searchTerm 
            ? `No accounts found matching "${this.searchTerm}"`
            : 'No accounts available';
    }
}