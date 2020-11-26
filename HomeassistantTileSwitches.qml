import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

Tile {
	id: homeAssistantTileSwitches
    property bool dimState: screenStateController.dimmedColors

	function init() {}

    Rectangle {
        id: watertemp
        visible: dimState

        Text {
            text: try { (JSON.parse(app.homeAssistantSensor1Info)['state'] + " " + JSON.parse(app.homeAssistantSensor1Info)['attributes']['unit_of_measurement']).replace("undefined", "") } catch(e) { try { JSON.parse(app.homeAssistantSensor1Info)['state'] } catch(e) { "" } }
            font.family: qfont.regular.name
            color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
            x: 40
            y: 59
            width: 150
            height: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 30
        }
    }

    Rectangle {
        id: rectangleScenes
        visible: !dimState

        IconButton {
            id: buttonOverdag
            x: 8
            y: 8
            width: 214
            height: 67
            text: (JSON.parse(app.homeAssistantSwitch1Info)['state'] == "on") ? "Overdag | AAN" : "Overdag | UIT"
            onClicked: {
                if (app.connected) {
                    if (JSON.parse(app.homeAssistantSwitch1Info)['state'] == "on") {
                        app.setHomeAssistant(app.homeAssistantSwitch1, 0);
                        text: "Overdag | UIT"
                    } else {
                        app.setHomeAssistant(app.homeAssistantSwitch1, 1);
                        text: "Overdag | AAN"
                    }
                } else {
                    app.logText("Unable to send command. Please verify connection settings.");
                }
            }
        }
    
        /*IconButton {
            id: buttonAvond
            x: 119
            y: 8
            width: 103
            height: 67
            text: "Avond"
            onClicked: {
                app.setHomeAssistant(app.homeAssistantScene2);
            }
        }*/

        IconButton {
            id: buttonWeg
            x: 8
            y: 83
            width: 214
            height: 67
            text: (JSON.parse(app.homeAssistantSwitch2Info)['state'] == "on") ? "Avond | AAN" : "Avond | UIT"
            onClicked: {
                if (app.connected) {
                    if (JSON.parse(app.homeAssistantSwitch2Info)['state'] == "on") {
                        app.setHomeAssistant(app.homeAssistantSwitch2, 0);
                        text: "Avond | UIT"
                    } else {
                        app.setHomeAssistant(app.homeAssistantSwitch2, 1);
                        text: "Avond | AAN"
                    }
                } else {
                    app.logText("Unable to send command. Please verify connection settings.");
                }
            }
        }

        /*IconButton {
            id: buttonSlapen
            x: 119
            y: 83
            width: 103
            height: 67
            text: "Slapen"
            onClicked: {
                app.setHomeAssistant(app.homeAssistantScene4);
            }
        }*/
    }
}
