export interface TMTPlayerPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
