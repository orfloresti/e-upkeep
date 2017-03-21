import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import "qrc:/dialogs"

ApplicationWindow {
    //Space used in the pages
    property int space: 20

    property string titleDialog
    property string textDialog

    property string appName: "Feedback"
    property string pageLabel
    property int pageIndex: -1
    property var db

    signal setPageLabel(string Pagelabel)
    signal setPageIndex(int Pageindex)

    onSetPageLabel: {
        pageLabel = Pagelabel
    }

    onSetPageIndex: {
        pageIndex = Pageindex
    }

    ListModel {
        id: userListModel
    }

    //Load the data base
    DataBase{

    }

    //Pages StackView
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: Page{
        }
    }

    //Dialogs
    SettingsDialog{
        id: settingsDialog
    }

    AboutDialog{
        id: aboutDialog
    }

    id: window
    visible: true
    width: 800
    height: 600

    title: appName

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

                onClicked: function iconReturn(){
                    if (stackView.depth > 1) {
                        stackView.pop()                        
                        pageLabel = pageListModel.get(pageIndex).title
                        if(pageLabel == "User"){
                            userListModel.clear()
                            loadUserList("User")
                        }
                        if(stackView.depth == 1){
                            pageLabel = appName
                        }

                    } else {                        
                        drawer.open()
                    }
                }

            }

            Label {
                id: titleLabel
                text: pageIndex > -1 ? pageLabel : appName
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
                    window.setPageIndex(index)
                    pageLabel = pageListModel.get(pageIndex).title

                    if(pageLabel == "User"){
                        userListModel.clear()
                        loadUserList("User")
                    }

                    stackView.push(model.source)                    
                    drawer.close()
                }
            }

            model: pageListModel

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    ListModel {
        id: pageListModel
        ListElement { title: "Report"; source: "qrc:/pages/ReportPage.qml" }
        ListElement { title: "User"; source: "qrc:/pages/UserPage.qml" }
        ListElement { title: "Component"; source:"" }
        ListElement { title: "Device"; source:"" }
        ListElement { title: "Map"; source:"" }
        ListElement { title: "Type"; source: "qrc:/pages/TypePage.qml"}
    }


    function loadUserList(varType){
        try{
            db.transaction(
                        function(tx) {
                            var qry = "SELECT * FROM " + varType
                            var results = tx.executeSql(qry)
                            for(var i = 0; i < results.rows.length; i++){
                                userListModel.append({"password":results.rows.item(i).password,
                                                      "name":results.rows.item(i).name,
                                                      "userType":results.rows.item(i).userTypeDescription})

                            }
                        })
        }catch(err){
            console.log(err)
        }
    }

}

