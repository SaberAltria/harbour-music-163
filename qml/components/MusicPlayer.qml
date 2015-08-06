import QtQuick 2.1
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import harbour.music163.core 1.0
//import QtSystemInfo 5.0
//import Sailfish.Media 1.0

Player {
    id: root

    property string song: ""
    property string code: ""
    property var content

    onCodeChanged: {
        content = JSON.parse(content = music163.song(code))
        console.log("content", JSON.stringify(content))

        //Cover
        cover.source = content.songs[0].album.picUrl

        //Lyric
        lyric =  JSON.parse(music163.lyric(code))
        console.log("lyric", JSON.stringify(lyric))


        console.log("artist", root.artist)
        root.playSingle(artist, song, content.songs[0].mp3Url)
        console.log("artist", root.artist)
    }

}




