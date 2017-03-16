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
        property int space: 20
        id: page

        width: root.width
        height: root.height * 1.01

        ColumnLayout{
            id: column
            width: parent.width

            Label {
                width: column.width - space
                text: "In this section you can create new types for users, reports and devices."
                wrapMode: Label.Wrap
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.topMargin: space
            }

            //**********************************************************
            Label {
                text: "User type"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.topMargin: space
            }
            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                TextField {
                    id: userTypeField
                    selectByMouse: true
                    placeholderText: "User type"
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
                        try{
                        db.transaction(
                                    function(tx) {
                                        var rs = tx.executeSql('INSERT INTO TypeUser VALUES(?)',[userTypeField.text])
                                        dialogDb.setTitleDialog("Saved")
                                        dialogDb.setTextDialog("New user type " + userTypeField.text + " saved correctly")
                                        dialogDb.open()
                                        userTypeField.text = ""

                                    }
                                    )
                        }catch(err){
                            console.log("Error adding type:  " + err);
                            dialogDb.setTitleDialog("Error")
                            dialogDb.setTextDialog(err)
                            dialogDb.open()
                        }
                    }
                }

                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Delete"
                        color: "Black"
                    }
                    Layout.rightMargin: space

                    onClicked: {
                        try{
                        db.transaction(
                                    function(tx) {
                                        var rs = tx.executeSql('DELETE FROM TypeUser WHERE description = ?',[userTypeField.text])
                                        dialogDb.setTitleDialog("Delete")
                                        dialogDb.setTextDialog("You delete the type " + userTypeField.text + " correctly")
                                        dialogDb.open()
                                        userTypeField.text = ""

                                    }
                                    )
                        }catch(err){
                            console.log("Error adding type:  " + err);
                            dialogDb.setTitleDialog("Error")
                            dialogDb.setTextDialog(err)
                            dialogDb.open()
                        }
                    }
                }
            }

            //**********************************************************
            Label {
                text: "Device type"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.topMargin: space
            }
            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                TextField {
                    id: deviceTypeField
                    selectByMouse: true
                    placeholderText: "Device type"
                    Layout.fillWidth: true
                }
                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Save"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                }
            }

            //**********************************************************
            Label {
                text: "Report type"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.topMargin: space
            }
            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                TextField {
                    id: reportTypeField
                    selectByMouse: true
                    placeholderText: "Report type"
                    Layout.fillWidth: true
                }
                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Save"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                }
            }

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
