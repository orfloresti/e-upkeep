import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0

import "qrc:/dialogs"
import "qrc:/settings"

ApplicationWindow {
    //Space used in the pages
    property int space: 20

    property string appName: "Feedback"
    property string moduleName: appName
    property int moduleIdex

    //The variable for the data base
    property var db

    //Define the module name
    signal setModuleName(string module)

    onSetModuleName: {
    }

    //ApplicationWindow settings
    id: window
    visible: true
    width: 400
    height: 600
    title: appName + "  [" + moduleName + "]"

    //ListModels used
    ListModel{id:typeListModel}
    ListModel{id:userListModel}

    ListModel {
        id: moduleListModel
        ListElement { title: "Report"; source: "qrc:/pages/ReportPage.qml" }
        ListElement { title: "User"; source: "qrc:/pages/UserPage.qml" }
        ListElement { title: "Component"; source:"" }
        ListElement { title: "Device"; source:"" }
        ListElement { title: "Map"; source:"" }
        ListElement { title: "Type"; source: "qrc:/pages/TypePage.qml"}
    }

    //Load the data base
    DataBase{}

    //Pages StackView
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: Page{
        }
    }

    //Dialogs in the menu
    SettingsDialog{id: settingsDialog}
    AboutDialog{id: aboutDialog}

    //Create the ToolBar
    header: ToolBarSettings{}

    //Create the Drawer for the ToolBar
    DrawerSettings{id: drawer}

}

