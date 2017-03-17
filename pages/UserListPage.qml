import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Page{
    property int space: 20
    property var userPassword
    property var userName
    property var userType

    property string titleDialog
    property string textDialog

    id: root
    contentHeight: page.height

    ListModel{
        id: userTypeListModel
    }

    Page{
        id: page
        width: root.width
        height: root.height * 1.01

        ColumnLayout{
            id: column
            width: parent.width

            Component{
                id: userDelegate

                SwipeDelegate{
                    id: swipeDelegate
                    width: parent.width
                    height: userDescription.height + 20
                    anchors.horizontalCenter: parent.horizontalCenter

                    swipe.left: Component {
                        Rectangle {
                            id: userDelete
                            color: "#848484" //SwipeDelegate.pressed ?  "#585858" : "#848484"
                            width: parent.width -80
                            height: parent.height
                            clip: true
                            Label {
                                //font.pixelSize: swipeDelegate.font.pixelSize
                                text: "Click to remove"
                                color: "white"
                                anchors.centerIn: parent
                            }

                            SwipeDelegate.onClicked: {
                                console.log(swipe.position)
                                userPageOption(swipe.position,index)
                            }
                        }
                    }

                    contentItem: RowLayout{                        
                        //anchors.fill: parent

                        Item{
                            width: userImage.width
                            height: userImage.height
                            //Layout.leftMargin: 10

                            Image {
                                width: 50
                                height: 50
                                id: userImage
                                anchors.centerIn: parent
                                source: "qrc:/images/avatar-default.png"
                            }
                        }

                        ColumnLayout{
                            id: userDescription
                            Layout.leftMargin: 10
                            Label{
                                text: password
                                wrapMode: Label.Wrap
                                font.pixelSize: 16
                                font.bold: true
                                Layout.fillWidth: true

                            }
                            Label{
                                text: name + ", " + userType
                                wrapMode: Label.Wrap
                                font.pixelSize: 12
                                Layout.fillWidth: true

                            }
                            Rectangle {
                                height: 1
                                color: "#E6E6E6"
                                Layout.fillWidth: true

                            }
                        }
                    }
                    onClicked: {
                        console.log(swipe.position)
                        userPageOption(swipe.position,index)
                    }
                }
            }

            ListView {
                id: userList
                Layout.fillWidth: true
                //Layout.fillHeight: true
                //width: swipeView.width
                height: page.height
                focus: true
                model: userListModel
                delegate: userDelegate
                ScrollIndicator.vertical: ScrollIndicator { }
            }
        }
    }

    AddButton{
        id: addUserButton
        x: root.width - (width + width/2)
        y: root.height - (height + height/2)
        NumberAnimation on y { from: root.height; to: root.height - (75); duration: 500 }

        onClicked: {
            flickableUserPage.newUser()
            stackView.push(flickableUserPage)
            //console.log(stackView.depth)
        }

    }



    Flickable {
        id: flickableUserPage
        visible: false
        contentHeight: userPage.height
        ScrollIndicator.vertical: ScrollIndicator { }

        signal editUser
        signal newUser

        onEditUser: {
            pageLabel = "Edit user"
            window.setPageLabel(pageLabel)
            passwordField.text = userPassword
            nameField.text = userName
            //typeUserField.text = userType
        }
        onNewUser: {
            pageLabel = "New user"
            window.setPageLabel(pageLabel)
            passwordField.text = ""
            nameField.text = ""
            //typeUserField.text = userType
        }

        Page{
            id: userPage
            width: flickableUserPage.width
            height: flickableUserPage.height * 1.01
            ColumnLayout{
                id: columnUser
                width: parent.width

                Item{
                    id: userItem
                    implicitHeight: newUserImage.height
                    Layout.fillWidth: true
                    Layout.leftMargin: space
                    Layout.rightMargin: space

                    Image {
                        width: 150
                        height: 150
                        id: newUserImage
                        anchors.centerIn: parent
                        source: "qrc:/images/avatar-default.png"

                    }
                }

                RowLayout{
                    spacing: space
                    Layout.fillWidth: true
                    Layout.leftMargin: space
                    Layout.rightMargin: space

                    ColumnLayout{
                        Label {
                            text: "Password"
                            Layout.fillWidth: true
                        }
                        TextField {
                            id: passwordField
                            selectByMouse: true
                            placeholderText: "Password"
                            Layout.fillWidth: true

                        }
                    }

                    ColumnLayout{
                        Label {
                            text: "User"
                            Layout.fillWidth: true
                        }
                        ComboBox{
                            id: userTypeComboBox
                            currentIndex: -1
                            model:userTypeListModel
                            Layout.fillWidth: true
                        }
                        Component.onCompleted: {
                            loadUserTypeList("UserType")
                        }
                    }


                }

                Label {
                    text: "Name"
                    Layout.fillWidth: true
                    Layout.leftMargin: space
                    Layout.rightMargin: space
                }
                TextField {
                    id: nameField
                    selectByMouse: true
                    placeholderText: "Name"
                    Layout.fillWidth: true
                    Layout.leftMargin: space
                    Layout.rightMargin: space

                }
                Button{
                    id: save
                    Label{
                        anchors.centerIn: parent
                        text: "Save"
                        color: "Black"

                    }
                    Layout.fillWidth: true
                    Layout.leftMargin: space
                    Layout.rightMargin: space

                    onClicked: {
                        saveUser(passwordField.text, nameField.text, userTypeComboBox.currentText)
                    }

                }

            }
        }
    }

    function saveUser(varPassword, varName, varTypeUser){
        try{
            db.transaction(
                        function(tx) {
                            //var qry = "INSERT INTO User VALUES (?, ?, ?);"
                            tx.executeSql("INSERT INTO User VALUES (?, ?, ?);", [varPassword, varName, varTypeUser])
                            dialogDb.setTitleDialog("Saved")
                            dialogDb.setTextDialog("New user with password "+ varDescription + " saved correctly")
                            listModel.append({"description":varDescription})
                            dialogDb.open()
                            typeField.text = ""
                        }
                        )
        }catch(err){
            console.log("Error :  " + err);
            dialogDb.setTitleDialog("Error")
            dialogDb.setTextDialog(err)
            dialogDb.open()
        }
    }



    function userPageOption(position,index){

        if(position === 0){
            console.log("Edit user" )
            userPassword = userListModel.get(index).password
            userName = userListModel.get(index).name
            //userTypeComboBox = userListModel.get(index).userType
            flickableUserPage.editUser()
            stackView.push(flickableUserPage)

        }else{
            //console.log("Delete user")
            deleteUser(userListModel.get(index).password)
            userListModel.remove(index)
        }
    }

    function loadUserTypeList(varType){
        try{
            db.transaction(
                        function(tx) {
                            var qry = "SELECT * FROM " + varType
                            var results = tx.executeSql(qry)
                            for(var i = 0; i < results.rows.length; i++){
                                userTypeListModel.append({"description":results.rows.item(i).description})

                            }
                        })
        }catch(err){
            console.log(err)
        }
    }

    function deleteUser(varPassword){
        try{
            db.transaction(
                        function(tx) {
                            tx.executeSql("DELETE FROM User WHERE password = ?;",[varPassword])
                            dialogDb.setTitleDialog("Delete")
                            dialogDb.setTextDialog("You delete the user with password" + varPassword + " correctly")
                            //typeField.text = ""
                            //listModel.remove(varIndex)
                            dialogDb.open()
                        })

        }catch(err){
            console.log("Error:  " + err);
            dialogDb.setTitleDialog("Error")
            dialogDb.setTextDialog(err)
            dialogDb.open()
        }
    }

    Dialog {

        signal setTitleDialog(string titleDialogInput)
        signal setTextDialog(string textDialogInput)

        onSetTitleDialog:  {
            titleDialog = titleDialogInput
        }

        onSetTextDialog:{
            textDialog = textDialogInput
        }

        id: dialogDb
        focus: true
        modal: true
        width: parent.width/1.5
        height: parent.height/1.5
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: titleDialog

        standardButtons: Dialog.Close

        Column{
            spacing: 20
            Text {
                width: dialogDb.availableWidth
                text: textDialog
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }

    }
}

