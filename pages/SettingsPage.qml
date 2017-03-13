import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Page {
    property bool fullScreenState: false

    Flickable {
        width: parent.width
        height: parent.height
        contentWidth: parent.width
        contentHeight: column.height

        ColumnLayout{
            id: column
            width: parent.width

            SwitchDelegate{
                position : fullScreenState
                id: screenOption
                text: qsTr("Full screen")
                Layout.fillWidth: true
                onClicked: fullScreen(screenOption.checked)
                function fullScreen(screenState){
                    if(screenState === true) {
                        showFullScreen()
                        fullScreenState = true
                    }
                    else{
                        showNormal()
                    }
                }
            }
        }

    }
}
