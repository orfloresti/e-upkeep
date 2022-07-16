import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Dialog {

    focus: true
    modal: true
    width: parent.width/1.1
    height: parent.height/1.1
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    title: "About"

    standardButtons: Dialog.Close

    Column{
        id: aboutColumn
        spacing: 20


        Image {
            source: "qrc:/icons/logo.png"
        }

        Label {
            width: aboutDialog.availableWidth
            text: "eUpkeep is a CMMS (Computerized Maintenance Management System)"
            wrapMode: Label.Wrap
            font.pixelSize: 12
        }
        Label{
            width: aboutDialog.availableWidth
            text: "Icons: Paper by Sam Hewitt" // is licensed under CC-SA-4.0
            wrapMode: Label.Wrap
            font.pixelSize: 12
        }
        Label{
            width: aboutDialog.availableWidth
            text: "Developer: Orlando Flores Teomitzi"
            wrapMode: Label.Wrap
            font.pixelSize: 12
        }

    }

}
