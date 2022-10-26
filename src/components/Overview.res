module Input = {
    @react.component
    let make = () => {
        let dispatch = State.AppState.useDispatch();
        let (input, setInput) = React.useState(() => "");

        let onChange = e => ReactEvent.Form.currentTarget(e)["value"]->setInput;
        let onKeyDown = e => {
            if ReactEvent.Keyboard.key(e) === "Enter" {
                Card.make(~front=input, ~back="", ~level=Card.New)
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
    let new = State.AppState.useSelector(({ stack }) => stack->Stack.Selectors.getByLevel(Card.New));
    let familiar = State.AppState.useSelector(({ stack }) => stack->Stack.Selectors.getByLevel(Card.Familiar));
    let remember = State.AppState.useSelector(({ stack }) => stack->Stack.Selectors.getByLevel(Card.Remember));
    let know = State.AppState.useSelector(({ stack }) => stack->Stack.Selectors.getByLevel(Card.Know));

    let iteration = State.AppState.useSelector(({ iteration }) => iteration);

    <>
        <TitleComp>
            {`Iteration: ${iteration->Belt.Int.toString}`}
        </TitleComp>
        <Input />
        <BoxComp cards=new label="New"/>
        <BoxComp cards=familiar label="Familiar"/>
        <BoxComp cards=remember label="Remember"/>
        <BoxComp cards=know label="Know"/>
    </>
}

