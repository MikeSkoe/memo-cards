@react.component
let make = (~review: View.review) => {
    let dispatch = State.AppState.useDispatch();
    let { toReview, reviewing, remember, forget } = review;

    <>
        <TitleComp>{"Review"}</TitleComp>
        <button onClick={_ => dispatch(State.Remember)}>{"remember"->React.string}</button>
        <button onClick={_ => dispatch(State.Forget)}>{"forget"->React.string}</button>
        <CardComp card=reviewing />

        <BoxComp cards=toReview label="To review" />
        <BoxComp cards=remember label="Remember" />
        <BoxComp cards=forget label="Forget" />
    </>
}

