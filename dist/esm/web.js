import { WebPlugin } from '@capacitor/core';
export class TMTPlayerWeb extends WebPlugin {
    async echo(options) {
        console.log('ECHO', options);
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
}
//# sourceMappingURL=web.js.map