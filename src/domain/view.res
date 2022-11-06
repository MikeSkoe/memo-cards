type t = InProgress(Stack.t, int) | Done(Stack.t) | Overview;

let empty = Overview;

let make = (stack: Stack.t) => InProgress(stack, 0);

// -- UPDATE --

let next = (t, familiarity) => {
    switch t {
        | Done(_) | Overview => t
        | InProgress(stack, cursor) => {
            let stack' = Stack.mapAt(
                stack,
                cursor,
                Card.mapLevel(_, Card.shiftLevel(_, familiarity)),
            );
            let cursor' = cursor + 1;

            cursor' >= stack'->Belt.List.size
                ? Done(stack')
                : InProgress(stack', cursor')
        }
    }
};

