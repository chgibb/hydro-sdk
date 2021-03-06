/**
 * @assertion bool any(bool f(E element))
 * Checks whether any element of this iterable satisfies test.
 * Checks every element in iteration order, and returns true if any of them make
 * test return true, otherwise returns false.
 * @description Checks that this method returns true if any of the elements of
 * this Iteratable make test return true, otherwise returns false.
 */

import { IIterable, List } from "../../../../runtime/dart/index";

declare const assert: (this: void, arg: boolean, message?: string) => void;

export function any_A01_t01(
    create: (
        content: IIterable<any> | undefined,
        props: { isSet: boolean }
    ) => IIterable<any>,
    props: { isSet: boolean }
) {
    const foo = (x: any) => x > 0;

    assert(create(undefined, { isSet: false }).any(foo) == false);
    assert(
        create(List.from<number>([-1, -3, -11] as any, {}), {
            isSet: props.isSet,
        }).any(foo) == false
    );
    assert(
        create(List.from<number>([-1, -3, -11, 5] as any, {}), {
            isSet: props.isSet,
        }).any(foo) == true
    );
    assert(
        create(List.from<number>([-1, -3, -11, 5, 3] as any, {}), {
            isSet: props.isSet,
        }).any(foo) == true
    );
}
