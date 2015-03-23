## Cabeçalho


O código deve possuir um cabeçalho no estilo # ... contendo o nome da classe, uma breve descrição da mesma e um aviso de direitos autorais.


## Declaração de classes e interfaces


* Inicie criando o cabeçalho;
* Declare as variáveis na seguinte ordem, públicas, protegidas e privadas;
* Declare o construtor;
* Declare os métodos;


## Indentação (Mudar de nome)


* Usar indentação de 2 espaços
* Terminar cada arquivo com uma linha em branco
* Usar espaços ao redor de operadores, depois de vírgulas, dois pontos, ponto e vírgula, ao redor { e antes }.
* Não usar espaços antes de (, [ ou depois de  ], )
* Não usar espaços depois de !
* As linhas devem ter menos de 80 caracteres.
* Deixar uma linha em branco acima da declaração do método; 


### Quebra de linha


Quando a expressão não couber em uma linha, quebre-a com os seguintes princípios:


* Quebrar depois da vírgula
* Quebrar antes do operador
* Alinhar nova linha no mesmo nível do início da expressão da linha anterior;


## Sintaxe


* Não usar as palavras-chave and e or. Sempre usar && e || 
* Não usar parênteses em ```if/unless/while```
*Inicialize o construtor com ```def initialize ()```;
*Utilizar, ```def self.method```, para declarar métodos da classe;


## Declaração de método


Usar ```def``` com parênteses apenas quando ele tiver argumentos. Deve-se omitir os parênteses quando o método não aceita nenhum argumento.


``` ruby
  def self.some_method
    # body omitted
  end


  def some_method_with_argument(arg1, arg2)
    # body omitted
  end
```


### Declaração `case`


Deve seguir o seguinte padrão:


``` ruby
  case
  when …
  when …
  else ...
  end …
```


### Declaração `for`


Deve seguir o seguinte padrão:
``` ruby 
for current_iteration_number in 1..100 do
   # body omitted
end
```


### Declaração `if-else, if-elsif-else`
``` ruby
  if some_condition
    # body omitted
  elsif some_condition
    # body omitted
  else
    # body omitted
  end
```


## Nomenclatura(pensar num nome melhor)


* Use ``` modo_correto ``` para métodos e variáveis.
* Use ``` ModoCorreto ``` para classe e módulos.
* Use ``` MODO_CORRETO``` para outras constantes


## Outras expressões


* Prefira ```%w``` para a sintaxe de um array literal quando precisar de array de strings.


``` ruby
  STATES = %w ( draft open, closed )
```


* Use símbolos em vez de strings


``` ruby
hash = { :one => 1, :two => 2, :three => 3 }
```


* Prefira a interpolação de string em vez da concatenação


``` ruby
  email_with_name = "#{user.name} <#{user.email}>"
```