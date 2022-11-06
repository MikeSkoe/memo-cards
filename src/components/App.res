%%raw("import './app.css'")

module AppState = State.AppState;

let rec classnames = (list, acc) =>
    switch list {
        | list{} => acc
        | list{(_, false), ...tail} => classnames(tail, acc)
        | list{(className, true), ...tail} => classnames(tail, `${acc} ${className}`)
    }

let app = ReactDOM.Style.make(~width="clamp(500px, 75vw, 800px)", ~border="1px solid gray", ());

module Root = {
    @react.component
    let make = () => {
        let view = AppState.useSelector(({ view }) => view);

        <div style={app}>
            {switch view {
                | View.InProgress(stack, cursor) => <Review stack cursor />
                | View.Done(stack) => <BoxComp stack label="Done" cursor={None} />
                | View.Overview => <Overview/>
            }}
        </div>
    }
}

@react.component
let make = () => {
    <AppState.Provider store=State.store>
        <Root/>
    </AppState.Provider>
}

