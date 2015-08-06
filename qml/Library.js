
function addToPlaylist(code, url, artist, album, song, cover) {

    //Save playlist
    var record  = playlist.value

    var pos
    //Prevent duplicate playlist record
    if ( record.map(function(record) { console.log("record.code", record.code); return record.code; }).indexOf(code) === -1 ) {

    console.log("pos", pos)
    record.unshift({ code: code, url: url, cover: cover, artist: artist, album: album, song: song, cover: cover })
    playlist.value = record
    banner.alert("Added to Playlist")

    } else {
        banner.alert("Song Exists")
    }
}
