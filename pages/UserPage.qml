import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Page {

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page {
            ColumnLayout{
                width: parent.width
                UserList{
                    model: ListModel {
                        ListElement { password: "500001974"; name: "Orlando Flores Teomitzi"; typeUser: "LabUser" }
                        ListElement { password: "7149"; name: "Vicente Martínez Villegas"; typeUser: "LabUser" }
                        ListElement { password: "500000000"; name: "Usuario"; typeUser: "PlantUser" }
                    }
                }
            }

        }

        Page {
            NewUserPage{

            }

        }


    }
    footer: TabBar{
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

