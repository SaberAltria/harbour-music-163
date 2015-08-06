#ifndef PLAYER_H
#define PLAYER_H

#include <QQuickItem>
#include <QString>
#include <QMediaPlayer>

class Player : public QQuickItem
{
    Q_OBJECT

    // Player
    Q_PROPERTY(qint64 duration READ duration NOTIFY durationChanged)
    Q_PROPERTY(qint64 position READ position WRITE setPosition NOTIFY positionChanged)

    Q_PROPERTY(QString artist READ artist)
    Q_PROPERTY(QString title READ title)
    Q_PROPERTY(QString album READ album)

public:
    Player(QQuickItem *parent = 0);
    ~Player();

    qint64 duration() const;
    qint64 position() const;

    // Meta Data
    QString artist() const;
    QString album() const;
    QString title() const;

private:
    QMediaPlayer *player;
    QMediaPlaylist *playlist;


public slots:
    // Player control
    void pause();
    void stop();
    void play();

    void playSingle(QString artist, QString song, QUrl source);
    void playPlaylist(QStringList list);

    void addToPlaylist(QString artist, QString song, QUrl source);
    void setPosition(qint64 position);

    void getMetaData();



    void abcd(bool available);

signals:
    void durationChanged(qint64 duration);
    void positionChanged(qint64 position);

};
#endif // PLAYER_H
