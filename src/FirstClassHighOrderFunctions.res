/*
 * First-Class e High-Order Functions
 * 1. O que é "first-class" ?
      - First Class significa que a função é um recurso tratada como qualquer outro valor
        Assim como string ou int pode ser passado como argumento, ser atribuido numa variável, manipulado por uma função, retornável por uma função...
          Com funções podemos fazer a mesma coisa, pois é tratado como um "recurso first-class" da linguagem.

 * 2. O que são "first-class" functions ?
        Nada mais são do que funções sendo tratadas como valores. First Class-> sendo tratado como string, int, boolean...

 * 3. O que são "high-order" functions ?
      - Toda High Order Function é uma First Class Function
      - High Order Functions basicamente são funções que recebem outras funções como argumento
      e/ou
       - Retornam uma outra função
       - Ex: useEffect do React é uma high order function.

 * 4. Exemplos de FCF (first-class functions)
 * 5. Exemplos de HOF (high-order functions)
 * 6. Relação com updates imutáveis em arrays (map, filter e reduce)
 */

// String um recurso first class
let name = "Alonzo"
let sayHello = name => Js.log(`Hello, ${name}`)
sayHello(name)

// Funções também é um recurso first-class no ReScript, assim como no Js
// Exemplo com Promises, onde temos a função .then que recebe uma função como parametro
let printResult = result => Js.log(result)
//promise.then(printResult)

// First Class Functions
let sum = (a, b) => a + b
let sub = (a, b) => a - b

//High Order Function, que é tbm é ao mesmo tempo uma First Class Function
let executeOperation = (a, operation) => operation(a, 1)
executeOperation(5, sum)->ignore // 6
executeOperation(6, sub)->ignore //5

Js.Global.setTimeout(() => {
  Js.log("Hey....")
}, 1000)->ignore

// Fazendo uso de argumentos nomeados
let executeFn = (name, fn) => {
  fn(~message=`Hello, ${name}`)
}
executeFn("Alonzo", (~message) => {
  Js.log(message)
})

// High Order Functions: Metodos de Array (map, filter e reduce)
type person = {name: string, age: int}
let people = [
  {name: "Alonzo", age: 32},
  {name: "Turing", age: 36},
  {name: "Levi", age: 25},
  {name: "Eren", age: 23},
]
let people2 = people->Js.Array2.map(person => person.name)
Js.log2("People: ", people)
Js.log2("People2: ", people2)

let only30 = people->Js.Array2.filter(person => person.age >= 30)
Js.log2("Only30: ", only30)

@react.component
let make = () => {
  // High Order Function
  // Passando uma função diretamente no argumento da Função useEffect
  /* React.useEffect(() => { */
  /* return () => {...} */ // Retornando uma função
  /* }, []) */

  <div>
    <h1> {`Hello from React + ReScript and Vite 😃`->React.string} </h1>
  </div>
}
