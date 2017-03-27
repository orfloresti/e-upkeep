//Define the icon and action in the toolbar
function iconReturn(index){

    if (stackView.depth > 1) {

        stackView.pop()

        if(stackView.depth == 2){
            moduleName = moduleListModel.get(index).title
        }

        if(stackView.depth == 1){
            moduleName = appName
        }
    }
    else {
        drawer.open()
    }
}
