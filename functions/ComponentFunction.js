//load the UserList
function loadComponentList(){
    componentListModel.clear()
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT * FROM Component ORDER BY description ASC"
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
    costField.text = ""
    descriptionField.text = ""
    stockField.text =""
    minimumField.text = ""

    saveLabel.text = "Save"
    passwordField.enabled = true
}

function saveComponent(varPassword,varDescription,varCost, varStock, varMin){

    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("INSERT INTO Component VALUES (?, ?, ?, ?, ?);",
                                      [varPassword,varDescription,varCost, varStock, varMin]);
                        componentDialog.setSettings("Saved",
                                                    "New component with password "+ varPassword + " saved correctly");
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
        componentListModel.clear()
        loadComponentList("Component")
        moduleName = moduleListModel.get(moduleIdex).title
        stackView.pop()
    }
}

//Depending the flag newUserState state, save new user or update one
function savingComponent(newComponentState){
    if(newComponentState === true){
        saveComponent(passwordField.text, descriptionField.text, costField.text, stockField.text, minimumField.text)
    }else{
        updateComponent(passwordField.text, descriptionField.text, costField.text, stockField.text, minimumField.text)
    }
}

//Option to update or delete
function updateOrDetele(position,index){
    if(position === 0){
        /*userSettings.updateUser(userListModel.get(index).password,
                              userListModel.get(index).name,
                              userListModel.get(index).userType)
        stackView.push(userSettings)*/
    }else{
        deleteComponent(componentListModel.get(index).password)
        componentListModel.remove(index)
    }
}

//Delete user function
function deleteComponent(varPassword){
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("DELETE FROM Component WHERE password = ?;",[varPassword])
                        componentDialog.setSettings("Delete",
                                               "You delete the component with password " + varPassword + " correctly")
                        componentDialog.open()
                    })

    }catch(err){
        componentDialog.setSettings("Error", err);
        componentDialog.open();
        componentDialog.open()
    }
}
