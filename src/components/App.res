%%raw("import './app.css'")

module AppState = State.AppState;

let rec classnames = (list, acc) =>
    switch list {
        | list{} => acc
        | list{(_, false), ...tail} => classnames(tail, acc)
        | list{(className, true), ...tail} => classnames(tail, `${acc} ${className}`)
    }

module Root = {
    @react.component
    let make = () => {
        let view = AppState.useSelector(({ view }) => view);

        {switch view {
            | View.InProgress(review) => <Review review={review} />
            | View.Done(stack) => <BoxComp cards=stack label="Done" />
            | View.Overview => <Overview/>
        }}
    }
}

@react.component
let make = () => {
    <AppState.Provider store=State.store>
        <Root/>
    </AppState.Provider>
}

