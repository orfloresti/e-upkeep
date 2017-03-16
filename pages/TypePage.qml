import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Flickable {
    property int space: 20
    id: root
    contentHeight: page.height
    ScrollIndicator.vertical: ScrollIndicator { }

    Page{
        property int space: 20
        id: page

        width: root.width
        height: root.height * 1.01

        ColumnLayout{
            id: column
            width: parent.width

            Label {
                width: column.width - space
                text: "In this section you can create new types for users, reports and devices."
                wrapMode: Label.Wrap
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.topMargin: space
            }

            //**********************************************************
            Label {
                text: "User type"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.topMargin: space
            }
            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                TextField {
                    id: userTypeField
                    selectByMouse: true
                    placeholderText: "User type"
                    Layout.fillWidth: true
                }
                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Save"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                }
            }

            //**********************************************************
            Label {
                text: "Device type"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.topMargin: space
            }
            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                TextField {
                    id: deviceTypeField
                    selectByMouse: true
                    placeholderText: "Device type"
                    Layout.fillWidth: true
                }
                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Save"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                }
            }

            //**********************************************************
            Label {
                text: "Report type"
                Layout.fillWidth: true
                Layout.leftMargin: space
                Layout.topMargin: space
            }
            RowLayout{
                spacing: space
                Layout.fillWidth: true
                Layout.leftMargin: space
                TextField {
                    id: reportTypeField
                    selectByMouse: true
                    placeholderText: "Report type"
                    Layout.fillWidth: true
                }
                Button{
                    Label{
                        anchors.centerIn: parent
                        text: "Save"
                        color: "Black"
                    }
                    Layout.rightMargin: space
                }
            }

        }
    }

}
