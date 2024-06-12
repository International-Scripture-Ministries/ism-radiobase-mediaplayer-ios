import { TMTPlayer } from 'tmtplayer';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    TMTPlayer.echo({ value: inputValue })
}
