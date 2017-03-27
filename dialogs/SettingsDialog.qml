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
        /*SwitchDelegate{
            id: minOption
            //checked: false
            text: qsTr("Minimized")
            Layout.fillWidth: true
            onClicked: fullScreen(minOption.checked)
            function fullScreen(screenState){
                if(screenState === true) {
                    showMinimized()
                }
                else{
                    //showNormal()
                }
            }
        }*/
    }

}
