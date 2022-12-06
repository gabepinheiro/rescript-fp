let root = ReactDOM.querySelector("#root")

switch root {
| Some(element) => ReactDOM.render(<Monads />, element)
| None => Js.log("Element root not found")
}
