//load the lists
function loadMapList(){
    mapListModel.clear()
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT * FROM Map ORDER BY name ASC"
                        var results = tx.executeSql(qry)
                        for(var i = 0; i < results.rows.length; i++){
                            mapListModel.append({"name":results.rows.item(i).name})

                        }
                    })
    }catch(err){
        errorMessage(err)
    }
}

function loadBuildingList(varMap){
    buildingListModel.clear()
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT name FROM Building WHERE mapName = ? ORDER BY name ASC"
                        var results = tx.executeSql(qry, [varMap])
                        for(var i = 0; i < results.rows.length; i++){
                            buildingListModel.append({"name":results.rows.item(i).name})

                        }
                    })
    }catch(err){
        errorMessage(err)
    }
}

function loadZoneList(varBuilding, varMap){
    zoneListModel.clear()
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT name FROM Zone WHERE mapName = ? AND buildingName = ? ORDER BY name ASC"
                        var results = tx.executeSql(qry, [varMap, varBuilding])
                        for(var i = 0; i < results.rows.length; i++){
                            zoneListModel.append({"name":results.rows.item(i).name})

                        }
                    })
    }catch(err){
        errorMessage(err)
    }
}




//load the UserList
function loadUserList(varType){
    userListModel.clear()
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT * FROM " + varType
                        var results = tx.executeSql(qry)
                        for(var i = 0; i < results.rows.length; i++){
                            userListModel.append({"password":results.rows.item(i).password,
                                                  "name":results.rows.item(i).name,
                                                  "zoneName":results.rows.item(i).zoneName,
                                                  "buildingName":results.rows.item(i).buildingName,
                                                  "mapName":results.rows.item(i).mapName})

                        }
                    })
    }catch(err){
        console.log(err)
    }
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
        moduleName = moduleListModel.get(moduleIdex).title
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
                              userListModel.get(index).zoneName,
                              userListModel.get(index).buildingName,
                              userListModel.get(index).mapName)
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


//Show error in a dialog and in console
function errorMessage(err){
    userDialog.setSettings("Error", err);
    console.log(err)
    userDialog.open();
}



