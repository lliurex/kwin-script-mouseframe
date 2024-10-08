/*
    This script is part of the Lliurex Project 
    SPDX-FileCopyrightText: 2024 Juanma1980 <juanma1980@gmail.com>
    SPDX-License-Identifier: GPL-3.0
*/

import QtQuick 2.12
import QtQuick.Window 2.12
import org.kde.kirigami 2.12 as Kirigami
import org.kde.plasma.core 2.0 as PlasmaCore;
import org.kde.kwin 3.0 as KWinComponents

//Window {
Item {
	Window {
		id: root
		property color bkgColor: "black"
		property var frameOpacity: 15
		property color rColor: "black"
		property int frameSize: 2
		property int borderWidth: 0
		property int degress: 0
		property int offshoreX: 0
		property int offshoreY: 0
		property bool outputOnly:true
		color:Qt.rgba(0,0,0,0)
		visible:false
		flags:Qt.FrameLessHint|Qt.WindowStaysOnTopHint|Qt.WindowSystemMenuHint| Qt.X11BypassWindowManagerHint | Qt.FramelessWindowHint| Qt.WindowTransparentForInput| Qt.TransparentForMouseEvents|Qt.OnScreenDisplay
			Rectangle {
				id:rect
				radius:90
				anchors.fill:parent
				color:root.rColor
				border.width: root.borderWidth
				visible:true
			}

		function reloadFrame(){
			applyConfig();
			moveFrame();
		}
		
		function readConfig(){
			bkgColor= KWin.readConfig("BackgroundColor",Qt.rgba(0,0,1,0.1));
			frameOpacity= KWin.readConfig("FrameOpacity",25);
			frameOpacity=frameOpacity/100
			rColor=Qt.rgba(bkgColor.r,bkgColor.g,bkgColor.b,frameOpacity);
			frameSize= KWin.readConfig("FrameSize",3);
			borderWidth= KWin.readConfig("BorderWidth",0);
			var framet= KWin.readConfig("FrameType",0);
			if (parseInt(framet)==0) degress= 90;
			offshoreX= KWin.readConfig("OffShoreX",0);
			offshoreY= KWin.readConfig("OffShoreY",0);

		}

		function updateConfig(){
			console.log("config");
		}

		function applyConfig(){
		   readConfig();
		   rect.border.width=root.borderWidth;
		   rect.radius=root.degress;
		   root.height=Kirigami.Units.gridUnit*root.frameSize;
		   root.width=Kirigami.Units.gridUnit*root.frameSize;
		}

		function moveFrame(){
		   root.y=KWinComponents.Workspace.cursorPos.y-(root.height*0.4)+root.offshoreY;
		   root.x=KWinComponents.Workspace.cursorPos.x-(root.width*0.5)+root.offshoreX;

		} // Window
	} //ITEM

    Connections {
        target: KWinComponents.Options
        function onConfigChanged() { updateConfig(); }
    }

    Connections {
        target: KWinComponents.Workspace
        function onCursorPosChanged() {
            root.moveFrame();
        }
    }

    Component.onCompleted: {
        //KWin.registerWindow(root);
        root.reloadFrame(true);
		root.show();
    }

}
