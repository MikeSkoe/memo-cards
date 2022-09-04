@react.component
let make = (~review: Selected.review) => {
    let dispatch = State.AppState.useDispatch();
    let { toReview, reviewing, remember, forget } = review;

    <>
        <TitleComp>{"Review"}</TitleComp>
        <button onClick={_ => dispatch(State.Remember)}>{"remember"->React.string}</button>
        <button onClick={_ => dispatch(State.Forget)}>{"forget"->React.string}</button>
        <CardComp card=reviewing />
        <BoxComp box=Box.make(~cards=toReview) label="To review" />
        <BoxComp box=Box.make(~cards=remember) label="Remember" />
        <BoxComp box=Box.make(~cards=forget) label="Forget" />
    </>
}

