function loadList(varType){
    listTypeModel.clear()
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT * FROM " + varType
                        var results = tx.executeSql(qry)
                        for(var i = 0; i < results.rows.length; i++){
                            listTypeModel.append({"description":results.rows.item(i).description})

                        }
                    })
    }catch(err){
        console.log(err)
    }
}

function saveType(varType, varDescription){
    try{
        db.transaction(
                    function(tx) {
                        var qry = "INSERT INTO " + varType +" VALUES (?);"
                        tx.executeSql(qry, [varDescription])
                        dialogType.setSettings("Saved","New " + varType + " "+ varDescription + " saved correctly")

                        listTypeModel.append({"description":varDescription})
                        dialogType.open()
                        typeField.text = ""
                    }
                    )
    }catch(err){
        dialogType.setSettings("Error", err)
        dialogType.open()
    }
}

function deleteType(varType, varDescription, varIndex){
    try{
        db.transaction(
                    function(tx) {
                        var qry = "DELETE FROM " + varType + " WHERE description = ?;"
                        tx.executeSql(qry,[varDescription])
                        dialogType.setSettings("Delete",
                                               "You delete the "+ varType + " " + varDescription + " correctly")
                        typeField.text = ""
                        listTypeModel.remove(varIndex)
                        dialogType.open()
                    })

    }catch(err){
        dialogType.setSettings("Error", err)
        dialogType.open()
    }
}

function blankSpace(){
    if(typeField.text.length < 1){
        dialogType.setSettings("Error","The TextField is blank")
        dialogType.open()
    }else{
        TypeFunction.saveType(typeSelect.currentText, typeField.text)
    }
}
