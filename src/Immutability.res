// Immutabilidade em let bindings

// Rescript trabalha com imutabilidade por padrão
let name = "Gabe"
// ReScript nem consegue entender isso, ele tenta presumir q vc ta tentando comparar as duas coisas
/* name = "Gabe Pinheiro" */

// Isso é Shadowing, basicamente o ReScript vai recriar o valor utilizando o mesmo nome da váriavel anterior
let name = "Gabe Pinheiro"

// Ao trabalhar com imutabilidade vamos sempre criar uma cópia de um valor, nunca mudar o valor que estamos trabalhando
// Ao fazer desta forma previnimos uma seria de bugs, principalmente quando estamos utilizando funções puras.
// Pois se a linguagem me garante que eu não posso mudar as coisas, nós não temos resultados inesperados
// Teremos sempre resultados muito previsiveis e consistentes
// Evita que as coisas sejam alteradas de maneira descontrolada, isso previne muito bug
// O fato da linguagem promover isso por padrão facilita muito vc não ter que forçar esse tipo de regra com paradigma ou com algum tipo de linter para poder garantir isso
let newName = `${name} Pinheiro`

// ================

// Immutabilidade e mutabilidade em records

type person = {
  /* mutable name: string, */
  id: int,
  name: string,
  age: int,
}

let alonzo = {
  id: 5,
  name: "Alonzo",
  age: 20,
}

// Não é possível fazer isso sem antes definir na tipagem que o field poderá ser mutável
/* alonzo.name = `${alonzo.name} Church` */

// Não vai permitir
/* alonzo.age = 50 */

//Update/Atualização imutável
// Atualizando um record imutável: Fazendo uma cópia com spread operator, por exemplo
let alonzoUpdate = {
  ...alonzo,
  name: `${alonzo.name} Church`,
}

Js.log(alonzoUpdate)

// =========================================

//Immutabilidade com arrays

let names = ["Gabe", "Alonzo Church", "Marcola", "Fake"]

// No JS fariamos assim para atualizar/mutar arrays mas no ReScript não é possível
// names.push("Turing")
// names[0] = "Fulano"

// Mas como o JS suporta isso, o ReScript acaba interoperando te permitindo utilizar o push atráves do module JS.array2, por exemplo
let _ = names->Js.Array2.push("Turing")

Js.log(names)

//  Trabalhando de maneira imutável com array.
let people = [
  {
    id: 0,
    name: "Alonzo",
    age: 32,
  },
  {
    id: 1,
    name: "Turing",
    age: 32,
  },
]

//Update/Atualização imutaável do array
let peopleUpdate = people->Js.Array2.map(person => {
  if person.id === 0 {
    {
      ...person,
      name: `${person.name} Church`,
    }
  } else {
    person
  }
})

Js.log2("People: ", people)
Js.log2("PeopleUpdate: ", peopleUpdate)

@react.component
let make = () => {
  let (state, setState) = React.useState(_ => "Alonzo")

  // Isso não é possível de se fazer
  // Ou melhor, não causará o efeito esperado que é atualizar o estado.
  // Se quisermos mudar o estado, isso é feito através do setState
  /* state = `${state} Church` */

  let handleChangeName = _ => {
    setState(name => `${name} Church`)
  }

  <div>
    <h1> {`Hello from React + ReScript`->React.string} </h1>
    <p> {state->React.string} </p>
    <button onClick=handleChangeName> {"Change Name"->React.string} </button>
  </div>
}
