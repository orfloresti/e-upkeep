//load the component list
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

function loadBuildingList(){
    buildingListModel.clear()
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT * FROM Building ORDER BY name ASC"
                        var results = tx.executeSql(qry)
                        for(var i = 0; i < results.rows.length; i++){
                            buildingListModel.append({"name":results.rows.item(i).name})

                        }
                    })
    }catch(err){
        errorMessage(err)
    }
}

function loadZoneList(){
    zoneListModel.clear()
    try{
        db.transaction(
                    function(tx) {
                        var qry = "SELECT * FROM Zone ORDER BY name ASC"
                        var results = tx.executeSql(qry)
                        for(var i = 0; i < results.rows.length; i++){
                            zoneListModel.append({"name":results.rows.item(i).name})

                        }
                    })
    }catch(err){
        errorMessage(err)
    }
}


//Save new item in data base
function saveMapName(varName){

    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("INSERT INTO Map VALUES (?);",[varName]);
                        dialog.setSettings("Saved","New map named "+ varName + " saved correctly");
                        dialog.open();
                        mapField.text=""
                        loadMapList()
                    }
                    )
    }catch(err){
        errorMessage(err)
    }
}

//Delete user function
function deleteMapName(varName){
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("DELETE FROM Map WHERE name = ?;",[varName])
                        dialog.setSettings("Delete","You delete the map named " + varName + " correctly")
                        dialog.open()
                        loadMapList()
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
}
