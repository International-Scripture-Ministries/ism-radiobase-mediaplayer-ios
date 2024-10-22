import { WebPlugin } from '@capacitor/core';

import type { TMTPlayerPlugin } from './definitions';

export class TMTPlayerWeb extends WebPlugin implements TMTPlayerPlugin {

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async playMediaList(options: { value: string }): Promise<{ value: string }> {
    console.log('playMediaList', options);
    return options;
  }

  async addMediaToList(options: { value: string }): Promise<{ value: string }> {
    console.log('addMediaToList', options);
    return options;
  }

  async clearMediaList(options: { value: string }): Promise<{ value: string }> {
    console.log('clearMediaList', options);
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

  async getCurrentPlayerItemSeekTime(options: { value: string }): Promise<{ value: string }> {
    console.log('getCurrentPlayerItemSeekTime', options);
    return options;
  }

  async fetchMediaListStatistics(options: { value: string }): Promise<{ value: string }> {
    console.log('fetchMediaListStatistics', options);
    return options;
  }
}
