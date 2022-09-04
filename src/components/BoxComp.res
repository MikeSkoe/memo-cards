@react.component
let make = (~box: Box.t, ~label: string) => {
    <>
        <h2>{label->React.string}</h2>
        {
            box.cards
            ->Belt.List.map(card => <CardComp key=card.front card=card />)
            ->Belt.List.toArray
            ->React.array
        }
    </>
};
