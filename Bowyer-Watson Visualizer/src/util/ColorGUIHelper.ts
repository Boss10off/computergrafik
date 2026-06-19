export class ColorGUIHelper {
    readonly object: Object;
    readonly prop: string;
    
    constructor(object: Object, prop: string) {
        this.object = object;
        this.prop = prop;
    }

    get value() {
        //@ts-ignore
        return "#" + this.object[this.prop].getHexString();
    }

    set value(hexString) {
        //@ts-ignore
        this.object[this.prop].set(hexString);
    }
}