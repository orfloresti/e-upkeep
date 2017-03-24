import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
//import QtQuick.Controls.Material 2.1

Page {

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Item {

        }
        Item {

        }
        Item {

        }

    }
    footer: TabBar{

        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            Label{
                text: qsTr("First")
                anchors.centerIn: parent
            }

        }
        TabButton {
            Label{
                text: qsTr("Second")
                anchors.centerIn: parent
            }
        }
        TabButton {
            Label{
                text: qsTr("Third")
                anchors.centerIn: parent
            }
        }

    }
}
