'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const TMTPlayer = core.registerPlugin('TMTPlayer', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.TMTPlayerWeb()),
});

class TMTPlayerWeb extends core.WebPlugin {
    async echo(options) {
        console.log('ECHO', options);
        return options;
    }
    async playMediaList(options) {
        console.log('playMediaList', options);
        return options;
    }
    async addMediaToList(options) {
        console.log('addMediaToList', options);
        return options;
    }
    async clearMediaList(options) {
        console.log('clearMediaList', options);
        return options;
    }
    async play(options) {
        console.log('play', options);
        return options;
    }
    async pause(options) {
        console.log('pause', options);
        return options;
    }
    async getCurrentPlayerItemSeekTime(options) {
        console.log('getCurrentPlayerItemSeekTime', options);
        return options;
    }
    async fetchMediaListStatistics(options) {
        console.log('fetchMediaListStatistics', options);
        return options;
    }
    async updatePlayerRate(options) {
        console.log('fetchMediaLupdatePlayerRateistStatistics', options);
        return options;
    }
    async getCurrentMediaItemPlaybackInfo(options) {
        console.log('getCurrentMediaItemPlaybackInfo', options);
        return options;
    }
    async removeAllMediaItemsExceptCurrentPlayingItem(options) {
        console.log('removeAllMediaItemsExceptCurrentPlayingItem', options);
        return options;
    }
    async seekToTimeInSeconds(options) {
        console.log('seekToTimeInSeconds', options);
        return options;
    }
    async checkPlayingMediaList(options) {
        console.log('checkPlayingMediaList', options);
        return options;
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    TMTPlayerWeb: TMTPlayerWeb
});

exports.TMTPlayer = TMTPlayer;
//# sourceMappingURL=plugin.cjs.js.map
