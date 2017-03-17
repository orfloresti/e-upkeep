import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Flickable {
    property int space: 20
    property string titleDialog
    property string textDialog

    id: root
    contentHeight: page.height
    ScrollIndicator.vertical: ScrollIndicator { }

    Page{
        id: page
        width: root.width
        height: root.height * 1.01

        ListModel{
            id: listModel
        }

        ColumnLayout{
            id: column
            width: parent.width
            Label {
                width: column.width - space
                text: "In this module you can create new types for users, reports and devices. Remenber the types used can't be delete."
                wrapMode: Label.Wrap
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.topMargin: space
            }

            Label {
                text: "Select one type"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.topMargin: space
            }

            ComboBox{
                id: typeSelect
                currentIndex: -1
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space

                onCurrentTextChanged: {
                    loadList(typeSelect.currentText)
                    console.log(typeSelect.currentText)
                }

                model: ListModel{
                    ListElement {table: "UserType"}
                    ListElement {table: "DeviceType"}
                    ListElement {table: "ReportType"}
                }

            }


            Label {
                text: "Type Settings"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.topMargin: space
            }

            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                TextField {
                    id: typeField
                    selectByMouse: true
                    placeholderText: "New type"
                    Layout.fillWidth: true
                }
                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Save"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                    onClicked: {
                        if(typeField.text.length < 1){
                            dialogDb.setTitleDialog("Error")
                            dialogDb.setTextDialog("The TextField is blank")
                            dialogDb.open()
                        }else{
                            saveType(typeSelect.currentText, typeField.text)
                        }
                    }
                }
            }
            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                ComboBox{
                    //currentIndex:
                    id: typeUserComboBox
                    Layout.fillWidth: true
                    model: listModel
                }                

                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Delete"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                    onClicked:{
                        deleteType(typeSelect.currentText, typeUserComboBox.currentText, typeUserComboBox.currentIndex)

                    }
                }
            }
        }
    }

    function loadList(varType){
        listModel.clear()
        try{
            db.transaction(
                        function(tx) {
                            var qry = "SELECT * FROM " + varType
                            var results = tx.executeSql(qry)
                            for(var i = 0; i < results.rows.length; i++){
                                listModel.append({"description":results.rows.item(i).description})

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
                            dialogDb.setTitleDialog("Saved")
                            dialogDb.setTextDialog("New " + varType + " "+ varDescription + " saved correctly")
                            listModel.append({"description":varDescription})
                            dialogDb.open()
                            typeField.text = ""
                        }
                        )
        }catch(err){
            console.log("Error adding type:  " + err);
            dialogDb.setTitleDialog("Error")
            dialogDb.setTextDialog(err)
            dialogDb.open()
        }
    }

    function deleteType(varType, varDescription, varIndex){
        try{
            db.transaction(
                        function(tx) {
                            var qry = "DELETE FROM " + varType + " WHERE description = ?;"
                            tx.executeSql(qry,[varDescription])
                            dialogDb.setTitleDialog("Delete")
                            dialogDb.setTextDialog("You delete the "+ varType + " " + varDescription + " correctly")
                            typeField.text = ""
                            listModel.remove(varIndex)
                            dialogDb.open()
                        })

        }catch(err){
            console.log("Error adding type:  " + err);
            dialogDb.setTitleDialog("Error")
            dialogDb.setTextDialog(err)
            dialogDb.open()
        }
    }


    Dialog {
        signal setTitleDialog(string titleDialogInput)
        signal setTextDialog(string textDialogInput)

        onSetTitleDialog:  {
            titleDialog = titleDialogInput
        }

        onSetTextDialog:{
            textDialog = textDialogInput
        }

        id: dialogDb
        focus: true
        modal: true
        width: parent.width/1.5
        height: parent.height/1.5
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: titleDialog

        standardButtons: Dialog.Close

        Column{
            spacing: 20
            Text {
                width: dialogDb.availableWidth
                text: textDialog
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }

    }


}
