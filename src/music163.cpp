#include "music163.h"
#include <QQuickItem>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QEventLoop>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QTextCodec>

Music163::Music163(QQuickItem *parent)
    : QQuickItem(parent)

{

}

QVariant Music163::search(QString keyword)
{
    // Create custom temporary event loop on stack
    QEventLoop eventLoop;

    // "quit()" the event-loop, when the network request "finished()"
    QObject::connect(&network, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    // the HTTP request
    QNetworkRequest request( QUrl( QString("http://music.163.com/api/search/get/") ) );
    request.setRawHeader ("Referer", "http://music.163.com");
    request.setRawHeader ("Cookie", "appver=2.0.2");
    request.setRawHeader ("Content-type","application/x-www-form-urlencoded");

    QByteArray parameter;
    parameter.append ("s=" + keyword);
    parameter.append ("&offset=0&limit=24&type=1");

    QNetworkReply *reply = network.post(request, parameter);
    eventLoop.exec();

    //Success
    if ( reply -> error() == QNetworkReply::NoError ) {

        QByteArray json = reply -> readAll();
        delete reply;
        return QString(json);

        return 1;
    }
    else {
        //Failure
        qDebug() << "Failure" << reply -> errorString();
        delete reply;
        return - 1;
    }
}


QVariant Music163::song(QString code)
{
    // Create custom temporary event loop on stack
    QEventLoop eventLoop;

    // "quit()" the event-loop, when the network request "finished()"

    QObject::connect(&network, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    // the HTTP request
    QNetworkRequest request( QUrl( QString("http://music.163.com/api/song/detail/?id=" + code + "&ids=%5B" + code + "%5D") ) );
    request.setRawHeader ("Referer", "http://music.163.com");
    request.setRawHeader ("Cookie", "appver=2.0.2");

    QByteArray parameter;
    parameter.append ("s=" + code);
    parameter.append ("&offset=0&limit=24&type=1");

    QNetworkReply *reply = network.post(request, parameter);
    eventLoop.exec();

    //Success
    if ( reply -> error() == QNetworkReply::NoError ) {

        QByteArray json = reply -> readAll();
        delete reply;
        return QString(json);

        return 1;
    }
    else {
        //Failure
        qDebug() << "Failure" << reply -> errorString();
        delete reply;
        return - 1;
    }
}


QVariant Music163::albumsByArtist(QString code)
{
    // Create custom temporary event loop on stack
    QEventLoop eventLoop;

    // "quit()" the event-loop, when the network request "finished()"

    QObject::connect(&network, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    // Prepare request
    QNetworkRequest request( QUrl( QString("http://music.163.com/api/artist/albums/" + code + "?offset=0&limit=16") ) );

    request.setRawHeader ("Referer", "http://music.163.com");
    request.setRawHeader ("Cookie", "appver=2.0.2");

    QNetworkReply *reply = network.get(request);
    eventLoop.exec();

    //Success
    if ( reply -> error() == QNetworkReply::NoError ) {
        qDebug() << "Success" << reply -> readAll();
        delete reply;
        return reply -> readAll();
    }
    else {
        //Failure
        qDebug() << "Failure" << reply -> errorString();
        delete reply;
        return -1;
    }
}

QVariant Music163::songsInAlbum(QString code)
{
    // Create custom temporary event loop on stack
    QEventLoop eventLoop;

    // "quit()" the event-loop, when the network request "finished()"

    QObject::connect(&network, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    // the HTTP request
    qDebug()<<"http://music.163.com/api/album/" + code;
    QNetworkRequest request( QUrl( QString("http://music.163.com/api/album/" + code) ) );
    request.setRawHeader("Referer", "http://music.163.com");
    request.setRawHeader("Cookie", "appver=2.0.2");

    QNetworkReply *reply = network.get(request);
    eventLoop.exec();

    //Success
    if ( reply -> error() == QNetworkReply::NoError ) {
        qDebug() << "Success" << reply -> readAll();
        delete reply;
        return reply -> readAll();
    }
    else {
        //Failure
        qDebug() << "Failure" << reply -> errorString();
        delete reply;
        return -1;
    }
}

QVariant Music163::lyric(QString code)
{
    // Create custom temporary event loop on stack
    QEventLoop eventLoop;

    // "quit()" the event-loop, when the network request "finished()"

    QObject::connect(&network, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    // the HTTP request
    qDebug() << "http://music.163.com/api/album/" + code;
    QNetworkRequest request( QUrl( QString("http://music.163.com/api/song/lyric?os=pc&id=" + code + "&lv=-1&kv=-1&tv=-1") ) );
    request.setRawHeader ("Referer", "http://music.163.com");
    request.setRawHeader ("Cookie", "appver=2.0.2");

    QNetworkReply *reply = network.get(request);
    eventLoop.exec();

    //Success
    if ( reply -> error() == QNetworkReply::NoError ) {

        QByteArray json = reply -> readAll();
        delete reply;
        return QString(json);

        return reply -> readAll();
    }

    else {
        //Failure
        qDebug() << "Failure" << reply -> errorString();
        delete reply;
        return -1;
    }
}



void Music163::save(const QUrl url, const QString _name)
{

    name = _name;

    downloader = new QNetworkAccessManager(this);

    connect(downloader, SIGNAL(finished(QNetworkReply*)), this, SLOT(write(QNetworkReply*)));

    downloader->get(QNetworkRequest(url));

}


qint64 Music163::progress(qint64 read, qint64 total)
{
    read = read / total;
    return read;
}

void Music163::write(QNetworkReply *reply)
{
    if( reply->error() )
    {
        qDebug() << reply->errorString();
    } else {
        QDir dir;
        qDebug()<<name<<name.toUtf8();

        QFile *file = new QFile(dir.homePath() + "/Music/" + name);
        file->open(QFile::Append);
        file->write(reply->readAll());
        file->flush();
        file->close();
    }

    reply->deleteLater();

}
