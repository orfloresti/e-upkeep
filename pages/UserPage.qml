import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Page {

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page {

            AddButton{
                x: swipeView.width - (width + width/4)
                y: swipeView.height - (height + height/4)
                z: 100
                onClicked: {
                    console.log("New lab user")
                }
            }

            ColumnLayout{
                width: parent.width
                UserList{
                    model: ListModel {
                        ListElement { password: "500001974"; name: "Orlando Flores Teomitzi"; typeUser: "LabUser" }
                        ListElement { password: "7149"; name: "Vicente Martínez Villegas"; typeUser: "LabUser" }
                    }
                }
            }
        }

        Page {
            AddButton{
                x: swipeView.width - (width + width/4)
                y: swipeView.height - (height + height/4)
                z: 100
                onClicked: {
                    console.log("New plant user")
                }
            }

            ColumnLayout{
                width: parent.width
                UserList{
                    model: ListModel {
                        ListElement { password: "500000000"; name: "Usuario"; typeUser: "PlantUser" }
                    }
                }
            }

        }

    }
    footer: TabBar{
        id: tabBar
        currentIndex: swipeView.currentIndex


        TabButton {
            Label{
                text: qsTr("Laboratory")
                anchors.centerIn: parent
            }
        }

        TabButton {
            Label{
                text: qsTr("Plant")
                anchors.centerIn: parent
            }

        }

    }

}

