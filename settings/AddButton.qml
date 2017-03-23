import QtQuick 2.5
import QtQuick.Controls 2.1

MouseArea{

    width: colorButton.width
    height: colorButton.height

    hoverEnabled: true
    onEntered: { colorButton.color="#e69500"}
    onExited: {colorButton.color="#ffa500"}
    onPressed: {colorButton.color="#cc8400"}

    Rectangle{
        id: colorButton
        implicitWidth: 50
        implicitHeight: width        
        radius: width * 0.5
        color: "#ffa500"
        Label{
            anchors.centerIn: parent
            text: "+"
            color: "white"
        }
    }
}
