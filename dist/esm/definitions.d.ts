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
        time: number;
    }>;
    fetchMediaListStatistics(): Promise<{
        statisticsList: any[];
    }>;
    updatePlayerRate(options: {
        rate: number;
    }): Promise<{
        value: string;
    }>;
    getCurrentMediaItemPlaybackInfo(): Promise<{
        info: any;
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
        mediaList: any[];
    }>;
    getStatisticsOfLastPlayedMediaBeforeAppClose(): Promise<{
        statistics: any;
    }>;
    removeStatisticsOfLastPlayedMedia(): Promise<{
        value: string;
    }>;
}
