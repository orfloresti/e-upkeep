import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Page{
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
                    height: userImage.height + 20
                    anchors.horizontalCenter: parent.horizontalCenter

                    swipe.left: Component {

                        Rectangle {
                            id: userDelete
                            color: SwipeDelegate.pressed ?  "#585858" : "#848484"
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
                                console.log("Delete user : " + index)
                                userListModel.remove(index)
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

                    onClicked: {
                        console.log("The user : " + index)
                    }
                }


            }

            ListModel {
                id: userListModel
                ListElement { password: "500001974"; name: "Orlando Flores Teomitzi"; typeUser: "LabUser" }
                ListElement { password: "7149"; name: "Vicente Martínez Villegas"; typeUser: "LabUser" }
                ListElement { password: "500000000"; name: "Usuario"; typeUser: "PlantUser" }
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
        x: root.width - (width + width/2)
        y: root.height - (height + height/2)
        onClicked: {
            stackView.push("qrc:/pages/NewUserPage.qml")
            console.log(stackView.depth)
        }

    }

}

