/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.music163.core 1.0
import "../components"
import "../Library.js" as Lib

Page {
    id: root

    property bool attached: false

    onStatusChanged: {
        if ( root.status === PageStatus.Active && !attached ) {
            pageStack.pushAttached(Qt.resolvedUrl("LyricPage.qml"))
            attached = true
        }
    }

    property var content

    property string name: qsTr("Music 163")

    SilicaListView {
        id: listView
        anchors.fill: parent
        anchors.bottomMargin: Theme.itemSizeHuge
        clip: true
        flickableDirection: Flickable.VerticalFlick
        model: content ? content.result.songs : -1

        VerticalScrollDecorator {  }

        ViewPlaceholder {
            enabled: listView.count === 0
            text: qsTr("( Insider Version )")
        }

        header: Column {
            width: parent.width
            spacing: Theme.paddingSmall

            PageHeader {
                anchors.right: parent.right
                title: name
            }

            SearchField {
                width:parent.width
                placeholderText: qsTr("Artist, Single, Album")
                EnterKey.enabled: text.length > 0
                EnterKey.onClicked: {
                    content = JSON.parse(music163.search(text))
                    console.log("search", JSON.stringify(content))
                }
            }
        }

        delegate: Component {
            SearchDelegate {
                id: delegate
                code: content.result.songs[index].id
                artist: content.result.songs[index].artists[0].name
                album: content.result.songs[index].album.name
                song: content.result.songs[index].name

            }

        }

    }


}


