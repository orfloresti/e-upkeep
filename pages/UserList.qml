import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

ListView {
    Layout.fillWidth: true
    //Layout.fillHeight: true
    //width: swipeView.width
    height: swipeView.height

    delegate: ItemDelegate {
        id: userDelegate
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
    }
}



