module Input = {
    @react.component
    let make = (~value, ~setValue, ~onEnter) => {
        let onKeyDown = e => {
            if ReactEvent.Keyboard.key(e) === "Enter" {
                onEnter();
            }
        }
        let onChange = e => ReactEvent.Form.currentTarget(e)["value"]->setValue;

        <input value=value onChange onKeyDown />
    }
}

@react.component
let make = _ => {
    let dispatch = State.AppState.useDispatch();
    let (front, setFront) = React.useState(_ => "");
    let (back, setBack) = React.useState(_ => "");

    let onEnter = _ => {
        let toSome = str => str == "" ? None : Some(str);
        let flatMap2 = (ab, fn) => switch ab {
            | (Some(a), Some(b)) => fn(a, b)
            | _ => None
        }

        (front->toSome, back->toSome)
            ->flatMap2((front, back) => Some(Card.make(~front, ~back, ~level=Card.New)))
            ->Belt.Option.map(card => {
                setFront(_ => "");
                setBack(_ => "");

                card->State.AddCard->dispatch;
            })
            ->ignore;
    }
    let onClick = _ => dispatch(State.StartReview);

    <>
        <Input
            onEnter
            value=front
            setValue=setFront
        />
        <Input
            onEnter
            value=back
            setValue=setBack
        />
        <button onClick>
            {React.string("Start")}
        </button>
    </>
}

