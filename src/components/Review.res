@react.component
let make = (~stack: Stack.t, ~cursor: int) => {
    let dispatch = State.AppState.useDispatch();

    <>
        <TitleComp>{"Review"}</TitleComp>

        {[Card.Back, Card.Skip, Card.Next]
            ->Belt.Array.map(familiarity =>
                <button onClick={_ => dispatch(State.Review(familiarity))}>
                    {familiarity
                        ->Card.familiarityToString
                        ->React.string}
                </button>
            )
            ->React.array
        }

        <BoxComp stack label="Skipped" cursor={Some(cursor)} />
    </>
}

