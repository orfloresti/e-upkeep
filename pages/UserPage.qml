import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Page {
    property int space: 20
    property int passwordUser
    property string nameUser
    property string typeUser


    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page {

            Flickable {
                width: parent.width
                height: parent.height
                contentWidth: parent.width
                contentHeight: column.height

                ColumnLayout{
                    id: column
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

                    }

                }

            }

        }

        Page {
            ColumnLayout{
                width: parent.width
                Component{
                    id: userDelegate

                    ItemDelegate {

                        width: parent.width
                        height: userImage.height + 15
                        anchors.horizontalCenter: parent.horizontalCenter

                        RowLayout{
                            anchors.fill: parent

                            Item{
                                width: userImage.width
                                height: userImage.height
                                Layout.leftMargin: 10

                                Image {
                                    width: 50
                                    height: 50
                                    id: userImage
                                    anchors.centerIn: parent
                                    source: "qrc:/images/avatar-default.png"
                                }
                            }

                            ColumnLayout{

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
                            }
                        }
                        onClicked: {
                            console.log(swipeView.currentIndex)
                        }
                   }

                }

                ListModel {
                    id: userList
                    ListElement { password: "500001974"; name: "Orlando Flores Teomitzi"; typeUser: "LabUser" }
                    ListElement { password: "7149"; name: "Vicente Martínez Villegas"; typeUser: "LabUser" }
                    ListElement { password: "500000000"; name: "Usuario"; typeUser: "PlantUser" }
                }

                ListView {
                    Layout.fillWidth: true
                    //Layout.fillHeight: true
                    //width: swipeView.width
                    height: swipeView.height
                    focus: true
                    model: userList
                    delegate: userDelegate
                }
            }

        }



    }
    footer: TabBar{
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            Label{
                text: qsTr("New")
                anchors.centerIn: parent
            }

        }

        TabButton {
            Label{
                text: qsTr("List")
                anchors.centerIn: parent
            }
        }

    }

}

