import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0

Page {
    property int space: 10

    SwipeView {
        id: swipeView

        anchors.fill: parent
        currentIndex: tabBar.currentIndex

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
                        Text{
                            color: "white"
                            text: "Save"
                            anchors.centerIn: parent
                        }
                        Layout.fillWidth: true
                        Layout.leftMargin: space
                        Layout.rightMargin: space

                    }

                }

            }


        Page {

            Component{
                id: userDelegate

                Frame{
                    width: parent.width
                    //height: userData.height
                    Column{
                        id: userData
                        Label{text: password}
                        Label{text: name}
                        Label{text: typeUser}
                    }
                }
            }

            ListView {
                anchors.fill: parent
                model: ListModel {
                    ListElement { password: "500001974"; name: "Orlando Flores Teomitzi"; typeUser: "LabUser" }
                    ListElement { password: "7149"; name: "Vicente Martínez Villegas"; typeUser: "LabUser" }

                }
                delegate: userDelegate
            }

        }



    }
    header: TabBar{
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

