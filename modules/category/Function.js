//load the component list
function loadList(){
    listModel.clear()
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT * FROM Category ORDER BY password ASC"
                        var results = tx.executeSql(qry)
                        for(var i = 0; i < results.rows.length; i++){
                            listModel.append({"password":results.rows.item(i).password,
                                              "description":results.rows.item(i).description})

                        }
                    })
    }catch(err){
        errorMessage(err)
    }
}

//Save new item in data base
function saveItem(varPassword, varDescription){

    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("INSERT INTO Category VALUES (?, ?);",[varPassword, varDescription]);
                        dialog.setSettings("Saved","New category  " + varDescription + " saved correctly");
                        dialog.open();
                        errorSaving = false;

                    }
                    )
    }catch(err){
        errorMessage(err)
    }
}

//Update item in data base
function updateItem(varPassword, varDescription) {
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("UPDATE Category SET password=?, description=? WHERE password=?",
                                      [varPassword, varDescription, varPassword]);
                        dialog.setSettings("Updated","The category "+ varDescription + " saved correctly");
                        dialog.open();
                        errorSaving = false;

                    }
                    )
    }catch(err){
        errorMessage(err)
    }

}

// Conditions in an error
function errorSavingItem(){
    if(errorSaving == false){
        listModel.clear()
        loadList()
        moduleName = moduleListModel.get(moduleIdex).title
        stackView.pop()
    }
}

//Depending the flag newUserState state, save new user or update one
function saving(newState){
    if(newState === true){
        saveItem(passwordField.text, descriptionField.text)
    }else{
        updateItem(passwordField.text, descriptionField.text)
    }
}

//Option to update or delete
function modeEditor(position,index){
    if(position === 0){
        editor.updateItem(listModel.get(index).password, listModel.get(index).description)
        stackView.push(editor)
    }else{
        deleteItem(listModel.get(index).password)
        listModel.remove(index)
    }
}

//Delete user function
function deleteItem(varPassword){
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("DELETE FROM Category WHERE password = ?;",[varPassword])
                        dialog.setSettings("Delete",
                                               "You delete the Category named " + varPassword + " correctly")
                        dialog.open()
                    })

    }catch(err){
        errorMessage(err)
    }
}

//Show error in a dialog and in console
function errorMessage(err){
    dialog.setSettings("Error", err);
    console.log(err)
    dialog.open();
    errorSaving = true;
}
