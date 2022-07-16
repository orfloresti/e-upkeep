import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Dialog {

    signal setSettings(string varTitle, string varText)

    onSetSettings: {
        dialog.title = varTitle
        dialogText.text = varText
    }

    id: dialog

    focus: true
    modal: true
    width: parent.width/1.5
    height: parent.height/1.5
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    //title:

    Column{
        spacing: 20
        Text {
            id: dialogText
            width: dialog.availableWidth
            //text: textDialog
            wrapMode: Label.Wrap
            font.pixelSize: 12
        }
    }

}
