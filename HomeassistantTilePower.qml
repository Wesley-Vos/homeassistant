import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

Tile {
	id: homeAssistantTilePower

    property bool dimState: screenStateController.dimmedColors

	function init() {}

    onClicked: {
		app.showPower = !app.showPower;
    }

    Rectangle {
        id: test 
        
        Text {
            id: textSolar
            x: 85
            y: 54
            color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
            text: try { (JSON.parse(app.homeAssistantSensor1Info)['state'] + " " + JSON.parse(app.homeAssistantSensor1Info)['attributes']['unit_of_measurement']).replace("undefined", "") } catch(e) { try { JSON.parse(app.homeAssistantSensor1Info)['state'] } catch(e) { "" } }
            font.pixelSize: 15
            font.family: qfont.regular.name
            horizontalAlignment: Text.AlignHCenter
            width: 60
            visible: app.showPower
        }

        Text {
            id: textSolarEnergy
            x: 162
            y: 27
            width: 60
            rotation: 45
            color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
            text: try { (String(Math.round((parseFloat(JSON.parse(app.homeAssistantSensor4Info)['state'])/1000 - parseFloat(JSON.parse(app.homeAssistantSensor5Info)['state']))*100)/100) + " " + JSON.parse(app.homeAssistantSensor5Info)['attributes']['unit_of_measurement']).replace("undefined", "") } catch(e) { "" }
            font.pixelSize: 15
            font.family: qfont.regular.name
            horizontalAlignment: Text.AlignHCenter
            visible: !app.showPower
        }


        Text {
            id: textSolarEnergyMiddle
            x: 85
            y: 87
            color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
            text: try { (String(Math.round(parseFloat(JSON.parse(app.homeAssistantSensor4Info)['state'])/10)/100) + " " + JSON.parse(app.homeAssistantSensor5Info)['attributes']['unit_of_measurement']).replace("undefined", "") } catch(e) { "" }
            font.pixelSize: 16
            font.family: qfont.regular.name
            horizontalAlignment: Text.AlignHCenter
            width: 60
            visible: !app.showPower
        }

        Text {
            id: textGrid
            x: 8
            y: 120
            width: 60
            color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
            text: try { (String((parseFloat(JSON.parse(app.homeAssistantSensor2Info)['state']) > 0) ? parseFloat(JSON.parse(app.homeAssistantSensor2Info)['state']) : parseFloat(JSON.parse(app.homeAssistantSensor3Info)['state']))  + " " + JSON.parse(app.homeAssistantSensor2Info)['attributes']['unit_of_measurement']).replace("undefined", "") } catch(e) { try { String((parseFloat(JSON.parse(app.homeAssistantSensor2Info)['state']) > 0) ? parseFloat(JSON.parse(app.homeAssistantSensor2Info)['state']) : parseFloat(JSON.parse(app.homeAssistantSensor3Info)['state'])) } catch(e) { "" } }
            font.pixelSize: 15
            font.family: qfont.regular.name
            horizontalAlignment: Text.AlignHCenter
            visible: app.showPower
        }

         Text {
            id: textGridEnergy
            x: 8
            y: 27
            rotation: -45
            width: 60
            color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
            text: try { (JSON.parse(app.homeAssistantSensor5Info)['state'] + " " + JSON.parse(app.homeAssistantSensor5Info)['attributes']['unit_of_measurement']).replace("undefined", "") } catch(e) { try { JSON.parse(app.homeAssistantSensor5Info)['state'] } catch(e) { "" } }
            font.pixelSize: 15
            font.family: qfont.regular.name
            horizontalAlignment: Text.AlignHCenter
            visible: !app.showPower
        }

        Text {
            id: textHome
            x: 163
            y: 120
            width: 60
            color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
            text: try { (String(parseFloat(JSON.parse(app.homeAssistantSensor1Info)['state']) - parseFloat(JSON.parse(app.homeAssistantSensor2Info)['state']) + parseFloat(JSON.parse(app.homeAssistantSensor3Info)['state'])) + " " + JSON.parse(app.homeAssistantSensor3Info)['attributes']['unit_of_measurement']).replace("undefined", "") } catch(e) { try { String(parseFloat(JSON.parse(app.homeAssistantSensor1Info)['state']) - parseFloat(JSON.parse(app.homeAssistantSensor2Info)['state']) + parseFloat(JSON.parse(app.homeAssistantSensor3Info)['state'])) } catch(e) { "" } }
            font.pixelSize: 15
            font.family: qfont.regular.name
            horizontalAlignment: Text.AlignHCenter
            visible: app.showPower
        }

        Text {
            id: textHomeEnergy
            x: 85
            y: 134
            color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
            text: try { (JSON.parse(app.homeAssistantSensor6Info)['state'] + " " + JSON.parse(app.homeAssistantSensor6Info)['attributes']['unit_of_measurement']).replace("undefined", "") } catch(e) { try { JSON.parse(app.homeAssistantSensor6Info)['state'] } catch(e) { "" } }
            font.pixelSize: 15
            font.family: qfont.regular.name
            horizontalAlignment: Text.AlignHCenter
            width: 60
            visible: !app.showPower
        }

        Image {
            id: solar
            x: 95
            y: 8
            width: 40
            height: 40
            source: dimState ? "drawables/solarWhite.png" : "drawables/solar.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: grid
            x: 18
            y: 74
            width: 40
            height: 40
            source: dimState ? "drawables/gridWhite.png" : "drawables/grid.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: home
            x: 172
            y: 74
            width: 40
            height: 40
            source: dimState ? "drawables/homeWhite.png" : "drawables/home.png"
            fillMode: Image.PreserveAspectFit
        }


        Image {
            id: arrowSN
            x: 24
            y: 21
            width: 60
            source: dimState ? "drawables/arrowWhite.png" : "drawables/arrow.png"
            rotation: 180
            visible: ((parseFloat(JSON.parse(app.homeAssistantSensor2Info)['state']) > 0) ? true : false) || !app.showPower
            fillMode: Image.PreserveAspectFit
        }
        
        Image {
            id: arrowNH
            x: 85
            y: 99
            width: 60
            source: dimState ? "drawables/arrowWhite.png" : "drawables/arrow.png"
            rotation: 45
            visible: ((parseFloat(JSON.parse(app.homeAssistantSensor3Info)['state']) > 0) ? true : false) || !app.showPower
            fillMode: Image.PreserveAspectFit
        }
        
        Image {
            id: arrowSH
            x: 146
            y: 21
            width: 60
            height: 60
            source: dimState ? "drawables/arrowFlippedWhite.png" : "drawables/arrowFlipped.png"
            fillMode: Image.PreserveAspectFit
            visible: ((parseFloat(JSON.parse(app.homeAssistantSensor1Info)['state']) > 0) ? true : false) || !app.showPower
        }
    }
}
