import { LightningElement, api } from 'lwc';
import checkpermission from '@salesforce/apex/checkUserAssignedPermission.method'
import USER_ID from '@salesforce/user/Id';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class AccountDetailsPage extends LightningElement {
    @api recordId;
    @api objectApiName;
    title;
    userId = USER_ID;
    viewForm = true;
    Editform = false;
    permissionisAvailable = false;
    connectedCallback() {
        this.title = this.objectApiName + 'View Form';
        checkpermission({ userId: this.userId }).then((result) => {
            this.permissionisAvailable = JSON.stringify(result);
        }).catch((error) => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        })
    }
    handleOnClick() {
        if (this.permissionisAvailable == false) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating record',
                    message: 'User donnot have edit and create permission',
                    variant: 'error'
                })
            );
        } else {
            this.title = this.objectApiName + ' Edit Form';
            this.viewForm = false;
            this.Editform = true;
        }

    }
    data(event) {
        event.preventDefault();
        const fields = event.detail.fields;
        console.log('OUTPUT : ', JSON.stringify(fields));

    }
}