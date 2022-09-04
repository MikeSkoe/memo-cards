module Input = {
    @react.component
    let make = () => {
        let dispatch = State.AppState.useDispatch();
        let (input, setInput) = React.useState(() => "");

        let onChange = e => ReactEvent.Form.currentTarget(e)["value"]->setInput;
        let onKeyDown = e => {
            if ReactEvent.Keyboard.key(e) === "Enter" {
                Card.make(~front=input, ~back="")
                    ->State.AddCard
                    ->dispatch
                ReactEvent.Keyboard.currentTarget(e)["value"] = "";
                setInput(_ => "");
            }
        }
        let onClick = _ => dispatch(State.Review);

        <>
            <div>{input->React.string}</div>
            <input onChange onKeyDown />
            <button onClick>{"Start"->React.string}</button>
        </>
    }
}

@react.component
let make = () => {
    let { new, familiar, remember, know } = State.AppState.useSelector(({ boxes }) => boxes);
    let iteration = State.AppState.useSelector(({ iteration }) => iteration);

    <>
        <TitleComp>
            {`Iteration: ${iteration->Belt.Int.toString}`}
        </TitleComp>
        <Input />
        <BoxComp box=new label="New"/>
        <BoxComp box=familiar label="Familiar"/>
        <BoxComp box=remember label="Remember"/>
        <BoxComp box=know label="Know"/>
    </>
}

