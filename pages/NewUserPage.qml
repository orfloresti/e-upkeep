import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs/"
import "qrc:/functions/UserFunction.js" as User
import "qrc:/functions/TypeFunction.js" as TypeFunction


Flickable {

    id:flickableUserPage
    visible: false
    contentHeight: userPage.height
    ScrollIndicator.vertical: ScrollIndicator { }

    property bool errorSaving: false

    DialogMessage{
        id: dialogNewUser
        standardButtons: Dialog.Ok
        onAccepted: User.errorSavingFunction()
    }

    Page{
        id: userPage
        width: flickableUserPage.width
        height: flickableUserPage.height * 1.01
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
                        text: ""
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
                        currentIndex: -1
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
                text:""

            }
            Button{
                id: save
                Label{
                    anchors.centerIn: parent
                    text: "Save"
                    color: "Black"
                }
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space

                onClicked: User.saveUser(passwordField.text, nameField.text, userTypeComboBox.currentText)

            }

        }
    }
}
