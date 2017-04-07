import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Drawer {    
    width: Math.min(window.width, window.height) / 3 * 2
    height: window.height
    dragMargin: stackView.depth > 1 ? 0 : undefined    

    ListView {
        id: listView
        focus: true
        currentIndex: -1
        anchors.fill: parent
        delegate: moduleDelegate
        model: moduleListModel
        ScrollIndicator.vertical: ScrollIndicator { }
    }

    Component{
        id: moduleDelegate
        ItemDelegate {
            width: parent.width
            text: title
            onClicked: {
                moduleName = title
                moduleIdex = index
                //console.log(moduleIdex+ ": " + moduleListModel.get(index).title)
                stackView.push(model.source)
                drawer.close()
            }
        }
    }
}
