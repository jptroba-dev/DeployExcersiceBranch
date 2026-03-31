import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountDatatableController.getAccounts';

export default class AccountDatatable extends LightningElement {
    @track accounts = [];
    @track error;
    @track searchKey = '';
    sortedBy = 'Name';
    sortedDirection = 'asc';

    columns = [
        { label: 'Name', fieldName: 'Name', sortable: true },
        { label: 'Industry', fieldName: 'Industry', sortable: true },
        { label: 'Phone', fieldName: 'Phone' },
        { label: 'Rating', fieldName: 'Rating', sortable: true },
        { label: 'Type', fieldName: 'Type', sortable: true },
        { label: 'Website', fieldName: 'Website', type: 'url', typeAttributes: { label: { fieldName: 'Website' }, target: '_blank' } }
    ];

    connectedCallback() {
        this.loadData();
    }

    async loadData() {
        try {
            const data = await getAccounts({
                searchKey: this.searchKey,
                sortedBy: this.sortedBy,
                sortedDirection: this.sortedDirection
            });
            this.accounts = data;
            this.error = undefined;
        } catch (e) {
            // surface message briefly, but also log full error for debugging
            this.error = (e && e.body && e.body.message) ? e.body.message : (e && e.message) ? e.message : 'Unknown error';
            // eslint-disable-next-line no-console
            console.error('Error loading accounts', e);
            this.accounts = [];
        }
    }

    handleSearchChange(event) {
        this.searchKey = event.target.value || '';
        // debounce simple by immediate reload; could be improved with setTimeout
        this.loadData();
    }

    handleSort(event) {
        this.sortedBy = event.detail.fieldName;
        this.sortedDirection = event.detail.sortDirection;
        this.loadData();
    }
}