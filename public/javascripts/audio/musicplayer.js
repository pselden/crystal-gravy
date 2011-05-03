var MusicPlayer;

(function() {
    MusicPlayer = function(interfaceSelector) {
        var player = $('<div class="jp-jplayer"></div>');
        var queue = new MusicPlayer.Queue();

        var playerInterface = $(interfaceSelector);
        var progressBar = playerInterface.find('.progress');
        var volumeBar = playerInterface.find('.volume');
        progressBar.slider({
            max: 100,
            range: 'min',
            animate: true,

            start: function(){
              progressBar.data("sliderEnabled", false);
            },

            stop: function(event, ui){
                player.jPlayer("playHead", ui.value);
                progressBar.data("sliderEnabled", true);
            }
        }).data("sliderEnabled", true);

        volumeBar.slider({
            value : 80,
            max: 100,
            range: 'min',
            animate: true,

            slide: function(event, ui) {
               player.jPlayer("volume", ui.value/100);
            }
        });

        function queueSong(song){
           queue.addSongToQueue(song);
        }

        // sets the song of the player and plays it
        function playSong(song){
            player.jPlayer('setMedia', song);
            player.jPlayer('play');
        }

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
          queueSong(song);
        });

        playerInterface.append(player);

        player.jPlayer({
            ready: function () {
                playerInterface.find('.jp-prev').click(function() {
                    playSong(queue.getPreviousSong());
                });

                playerInterface.find('.jp-next').click(function() {
                    playSong(queue.getNextSong());
                });

                player.jPlayer('setMedia', queue.getCurrentSong());
            },

            ended: function() {
                playSong(queue.getNextSong());
            },

            play: function() {
                player.jPlayer("pauseOthers");
            },

            timeupdate: function(event){
                if(progressBar.data('sliderEnabled')){
                    var currentPercent = event.jPlayer.status.currentPercentAbsolute;
                    progressBar.slider('value', currentPercent);
                }
            },

            swfPath: '/swf',
            supplied: 'mp3, m4a, oga',
            cssSelectorAncestor: interfaceSelector
        });

        $.comm.listen('musicplayer.queuesong', function(song){
            queueSong(song);
        });
    };
})();