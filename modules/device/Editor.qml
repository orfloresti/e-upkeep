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

    //property to password
    property string categoryPassword
    property string brandPassword

    signal updatePasswordDevice()

    onUpdatePasswordDevice: {
        passwordField.text = categoryPassword + brandPassword

    }

    //Signals to create new user or update new one
    signal newItem()
    signal updateItem()

    onNewItem: {
        moduleName = "New Device"
        newState = true

        passwordField.clear()
        spinBox.value = 1
        categoryComboBox.currentIndex = -1
        brandComboBox.currentIndex =-1
        mapComboBox.currentIndex = -1
        buildingComboBox.currentIndex = -1
        zoneComboBox.currentIndex = -1

        button.text = "Save"
        passwordField.enabled = true
    }

    onUpdateItem:{
        moduleName = "Update Device"
        newState = false

        //actualName = varName
        //nameField.text = varName

        button.text = "Update"
        passwordField.enabled = false
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
                        //enabled: false
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
                        id: spinBox
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
                    text: "Category"
                    Layout.rightMargin: space

                }

                ComboBox{
                    id: categoryComboBox
                    model:categoryListModel
                    textRole: "description"
                    Layout.fillWidth: true
                    onCurrentTextChanged: {
                        categoryPassword = categoryListModel.get(categoryComboBox.currentIndex).password;
                        updatePasswordDevice()
                    }

                }

                Label {
                    text: "Brand"
                    Layout.rightMargin: space

                }

                ComboBox{
                    id: brandComboBox
                    model:brandListModel
                    textRole: "name"
                    Layout.fillWidth: true
                    onCurrentTextChanged: {
                        brandPassword = brandListModel.get(brandComboBox.currentIndex).password;
                        updatePasswordDevice()
                    }

                }

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
