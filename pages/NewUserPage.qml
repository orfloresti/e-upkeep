import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1


Flickable {
    property int space: 20

    id: root
    contentHeight: page.height
    ScrollIndicator.vertical: ScrollIndicator { }

    Page{
        id: page
        width: root.width
        height: root.height * 1.01
        ColumnLayout{
            id: column
            width: parent.width

            Item{
                id: userItem
                implicitHeight: newUserImage.height
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space

                Image {
                    width: 150
                    height: 150
                    id: newUserImage
                    anchors.centerIn: parent
                    source: "qrc:/images/avatar-default.png"

                }
            }

            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space

                ColumnLayout{
                    Label {
                        text: "Password"
                        Layout.fillWidth: true
                    }
                    TextField {
                        id: passwordField
                        selectByMouse: true
                        placeholderText: "Password"
                        Layout.fillWidth: true

                    }
                }

                ColumnLayout{
                    Label {
                        text: "User"
                        Layout.fillWidth: true
                    }
                    ComboBox{
                        id: typeUserField
                        currentIndex: -1
                        model:["Laboratory", "Plant"]
                        Layout.fillWidth: true
                    }
                }


            }

            Label {
                text: "Name"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
            }
            TextField {
                id: nameField
                selectByMouse: true
                placeholderText: "Name"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space

            }
            Button{
                id: save
                Label{
                    anchors.centerIn: parent
                    text: "Save"
                    color: "Black"

                }
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space

                onClicked: {
                    console.log("\nPassword: " +passwordField.text + "\nUser: " + typeUserField.currentText+ "\nName: " + nameField.text)
                }

            }

        }
    }
}

