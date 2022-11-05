@react.component
let make = (~review: View.review) => {
    let dispatch = State.AppState.useDispatch();
    let { toReview, reviewing, skipped, remember, forget } = review;

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

        <CardComp card=reviewing />

        <BoxComp cards=toReview label="To review" />
        <BoxComp cards=remember label="Remember" />
        <BoxComp cards=forget label="Forget" />
        <BoxComp cards=skipped label="Skipped" />
    </>
}

