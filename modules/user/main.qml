import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1


import "qrc:/dialogs"
import "qrc:/settings"

import "qrc:/modules/user"
import "qrc:/modules/user/Function.js" as User

Page{
    //Page settings
    id: userPageRoot
    contentHeight: page.height

    //List model
    ListModel{id:userListModel}
    ListModel{id:typeListModel}

    //Create one UserSettingsPage model to new user or update one
    Editor{
        visible: false
        id: userSettings
    }

    //Create the dialog
    DialogMessage{
        id: deleteUserDialog
        standardButtons: Dialog.Close
    }

    Component.onCompleted: {
        User.loadUserList("User")
    }

    //Main page
    Page{
        id: page
        width: userPageRoot.width
        height: userPageRoot.height * 1.01

        ColumnLayout{
            id: column
            width: parent.width

            Component{
                id: userDelegate
                SwipeDelegate{
                    id: swipeDelegate
                    width: parent.width
                    height: userDescription.height + 20
                    anchors.horizontalCenter: parent.horizontalCenter

                    swipe.left: Component {
                        Rectangle {
                            id: userDelete
                            color: "#848484" //SwipeDelegate.pressed ?  "#585858" : "#848484"
                            width: parent.width -80
                            height: parent.height
                            clip: true
                            Label {
                                //font.pixelSize: swipeDelegate.font.pixelSize
                                text: "Click to remove"
                                color: "white"
                                anchors.centerIn: parent
                            }
                            SwipeDelegate.onClicked: {
                                User.updateOrDetele(swipe.position,index)
                            }
                        }
                    }
                    contentItem: RowLayout{
                        Item{
                            width: userImage.width
                            height: userImage.height
                            Image {
                                width: 50
                                height: 50
                                id: userImage
                                anchors.centerIn: parent
                                source: "qrc:/images/avatar-default.png"
                            }
                        }
                        ColumnLayout{
                            id: userDescription
                            Layout.leftMargin: 10
                            Label{
                                text: password
                                wrapMode: Label.Wrap
                                font.pixelSize: 16
                                font.bold: true
                                Layout.fillWidth: true

                            }
                            Label{
                                text: "<b>" + name + "</b>, " + userType
                                wrapMode: Label.Wrap
                                font.pixelSize: 12
                                Layout.fillWidth: true
                                color: "grey"

                            }
                            Rectangle {
                                height: 1
                                color: "#E6E6E6"
                                Layout.fillWidth: true
                            }
                        }
                    }
                    onClicked: {
                        User.updateOrDetele(swipe.position,index)
                    }
                }
            }
            ListView {
                id: userList
                Layout.fillWidth: true
                height: page.height
                focus: true
                model: userListModel
                delegate: userDelegate
                ScrollIndicator.vertical: ScrollIndicator { }
            }
        }
    }
    AddButton{
        id: addUserButton
        x: userPageRoot.width - (width + width/2)
        y: userPageRoot.height - (height + height/2)
        NumberAnimation on y { from: userPageRoot.height; to: userPageRoot.height - (75); duration: 500 }

        onClicked: {
            userSettings.newUser()
            stackView.push(userSettings)
        }
    }
}

