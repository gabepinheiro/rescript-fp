let root = ReactDOM.querySelector("#root")

switch root {
| Some(element) => ReactDOM.render(<FirstClassHighOrderFunctions />, element)
| None => Js.log("Element root not found")
}
