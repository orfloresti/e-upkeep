import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

ScrollablePage {
    ColumnLayout{
        id: column
        width: parent.width

        SwitchDelegate{
            id: screenOption
            text: qsTr("Full screen")
            Layout.fillWidth: true
            onClicked: fullScreen(screenOption.checked)
            function fullScreen(screenState){
                if(screenState === true){ showFullScreen()}
                else{showNormal()}
            }

        }
    }
}
