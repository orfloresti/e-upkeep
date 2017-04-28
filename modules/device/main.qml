import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs"
import "qrc:/settings"

import "qrc:/modules/device"
import "qrc:/modules/device/Function.js" as Def

//Main page
Page{
    id: page

    //Create the dialog
    DialogMessage{
        id: dialog
        standardButtons: Dialog.Close
    }

    //Load list and order showed

    Component.onCompleted: {
        Def.loadList()
        Def.loadMapList()
        Def.loadDescriptionList()
        Def.loadBrandList()
    }

    ListModel{id:categoryListModel}
    ListModel{id:brandListModel}
    ListModel{id:mapListModel}
    ListModel{id:buildingListModel}
    ListModel{id:zoneListModel}
    ListModel{id:listModel}

    //Create editor to new or update one
    Editor{
        id: editor
        visible: false
    }

    //Principal content
    ColumnLayout{
        id: column
        width: parent.width

        Component{
            id: delegate

            SwipeDelegate{
                id: swipeDelegate
                width: parent.width
                height: columnDescription.height + space
                anchors.horizontalCenter: parent.horizontalCenter

                swipe.left: Component {
                    Rectangle {
                        color: "#848484" //SwipeDelegate.pressed ?  "#585858" : "#848484"
                        width: parent.width - (image.height + 30)
                        height: parent.height
                        clip: true
                        Label {
                            text: "Click to remove"
                            color: "white"
                            anchors.centerIn: parent
                        }
                        SwipeDelegate.onClicked: Def.modeEditor(swipe.position,index)
                    }
                }
                contentItem: RowLayout{
                    Item{
                        width: image.width
                        height: image.height
                        Image {
                            width: 50
                            height: 50
                            id: image
                            anchors.centerIn: parent
                            source: "qrc:/images/media-flash.png"
                        }
                    }
                    ColumnLayout{
                        id: columnDescription
                        Layout.leftMargin: 10
                        Label{
                            text: password
                            wrapMode: Label.Wrap
                            font.pixelSize: 16
                            font.bold: true
                            Layout.fillWidth: true

                        }
                        Label{
                            text: description
                            wrapMode: Label.Wrap
                            font.pixelSize: 12
                            Layout.fillWidth: true
                            color: "grey"

                        }
                        Rectangle {
                            height: 1
                            color: "#E6E6E6"
                            Layout.fillWidth: true
                        }
                    }
                    ToolButton{
                        id:deviceToolButton
                        contentItem: Image {
                            fillMode: Image.Pad
                            horizontalAlignment: Image.AlignHCenter
                            verticalAlignment: Image.AlignVCenter
                            source: "qrc:/icons/menu.png"
                        }
                        onClicked: optionsMenu.open()

                        Menu {
                            id: optionsMenu
                            //transformOrigin: deviceToolButton
                            MenuItem {
                                text: "History"
                                //onTriggered: aboutDialog.open()
                            }

                        }
                    }
                }
                onClicked: Def.modeEditor(swipe.position,index)
            }
        }
        ListView {
            id: userList
            Layout.fillWidth: true
            height: page.height
            focus: true
            model: listModel
            delegate: delegate
            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }



    AddButton{
        id: addUserButton
        x: page.width - (width + width/2)
        y: page.height - (height + height/2)
        NumberAnimation on y { from: page.height; to: page.height - (75); duration: 500 }

        onClicked: {
            editor.newItem()
            stackView.push(editor)
        }
    }
}

