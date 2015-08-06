#include "player.h"
#include <QQuickItem>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QFile>
#include <QFileInfo>
#include <QDir>
#include <QMediaMetaData>

Player::Player(QQuickItem *parent)
    : QQuickItem(parent)

{
    player = new QMediaPlayer(this);

    playlist = new QMediaPlaylist();

    connect(player, SIGNAL(durationChanged(qint64)), SIGNAL(durationChanged(qint64)));
    connect(player, SIGNAL(positionChanged(qint64)), SIGNAL(positionChanged(qint64)));
    connect(player, SIGNAL(metaDataChanged), SLOT(getMetaData()));
    connect(player, SIGNAL(metaDataAvailableChanged(bool)), SLOT(abcd(bool)));
}

Player::~Player()
{

}


/*void Player::setPlaylist(QMediaPlaylist playlist)
{

}*/



// Signal
void Player::abcd(bool available)
{
    qDebug()<<"1234567890";
    qDebug()<<player->metaData(QMediaMetaData::Title).toString();
}

// Control
void Player::pause()
{
    player->pause();
}

void Player::stop()
{
    player->stop();

    playlist->clear();
}

void Player::play()
{
    player->play();
}

void Player::playSingle(QString artist, QString song, QUrl source)
{
    // check if file exists and if yes: Is it really a file and no directory?

    QDir dir;
    QString url = dir.homePath() + "/Music/" + artist + " - " + song + ".mp3";
    QFileInfo localMusic(url);

    qDebug()<<url;

    if ( localMusic.exists() && localMusic.isFile() ) {
        player->setMedia(QUrl::fromLocalFile(url));
    } else {
        player->setMedia(source);
    }
    player->play();

    //Player::getMetaData();
    //qDebug()<<"True or False?"<<player->isMetaDataAvailable();
    //qDebug()<<player->metaData(QMediaMetaData::Title).toString();

}

void Player::playPlaylist(QStringList list)
{
    playlist->clear();

    foreach ( QString source, list ) {
        qDebug()<<source;
        playlist->addMedia(QUrl(source));
    }

    player->setPlaylist(playlist);
    player->play();
}

void Player::addToPlaylist(QString artist, QString song, QUrl source)
{
    // check if file exists and if yes: Is it really a file and no directory?

    playlist->clear();

    QDir dir;
    QString url = dir.homePath() + "/Music/" + artist + " - " + song + ".mp3";
    QFileInfo localMusic(url);

    qDebug()<<url;

    if ( localMusic.exists() && localMusic.isFile() ) {
        playlist->addMedia(QUrl::fromLocalFile(url));
    } else {
        player->setMedia(source);
    }

    //Player::getMetaData();
    qDebug()<<"True or False?"<<player->isMetaDataAvailable();
    qDebug()<<player->metaData(QMediaMetaData::Title).toString();
}

void Player::setPosition(qint64 position)
{
    if ( player->isSeekable() ) {
        qDebug() << "positionChanged";
        player->setPosition(position);
        emit positionChanged(position);
    }
}

qint64 Player::duration() const
{
    return player->duration();
}

qint64 Player::position() const
{
    return player->position();
}

QString Player::artist() const
{
    return player->metaData("Artist").toString();
}


QString Player::album() const
{
    return player->metaData("Album").toString();
}


QString Player::title() const
{
    return player->metaData("Title").toString();
}





// Meta data
void Player::getMetaData()
{
    QString artist = player->metaData("Artist").toString();
    QString title = player->metaData("Title").toString();
    QString album = player->metaData("Album").toString();

    qDebug()<<artist<<album<<title;
}
