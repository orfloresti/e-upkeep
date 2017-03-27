//load the component list
function loadList(){
    listModel.clear()
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT * FROM brand ORDER BY name ASC"
                        var results = tx.executeSql(qry)
                        for(var i = 0; i < results.rows.length; i++){
                            listModel.append({"name":results.rows.item(i).name})

                        }
                    })
    }catch(err){
        errorMessage(err)
    }
}

//Save new item in data base
function saveItem(varName){

    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("INSERT INTO Brand VALUES (?);",[varName]);
                        dialog.setSettings("Saved","New brand named "+ varName + " saved correctly");
                        dialog.open();
                        errorSaving = false;

                    }
                    )
    }catch(err){
        errorMessage(err)
    }
}

//Update item in data base
function updateItem(varName) {
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("UPDATE Brand SET name=? WHERE name=?",
                                      [varName, actualName]);
                        dialog.setSettings("Updated","Component with password "+ varName + " saved correctly");
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
        saveItem(nameField.text)
    }else{
        updateItem(nameField.text)
    }
}

//Option to update or delete
function modeEditor(position,index){
    if(position === 0){
        editor.updateItem(listModel.get(index).name)
        stackView.push(editor)
    }else{
        deleteItem(listModel.get(index).name)
        listModel.remove(index)
    }
}

//Delete user function
function deleteItem(varName){
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("DELETE FROM Brand WHERE name = ?;",[varName])
                        dialog.setSettings("Delete",
                                               "You delete the brand named " + varName + " correctly")
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
