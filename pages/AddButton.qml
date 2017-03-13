import QtQuick 2.5
import QtQuick.Controls 2.1

MouseArea{
    id: addButton
    hoverEnabled: true
    width: colorButton.width
    height: colorButton.height

    onEntered: { colorButton.color="#006767"}
    onExited: {colorButton.color="Teal"}
    onPressed: {colorButton.color="#003434"}

    Rectangle{
        id: colorButton
        implicitWidth: 50
        implicitHeight: width
        radius: width * 0.5
        color: "Teal"
        Label{
            anchors.centerIn: parent
            text: "+"
            color: "white"
        }
    }
}
