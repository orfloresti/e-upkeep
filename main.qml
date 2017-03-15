import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtQuick.LocalStorage 2.0

ApplicationWindow {

    property string titleLabelText

    id: window
    visible: true
    width: 800
    height: 600

    title: qsTr("Feedback")

    Item {
        Component.onCompleted: {
            var db = LocalStorage.openDatabaseSync("Feedback", "3.0", "Feedback database", 10000);
        }
    }

    header: ToolBar{

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

                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop()
                        console.log(stackView.depth)
                    } else {                        
                        drawer.open()
                        console.log(stackView.depth)
                    }
                }

            }

            Label {
                id: titleLabel
                text: titleLabelText //listView.currentItem ? listView.currentItem.text : "Feedback"
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

        }
    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
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
                    console.log(stackView.depth)
                }
            }

            model: ListModel {
                ListElement { title: "Report"; source: "qrc:/pages/ReportPage.qml" }
                ListElement { title: "User"; source: "qrc:/pages/UserListPage.qml" }
                ListElement { title: "Type"; source: "qrc:/pages/TypePage.qml"}
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: Page{
            Component.onCompleted:  {
                window.titleLabelText = "Feedback"
            }

        }
    }


    Dialog {
        id: aboutDialog
        focus: true
        modal: true
        width: parent.width/1.5
        height: parent.height/1.5
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: "About"

        Column{
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

    Dialog {
        id: settingsDialog
        focus: true
        modal: true
        width: parent.width/1.5
        height: parent.height/1.5
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: "Settings"
        ColumnLayout{
            id: column
            width: parent.width
            SwitchDelegate{                
                id: screenOption
                text: qsTr("Full screen")
                Layout.fillWidth: true
                onClicked: fullScreen(screenOption.checked)
                function fullScreen(screenState){
                    if(screenState === true) {
                        showFullScreen()
                    }
                    else{
                        showNormal()
                    }
                }
            }
        }

    }
}

