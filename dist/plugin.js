var capacitorTMTPlayer = (function (exports, core) {
    'use strict';

    const TMTPlayer = core.registerPlugin('TMTPlayer', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.TMTPlayerWeb()),
    });

    class TMTPlayerWeb extends core.WebPlugin {
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

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        TMTPlayerWeb: TMTPlayerWeb
    });

    exports.TMTPlayer = TMTPlayer;

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
