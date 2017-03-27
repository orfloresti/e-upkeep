import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs"
import "qrc:/settings"

import "qrc:/modules/brand"
import "qrc:/modules/brand/Function.js" as Def

/*
Page{
    //Page settings
    id: rootPage
    contentHeight: page.height

    //Create one SettingsPage model to create new or update
    BrandSettingsPage{
        visible: false
        id: settings
    }

    //Create the dialog
    DialogMessage{
        id: dialog
        standardButtons: Dialog.Close
    }

    //List comp
    ListModel{id:listModel}

    Component.onCompleted: {
        Brand.loadList()
    }
*/
    //Main page
    Page{
        id: page
        //width: rootPage.width
        //height: rootPage.height * 1.01

        //Create the dialog
        DialogMessage{
            id: dialog
            standardButtons: Dialog.Close
        }

        //List comp
        ListModel{id:listModel}

        ColumnLayout{
            id: column
            width: parent.width

            Component{
                id: componentDelegate

                SwipeDelegate{
                    id: swipeDelegate
                    width: parent.width
                    height: componentDescription.height + 20
                    anchors.horizontalCenter: parent.horizontalCenter

                    swipe.left: Component {
                        Rectangle {
                            id: componentDelete
                            color: "#848484" //SwipeDelegate.pressed ?  "#585858" : "#848484"
                            width: parent.width -80
                            height: parent.height
                            clip: true
                            Label {
                                //font.pixelSize: swipeDelegate.font.pixelSize
                                text: "Click to remove"
                                color: "white"
                                anchors.centerIn: parent
                            }
                            SwipeDelegate.onClicked: Comp.updateOrDetele(swipe.position,index)                        }
                    }
                    contentItem: RowLayout{
                        Item{
                            width: componentImage.width
                            height: componentImage.height
                            Image {
                                width: 50
                                height: 50
                                id: componentImage
                                anchors.centerIn: parent
                                source: "qrc:/images/yast.png"
                            }
                        }
                        ColumnLayout{
                            id: componentDescription
                            Layout.leftMargin: 10
                            Label{
                                text: password
                                wrapMode: Label.Wrap
                                font.pixelSize: 16
                                font.bold: true
                                Layout.fillWidth: true

                            }
                            Label{
                                text: "<b>" + description + "</b>" +
                                      ", Stock: " + stock +
                                      ", Min: " + min
                                wrapMode: Label.Wrap
                                font.pixelSize: 12
                                Layout.fillWidth: true
                                color: "grey"

                            }
                            Label{
                                text: "<b> $" + cost + "</b>"
                                wrapMode: Label.Wrap
                                font.pixelSize: 14
                                Layout.fillWidth: true
                                color: "grey"

                            }
                            Rectangle {
                                height: 1
                                color: "#E6E6E6"
                                Layout.fillWidth: true
                            }
                        }
                    }
                    //onClicked: Comp.updateOrDetele(swipe.position,index)
                }
            }
            ListView {
                id: userList
                Layout.fillWidth: true
                height: page.height
                focus: true
                model: listModel
                delegate: componentDelegate
                ScrollIndicator.vertical: ScrollIndicator { }
            }
        }

        AddButton{
            id: addUserButton
            x: page.width - (width + width/2)
            y: page.height - (height + height/2)
            NumberAnimation on y { from: page.height; to: page.height - (75); duration: 500 }

            onClicked: {
                componentSettings.newComponent()
                stackView.push(componentSettings)
            }
        }
    }

//}
