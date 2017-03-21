function loadUserTypeList(varType){
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT * FROM " + varType
                        var results = tx.executeSql(qry)
                        for(var i = 0; i < results.rows.length; i++){
                            userTypeListModel.append({"description":results.rows.item(i).description})

                        }
                    })
    }catch(err){
        console.log(err)
    }
}
