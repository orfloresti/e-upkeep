//load the component list
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
function updateComponentSettings(varPassword,varDescription,varCost, varStock, varMin){
    moduleName = "Update Component"
    newComponentState = false

    passwordField.text = varPassword
    costField.text = varCost
    descriptionField.text = varDescription
    stockField.text = varStock
    minimumField.text = varMin

    saveLabel.text = "Update"
    passwordField.enabled = false
}

function updateComponent(varPassword,varDescription,varCost, varStock, varMin) {
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("UPDATE Component SET password=?, description=?, cost=?, stock=?, min=? WHERE password=?",
                                      [varPassword, varDescription,varCost, varStock, varMin, varPassword]);
                        componentDialog.setSettings("Updated","Component with password "+ varPassword + " saved correctly");
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
        componentSettings.updateComponent(componentListModel.get(index).password,
                                                  componentListModel.get(index).description,
                                                  componentListModel.get(index).cost,
                                                  componentListModel.get(index).stock,
                                                  componentListModel.get(index).min)
        stackView.push(componentSettings)
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
