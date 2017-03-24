import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs"
import "qrc:/modules/type/TypeFunction.js" as Type

Page {
    id: page

    //Show a message of the process
    DialogMessage{
        id: dialogType
        standardButtons: Dialog.Close
    }

    //ListModel used only in this page
    ListModel{
        id: definedTypes
        ListElement {table: "UserType"}
        ListElement {table: "DeviceType"}
        ListElement {table: "ReportType"}
    }

    ListModel{id:typeListModel}

    //Clear the type list on the beginning
    Component.onCompleted: {
        typeListModel.clear()
    }

    //Main page
    Flickable{
        anchors.fill: parent
        contentHeight: column.height
        //boundsBehavior: Flickable.StopAtBounds
        ScrollIndicator.vertical: ScrollIndicator { }

        ColumnLayout{
            id: column
            width: parent.width
            Label {
                width: column.width - space
                text: "In this module you can create new types for users, reports and devices. Remenber the types used can't be delete."
                wrapMode: Label.Wrap
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.topMargin: space
            }

            Label {
                text: "Select one type"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space
                Layout.topMargin: space
            }

            ComboBox{
                id: typeSelect
                currentIndex: -1
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.rightMargin: space                
                model: definedTypes
                onCurrentTextChanged: Type.loadList(typeSelect.currentText)
            }

            Label {
                text: "Type Settings"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.topMargin: space
            }

            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                TextField {
                    id: typeField
                    selectByMouse: true
                    placeholderText: "New type"
                    Layout.fillWidth: true
                }
                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Save"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                    onClicked: Type.blankSpace()
                }
            }
            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                ComboBox{
                    id: typeUserComboBox
                    Layout.fillWidth: true
                    model: typeListModel
                }                

                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Delete"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                    onClicked: Type.deleteType(typeSelect.currentText,
                                                       typeUserComboBox.currentText,
                                                       typeUserComboBox.currentIndex)
                }
            }
        }
    }


}