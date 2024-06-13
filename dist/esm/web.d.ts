import { WebPlugin } from '@capacitor/core';
import type { TMTPlayerPlugin } from './definitions';
export declare class TMTPlayerWeb extends WebPlugin implements TMTPlayerPlugin {
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
