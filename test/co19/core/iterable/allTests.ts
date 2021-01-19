import { IIterable } from "../../../../runtime/dart/core/iterable";
import { any_A01_t01 } from "./any_A01_t01";
import { any_A01_t02 } from "./any_A01_t02";
import { any_A01_t03 } from "./any_A01_t03";
import { any_A01_t04 } from "./any_A01_t04";
import { any_A01_t05 } from "./any_A01_t05";
import { any_A02_t01 } from "./any_A02_t01";
import { contains_A01_t01 } from "./contains_A01_t01";
import { elementAt_A01_t01 } from "./elementAt_A01_t01";
import { elementAt_A02_t01 } from "./elementAt_A02_t01";
import { every_A01_t01 } from "./every_A01_t01";
import { every_A01_t02 } from "./every_A01_t02";
import { every_A02_t01 } from "./every_A02_t01";
import { every_A02_t02 } from "./every_A02_t02";
import { every_A03_t01 } from "./every_A03_t01";
import { every_A04_t01 } from "./every_A04_t01";
import { expand_A01_t01 } from "./expand_A01_t01";
import { expand_A01_t02 } from "./expand_A01_t02";
import { expand_A02_t01 } from "./expand_A02_t01";
import { expand_A02_t02 } from "./expand_A02_t02";
import { first_A01_t01 } from "./first_A01_t01";
import { first_A01_t02 } from "./first_A01_t02";
import { first_A02_t01 } from "./first_A02_t01";
import { first_A03_t01 } from "./first_A03_t01";
import { firstWhere_A01_t01 } from "./firstWhere_A01_t01";
import { firstWhere_A02_t01 } from "./firstWhere_A02_t01";
import { firstWhere_A03_t01 } from "./firstWhere_A03_t01";
import { firstWhere_A04_t01 } from "./firstWhere_A04_t01";
import { fold_A01_t01 } from "./fold_A01_t01";
import { fold_A01_t02 } from "./fold_A01_t02";
import { forEach_A01_t01 } from "./forEach_A01_t01";
import { forEach_A01_t02 } from "./forEach_A01_t02";
import { forEach_A02_t01 } from "./forEach_A02_t01";
import { forEach_A03_t01 } from "./forEach_A03_t01";
import { isEmpty_A01_t01 } from "./isEmpty_A01_t01";
import { isNotEmpty_A01_t01 } from "./isNotEmpty_A01_t01";
import { join_A01_t01 } from "./join_A01_t01";
import { join_A01_t02 } from "./join_A01_t02";
import { last_A01_t01 } from "./last_A01_t01";
import { last_A02_t01 } from "./last_A02_t01";
import { lastWhere_A01_t01 } from "./lastWhere_A01_t01";
import { lastWhere_A02_t01 } from "./lastWhere_A02_t01";
import { lastWhere_A03_t01 } from "./lastWhere_A03_t01";
import { lastWhere_A04_t01 } from "./lastWhere_A04_t01";
import { length_A01_t01 } from "./length_A01_t01";
import { map_A01_t01 } from "./map_A01_t01";
import { map_A01_t02 } from "./map_A01_t02";
import { map_A02_t01 } from "./map_A02_t01";
import { map_A03_t01 } from "./map_A03_t01";
import { reduce_A01_t01 } from "./reduce_A01_t01";
import { single_A01_t01 } from "./single_A01_t01";
import { singleWhere_A01_t01 } from "./singleWhere_A01_t01";
import { singleWhere_A02_t01 } from "./singleWhere_A02_t01";
import { singleWhere_A02_t02 } from "./singleWhere_A02_t02";
import { skip_A01_t01 } from "./skip_A01_t01";
import { skip_A02_t01 } from "./skip_A02_t01";
import { skip_A03_t01 } from "./skip_A03_t01";
import { skipwhile_A01_t01 } from "./skipWhile_A01_t01";
import { skipwhile_A02_t01 } from "./skipWhile_A02_t01";
import { skipwhile_A03_t01 } from "./skipWhile_A03_t01";
import { skipwhile_A04_t01 } from "./skipWhile_A04_t01";
import { skipwhile_A05_t01 } from "./skipWhile_A05_t01";
import { take_A01_t01 } from "./take_A01_t01";
import { take_A02_t01 } from "./take_A02_t01";
import { take_A03_t01 } from "./take_A03_t01";
import { takeWhile_A01_t01 } from "./takeWhile_A01_t01";
import { takeWhile_A02_t01 } from "./takeWhile_A02_t01";
import { takeWhile_A03_t01 } from "./takeWhile_A03_t01";
import { takeWhile_A04_t01 } from "./takeWhile_A04_t01";
import { toList_A01_t01 } from "./toList_A01_t01";
import { toList_A01_t02 } from "./toList_A01_t02";
import { toSet_A01_t01 } from "./toSet_A01_t01";
import { where_A01_t01 } from "./where_A01_t01";
import { where_A01_t02 } from "./where_A01_t02";

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
    elementAt_A02_t01(create);
    every_A01_t01(create);
    every_A01_t02(create);
    every_A02_t01(create);
    every_A02_t02(create);
    every_A03_t01(create);
    every_A04_t01(create);
    expand_A01_t01(create);
    expand_A01_t02(create);
    expand_A02_t01(create);
    expand_A02_t02(create);
    first_A01_t01(create);
    first_A01_t02(create, { isSet: props.isSet });
    first_A02_t01(create);
    first_A03_t01(create);
    firstWhere_A01_t01(create, { isSet: props.isSet });
    firstWhere_A02_t01(create);
    firstWhere_A03_t01(create);
    firstWhere_A04_t01(create, { isSet: props.isSet });
    fold_A01_t01(create);
    fold_A01_t02(create);
    forEach_A01_t01(create);
    forEach_A01_t02(create);
    forEach_A02_t01(create);
    forEach_A03_t01(create);
    isEmpty_A01_t01(create);
    isNotEmpty_A01_t01(create);
    join_A01_t01(create);
    join_A01_t02(create);
    last_A01_t01(create, { isSet: props.isSet });
    last_A02_t01(create);
    lastWhere_A01_t01(create);
    lastWhere_A02_t01(create);
    lastWhere_A03_t01(create);
    lastWhere_A04_t01(create, { isSet: props.isSet });
    length_A01_t01(create, { isSet: props.isSet });
    map_A01_t01(create);
    map_A01_t02(create);
    map_A02_t01(create);
    map_A03_t01(create);
    reduce_A01_t01(create);
    single_A01_t01(create);
    singleWhere_A01_t01(create);
    singleWhere_A02_t01(create);
    singleWhere_A02_t02(create);
    skip_A01_t01(create);
    skip_A02_t01(create);
    skip_A03_t01(create);
    skipwhile_A01_t01(create);
    skipwhile_A02_t01(create);
    skipwhile_A03_t01(create);
    skipwhile_A04_t01(create);
    skipwhile_A05_t01(create);
    take_A01_t01(create);
    take_A02_t01(create);
    take_A03_t01(create);
    takeWhile_A01_t01(create);
    takeWhile_A02_t01(create);
    takeWhile_A03_t01(create);
    takeWhile_A04_t01(create);
    takeWhile_A04_t01(create);
    toList_A01_t01(create);
    toList_A01_t02(create);
    toSet_A01_t01(create);
    where_A01_t01(create);
    where_A01_t02(create);
}
