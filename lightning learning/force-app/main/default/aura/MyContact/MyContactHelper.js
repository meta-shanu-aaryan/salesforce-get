({
	getSelectedContacts : function(component) {
		var selectedcontact = [];
        var checkBoxes = component.find("recordCheckbox");
        
        if(!Array.isArray(checkBoxes)){
            checkBoxes = [checkBoxes];
        }
        
        checkBoxes.forEach((checkBox)=>{
            if(checkBox.getElement().checked){
            	selectedcontact.push(checkBox.getElement().value);
        	}
        });
        
        return selectedcontact;
	}
})