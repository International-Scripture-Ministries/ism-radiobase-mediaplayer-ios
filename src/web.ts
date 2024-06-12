import { WebPlugin } from '@capacitor/core';

import type { TMTPlayerPlugin } from './definitions';

export class TMTPlayerWeb extends WebPlugin implements TMTPlayerPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
