import { WebPlugin } from '@capacitor/core';
export class TMTPlayerWeb extends WebPlugin {
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
}
//# sourceMappingURL=web.js.map