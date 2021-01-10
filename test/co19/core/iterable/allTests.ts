import { IIterable } from "../../../../runtime/dart/core/iterable";
import { any_A01_t01 } from "./any_A01_t01";
import { any_A01_t02 } from "./any_A01_t02";
import { any_A01_t03 } from "./any_A01_t03";
import { any_A01_t04 } from "./any_A01_t04";
import { any_A01_t05 } from "./any_A01_t05";
import { any_A02_t01 } from "./any_A02_t01";
import { contains_A01_t01 } from "./contains_A01_t01";
import { elementAt_A01_t01 } from "./elementAt_A01_t01";

export function allIterableTests(
    create: (content: IIterable<any> | undefined) => IIterable<any>,
    props: { isSet: boolean }
) {
    any_A01_t01(create, { isSet: props.isSet });
    any_A01_t02(create, { isSet: props.isSet });
    any_A01_t03(create, { isSet: props.isSet });
    any_A01_t04(create, { isSet: props.isSet });
    any_A01_t05(create, { isSet: props.isSet });
    any_A02_t01(create, { isSet: props.isSet });
    contains_A01_t01(create, { isSet: props.isSet });
    elementAt_A01_t01(create, { isSet: props.isSet });
}