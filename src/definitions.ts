export interface TMTPlayerPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  playMediaList(options: { value: string }): Promise<{ value: string }>;
  addMediaToList(options: { value: string }): Promise<{ value: string }>;
  clearMediaList(options: { value: string }): Promise<{ value: string }>;  
  play(options: { value: string }): Promise<{ value: string }>;  
  pause(options: { value: string }): Promise<{ value: string }>;  
  getCurrentPlayerItemSeekTime(options: { value: string }): Promise<{ value: string }>;  
  fetchMediaListStatistics(options: { value: string }): Promise<{ value: string }>;  
  updatePlayerRate(options: { value: string }): Promise<{ value: string }>;  
  getCurrentMediaItemPlaybackInfo(options: { value: string }): Promise<{ value: string }>;  
  removeAllMediaItemsExceptCurrentPlayingItem(options: { value: string }): Promise<{ value: string }>;  
  seekToTimeInSeconds(options: { value: string }): Promise<{ value: string }>; 
  checkPlayingMediaList(options: { value: string }): Promise<{ value: string }>; 
  getStatisticsOfLastPlayedMediaBeforeAppClose(options: { value: string }): Promise<{ value: string }>; 
  removeStatisticsOfLastPlayedMedia(options: { value: string }): Promise<{ value: string }>; 
}
