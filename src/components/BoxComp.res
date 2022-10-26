@react.component
let make = (~cards: list<Card.t>, ~label: string) => {
    <>
        <h2>{label->React.string}</h2>
        {
            cards
            ->Belt.List.map(card => <CardComp key=card.front card=card />)
            ->Belt.List.toArray
            ->React.array
        }
    </>
};
