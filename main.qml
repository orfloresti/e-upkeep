import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtWebView 1.1

import "qrc:/settings"
import "qrc:/dialogs"

ApplicationWindow {
    //Space used in the pages
    property int space: 20

    //property to design the url of the server
    property string serverIp: "192.168.56.102"

    //Module name and module index
    property string appName: "Feedback"
    property string moduleName: appName
    property int moduleIdex

    //The variable for the data base
    property var db

    //ApplicationWindow settings
    id: window
    visible: true
    width: 400
    height: 600
    title: appName + "  [" + moduleName + "]"

    //ListModels used
    ListModel {
        id: moduleListModel
        ListElement { title: "Report"; source: "qrc:/modules/report/main.qml" }
        ListElement { title: "Component"; source:"qrc:/modules/component/main.qml" }
        ListElement { title: "Device"; source:"qrc:/modules/device/main.qml" }        
        ListElement { title: "Category"; source:"qrc:/modules/category/main.qml" }
        ListElement { title: "Brand"; source:"qrc:/modules/brand/main.qml" }
        ListElement { title: "User"; source: "qrc:/modules/user/main.qml" }
        ListElement { title: "Map"; source:"qrc:/modules/map/main.qml" }
        ListElement { title: "Type"; source: "qrc:/modules/type/main.qml"}
        ListElement { title: "Wiki"; source: "qrc:/modules/wiki/main.qml"}
    }

    //Pages StackView
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem:Page{

        }

        
    }

    //Load the data base
    DataBase{}        

    //Create the ToolBar
    header: ToolBarSettings{}

    //Create the Drawer for the ToolBar
    DrawerSettings{id: drawer}

    //Dialogs in the menu
    SettingsDialog{id: settingsDialog}
    AboutDialog{id: aboutDialog}

}

