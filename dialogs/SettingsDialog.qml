import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0

Dialog {

    focus: true
    modal: true
    width: parent.width/1.5
    height: parent.height/1.5
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    title: "Settings"

    standardButtons: Dialog.Close

    ColumnLayout{
        id: column
        width: parent.width

        SwitchDelegate{
            id: screenOption
            text: qsTr("Full screen")
            Layout.fillWidth: true
            onClicked: fullScreen(screenOption.checked)
            function fullScreen(screenState){
                if(screenState === true) {
                    showFullScreen()
                }
                else{
                    showNormal()
                }
            }
        }

        //Don´t work yet
        RowLayout{
            spacing: space
            Layout.fillWidth: true
            Layout.leftMargin: space
            Label {
                //width: column.width - space
                text: "Server IP"
                wrapMode: Label.Wrap
                //Layout.fillWidth: true
                //Layout.leftMargin: space
                Layout.rightMargin: space
                //Layout.topMargin: space
            }
            TextField {
                id: ipField
                selectByMouse: true
                placeholderText: "192.168.56.102"
                Layout.fillWidth: true
                onAccepted: serverIp = ipField.text
            }
        }
    }

}
