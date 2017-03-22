import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs/"
import "qrc:/functions/UserFunction.js" as User
import "qrc:/functions/TypeFunction.js" as TypeFunction


Flickable {
    //Flag if a error passed saving or update user
    property bool errorSaving: false

    //Flag to determinate if a new user is creating
    property bool newUserState

    //Signals to create new user or update new one
    signal newUser()
    signal updateUser(int varPassword,string varName, string varType)
    onNewUser: {
        User.newUserSettings()
    }
    onUpdateUser: {
        User.updateUserSettings(varPassword,varName,varType)
    }

    //Load the ListModel of UserType on the beginning
    Component.onCompleted: {
        TypeFunction.loadList("UserType")
    }

    //Create the dialog to show problems or complete operations
    DialogMessage{
        id: userDialog
        standardButtons: Dialog.Ok
        onAccepted: User.errorSavingUser()
    }

    //Page settings
    id:userSettings
    visible: false
    contentHeight: userPage.height
    ScrollIndicator.vertical: ScrollIndicator { }

    //Main page
    Page{
        id: userPage
        width: userSettings.width
        height: userSettings.height * 1.01
        ColumnLayout{
            id: columnUser
            width: parent.width
            Item{
                id: userItem
                implicitHeight: newUserImage.height
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Image {
                    width: 150
                    height: 150
                    id: newUserImage
                    anchors.centerIn: parent
                    source: "qrc:/images/avatar-default.png"
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
                        text: "User"
                        Layout.fillWidth: true
                    }
                    ComboBox{
                        id: userTypeComboBox
                        model:listTypeModel
                        Layout.fillWidth: true
                    }
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
                placeholderText: "Name"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
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
                onClicked: User.savingUser(newUserState)
            }

        }
    }
}
