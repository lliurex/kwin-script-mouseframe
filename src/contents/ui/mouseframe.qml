// main.qml
import org.kde.plasma.core 2.0 as PlasmaCore
import QtQuick 2.0
import org.kde.kwin 2.0

/*PlasmaCore.Dialog {
    // This item will be the parent for the text display
	id: mouseframe
	//property int height: 64
    flags: Qt.X11BypassWindowManagerHint | Qt.FramelessWindowHint| Qt.WindowTransparentForInput
    //flags: Qt.X11BypassWindowManagerHint | Qt.FramelessWindowHint 
	//property int width: 64
	//
	visible:true
    location: PlasmaCore.Types.Floating
	outputOnly: true
	property color frameColor: "red"
	property int degress: 0
	property int borderWidth: 0
	color: frameColor*/
	Rectangle {
			id: mouseframe
			property color frameColor: "red"
			property int degress: 0
			property int borderWidth: 0
			radius:degress
			color: frameColor
			border.width: borderWidth
			anchors.centerIn: parent
			anchors.fill: parent
			anchors.margins:0
			//border:0
			x:0
			y:0
	//}

	Component.onCompleted: {
//        mouseframe.show();
    	//KWin.registerWindow(mouseframe);
	}
}
