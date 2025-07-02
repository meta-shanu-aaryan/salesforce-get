import { LightningElement, wire } from 'lwc';
import Toast from 'lightning/toast';
import getAllProduct from '@salesforce/apex/ProductController.getAllProduct';
import addToCart from '@salesforce/apex/CartController.addToCart';
import searchProduct from '@salesforce/apex/ProductController.searchProduct';

const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'MRP', fieldName: 'MRP__c', type: 'currency' },
    { label: 'Discount', fieldName: 'Discount__c' },
    { label: 'Selling Price', fieldName: 'SellingPrice__c', type: 'currency' },
    { label: 'Available Units', fieldName: 'Available_Units__c'},
]

let selectedRow = new Set();

export default class ProductPage extends LightningElement {

    
    columns = columns;
    filteredProductList = [];


    @wire(getAllProduct)
    prodWire(response) {
        this.filteredProductList = response.data;
    }


    productListLength = () => {
        return this.productList.length > 0
    };



    getSelectedName(event) {
        const selectedRows = event.detail.selectedRows;
        // Display that fieldName of the selected rows
        selectedRow.clear();
        for (let i = 0; i < selectedRows.length; i++) {
            selectedRow.add(selectedRows[i].Id);
        }
    }

    async handleAddToCart(){
        const success = await addToCart({itemIds: [...selectedRow]});
        if(success){
            Toast.show({
            label: 'Added this product to cart!!',
            mode: 'dismissible',
            variant: 'success'
        }, this);
        }else{
            Toast.show({
            label: 'Some Error Occured!!',
            mode: 'sticky',
            variant: 'error'
        }, this);
        }
    }

    async handleSearch(event){
        const searchKey = event.target.value;
        if(searchKey.length == 0){
            this.filteredProductList = await getAllProduct();
        }else{
            this.filteredProductList = await searchProduct({searchTerm : searchKey});
        }
    }

}