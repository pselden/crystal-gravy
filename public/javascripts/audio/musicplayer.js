var MusicPlayer;

(function() {
    MusicPlayer = function(interfaceSelector) {
        var player = $('<div class="jp-jplayer"></div>');
        var queue = new MusicPlayer.Queue();

        var songs = [
            {
                name:"Tempered Song",
                mp3:"http://www.jplayer.org/audio/mp3/Miaow-01-Tempered-song.mp3",
                oga:"http://www.jplayer.org/audio/ogg/Miaow-01-Tempered-song.ogg"
            },
            {
                name:"Hidden",
                mp3:"http://www.jplayer.org/audio/mp3/Miaow-02-Hidden.mp3",
                oga:"http://www.jplayer.org/audio/ogg/Miaow-02-Hidden.ogg"
            },
            {
                name:"Lentement",
                free:true,
                mp3:"http://www.jplayer.org/audio/mp3/Miaow-03-Lentement.mp3",
                oga:"http://www.jplayer.org/audio/ogg/Miaow-03-Lentement.ogg"
            },
            {
                name:"Lismore",
                free:true,
                mp3:"http://www.jplayer.org/audio/mp3/Miaow-04-Lismore.mp3",
                oga:"http://www.jplayer.org/audio/ogg/Miaow-04-Lismore.ogg"
            },
            {
                name: "Bubbles",
                m4a: "http://www.jplayer.org/audio/m4a/Miaow-07-Bubble.m4a",
                oga: "http://www.jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"
            }
        ];

        $.each(songs, function(i, song){
          queue.addSongToQueue(song);
        });

        $('body').append(player);

        // sets the song of the player and plays it
        function playSong(song){
            player.jPlayer('setMedia', song);
            player.jPlayer('play');
        }

        player.jPlayer({
            ready: function () {
                var playerInterface = $(interfaceSelector);
                playerInterface.find('.jp-prev').click(function() {
                    playSong(queue.getPreviousSong());
                });

                playerInterface.find('.jp-next').click(function() {
                    playSong(queue.getNextSong());
                });

                playSong(queue.getCurrentSong());
            },

            ended: function() {
                playSong(queue.getNextSong());
            },

            play: function() {
                player.jPlayer("pauseOthers");
            },

            swfPath: '/swf',
            supplied: 'mp3, m4a, oga',
            cssSelectorAncestor: interfaceSelector
        });
    };
})();