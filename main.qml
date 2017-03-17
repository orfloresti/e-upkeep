import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtQuick.LocalStorage 2.0

ApplicationWindow {

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
                        if(stackView.depth == 1){pageLabel = appName}

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
                    //console.log(pageIndex)
                    pageLabel = pageListModel.get(pageIndex).title
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
        ListElement { title: "User"; source: "qrc:/pages/UserListPage.qml" }
        ListElement { title: "Component"; source:"" }
        ListElement { title: "Device"; source:"" }
        ListElement { title: "Map"; source:"" }
        ListElement { title: "Type"; source: "qrc:/pages/TypePage.qml"}
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: Page{

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

    Component.onCompleted: {
        db = LocalStorage.openDatabaseSync("Feedback", "1.0", "Feedback database", 10000);

        db.transaction(
                    function(tx) {
                        tx.executeSql("CREATE TABLE IF NOT EXISTS Component(
                                    password TEXT NOT NULL PRIMARY KEY ,
                                    description TEXT NOT NULL,
                                    cost NUMERIC NOT NULL,
                                    stock INTEGER NOT NULL,
                                    min INTEGER NOT NULL
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Brand(
                                    name TEXT NOT NULL PRIMARY KEY
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Building(
                                    name TEXT NOT NULL PRIMARY KEY
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Zone(
                                    name TEXT NOT NULL PRIMARY KEY
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS UserType(
                                    description TEXT NOT NULL PRIMARY KEY
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS ReportType(
                                    description TEXT NOT NULL PRIMARY KEY
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS DeviceType(
                                    description TEXT NOT NULL PRIMARY KEY
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Device(
                                    password TEXT NOT NULL PRIMARY KEY,
                                    description TEXT NOT NULL,
                                    stock INTEGER NOT NULL,
                                    brandName TEXT,
                                    deviceTypeDescription TEXT,
                                    buildingZoneBuildingName TEXT,
                                    buildingZoneZoneName TEXT,
                                    FOREIGN KEY(brandName) REFERENCES Brand(name),
                                    FOREIGN KEY(deviceTypeDescription) REFERENCES DeviceType(description)
                                    FOREIGN KEY(buildingZoneBuildingName) REFERENCES BuildingZone(buildingName)
                                    FOREIGN KEY(buildingZoneZoneName) REFERENCES BuildingZone(zoneName)
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS User(
                                    password INTEGER NOT NULL PRIMARY KEY,
                                    name TEXT NOT NULL,
                                    userTypeDescription TEXT,
                                    FOREIGN KEY(userTypeDescription) REFERENCES UserType(description)
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS BuildingZone(
                                    buildingName TEXT,
                                    zoneName TEXT,
                                    PRIMARY KEY(buildingName, zoneName)
                                    FOREIGN KEY(buildingName) REFERENCES Building(name),
                                    FOREIGN KEY(zoneName) REFERENCES Zone(name)

                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Arrive(
                                    year INTEGER NOT NULL,
                                    month INTEGER NOT NULL,
                                    day INTEGER NOT NULL,
                                    numberControl INTEGER NOT NULL,
                                    labUser TEXT,
                                    plantUser TEXT,
                                    PRIMARY KEY(year, month, day, numberControl),
                                    FOREIGN KEY(labUser, plantUser) REFERENCES User(password, password)
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Out(
                                    year INTEGER NOT NULL,
                                    month INTEGER NOT NULL,
                                    day INTEGER NOT NULL,
                                    numberControl INTEGER NOT NULL,
                                    labUser TEXT,
                                    plantUser TEXT,
                                    PRIMARY KEY(year, month, day, numberControl),
                                    FOREIGN KEY(labUser, plantUser) REFERENCES User(password, password)
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Report(
                                    password TEXT PRIMARY KEY NOT NULL,
                                    observation TEXT NOT NULL,
                                    process TEXT NOT NULL,
                                    reportTypeDescription TEXT,
                                    arriveDate TEXT,
                                    outDate TEXT,
                                    devicePassword TEXT,
                                    FOREIGN KEY(reportTypeDescription) REFERENCES ReportType(description),
                                    FOREIGN KEY(arriveDate) REFERENCES Arrive(dateArrive),
                                    FOREIGN KEY(outDate) REFERENCES Out(dataOut),
                                    FOREIGN KEY(devicePassword) REFERENCES Device(password)
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS DoBy(
                                    reportPassword TEXT,
                                    userPassword TEXT,
                                    PRIMARY KEY(reportPassword, userPassword),
                                    FOREIGN KEY(reportPassword) REFERENCES Report(password),
                                    FOREIGN KEY(userPassword) REFERENCES User(password)
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS UsedComponent(
                                    reportPassword TEXT,
                                    componentPassword TEXT,
                                    quantity INTEGER NOT NULL,
                                    PRIMARY KEY(reportPassword, componentPassword),
                                    FOREIGN KEY(reportPassword) REFERENCES Report(password),
                                    FOREIGN KEY(componentPassword) REFERENCES Component(password)
                                  );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS UsedDevice(
                                    reportPassword TEXT,
                                    devicePassword TEXT,
                                    quantity INTEGER NOT NULL,
                                    PRIMARY KEY(reportPassword, devicePassword),
                                    FOREIGN KEY(reportPassword) REFERENCES Report(password),
                                    FOREIGN KEY(devicePassword) REFERENCES Device(password)
                                  );")
                    }
                    )

    }
}

