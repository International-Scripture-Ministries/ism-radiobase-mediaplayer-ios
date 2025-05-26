'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const TMTPlayer = core.registerPlugin('TMTPlayer', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.TMTPlayerWeb()),
});

// import { FetchMediaIOSList } from "../../../../src/app/interfaces/study";
class TMTPlayerWeb extends core.WebPlugin {
    async echo(options) {
        return { value: options.value };
    }
    async playMediaList(options) {
        console.log('Playing media list:', options.mediaList);
        return { value: 'Playing media list' };
    }
    async addMediaToList(options) {
        console.log('Adding media to list:', options.mediaList);
        return { value: 'Media added' };
    }
    async clearMediaList() {
        console.log('Media list cleared');
        return { value: 'Media list cleared' };
    }
    async play() {
        console.log('Playing media');
        return { value: 'Playing' };
    }
    async pause() {
        console.log('Paused media');
        return { value: 'Paused' };
    }
    async getCurrentPlayerItemSeekTime() {
        console.log('Getting current seek time');
        return { time: 42 };
    }
    async fetchMediaListStatistics() {
        console.log('Fetching media list statistics');
        return { statisticsList: [] };
    }
    async updatePlayerRate(options) {
        console.log('Updating player rate to', options.rate);
        return { value: 'Rate updated' };
    }
    async getCurrentMediaItemPlaybackInfo() {
        console.log('Getting current playback info');
        return { info: { title: 'Sample Media', duration: 120 } };
    }
    async removeAllMediaItemsExceptCurrentPlayingItem() {
        console.log('Removing all media items except current');
        return { value: 'Remaining current item only' };
    }
    async seekToTimeInSeconds(options) {
        console.log('Seeking to time (sec):', options.seconds);
        return { value: 'Seeked' };
    }
    async checkPlayingMediaList() {
        console.log('Checking current media list');
        return { mediaList: ['track1', 'track2'] };
    }
    async getStatisticsOfLastPlayedMediaBeforeAppClose() {
        console.log('Getting last media statistics');
        return { statistics: { title: 'Track 1', duration: 180 } };
    }
    async removeStatisticsOfLastPlayedMedia() {
        console.log('Removing last played media statistics');
        return { value: 'Removed statistics' };
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    TMTPlayerWeb: TMTPlayerWeb
});

exports.TMTPlayer = TMTPlayer;
//# sourceMappingURL=plugin.cjs.js.map
