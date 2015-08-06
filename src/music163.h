#ifndef MUSIC163_H
#define MUSIC163_H

#include <QQuickItem>
#include <QString>
#include <QNetworkReply>

class Music163 : public QQuickItem
{
    Q_OBJECT

public slots:
    QVariant search(QString keyword);
    QVariant albumsByArtist(QString code);
    QVariant songsInAlbum(QString code);
    QVariant lyric(QString code);
    QVariant song(QString code);


    qint64 progress(qint64 read, qint64 total);
    void save(const QUrl url, const QString _name);

public:
    Music163(QQuickItem *parent=0);

private:
    QNetworkAccessManager network;

    //Download staff
    QNetworkAccessManager* downloader;
    QNetworkRequest request;
    QString name;

    QTextCodec *codec;
private slots:
    void write(QNetworkReply *reply);

signals:
    void progessChanged(qint64 read, qint64 total);

};

#endif // MUSIC163_H
