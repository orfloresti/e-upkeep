import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs/"
import "qrc:/settings"

import "qrc:/modules/device/Function.js" as Def

Page{

    //Flag if a error passed saving or update user
    property bool errorSaving: false

    //Flag to determinate if a new user is creating
    property bool newState

    //property to actual name
    property string actualName

    //Signals to create new user or update new one
    signal newItem()
    signal updateItem()

    onNewItem: {
        moduleName = "New Device"
        newState = true

        //nameField.clear()
        button.text = "Save"
        //passwordField.enabled = true
    }

    onUpdateItem:{
        moduleName = "Update Device"
        newState = false

        //actualName = varName
        //nameField.text = varName

        button.text = "Update"
        //passwordField.enabled = false
    }

    //Create the dialog to show problems or complete operations
    DialogMessage{
        id: dialog
        standardButtons: Dialog.Ok
        onAccepted: Def.errorSavingItem()
    }

    //Listmodels
    ListModel{
        id:descriptionListModel
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
                id: userItem
                implicitHeight: newUserImage.height
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.topMargin: space
                Layout.bottomMargin: space

                Image {
                    width: 150
                    height: 150
                    id: newUserImage
                    anchors.centerIn: parent
                    source: "qrc:/images/media-flash.png"
                }
            }

            RowLayout{
            ColumnLayout{
            Label {
                text: "Password"
                Layout.fillWidth: true
                Layout.leftMargin: space
                //Layout.rightMargin: space
            }
            TextField {
                id: passwordField
                selectByMouse: true
                placeholderText: "Password"
                Layout.fillWidth: true
                Layout.leftMargin: space
                //Layout.rightMargin: space
                enabled: false
            }
            }

            ColumnLayout{
                Label {
                    text: "Stock"
                    //Layout.fillWidth: true
                    Layout.leftMargin: space
                    Layout.rightMargin: space
                }

                SpinBox{
                    //Layout.fillWidth: true
                    Layout.leftMargin: space
                    Layout.rightMargin: space
                }
            }

            }



            GridLayout{
                Layout.topMargin: space
                Layout.leftMargin: space
                Layout.rightMargin: space
                columns: 2

                Label {
                    text: "Map"
                    Layout.rightMargin: space

                }

                ComboBox{
                    id: mapComboBox
                    model:mapListModel
                    Layout.fillWidth: true
                    onCurrentTextChanged: Def.loadBuildingList(mapComboBox.currentText)

                }

                Label {
                    text: "Building"
                    Layout.rightMargin: space

                }

                ComboBox{
                    id: buildingComboBox
                    model:buildingListModel
                    Layout.fillWidth: true
                    onCurrentTextChanged: Def.loadZoneList(buildingComboBox.currentText,
                                                            mapComboBox.currentText)

                }

                Label {
                    text: "Zone"
                    Layout.rightMargin: space

                }

                ComboBox{
                    id: zoneComboBox
                    model:zoneListModel
                    Layout.fillWidth: true

                }
            }





            Button{
                Label{
                    id: button
                    anchors.centerIn: parent
                    color: "Black"
                }
                Layout.topMargin: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.bottomMargin: space
                onClicked: Def.saving(newState)
            }

        }
    }
}
