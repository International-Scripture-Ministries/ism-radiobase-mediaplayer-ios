import { W as WebPlugin } from "./index.5203bbbe.js";
class TMTPlayerWeb extends WebPlugin {
  async echo(options) {
    console.log("ECHO", options);
    return options;
  }
}
export { TMTPlayerWeb };
