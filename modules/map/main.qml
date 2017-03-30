import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs"
import "qrc:/modules/map/Function.js" as Def

//Main page
Page{
    id: page

    //Create the dialog
    DialogMessage{
        id: dialog
        standardButtons: Dialog.Close
    }

    //Load list and order showed
    ListModel{id:mapListModel}
    ListModel{id:buildingListModel}
    ListModel{id:zoneListModel}

    Component.onCompleted: {
        Def.loadMapList()
        //Def.loadBuildingList()
        //Def.loadZoneList()
    }

    //Main page
    Flickable{
        anchors.fill: parent
        contentHeight: column.height
        ScrollIndicator.vertical: ScrollIndicator { }

        //Principal content
        ColumnLayout{
            id: column
            width: parent.width

            Label {
                width: column.width - space
                text: "In this module you can create general characteristics of your map."
                wrapMode: Label.Wrap
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.topMargin: space
            }

            Label {
                width: column.width - space
                text: "Map name"
                wrapMode: Label.Wrap
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.topMargin: space
            }
            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                TextField {
                    id: mapField
                    selectByMouse: true
                    placeholderText: "New map"
                    Layout.fillWidth: true
                }
                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Save"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                    onClicked: Def.saveMapName(mapField.text)
                }
            }

            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                ComboBox{
                    id: mapComboBox
                    Layout.fillWidth: true
                    model: mapListModel
                    onCurrentTextChanged: Def.loadBuildingList(mapComboBox.currentText)
                }

                Button{
                    enabled: false
                    Label{
                        anchors.centerIn: parent
                        text: "Delete"
                        //color: "Black"
                    }
                    Layout.rightMargin: space
                    onClicked:Def.deleteMapName(mapComboBox.currentText)
                }
            }




            Label {
                width: column.width - space
                text: "Building name"
                wrapMode: Label.Wrap
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.topMargin: space
            }
            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                TextField {
                    id: buildingField
                    selectByMouse: true
                    placeholderText: "New Building"
                    Layout.fillWidth: true
                }
                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Save"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                    onClicked: Def.saveBuildingName(buildingField.text, mapComboBox.currentText)
                }
            }

            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                ComboBox{
                    id: buildingComboBox
                    Layout.fillWidth: true
                    model: buildingListModel
                    onCurrentTextChanged: Def.loadZoneList(buildingComboBox.currentText,
                                                           mapComboBox.currentText)
                }

                Button{
                    enabled: false
                    Label{
                        anchors.centerIn: parent
                        text: "Delete"
                        //color: "Black"
                    }
                    Layout.rightMargin: space
                    onClicked: Def.deleteBuildingName(buildingField.text, mapComboBox.currentText)
                }
            }



            Label {
                width: column.width - space
                text: "Zone name"
                wrapMode: Label.Wrap
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.topMargin: space
            }
            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                TextField {
                    id: zoneField
                    selectByMouse: true
                    placeholderText: "New zone"
                    Layout.fillWidth: true
                }
                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Save"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                    onClicked: Def.saveZoneName(zoneField.text,
                                                buildingComboBox.currentText,
                                                mapComboBox.currentText)
                }
            }

            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                ComboBox{
                    id: zoneComboBox
                    Layout.fillWidth: true
                    model: zoneListModel
                }

                Button{
                    enabled: false
                    Label{
                        anchors.centerIn: parent
                        text: "Delete"
                        //color: "Black"
                    }
                    Layout.rightMargin: space
                    onClicked: Def.deleteZoneName(zoneField.text,
                                                  buildingComboBox.currentText,
                                                  mapComboBox.currentText)
                }
            }

        }
    }

}

