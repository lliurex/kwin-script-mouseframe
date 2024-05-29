/*
    This script is part of the Lliurex Project 
    SPDX-FileCopyrightText: 2024 juanma1980 <juanma1980@gmail.com>
    SPDX-License-Identifier: GPL-3.0
*/
import QtQuick 2.0;
import QtQuick.Window 2.0;
import org.kde.plasma.core 2.0 as PlasmaCore;
import org.kde.kwin 2.0;

PlasmaCore.Dialog {
    id: mouseframe
    location: PlasmaCore.Types.Floating
    visible: true
	mainItem: Item{
    	width: 64 //workspace.workspaceWidth
    	height: 64 //workspace.workspaceHeight //workspace.activeClient.geometry.height //Screen.height
		color:red
        Text {
            anchors.centerIn: parent
            color: "red"
            text: qsTr("text")
        }
	}
    //outputOnly: true


    Component.onCompleted: {
        mouseframe.show();
        KWin.registerWindow(mouseframe);
    }

}
