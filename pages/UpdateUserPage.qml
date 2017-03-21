import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs/"
import "qrc:/functions/UserFunction.js" as User
import "qrc:/functions/TypeFunction.js" as TypeFunction


Flickable {

    property int password
    property string name

    property bool errorSaving: false

    property bool newUserState


    signal newUser()
    signal updateUser(int varPassword,string varName, string varType)


    onNewUser: {
        newUserState = true
        userTypeComboBox.currentIndex = -1
        saveLabel.text = "Save"
        passwordField.enabled = true


    }

    onUpdateUser: {
        newUserState = false
        password = varPassword
        name = varName
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


    id:updatePageRoot
    visible: false
    contentHeight: userPage.height
    ScrollIndicator.vertical: ScrollIndicator { }

    DialogMessage{
        id: dialogUpdateUser
        standardButtons: Dialog.Ok
        onAccepted: User.errorSavingFunction()
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
                        text: password
                        //enabled: false
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
                        //displayText: userPageRoot.userType
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
                text: name

            }
            Button{
                id: save
                Label{
                    id: saveLabel
                    anchors.centerIn: parent
                    //text: "Update"
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
