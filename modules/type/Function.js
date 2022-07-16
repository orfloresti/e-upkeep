function loadList(varType){
    typeListModel.clear()
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT * FROM " + varType
                        var results = tx.executeSql(qry)
                        for(var i = 0; i < results.rows.length; i++){
                            typeListModel.append({"description":results.rows.item(i).description})

                        }
                    })
    }catch(err){
        console.log(err)
    }
}

function saveType(varDescription){
    try{
        db.transaction(
                    function(tx) {
                        var qry = "INSERT INTO ReportType VALUES (?);"
                        tx.executeSql(qry, [varDescription])
                        dialogType.setSettings("Saved","New "+ varDescription + " saved correctly")

                        typeListModel.append({"description":varDescription})
                        dialogType.open()
                        typeField.text = ""
                    }
                    )
    }catch(err){
        dialogType.setSettings("Error", err)
        dialogType.open()
    }
}

function deleteType(varDescription, varIndex){
    try{
        db.transaction(
                    function(tx) {
                        var qry = "DELETE FROM ReportType WHERE description = ?;"
                        tx.executeSql(qry,[varDescription])
                        dialogType.setSettings("Delete",
                                               "You delete the type " +  varDescription + " correctly")
                        typeField.text = ""
                        typeListModel.remove(varIndex)
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
        //saveType(definedTypes.get(typeSelect.currentIndex).table, typeField.text)
        saveType(typeField.text)
    }
}
