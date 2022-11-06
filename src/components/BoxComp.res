@react.component
let make = (~stack: Stack.t, ~label: string, ~cursor: option<int>) => {
    <>
        <h2>{label->React.string}</h2>
        {
            stack
            ->Belt.List.mapWithIndex((ind, card) =>
                <CardComp
                    key=card.front
                    card=card
                    selected={switch cursor {
                        | Some(cursor) if cursor == ind => true
                        | _ => false
                    }}
                />)
            ->Belt.List.toArray
            ->React.array
        }
    </>
};
