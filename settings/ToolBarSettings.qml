import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

import "qrc:/functions/MainFunction.js" as Main

ToolBar{    
    RowLayout{
        spacing: 20
        anchors.fill: parent
        ToolButton {
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: stackView.depth == 1 ?  "qrc:/icons/drawer.png" : "qrc:/icons/back.png"
            }            
            onClicked: Main.iconReturn(moduleIdex)
        }
        Label {
            id: titleLabel
            text: moduleName
            font.pixelSize: 20
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            Layout.fillWidth: true
        }
        ToolButton {
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: "qrc:/icons/menu.png"
            }
            onClicked: optionsMenu.open()

        }
    }

    Menu {
        id: optionsMenu
        x: parent.width - width
        transformOrigin: Menu.TopRight
        MenuItem {
            text: "About"
            onTriggered: aboutDialog.open()
        }
        MenuItem{
            text:"Settings"
            onTriggered: settingsDialog.open()
        }
        MenuItem {
            text: "Close"
            onTriggered: close()
        }
    }
}



