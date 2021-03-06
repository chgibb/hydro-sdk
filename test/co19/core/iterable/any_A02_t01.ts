/**
 * @assertion bool any(bool f(E element))
 * Checks whether any element of this iterable satisfies test.
 * Checks every element in iteration order, and returns true if any of them make
 * test return true, otherwise returns false.
 */

import { IIterable, List } from "../../../../runtime/dart/index";

declare const assert: (this: void, arg: boolean, message?: string) => void;

export function any_A02_t01(
    create: (
        content: IIterable<any> | undefined,
        props: { isSet: boolean }
    ) => IIterable<any>,
    props: { isSet: boolean }
) {
    let count = 0;

    try {
        create(List.from<number>([1, 2] as any, {}), {
            isSet: props.isSet,
        }).any(() => {
            throw ++count;
        });
    } catch (err) {
        assert(count == 1);
    }

    count = 0;

    try {
        create(List.from<number>([1, 2, 3, 4, 5] as any, {}), {
            isSet: props.isSet,
        }).any(() => {
            throw ++count;
        });
    } catch (err) {
        assert(count == 1);
    }
}
