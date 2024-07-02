export interface TMTPlayerPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  play(options: { url: string; title: String; artist: String; image: String }): Promise<{ url: string; title: String; artist: String; image: String }>;
  pause(options: { value: string }): Promise<{ value: string }>;  
}
