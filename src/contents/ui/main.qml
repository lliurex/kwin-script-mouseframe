/*
    This script is part of the Lliurex Project 
    SPDX-FileCopyrightText: 2024 Juanma1980 <juanma1980@gmail.com>
    SPDX-License-Identifier: GPL-3.0
*/

import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import org.kde.kirigami 2.12 as Kirigami
import org.kde.kwin 2.0 as KWinComponents

Window {
    id: root

    property color bkgColor: "black"
    property var frameOpacity: 15
    property color rColor: "black"
    property int frameSize: 2
    property int borderWidth: 0
    property int degress: 0
	color:Qt.rgba(0,0,0,0)
    flags:Qt.FrameLessHint|Qt.WindowStaysOnTopHint|Qt.WindowSystemMenuHint| Qt.X11BypassWindowManagerHint | Qt.FramelessWindowHint| Qt.WindowTransparentForInput

	Rectangle {
		id:rect
		radius:90
		anchors.fill:parent
		color:rColor
		border.width: borderWidth
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
		if (framet==0) degress= 90;

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
       root.y=workspace.cursorPos.y-(root.height*0.4);
       root.x=workspace.cursorPos.x-(root.width*0.5);

    }


    Connections {
        target: options
        function onConfigChanged() { updateConfig(); }
    }

    Connections {
        target: workspace
        function onCursorPosChanged() {
            moveFrame();
        }
    }

    KWinComponents.DBusCall {
        id: kwinReconfigure
        service: "org.kde.KWin"; path: "/KWin"; method: "reconfigure";
    }

    Component.onCompleted: {
        reloadFrame(true);
		root.show();
    }
}
