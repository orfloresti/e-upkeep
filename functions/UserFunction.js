function saveUser(varPassword, varName, varTypeUser){
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("INSERT INTO User VALUES (?, ?, ?);", [varPassword, varName, varTypeUser]);
                        dialogUser.setSettings("Saved",
                                               "New user with password "+ varPassword + " saved correctly");
                        dialogUser.open();
                        errorSaving = false;

                    }
                    )
    }catch(err){
        dialogUser.setSettings("Error", err);
        dialogUser.open();
        errorSaving = true;
    }
}

function updateUser(varPassword, varName, varTypeUser) {
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("UPDATE User SET password=?, name=?, userTypeDescription=? WHERE password=?",
                                      [varPassword, varName, varTypeUser,varPassword]);
                        dialogUser.setSettings("Updated","User with password "+ varPassword + " saved correctly");
                        dialogUser.open();
                        errorSaving = false;

                    }
                    )
    }catch(err){
        dialogUser.setSettings("Error", err);
        dialogUser.open();
        errorSaving = true;
    }

}

function errorSavingUser(){
    if(errorSaving == false){
        userListModel.clear()
        loadUserList("User")
        stackView.pop()
    }
}

