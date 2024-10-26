# Como configurar para testar

## Configurando o banco postgres

> [!IMPORTANT]
> É necessário já ter o banco do postgres instalado em sua máquina, verifique isso antes de tentar os próximos passos.
> 
> Se estiver usando um Fedora ou Rocky por exemplo, utilize o comando abaixo para a instalação do postgres em sua máquina:
> ```
> sudo dnf in postgresql
> ```

Primeiramente, as configurações de acesso ao banco estão no arquivo `./config/database.yml`, lá há os 3 tipos de `environment` , ao rodar um projeto do rails, por padrão ele estará no environment `development`, portanto você pode configurar o acesso ao seu banco ou nele, ou no `default`.

Para dar acesso para o projeto para o banco de dados, é necessário passar os campos `database` e `username` e se preciso `password`. Atualmente no projeto, já está configurado para buscar um banco chamado `ext_db` com um usuário `behnck`, você pode usar isso como base para seu caso.

## bundle

Esse projeto está atualmente com o rails `7.2`, portanto, certifique-se se vc tem essa versão instalado no seu sistema.

Depois disso, será necessário rodar o sguinte comando para instalar as "dependencias" do rails, também conhecidas como `gems`:

```shell
bundle install --local
```

Se tudo ocorrer bem, algo como a mensagem a seguir aparecerá para você:

```
Bundle complete! 10 Gemfile dependencies, 83 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed
```

> [!NOTE]
> É possível que esse processo não dê certo de primeira, se for necessário, tente repetir o comando sem o `--local`

## Rodar o servidor

Com os passos acimas concluídos, você poderá rodar sua API usando o seguinte comando:

```shell
rails server
```

Esse comando deverá ter uma saída parecida com a seguinte:

```text
=> Booting Puma
=> Rails 7.2.1 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 6.4.3 (ruby 3.3.4-p94) ("The Eagle of Durango")
*  Min threads: 3
*  Max threads: 3
*  Environment: development
*          PID: 5569
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
```

Agora se acessar seu `http://127.0.0.1:3000`, sua aplicação já deve estar de pé


## Requisições possível

Se estiver utilizando o postman (aplicação desktop que facilita o processo de criar requisições HTTP), há uma coleção de requisições GET, POST e PATCH/PUT para esse projeto no arquivo json `ext_api.postman_collection.json` é possível importar esse arquivo no postman e ter a exata mesmas requisições.
