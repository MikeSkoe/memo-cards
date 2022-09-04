@react.component
let make = (~card: Card.t) => {
    <div style={ReactDOM.Style.make(~border="1px solid gray", ())}>
        {card.front->React.string}
    </div>
}
