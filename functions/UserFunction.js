//Functions to new user
function newUserSettings(){
    newUserState = true

    passwordField.text = ""
    nameField.text = ""
    userTypeComboBox.currentIndex = -1

    saveLabel.text = "Save"
    passwordField.enabled = true
}

function saveUser(varPassword, varName, varTypeUser){

    if(varPassword.length < 1 || varPassword.length > 9){
        userDialog.setSettings("Error","The password must be between one and nine characters.")
        userDialog.open()
        errorSaving = true;
    }else{
        try{
            db.transaction(
                        function(tx) {
                            tx.executeSql("INSERT INTO User VALUES (?, ?, ?);", [varPassword, varName, varTypeUser]);
                            userDialog.setSettings("Saved",
                                                   "New user with password "+ varPassword + " saved correctly");
                            userDialog.open();
                            errorSaving = false;

                        }
                        )
        }catch(err){
            userDialog.setSettings("Error", err);
            userDialog.open();
            errorSaving = true;
        }
    }
}

//Functions to update user
function updateUserSettings(varPassword,varName,varType){
    newUserState = false

    passwordField.text  = varPassword
    nameField.text = varName

    //Determine the index of the listTypeModel with UserTypes using a string, to show in the combobox
    var i = 0;
    for(i; i < listTypeModel.count; i++){
        if(varType === listTypeModel.get(i).description){
            userTypeComboBox.currentIndex = parseInt(i);
        }
    }

    saveLabel.text = "Update"
    passwordField.enabled = false
}

function updateUser(varPassword, varName, varTypeUser) {
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("UPDATE User SET password=?, name=?, userTypeDescription=? WHERE password=?",
                                      [varPassword, varName, varTypeUser,varPassword]);
                        userDialog.setSettings("Updated","User with password "+ varPassword + " saved correctly");
                        userDialog.open();
                        errorSaving = false;

                    }
                    )
    }catch(err){
        userDialog.setSettings("Error", err);
        userDialog.open();
        errorSaving = true;
    }

}

// Conditions in an error
function errorSavingUser(){
    if(errorSaving == false){
        userListModel.clear()
        loadUserList("User")
        stackView.pop()
    }
}

//Depending the flag newUserState state, save new user or update one
function savingUser(newUserState){
    if(newUserState === true){
        saveUser(passwordField.text, nameField.text, userTypeComboBox.currentText)
    }else{
        updateUser(passwordField.text, nameField.text, userTypeComboBox.currentText)
    }
}

//Option to update or delete
function updateOrDetele(position,index){
    if(position === 0){
        userSettings.updateUser(userListModel.get(index).password,
                              userListModel.get(index).name,
                              userListModel.get(index).userType)
        stackView.push(userSettings)
    }else{
        deleteUser(userListModel.get(index).password)
        userListModel.remove(index)
    }
}

//Delete user function
function deleteUser(varPassword){
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("DELETE FROM User WHERE password = ?;",[varPassword])
                        deleteUserDialog.setSettings("Delete",
                                               "You delete the user with password " + varPassword + " correctly")
                        deleteUserDialog.open()
                    })

    }catch(err){
        deleteUserDialog.setSettings("Error", err);
        deleteUserDialog.open();
        deleteUserDialog.open()
    }
}



