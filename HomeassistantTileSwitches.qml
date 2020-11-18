import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

Tile {
	id: homeAssistantTileSwitches

	function init() {}

	Text {
		id: txtTimeBig
		text: app.timeStr
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			left: parent.left
			leftMargin: 10
			baseline: parent.top
			baselineOffset: isNxt ? 67 : 54
		}
		font {
			family: qfont.regular.name
			pixelSize: dimState ? qfont.clockFaceText : qfont.timeAndTemperatureText - isNxt ? 5 : 4
		}
		visible: app.clockTile ? true : false
	}

	Text {
		id: txtDate
		text: app.dateStr
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			left: txtTimeBig.left
			top: txtTimeBig.bottom
			topMargin: -10
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: qfont.tileTitle - 2
		font.family: qfont.regular.name
		visible: app.clockTile ? !dimState : false
	}

	Image {
		id: homeAssistantIconSmall
		source: "qrc:/tsc/homeAssistantIconSmall.png"
		anchors {
			bottom: txtDate.bottom
			right: parent.right
			rightMargin: 10
		}
		cache: false
		visible: app.clockTile ? !dimState : false
	}

	Image {
		id: homeAssistantIconSmallCenter
		source: dimState ? "qrc:/tsc/homeAssistantIconSmallDim.png" : "qrc:/tsc/homeAssistantIconSmall.png"
		anchors {
			baseline: parent.top
			horizontalCenter: parent.horizontalCenter
			baselineOffset: isNxt ? 19 : 15
		}
		cache: false
		visible: app.clockTile ? false : true
	}

	property alias switch1R: switchRect1

    Rectangle {
        id: switchRect1
        width: 250
        color: "transparent"
        anchors {
            baseline: parent.top
            horizontalCenter: parent.horizontalCenter
            baselineOffset: 10
        }

        Text {
            id: homeAssistantSwitch1Name
            width: 200
            text: try { JSON.parse(app.homeAssistantSwitch1Info)['attributes']['friendly_name'] } catch(e) { "" }
            font.pixelSize: 12
            color: "Black"
            wrapMode: Text.WordWrap
            anchors {
                verticalCenter: switchRect1.verticalCenter
            }
        }

        property alias switch1: toggleSwitch1

        Item {
            id: toggleSwitch1
            width: 54
            height: 36
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            property bool on: false

            Image {
                id: homeAssistantSwitch1Button
                x: 0; y: 0
                width: 54
                height: 36
                source: "qrc:/tsc/button_off.png"
                smooth: true

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (app.connected) {
                            if (toggleSwitch1.state == "on") {
                                parent.source = "qrc:/tsc/button_off.png"
                                knob.x = 1;
                                app.setHomeAssistant(app.homeAssistantSwitch1, 0);
                            } else {
                                parent.source = "qrc:/tsc/button_on.png"
                                knob.x = 22;
                                app.setHomeAssistant(app.homeAssistantSwitch1, 1);
                            }
                        } else {
                            app.logText("Unable to send command. Please verify connection settings.");
                        }
                    }
                }
            }

            Image {
                id: knob
                x: 1; y: 0
                width: 32
                height: 36
                source: "qrc:/tsc/knob.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (app.connected) {
                            if (toggleSwitch1.state == "on") {
                                homeAssistantSwitch1Button.source = "qrc:/tsc/button_off.png"
                                parent.x = 1;
                                app.setHomeAssistant(app.homeAssistantSwitch1, 0);
                            } else {
                                homeAssistantSwitch1Button.source = "qrc:/tsc/button_on.png"
                                parent.x = 22;
                                app.setHomeAssistant(app.homeAssistantSwitch1, 1);
                            }
                        } else {
                            app.logText("Unable to send command. Please verify connection settings.");
                        }
                    }
                }
            }

            states: [
                State {
                    name: "on"
                    PropertyChanges { target: knob; x: 22 }
                    PropertyChanges { target: homeAssistantSwitch1Button; source: "qrc:/tsc/button_on.png" }
                    PropertyChanges { target: toggleSwitch1; on: true }
                },
                State {
                    name: "off"
                    PropertyChanges { target: knob; x: 1 }
                    PropertyChanges { target: homeAssistantSwitch1Button; source: "qrc:/tsc/button_off.png" }
                    PropertyChanges { target: toggleSwitch1; on: false }
                }
            ]
        }
    }
}
