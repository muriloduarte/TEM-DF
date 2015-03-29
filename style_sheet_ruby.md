**Integrantes:** Murilo Duarte, Karine Valença, Wesley Araujo e Vinícius Bandeira  
**Curso:** Engenharia de Software  
**Universidade:** Universidade de Brasília (UnB)  
**Matéria:** Técnicas de Programação   
**Professor:** Maurício Serrano  
**Linguagem do Projeto:** Ruby com framework Ruby on Rails  
**Softwares Utilizados:** Transparência em Escalas Médicas do DF (TEM-DF) e Proconsulta



## 1 Cabeçalho

O código deve possuir um cabeçalho no estilo # ... contendo o nome da classe, uma breve descrição da mesma e um aviso de direitos autorais.

## 2 Comentários

Para comentários de uma única linha deve-se começar com caracter #, dar espaço e iniciar a frase com letra maiúscula.
```ruby
# This line is ignored by the ruby interpreter
```
Para comentários de mais de uma linha NÃO se deve usar comentários em bloco iniciado com =begin e terminado com =end. Ao invés disso, deve-se usar comentários regulares de uma linha #


``` ruby
# mau
=begin
linha de comentário
outra linha de comentário
=end

# bom
# linha de comentário
# outra linha de comentário
```

### 2.1 Comment annotations

* Serve para atentar sobre alguma eventualidade do código, alertar para alteração, melhoria, insegurança de algum trecho de código. 
* Comment annotation é usado imediatamente acima de um determinado código.
* É escrito com caracteres em maiúsculo, `:`, um espaço e a descrição.
* Se houver linhas múltiplas, a descrição do annotation deverá ter três espaços depois de `#`:

``` ruby
def bar
  # FIXME: This has crashed occasionally since v3.2.1. It may
  #   be related to the BarBazUtil upgrade.
  baz(:quux)
end
```
As annotations são listadas abaixo: 
* Usar `TODO` para anotar a adição de features e funciolidades posteriormente.
* Usar `FIXME` para anotar um código quebrado que necessita ser finalizado.
* Usar `OPTIMIZE` para anotar um código que afeta a performance e deve ser melhorado.
* Usar `HACK` para anotar um código questionável em sua prática de programação e que pode ser refatorado.
* Usar `REVIEW` para anotar se parte do código está realmente inteligível. 

## 3 Declaração de Variáveis

* Na declaração de variáveis deve-se manter um nome conexo com a ação da variável.
* Deve-se colocar “@” antes de todas as variáveis de instancia;
* Para variáveis de nome único, mantem-se a escrita em letra minuscula;
* Para variáveis compostas, mantem-se a escrita em letra minuscula, porem é necessário a utilização de “_” entre os nomes;
* Deve-se inicializar os valores na declaração da variável;

## 4 Declaração de classes e interfaces

* Inicie criando o cabeçalho;
* Declare as variáveis na seguinte ordem, públicas, protegidas e privadas;
* Declare o construtor;
* Declare os métodos;

## 5 Indentação

* Usar indentação de 2 espaços
* Terminar cada arquivo com uma linha em branco
* Usar espaços ao redor de operadores, depois de vírgulas, dois pontos, ponto e vírgula, ao redor `{  }` e depois de { e antes de }.
* Não usar espaços antes de (, [ ou depois de  ], )
* Não usar espaços depois de !
* As linhas devem ter no máximo 80 caracteres.
* Deixar uma linha em branco acima da declaração do método; 

### 5.1 Quebra de linha

Quando a expressão não couber em uma linha, quebre-a com os seguintes princípios:

* Quebrar depois da vírgula
* Quebrar antes do operador
* Alinhar nova linha no mesmo nível do início da expressão da linha anterior.
* Não usar `;` para indicar fim de instrução e linha. 

## 6 Sintaxe
* Declare uma classe sempre usando a primeira letra maiuscula;
* Declare uma classe com nome composto, usando sempre a primeira letra de cada palavra em maiúsculo;
* Não usar as palavras-chave and e or. Sempre usar && e ||. Também não utilizar `not`, ao invés disso utilizar `!` 
* Não usar parênteses em ```if/unless/while```
* Inicialize o construtor com ```def initialize ()```.
 
## 7 Declarações
### 7.1 Declaração de método

* Usar ```def``` com parênteses apenas quando ele tiver argumentos. Deve-se omitir os parênteses quando o método não aceita nenhum argumento.

``` ruby
  def self.some_method
    # body omitted
  end

  def some_method_with_argument(arg1, arg2)
    # body omitted
  end
```


* Utilizar, ```def self.method```, para declarar métodos singleton

```ruby
class TestClass
  # bad
  def TestClass.some_method
    # body omitted
  end

  # good
  def self.some_other_method
    # body omitted
  end
```
### 7.2 Declaração `case`

O `when` deve estar indentado no mesmo nível do `case`:

``` ruby
  case
  when …
  when …
  else ...
  end …
```

### 7.3 Declaração `for`

Deve seguir o seguinte padrão:

``` ruby 
for current_iteration_number in 1..100 do
    # body omitted
end
```
* Apesar do padrão acima, deve-se evitar o uso do `for`, a não ser em casos que seja extremamente necessário.

```ruby
arr = [1, 2, 3]

# mau
for elem in arr do
  puts elem
end

# note que elem é acessível de fora do loop for
elem #=> 3

# bom
arr.each { |elem| puts elem }

# elem não é acessível fora de cada bloco
elem #=> NameError: undefined local variable or method 'elem'

end
```
* Evitar utilizar `do-end` para blocos de apenas uma linha em `each`, caso contrário, em bloco de mais de uma linha, utiliza-se o `do-end`.

``` ruby
names = ['Bozhidar', 'Steve', 'Sarah']

# bad
names.each do |name|
  puts name
end

# good
names.each { |name| puts name }

# bad
names.select do |name|
  name.start_with?('S')
end.map { |name| name.upcase }

# good
names.select { |name| name.start_with?('S') }.map { |name| name.upcase }

```
### 7.4 Declaração `if-else, if-elsif-else e unless`
``` ruby
  if some_condition
    # body omitted
  elsif some_condition
    # body omitted
  else
    # body omitted
  end
```
*Evitar o operador ternário `?:`
*Nunca usar `else` numa condição `unless`:
```ruby
# bad
unless success?
  puts "failure"
else
  puts "success"
end

# good
if success?
  puts "success"
else
  puts "failure"
end
```
*`unless` deve ser usado apenas em condições negativas ou controle de fluxo `||`, caso contrário deverá ser utilizado o `if-else, if-elsif-else`.
*um `if, if-elsif` deverão ser sempre acompanhados de `else` mesmo que não tenha nenhum código para o else.
* Nunca usar `then` para `if/unless`
* quando o corpo de um `if/unless` tiver apenas uma linha, deve-se usar a seguinte sintaxe:
``` ruby 
# bad
  if some_condition
    do_something
  end

  # good
  do_something if some_condition
```

## 8 Nomenclatura

* Use ``` modo_correto ``` conhedido como `snake_case` para métodos e variáveis.
* Use ``` ModoCorreto ``` conhecido como `CamelCase` para classes e módulos.
* Use ``` MODO_CORRETO``` conhecido como `SCREAMING_CAMEL_CASE` para outras constantes
* Métodos que retornam um valor booleano devem terminar com interrogação `?`
*Métodos com algum risco devem terminar com exclamação `!`

## 9 Outras expressões

### 9.1 Strings
* Prefira ```%w``` para a sintaxe de um array literal quando precisar de array de strings.

``` ruby
  STATES = %w (draft, open, closed)
```

* Use símbolos ao invés de strings

``` ruby
hash = { :one => 1, :two => 2, :three => 3 }
```

* Prefira a interpolação de string ao invés da concatenação

``` ruby
  email_with_name = "#{user.name} <#{user.email}>"
```
* Usar `" "` ao invés de `' '` para declaração de string.

### 9.2 Hashs e arrays

* Preferir utilizar `array = []` e `hash = {}` do que `array = Array.new` e `hash = Hash.new` a não ser que sejam passados parâmetros para construtor.

``` ruby
# ruim
array = Array.new
hash = Hash.new

# bom
array = []
hash = {}
```
### 9.3 Números

* Para números grandes, é melhor declarar seu literal pois fica mais fácil de interpretar

``` ruby
# ruim
number = 1000000
# bom
number = 1_000_000
```

Referências: 
* [Ruby Style Sheet](https://github.com/bbatsov/ruby-style-guide) 
* [Ruby Style Sheet Guide Git](https://github.com/styleguide/ruby)


