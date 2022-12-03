/* - O que é Curryng ? */
/* - O que é partial application ? */
/* - Vantagens */
/* - Funções em ReScript são `currified/currificadas` por padrão */
/* - Currying em argumentos posicionais */
/* - Currying em argumentos nomeados */
/* - Interoperabilidade e output em Javascript */
/* - Problemas e como `descurrificar` funções */

let sum = (a, b, c) => a + b + c
//Currificando a função sum
// let sum = a => b => c => a + b + c

//Aplicação Parcial
let sum = a => {
  let anotherFunc = (b, c) => a + b + c

  anotherFunc
}

let result = sum(1)

// Funções em ReScript são currificadas por padrão.
// Isso significa que em Rescript não existem funções que recebem mais de um argumento, todas as funções recebem um único argumento assim como no Lambda Calculus
let sum = (a, b) => a + b // O ReScript transforma em isso aqui: let sum = a => b => a + b

// Aplicando a função `sum` de forma parcial
// Retorna uma função com o segundo parametro da função sum
let result = sum(1) // int => int

// Se fizermos a mesma coisa de cima em Javasript teriamos este resultado:
// O segundo parametro receberia undefined como valor
// const result = sum(1, undefined) // NaN

// Aplicação Parcial
let addOne = sum(1)
// let addOne = b => sum(1, b)
let resultAddOne = addOne(2)

Js.log(10->sum(10)->addOne) // 21

let saySomething = (message, name) => Js.log(`${message}, ${name}`)
saySomething("Hello", "Fulano")
saySomething("Hello", "Ciclano")

// Reaproveitar e compor uma nova função
let sayHello = saySomething("Hello")
sayHello("Alonzo")
sayHello("Marcola")

// Invertendo a ordem dos argumentos da função currificada
let saySomethingToTuring = saySomething(_, "Turing")
saySomethingToTuring("Hi")

// Função currificada com argumentos nomeados
let saySomething = (~message, ~name) => Js.log(`${message}, ${name}`)
let sayHello = saySomething(~message="Hello")
sayHello(~name="Alonzo")

let saySomethingToAlonzo = saySomething(~name="Alonzo")
saySomethingToAlonzo(~message="Hi")

// Função currificada mesclada com argumentos posicionas com nomeados
let saySomething = (~message, name) => Js.log(`${message}, ${name}`)
let sayHello = saySomething(~message="Hello")
sayHello("Bandidinho")
let saySomethingToGabe = saySomething("Gabe")
saySomethingToGabe(~message="E aí, meu chapa")

// Dizendo para o compildador do ReScript que não queremos que a função seja currificada por padrão
let sumUncurried = (. a, b) => a + b
sumUncurried(. 1, 2)->ignore

@react.component
let make = () => <h1> {`Currying and Partial Application in ReScript`->React.string} </h1>
