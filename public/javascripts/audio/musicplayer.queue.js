var MusicPlayer = MusicPlayer || {};

(function() {
    MusicPlayer.Queue = function() {
        var songQueue = [], currentSongIndex = 0;

        // adds a song to the end of the queue
        this.queueSong = function(song) {
            songQueue.push(song);
        };

        // adds a song to the next position in the queue
        this.queueNextSong = function(song){
            songQueue.splice(currentSongIndex+1, 0, song);
        };

        this.getNextSong = function() {
            var nextIndex = currentSongIndex + 1;
            nextIndex = nextIndex < songQueue.length ? nextIndex : 0;
            currentSongIndex = nextIndex;
            return songQueue[currentSongIndex];
        };

        this.getPreviousSong = function() {
            var prevIndex = currentSongIndex - 1;
            prevIndex = prevIndex >= 0 ? prevIndex : songQueue.length - 1;
            currentSongIndex = prevIndex;
            return songQueue[currentSongIndex];
        };

        this.getCurrentSong = function(){
            return songQueue[currentSongIndex];
        };
    }
})();