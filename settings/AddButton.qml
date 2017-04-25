import QtQuick 2.5
import QtQuick.Controls 2.1

MouseArea{

    width: colorButton.width
    height: colorButton.height

    hoverEnabled: true
    onEntered: { colorButton.color="#e1e1e1"}
    onExited: {colorButton.color="#fafafa"}
    onPressed: {colorButton.color="#d4d4d4"}

    Image {
        id: shallowImage
        source: "qrc:/icons/shallow.png"
        sourceSize.width: 65
        anchors.centerIn: parent
    }

    Rectangle{
        id: colorButton
        implicitWidth: 50
        implicitHeight: width
        radius: width * 0.5
        //color: "#ffa500"
        color:"#fafafa"
        //z: 100
        Label{
            anchors.centerIn: parent
            text: "+"
            color: "black"
        }
    }
}
