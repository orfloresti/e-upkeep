//load the UserList
function loadComponentList(varType){
    componentListModel.clear()
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT * FROM " + varType
                        var results = tx.executeSql(qry)
                        for(var i = 0; i < results.rows.length; i++){
                            componentListModel.append({"password":results.rows.item(i).password,
                                                     "description":results.rows.item(i).description,
                                                     "cost":results.rows.item(i).cost,
                                                     "stock":results.rows.item(i).stock,
                                                     "min":results.rows.item(i).min
                                                 })

                        }
                    })
    }catch(err){
        console.log(err)
    }
}

//Functions to new user
function newComponentSettings(){
    moduleName = "New Component"
    newComponentState = true

    passwordField.text = ""
    nameField.text = ""
    userTypeComboBox.currentIndex = -1

    saveLabel.text = "Save"
    passwordField.enabled = true
}

function saveComponent(varPassword, varName, varTypeUser){

    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("INSERT INTO User VALUES (?, ?, ?);", [varPassword, varName, varTypeUser]);
                        componentDialog.setSettings("Saved",
                                                    "New user with password "+ varPassword + " saved correctly");
                        componentDialog.open();
                        errorSaving = false;

                    }
                    )
    }catch(err){
        componentDialog.setSettings("Error", err);
        componentDialog.open();
        errorSaving = true;
    }

}

//Functions to update user
function updateComponentSettings(varPassword,varName,varType){
    moduleName = "Update Component"

    newUserState = false

    passwordField.text  = varPassword
    nameField.text = varName

    //Determine the index of the listTypeModel with UserTypes using a string, to show in the combobox
    var i = 0;
    for(i; i < typeListModel.count; i++){
        if(varType ===typeListModel.get(i).description){
            userTypeComboBox.currentIndex = parseInt(i);
        }
    }

    saveLabel.text = "Update"
    passwordField.enabled = false
}

function updateComponent(varPassword, varName, varTypeUser) {
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("UPDATE User SET password=?, name=?, userTypeDescription=? WHERE password=?",
                                      [varPassword, varName, varTypeUser,varPassword]);
                        componentDialog.setSettings("Updated","User with password "+ varPassword + " saved correctly");
                        componentDialog.open();
                        errorSaving = false;

                    }
                    )
    }catch(err){
        componentDialog.setSettings("Error", err);
        componentDialog.open();
        errorSaving = true;
    }

}

// Conditions in an error
function errorSavingComponent(){
    if(errorSaving == false){
        userListModel.clear()
        loadUserList("Component")
        moduleName = moduleListModel.get(moduleIdex).title
        stackView.pop()
    }
}

//Depending the flag newUserState state, save new user or update one
function savingComponent(newComponentState){
    if(newComponentState === true){
        saveComponent(passwordField.text, nameField.text, userTypeComboBox.currentText)
    }else{
        updateComponent(passwordField.text, nameField.text, userTypeComboBox.currentText)
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
        deleteComponent(userListModel.get(index).password)
        userListModel.remove(index)
    }
}

//Delete user function
function deleteComponent(varPassword){
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("DELETE FROM User WHERE password = ?;",[varPassword])
                        componentDialog.setSettings("Delete",
                                               "You delete the user with password " + varPassword + " correctly")
                        componentDialog.open()
                    })

    }catch(err){
        componentDialog.setSettings("Error", err);
        componentDialog.open();
        componentDialog.open()
    }
}
