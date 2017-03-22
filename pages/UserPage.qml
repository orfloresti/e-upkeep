import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/pages/"


Page{

    property string titleDialog
    property string textDialog

    id: userPageRoot
    contentHeight: page.height

    UserSettingsPage{
        id: userSettings
    }

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
                                //console.log(swipe.position)
                                userPageOption(swipe.position,index)
                            }
                        }
                    }

                    contentItem: RowLayout{                        
                        //anchors.fill: parent

                        Item{
                            width: userImage.width
                            height: userImage.height
                            //Layout.leftMargin: 10

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
                                text: name + ", " + userType
                                wrapMode: Label.Wrap
                                font.pixelSize: 12
                                Layout.fillWidth: true

                            }
                            Rectangle {
                                height: 1
                                color: "#E6E6E6"
                                Layout.fillWidth: true

                            }
                        }
                    }
                    onClicked: {
                        //console.log(swipe.position)
                        userPageOption(swipe.position,index)
                        //console.log(index)
                    }
                }
            }

            ListView {
                id: userList
                Layout.fillWidth: true
                //Layout.fillHeight: true
                //width: swipeView.width
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

    function userPageOption(position,index){
        if(position === 0){
            userSettings.updateUser(userListModel.get(index).password,
                                  userListModel.get(index).name,
                                  userListModel.get(index).userType)
            stackView.push(userSettings)
        }else{
            deleteUser(userListModel.get(index).password)
            userListModel.remove(index)
        }
    }

    function deleteUser(varPassword){
        try{
            db.transaction(
                        function(tx) {
                            tx.executeSql("DELETE FROM User WHERE password = ?;",[varPassword])
                            dialogUser.setTitleDialog("Delete")
                            dialogUser.setTextDialog("You delete the user with password " + varPassword + " correctly")
                            //typeField.text = ""
                            //listModel.remove(varIndex)
                            dialogUser.open()
                        })

        }catch(err){
            console.log("Error:  " + err);
            dialogUser.setTitleDialog("Error")
            dialogUser.setTextDialog(err)
            dialogUser.open()
        }
    }
}

