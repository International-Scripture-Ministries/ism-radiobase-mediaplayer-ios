import { FetchMediaIOSList } from "../../../../src/app/interfaces/study";

export interface TMTPlayerPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
    playMediaList(options: {
        mediaList: string;
    }): Promise<{
        value: string;
    }>;
    addMediaToList(options: {
        mediaList: string;
    }): Promise<{
        value: string;
    }>;
    clearMediaList(): Promise<{
        value: string;
    }>;
    play(): Promise<{
        value: string;
    }>;
    pause(): Promise<{
        value: string;
    }>;
    getCurrentPlayerItemSeekTime(): Promise<{
        value: string;
    }>;
    fetchMediaListStatistics(): Promise<{
        statisticsList: [];
    }>;
    updatePlayerRate(options: {
        rate: number;
    }): Promise<{
        value: string;
    }>;
    getCurrentMediaItemPlaybackInfo(): Promise<{
        value: string;
    }>;
    removeAllMediaItemsExceptCurrentPlayingItem(): Promise<{
        value: string;
    }>;
    seekToTimeInSeconds(options: {
        seconds: number;
    }): Promise<{
        value: string;
    }>;
    checkPlayingMediaList(): Promise<{
        value: string;
    }>;
    getStatisticsOfLastPlayedMediaBeforeAppClose(): Promise<{
        value: string
    }>;
    removeStatisticsOfLastPlayedMedia(): Promise<{
        value: string
    }>;    
}