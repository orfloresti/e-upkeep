import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import "qrc:/dialogs"
import "qrc:/functions/TypeFunction.js" as TypeFunction

Flickable {
    id: root
    contentHeight: page.height
    ScrollIndicator.vertical: ScrollIndicator { }

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

    //Clear the type list on the beginning
    Component.onCompleted: {
        listTypeModel.clear()
    }

    //Main page
    Page{
        id: page
        width: root.width
        height: root.height * 1.01        

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
                onCurrentTextChanged: TypeFunction.loadList(typeSelect.currentText)
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
                    onClicked: TypeFunction.blankSpace()
                }
            }
            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                ComboBox{
                    id: typeUserComboBox
                    Layout.fillWidth: true
                    model: listTypeModel
                }                

                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Delete"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                    onClicked: TypeFunction.deleteType(typeSelect.currentText,
                                                       typeUserComboBox.currentText,
                                                       typeUserComboBox.currentIndex)
                }
            }
        }
    }


}
