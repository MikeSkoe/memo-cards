let cardStyle = ReactDOM.Style.make(~display="flex", ~flexDirection="row", ~width="100%", ());
let side = ReactDOM.Style.make(~flex="1", ~border="1px solid gray", ());

@react.component
let make = (~card: Card.t, ~selected: bool) =>
    <div style={cardStyle}>
        {
            [card.front, card.back]
            ->Belt.Array.map(str =>
                <div style={side}>
                    {str->React.string}
                    {(selected ? " <" : "")->React.string}
                </div>)
            ->React.array
        }
    </div>
