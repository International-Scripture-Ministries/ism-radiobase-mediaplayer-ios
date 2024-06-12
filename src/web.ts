import { WebPlugin } from '@capacitor/core';

import type { TMTPlayerPlugin } from './definitions';

export class TMTPlayerWeb extends WebPlugin implements TMTPlayerPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async play(options: { value: string }): Promise<{ value: string }> {
    console.log('play', options);
    return options;
  }

  async pause(options: { value: string }): Promise<{ value: string }> {
    console.log('pause', options);
    return options;
  }
}
