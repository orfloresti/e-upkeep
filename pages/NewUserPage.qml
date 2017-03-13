import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1


Flickable {
    property int space: 10

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

        Label {
            text: "Password"
            Layout.fillWidth: true
            Layout.leftMargin: space
            Layout.rightMargin: space
        }
        TextField {
            id: passwordFiel
            selectByMouse: true
            placeholderText: "Password"
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
            placeholderText: "Name"
            Layout.fillWidth: true
            Layout.leftMargin: space
            Layout.rightMargin: space

        }
        Button{

        }

    }

}


