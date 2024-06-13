import { registerPlugin } from '@capacitor/core';
const TMTPlayer = registerPlugin('TMTPlayer', {
    web: () => import('./web').then(m => new m.TMTPlayerWeb()),
});
export * from './definitions';
export { TMTPlayer };
//# sourceMappingURL=index.js.map