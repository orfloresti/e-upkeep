import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs/"
import "qrc:/settings"

import "qrc:/modules/brand/Function.js" as Def

Page{

    //Flag if a error passed saving or update user
    property bool errorSaving: false

    //Flag to determinate if a new user is creating
    property bool newState

    //property to actual name
    property string actualName

    //Signals to create new user or update new one
    signal newItem()
    signal updateItem(string varName)

    onNewItem: {
        moduleName = "New Brand"
        newState = true
        nameField.clear()
        button.text = "Save"
        //passwordField.enabled = true
    }

    onUpdateItem:{
        moduleName = "Update Brand"
        newState = false

        actualName = varName
        nameField.text = varName

        button.text = "Update"
        //passwordField.enabled = false
    }

    //Create the dialog to show problems or complete operations
    DialogMessage{
        id: dialog
        standardButtons: Dialog.Ok
        onAccepted: Def.errorSavingItem()
    }

    //Page settings
    id:page

    //Main page
    Flickable{
        anchors.fill: parent
        contentHeight: columnLayout.height
        ScrollIndicator.vertical: ScrollIndicator { }

        ColumnLayout{
            id: columnLayout
            width: parent.width
            Item{
                id: item
                implicitHeight: image.height
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.topMargin: space
                Layout.bottomMargin: space

                Image {
                    width: 150
                    height: 150
                    id: image
                    anchors.centerIn: parent
                    source: "qrc:/images/easytag.png"
                }
            }

            Label {
                text: "Name"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
            }
            TextField {
                id: nameField
                selectByMouse: true
                placeholderText: "Brand name"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
            }

            Button{
                Label{
                    id: button
                    anchors.centerIn: parent
                    color: "Black"
                }
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.bottomMargin: space
                onClicked: Def.saving(newState)
            }

        }
    }
}
