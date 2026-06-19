export abstract class Instantiable<T> {

    public abstract clone(): T;

    public abstract equals(other: T): boolean;

    public abstract toString(): string;

}
