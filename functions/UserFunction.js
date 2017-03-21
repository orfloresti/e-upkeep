function saveUser(varPassword, varName, varTypeUser){
    try{
        db.transaction(
                    function(tx) {
                        //var qry = "INSERT INTO User VALUES (?, ?, ?);"
                        tx.executeSql("INSERT INTO User VALUES (?, ?, ?);", [varPassword, varName, varTypeUser])
                        dialogNewUser.setTitleDialog("Saved")
                        dialogNewUser.setTextDialog("New user with password "+ varPassword + " saved correctly")
                        dialogNewUser.open()
                        errorSaving = false

                    }
                    )
    }catch(err){
        errorSaving = true
        console.log("Error :  " + err);
        dialogNewUser.setTitleDialog("Error")
        dialogNewUser.setTextDialog(err)
        dialogNewUser.open()
    }
}

function updateUser(varPassword, varName, varTypeUser) {
    try{
        db.transaction(
                    function(tx) {
                        //var sql ="UPDATE User SET password=?, name=?, userTypeDescription=? WHERE password=?"
                        tx.executeSql("UPDATE User SET password=?, name=?, userTypeDescription=? WHERE password=?", [varPassword, varName, varTypeUser,varPassword])
                        dialogUpdateUser.setTitleDialog("Updated")
                        dialogUpdateUser.setTextDialog("User with password "+ varPassword + " saved correctly")
                        dialogUpdateUser.open()

                        errorSaving = false

                    }
                    )
    }catch(err){
        errorSaving = true

        console.log("Error :  " + err);
        dialogUpdateUser.setTitleDialog("Error")
        dialogUpdateUser.setTextDialog(err)
        dialogUpdateUser.open()
    }

}

function errorSavingFunction(){
    if(errorSaving == false){
        userListModel.clear()
        loadUserList("User")
        stackView.pop()
    }
}
