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

        <div>
            {switch view {
                | Review(review) => <Review review={review} />
                | Overview => <Overview/>
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

