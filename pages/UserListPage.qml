import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Page{
    property int space: 20
    property var userPassword
    property var userName
    property var userType

    id: root
    contentHeight: page.height

    Page{
        id: page
        width: root.width
        height: root.height * 1.01

        ColumnLayout{
            id: column
            width: parent.width

            Component{
                id: userDelegate

                SwipeDelegate{
                    //id: swipeDelegate
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

                            SwipeDelegate.onClicked: userPageOption(swipe.position,index)
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
                                text: name + ", " + typeUser
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

                    onClicked: userPageOption(swipe.position,index)
                }


            }

            ListModel {
                id: userListModel
                ListElement { password: "500001974"; name: "Orlando Flores Teomitzi"; typeUser: "Laboratory" }
                ListElement { password: "7149"; name: "Vicente Martínez Villegas"; typeUser: "Laboratory" }
                ListElement { password: "500000000"; name: "Usuario"; typeUser: "Plant" }
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
        x: root.width - (width + width/2)
        y: root.height - (height + height/2)
        NumberAnimation on y { from: root.height; to: root.height - (75); duration: 500 }

        onClicked: {
            flickableUserPage.newUser()
            stackView.push(flickableUserPage)
            //console.log(stackView.depth)
        }

    }

    function userPageOption(position,index){
        if(position===0){
            console.log("Edit user" )
            userPassword = userListModel.get(index).password
            userName = userListModel.get(index).name
            //userType = userListModel.get(index).typeUser
            flickableUserPage.editUser()
            stackView.push(flickableUserPage)

        }else{
            console.log("Delete user")
            userListModel.remove(index)
        }
    }

    Flickable {
        id: flickableUserPage
        visible: false
        contentHeight: userPage.height
        ScrollIndicator.vertical: ScrollIndicator { }

        signal editUser
        signal newUser

        onEditUser: {
            pageLabel = "Edit user"
            window.setPageLabel(pageLabel)

            passwordField.text = userPassword
            nameField.text = userName
            //typeUserField.text = userType
        }
        onNewUser: {
            pageLabel = "New user"
            window.setPageLabel(pageLabel)

            passwordField.text = ""
            nameField.text = ""
            //typeUserField.text = userType
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
                            id: typeUserField
                            currentIndex: -1
                            model:["Laboratory", "Plant"]
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
                        anchors.centerIn: parent
                        text: "Save"
                        color: "Black"

                    }
                    Layout.fillWidth: true
                    Layout.leftMargin: space
                    Layout.rightMargin: space

                    onClicked: {
                        console.log("\nPassword: " +passwordField.text + "\nUser: " + typeUserField.currentText+ "\nName: " + nameField.text)
                    }

                }

            }
        }
    }

}

