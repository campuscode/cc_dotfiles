## Zsh

### Caracter na linha de comando

```
~/workspace
☻                                                                     ruby-2.7.0
```

Para substituir o "☻", basta incluir as seguintes variáveis no `.zshrc.local`:

```
export CC_GOOD_COMMAND=":)" # para exit 0, comando com sucesso
export CC_BAD_COMMAND=":(" # para comandos com erro
```

### Key Bindings

- Ctrl-A - Começo da linha
- Ctrl-E - Fim da linha
- Ctrl-R - pesquisa incremental no history
- Ctrl-P - Pesquisa no history
- Ctrl-N - Insere ultima palavra
- Ctrl-T - Sudo e comando

### Secrets

Adicione suas variáveis de ambientes locais em `.secrets`

### Aliases

Leia o arquivo: `~/.aliases` para ver a quantidade de aliases úteis.

Ser precisar rodar um comando sem o uso de alias, faça:

`\comando`

Ex: `\ls`

