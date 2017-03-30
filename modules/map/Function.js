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

function saveBuildingName(varName, varMap){

    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("INSERT INTO Building VALUES (?, ?);",[varName, varMap]);
                        dialog.setSettings("Saved","New Building named "+ varName + " saved correctly");
                        dialog.open();
                        buildingField.text=""
                        loadBuildingList(varMap)
                    }
                    )
    }catch(err){
        errorMessage(err)
    }
}

function saveZoneName(varName, varBuilding, varMap){

    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("INSERT INTO Zone VALUES (?, ?, ?);",[varName, varBuilding, varMap ]);
                        dialog.setSettings("Saved","New Building named "+ varName + " saved correctly");
                        dialog.open();
                        zoneField.text=""
                        loadZoneList(varBuilding, varMap)
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

function deleteBuildingName(varName, varMap){
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("DELETE FROM Building WHERE name = ?;",[varName])
                        dialog.setSettings("Delete","You delete the building named " + varName + " correctly")
                        dialog.open()
                        loadBuildingList(varMap)
                    })

    }catch(err){
        errorMessage(err)
    }
}

function deleteZoneName(varName, varBuilding, varMap){
    try{
        db.transaction(
                    function(tx) {
                        tx.executeSql("DELETE FROM Zone WHERE name = ?;",[varName])
                        dialog.setSettings("Delete","You delete the zone named " + varName + " correctly")
                        dialog.open()
                        loadZoneList(varBuilding, varMap)
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
