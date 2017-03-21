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
    DialogPage{
        id: dialogType
    }

    //ListModel used
    ListModel{
        id: listTypeModel
    }

    ListModel{
        id: definedTypes
        ListElement {table: "UserType"}
        ListElement {table: "DeviceType"}
        ListElement {table: "ReportType"}
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

                onCurrentTextChanged: {
                    TypeFunction.loadList(typeSelect.currentText)
                }
                model: definedTypes
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
                    onClicked: {
                        if(typeField.text.length < 1){
                            dialogType.setTitleDialog("Error")
                            dialogType.setTextDialog("The TextField is blank")
                            dialogType.open()
                        }else{
                            TypeFunction.saveType(typeSelect.currentText, typeField.text)
                        }
                    }
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
                    onClicked:{
                        TypeFunction.deleteType(typeSelect.currentText, typeUserComboBox.currentText, typeUserComboBox.currentIndex)

                    }
                }
            }
        }
    }


}
