export interface TMTPlayerPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
    play(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
    pause(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
