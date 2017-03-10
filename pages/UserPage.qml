import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Page {
    property int space: 10

    SwipeView {
        id: swipeView

        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page {

            ListView {
                width: swipeView.width
                height: swipeView.height

                model: ListModel {
                    ListElement { password: "500001974"; name: "Orlando Flores Teomitzi"; typeUser: "LabUser" }
                    ListElement { password: "7149"; name: "Vicente Martínez Villegas"; typeUser: "LabUser" }

                }
                delegate: ItemDelegate {
                    id: userDelegate
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: textheight.height + 30

                    RowLayout{
                        anchors.fill: userDelegate

                        Item{
                            Layout.fillHeight:  true
                            Layout.leftMargin: (userImagen.width / 2 ) + 7
                            Layout.rightMargin: (userImagen.width / 2 ) + 4

                            Image {
                                width: 50
                                height: 50
                                id: userImagen
                                anchors.centerIn: parent
                                source: "qrc:/images/avatar-default.png"
                            }
                        }

                        ColumnLayout{
                            id: textheight

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
                        console.log("Click")
                    }
                }
            }

        }
        ScrollablePage {

                ColumnLayout{

                    Item{
                        id: userItem
                        implicitHeight: userImage.height
                        Layout.fillWidth: true
                        Layout.leftMargin: space
                        Layout.rightMargin: space

                        Image {
                            width: 150
                            height: 150
                            id: userImage
                            anchors.centerIn: parent
                            source: "qrc:/images/avatar-default.png"

                        }
                    }

                    Label {
                        text: "Password"
                        Layout.fillWidth: true
                        Layout.leftMargin: space
                        Layout.rightMargin: space
                    }
                    TextField {
                        id: passwordFiel
                        selectByMouse: true
                        text: ""
                        Layout.fillWidth: true
                        Layout.leftMargin: space
                        Layout.rightMargin: space

                    }

                    Label {
                        text: "Name"
                        Layout.fillWidth: true
                        Layout.leftMargin: space
                        Layout.rightMargin: space
                    }
                    TextField {
                        id: name
                        selectByMouse: true
                        text: ""
                        Layout.fillWidth: true
                        Layout.leftMargin: space
                        Layout.rightMargin: space

                    }

                    Button{
                        Label{
                            //color: "white"
                            text: "Save"
                            anchors.centerIn: parent
                        }
                        Layout.fillWidth: true
                        Layout.leftMargin: space
                        Layout.rightMargin: space

                    }

                }

            }

    }
    footer:  TabBar{
        id: tabBar
        currentIndex: swipeView.currentIndex


        TabButton {
            Label{
                text: qsTr("List")
                anchors.centerIn: parent
            }
        }

        TabButton {
            Label{
                text: qsTr("New")
                anchors.centerIn: parent
            }

        }

    }
}

