import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtWebView 1.1

import "qrc:/settings"
import "qrc:/dialogs"

ApplicationWindow {
    //Space used in the pages
    property int space: 20

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
        ListElement { title: "-Report"; source: "qrc:/modules/report/ReportPage.qml" }
        ListElement { title: "Component"; source:"qrc:/modules/component/ComponentPage.qml" }
        ListElement { title: "-Device"; source:"" }
        ListElement { title: "User"; source: "qrc:/modules/user/UserPage.qml" }
        ListElement { title: "Map"; source:"qrc:/modules/map/Main.qml" }
        ListElement { title: "Brand"; source:"qrc:/modules/brand/Main.qml" }
        ListElement { title: "Type"; source: "qrc:/modules/type/TypePage.qml"}
        ListElement { title: "Wiki"; source: "qrc:/modules/wiki/Main.qml"}
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

