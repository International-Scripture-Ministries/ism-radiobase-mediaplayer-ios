import { registerPlugin } from '@capacitor/core';

import type { TMTPlayerPlugin } from './definitions';

const TMTPlayer = registerPlugin<TMTPlayerPlugin>('TMTPlayer', {
  web: () => import('./web').then(m => new m.TMTPlayerWeb()),
});

export * from './definitions';
export { TMTPlayer };
