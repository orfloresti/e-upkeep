import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Page {
    Page{
        id: newUser
        NewUserPage{
        }
    }

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
                    console.log("New plant user")
                    //tabBar.currentIndex = 1
                    push(newUser)
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


    }
    footer: TabBar{
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            Label{
                text: qsTr("Plant")
                anchors.centerIn: parent
            }

        }

        TabButton {
            Label{
                text: qsTr("Laboratory")
                anchors.centerIn: parent
            }
        }

    }

}

