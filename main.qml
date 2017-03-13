import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0

ApplicationWindow {

    property int widthDialog: Math.min(root.width, root.height) / 3 * 2

    id: root
    visible: true
    //visibility: Window.FullScreen
    width: 800
    height: 600

    title: qsTr("Feedback")

    header: ToolBar{


        RowLayout{
            spacing: 20
            anchors.fill: parent

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: stackView.depth > 1 ? "qrc:/icons/back.png" : "qrc:/icons/drawer.png"
                    //source:"qrc:/icons/drawer.png"
                }

                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop()
                        listView.currentIndex = -1
                    } else {
                        drawer.open()
                    }
                }

            }

            Label {
                id: titleLabel
                text: listView.currentItem ? listView.currentItem.text : "Feedback"
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

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "About"
                        onTriggered: aboutDialog.open()
                    }
                    MenuItem {
                        text: "Close"
                        onTriggered: close()
                    }
                }
            }

        }
    }

    Drawer {
        id: drawer
        width: Math.min(root.width, root.height) / 3 * 2
        height: root.height
        dragMargin: stackView.depth > 1 ? 0 : undefined

        ListView {
            id: listView

            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    listView.currentIndex = index
                    stackView.push(model.source)
                    drawer.close()
                }
            }

            model: ListModel {
                ListElement { title: "Report"; source: "qrc:/pages/ReportPage.qml" }
                ListElement { title: "User"; source: "qrc:/pages/UserPage.qml" }
                ListElement { title: "Settings"; source: "qrc:/pages/SettingsPage.qml"}

            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Pane {
            id: pane

        }
    }


    Dialog {
        id: aboutDialog
        modal: true
        focus: true
        x: (root.width - width) / 2
        y: ((root.height - height) / 2)
        width: widthDialog
        title: "About"

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                width: aboutDialog.availableWidth
                text: "Feedback is a tool for the maintenance of electronics boards, inventory control, report creator and more modules to make the electronics easy and fun."
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
            Label {
                width: aboutDialog.availableWidth
                text: "Based on Qt 5.8"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
            Label{
                width: aboutDialog.availableWidth
                text: "Paper Icons: by Sam Hewitt" // is licensed under CC-SA-4.0
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }

        }

    }
}

