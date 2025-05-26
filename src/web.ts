// import { FetchMediaIOSList } from "../../../../src/app/interfaces/study";

import { WebPlugin } from '@capacitor/core';
import { TMTPlayerPlugin } from './definitions';

export class TMTPlayerWeb extends WebPlugin implements TMTPlayerPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    return { value: options.value };
  }

  async playMediaList(options: { mediaList: string }): Promise<{ value: string }> {
    console.log('Playing media list:', options.mediaList);
    return { value: 'Playing media list' };
  }

  async addMediaToList(options: { mediaList: string }): Promise<{ value: string }> {
    console.log('Adding media to list:', options.mediaList);
    return { value: 'Media added' };
  }

  async clearMediaList(): Promise<{ value: string }> {
    console.log('Media list cleared');
    return { value: 'Media list cleared' };
  }

  async play(): Promise<{ value: string }> {
    console.log('Playing media');
    return { value: 'Playing' };
  }

  async pause(): Promise<{ value: string }> {
    console.log('Paused media');
    return { value: 'Paused' };
  }

  async getCurrentPlayerItemSeekTime(): Promise<{ time: number }> {
    console.log('Getting current seek time');
    return { time: 42 };
  }

  async fetchMediaListStatistics(): Promise<{ statisticsList: any[] }> {
    console.log('Fetching media list statistics');
    return { statisticsList: [] };
  }

  async updatePlayerRate(options: { rate: number }): Promise<{ value: string }> {
    console.log('Updating player rate to', options.rate);
    return { value: 'Rate updated' };
  }

  async getCurrentMediaItemPlaybackInfo(): Promise<{ info: any }> {
    console.log('Getting current playback info');
    return { info: { title: 'Sample Media', duration: 120 } };
  }

  async removeAllMediaItemsExceptCurrentPlayingItem(): Promise<{ value: string }> {
    console.log('Removing all media items except current');
    return { value: 'Remaining current item only' };
  }

  async seekToTimeInSeconds(options: { seconds: number }): Promise<{ value: string }> {
    console.log('Seeking to time (sec):', options.seconds);
    return { value: 'Seeked' };
  }

  async checkPlayingMediaList(): Promise<{ mediaList: any[] }> {
    console.log('Checking current media list');
    return { mediaList: ['track1', 'track2'] };
  }

  async getStatisticsOfLastPlayedMediaBeforeAppClose(): Promise<{ statistics: any }> {
    console.log('Getting last media statistics');
    return { statistics: { title: 'Track 1', duration: 180 } };
  }

  async removeStatisticsOfLastPlayedMedia(): Promise<{ value: string }> {
    console.log('Removing last played media statistics');
    return { value: 'Removed statistics' };
  }
}
