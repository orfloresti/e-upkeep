import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs/"
import "qrc:/functions/UserFunction.js" as User
import "qrc:/functions/TypeFunction.js" as TypeFunction


Flickable {

    property bool errorSaving: false
    property bool newUserState
    signal newUser()
    signal updateUser(int varPassword,string varName, string varType)

    id:updatePageRoot
    visible: false
    contentHeight: userPage.height
    ScrollIndicator.vertical: ScrollIndicator { }

    onNewUser: {
        newUserState = true

        passwordField.text = ""
        nameField.text = ""
        userTypeComboBox.currentIndex = -1

        saveLabel.text = "Save"
        passwordField.enabled = true
    }

    onUpdateUser: {
        newUserState = false

        passwordField.text  = varPassword
        nameField.text = varName

        var i = 0;
        for(i; i < listTypeModel.count; i++){
            if(varType === listTypeModel.get(i).description){
                userTypeComboBox.currentIndex = parseInt(i);
            }
        }

        saveLabel.text = "Update"
        passwordField.enabled = false
    }

    Component.onCompleted: {
        TypeFunction.loadList("UserType")
    }

    DialogMessage{
        id: dialogUser
        standardButtons: Dialog.Ok
        onAccepted: User.errorSavingUser()
    }

    Page{
        id: userPage
        width: updatePageRoot.width
        height: updatePageRoot.height * 1.01
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
                id: save
                Label{
                    id: saveLabel
                    anchors.centerIn: parent
                    color: "Black"
                }
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space

                onClicked: {
                    if(newUserState === true){
                        User.saveUser(passwordField.text, nameField.text, userTypeComboBox.currentText)
                    }else{
                        User.updateUser(passwordField.text, nameField.text, userTypeComboBox.currentText)
                    }
                }


            }

        }
    }
}
