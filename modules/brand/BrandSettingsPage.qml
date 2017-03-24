import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs/"
import "qrc:/settings"

import "qrc:/modules/brand/BrandFunction.js" as Brand

Page{
    //Flag if a error passed saving or update user
    property bool errorSaving: false

    //Flag to determinate if a new user is creating
    property bool newState

    //Signals to create new user or update new one
    signal newComponent()
    signal updateComponent(string varPassword,string varDescription,double varCost, int varStock, int varMin)

    onNewComponent: {
        Comp.newComponentSettings()
    }
    onUpdateComponent: {
        Comp.updateComponentSettings(varPassword,varDescription,varCost, varStock, varMin)
    }

    //Create the dialog to show problems or complete operations
    DialogMessage{
        id: componentDialog
        standardButtons: Dialog.Ok
        onAccepted: Comp.errorSavingComponent()
    }

    //Page settings
    id:page

    //Main page
    Flickable{
        anchors.fill: parent
        contentHeight: columnUser.height
        ScrollIndicator.vertical: ScrollIndicator { }

        ColumnLayout{
            id: columnUser
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
                    source: "qrc:/images/yast.png"
                }
            }

            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space

                ColumnLayout{
                    Label {
                        text: "Password"
                        Layout.fillWidth: true
                    }
                    TextField {
                        id: passwordField
                        selectByMouse: true
                        placeholderText: "Password"
                        Layout.fillWidth: true
                    }
                }

                ColumnLayout{
                    Label {
                        text: "Cost"
                        Layout.fillWidth: true
                    }
                    TextField {
                        id: costField
                        selectByMouse: true
                        placeholderText: "$"
                        Layout.fillWidth: true
                    }
                }
            }

            Label {
                text: "Description"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
            }
            TextField {
                id: descriptionField
                selectByMouse: true
                placeholderText: "Component description"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
            }

            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space

                ColumnLayout{
                    Label {
                        text: "Stock"
                        Layout.fillWidth: true
                    }
                    TextField {
                        id: stockField
                        selectByMouse: true
                        placeholderText: "Actual stock"
                        Layout.fillWidth: true
                    }
                }

                ColumnLayout{
                    Label {
                        text: "Minimum"
                        Layout.fillWidth: true
                    }
                    TextField {
                        id: minimumField
                        selectByMouse: true
                        placeholderText: "Minimum stock"
                        Layout.fillWidth: true
                    }
                }
            }

            Button{
                Label{
                    id: saveLabel
                    anchors.centerIn: parent
                    color: "Black"
                }
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.bottomMargin: space
                onClicked: Comp.savingComponent(newState)
            }

        }
    }
}
