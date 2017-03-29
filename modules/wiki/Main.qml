import QtQuick 2.7
import QtQuick.Controls 2.1
import QtWebView 1.1

Page{
    BusyIndicator{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        running: wiki.loading == true
    }

    WebView{
        id: wiki
        anchors.fill: parent
        url: "http://192.168.56.102/mediawiki/Main_Page"
        //url:"http://www.google.com"
    }
}
