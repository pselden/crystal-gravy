var MusicPlayer = MusicPlayer || {};

(function() {
    MusicPlayer.Queue = function() {
        var songQueue = [], currentSongIndex = 0;

        this.addSongToQueue = function(song) {
            songQueue.push(song);
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