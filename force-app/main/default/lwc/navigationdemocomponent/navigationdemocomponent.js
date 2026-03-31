import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';     

export default class navigationdemocomponent extends NavigationMixin(LightningElement) {

    navigateToRecordDetailPage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'clone,view,edit'
            }
        });

    }

    createNewRecord() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'new'
            }
        });
    }


}