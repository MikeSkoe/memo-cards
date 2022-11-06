@react.component
let make = () => {
    let new = State.AppState.useSelector(({ stack }) => stack->Stack.getByLevel(Card.New));
    let familiar = State.AppState.useSelector(({ stack }) => stack->Stack.getByLevel(Card.Familiar));
    let remember = State.AppState.useSelector(({ stack }) => stack->Stack.getByLevel(Card.Remember));
    let know = State.AppState.useSelector(({ stack }) => stack->Stack.getByLevel(Card.Know));

    let iteration = State.AppState.useSelector(({ iteration }) => iteration);

    <>
        <TitleComp>
            {`Iteration: ${iteration->Belt.Int.toString}`}
        </TitleComp>
        <Form />
        <BoxComp stack=new label="New" cursor={None} />
        <BoxComp stack=familiar label="Familiar" cursor={None} />
        <BoxComp stack=remember label="Remember" cursor={None} />
        <BoxComp stack=know label="Know" cursor={None} />
    </>
}

