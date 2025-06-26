({
    getCont : function(component, event, helper) { 
        var action = component.get("c.getContacts"); 
        action.setCallback(this, function(response){ 
            component.set("v.rec", response.getReturnValue()); 
        }); 
        $A.enqueueAction(action); 
    },
    
    modalOpenFunc : function(component, event, helper){
        component.set("v.handleModalOpen", "true")
    },
    
    modalCloseFunc : function(component, event, helper){
        component.set("v.handleModalOpen", "false")
    },
    
    createCont : function(component, event, helper){
        var contact = component.get("v.contactData");
        var action = component.get("c.createContact");
        action.setParams({ lastName : contact.lastName,  firstName:contact.firstName, email:contact.email, phone:contact.phone});
        
        action.setCallback(this, function(response){
            var returnVal = response.getReturnValue();
            component.set("v.createdContactId", returnVal);
            component.set("v.handleModalOpen", "false");
            //getCont();
            window.location.reload();
        });
        $A.enqueueAction(action);
    },
    
    editContact : function(component, event, helper){
        var selectedContactIds = helper.getSelectedContacts(component);
        if(selectedContactIds.length!=1){
            alert("No or more than one row is selected");
        }else{
            
            var getContactDetail = component.get("c.getContact");
            var selectedId = selectedContactIds[0];
            getContactDetail.setParams({contactId : selectedId});
            getContactDetail.setCallback(this, function(response){
                var returnedVal = response.getReturnValue();
                component.set("v.editContactData", returnedVal);
                console.log(returnedVal);
                console.log("called");
            })
            
            $A.enqueueAction(getContactDetail);
            component.set("v.editModalOpen", "true")
        }
        
        
    },
    
    saveEditedChanges : function(component, event, helper){
        var editContactDetail = component.get("v.editContactData");
        //console.log(editContactDetail);
        //alert(editContactDetail.Id + editContactDetail.FirstName + editContactDetail.LastName + editContactDetail.Phone + editContactDetail.Email);
        var action = component.get("c.editContactList");
        // editContact(String contactid, String lastName, String firstName, String phone, String email)
        action.setParams({contactid:editContactDetail.Id, lastName:editContactDetail.LastName, firstName:editContactDetail.FirstName, phone:editContactDetail.Phone, email:editContactDetail.Email});
        action.setCallback(this, function(a){
            //alert("Called")
            var val = a.getReturnValue();
            if(val === true){
                alert('Contact updated');
            }else{
                alert('Some issue');
            }
            window.location.reload();
        })
        
        $A.enqueueAction(action);
        component.set("v.editModalOpen", "false");
        
    },
    
    openEditModal : function(component, event, helper){
        component.set("v.editModalOpen", "true");
    },
    
    closeEditModal : function(component, event, helper){
        component.set("v.editModalOpen", "false");
    },
    
    deleteSelectedContact : function(component, event, helper){
        var selectedContact = helper.getSelectedContacts(component);
        
        if(selectedContact.length < 1){
            alert("select at least one contact to delete");
        }else{
            
            
            
            var action = component.get("c.deleteContact");
            action.setParams({contactIdList:selectedContact});
            action.setCallback(this, function(response){
                var val = response.getReturnValue();
                
                if(val){
                    alert("Deleted successfully");
                }else if(!val){
                    alert("Something went wrong");
                }else{
                    alert("undefined");
                }
                
                window.location.reload();
            })
            
            $A.enqueueAction(action);
        }
    }
    
    
})