import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/pages/"
import "qrc:/functions/TypeFunction.js" as TypeFunction


Page{

    property string titleDialog
    property string textDialog

    id: userPageRoot
    contentHeight: page.height


    NewUserPage{
        id: newUser
    }

    UpdateUserPage{
        id: updateUser
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
            //updateUser.newUser()
            TypeFunction.loadList("UserType")
            stackView.push(newUser)
        }
    }


    function userPageOption(position,index){
        if(position === 0){
            updateUser.updateUser(userListModel.get(index).password,
                                  userListModel.get(index).name,
                                  userListModel.get(index).userType)
            //updateUser.setPassword(userListModel.get(index).password)
            //updateUser.setName(userListModel.get(index).name)
            //updateUser.getTypeIndex(userListModel.get(index).userType)
            stackView.push(updateUser)
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

    Dialog {

        signal setTitleDialog(string titleDialogInput)
        signal setTextDialog(string textDialogInput)

        onSetTitleDialog:  {
            titleDialog = titleDialogInput
        }

        onSetTextDialog:{
            textDialog = textDialogInput
        }

        id: dialogUser
        focus: true
        modal: true

        width: parent.width/1.5
        height: parent.height/1.5
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: titleDialog

        standardButtons: Dialog.Close

        Column{
            spacing: 20
            Text {
                width: dialogUser.availableWidth
                text: textDialog
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }

    }
}

