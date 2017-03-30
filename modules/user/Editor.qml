import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs/"
import "qrc:/settings"
import "qrc:/modules/user/Function.js" as User

Page {
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
        User.loadTypeList("UserType")
    }

    //Create the dialog to show problems or complete operations
    DialogMessage{
        id: userDialog
        standardButtons: Dialog.Ok
        onAccepted: User.errorSavingUser()
    }

    //Page settings
    id:userSettings

    //Main page
    Flickable{
        anchors.fill: parent
        contentHeight: columnUser .height
        //boundsBehavior: Flickable.StopAtBounds
        ScrollIndicator.vertical: ScrollIndicator { }

        ColumnLayout{
            id: columnUser
            width: parent.width
            Layout.topMargin: space
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


            }

            ColumnLayout{
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
            }

            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space

                ColumnLayout{
                    Label {
                        text: "Map"
                        Layout.fillWidth: true
                    }
                    ComboBox{
                        id: userTypeComboBox
                        model:typeListModel
                        Layout.fillWidth: true
                    }
                }

                ColumnLayout{
                    Label {
                        text: "Building"
                        Layout.fillWidth: true
                    }
                    ComboBox{
                        id: buildingComboBox
                        model:typeListModel
                        Layout.fillWidth: true
                    }
                }

                ColumnLayout{
                    Label {
                        text: "Zone"
                        Layout.fillWidth: true
                    }
                    ComboBox{
                        id: zoneComboBox
                        model:typeListModel
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
                onClicked: User.savingUser(newUserState)
            }

        }
    }
}
