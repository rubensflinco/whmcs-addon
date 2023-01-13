---
slug: configuracao
permalink: /docs/configuracao/
layout: page
title: Configuração
---

Este documento irá mostrar como configurar com sucesso o [Módulo Nota Fiscal para WHMCS via NFE.io](https://github.com/nfe/whmcs-addon). Ela irá guiar passo a passo por todo o processo de configuração.

## Configurações do Módulo

Após a instalação e configuração inicial do addon como chave de API e código da empresa, é necessário realizar as configurações avançadas e rotinas de emissão das notas fiscais. Para isso acesse `Addons -> NFE.io NFSe -> Configurações`.

![](../assets/img/nfeio-whmcs-docs-configuracao-05.png)

As configurações disponíveis estão descritas a seguir.

### API Key

Chave de acesso privada gerado na sua conta NFE.io, necessária para a autenticação das chamadas à API.

> Configurado na etapa de instalação do módulo.

### ID da Empresa

ID da empresa ao qual serão associadas as notas fiscais gerados pelo WHMCS.

> Configurado na etapa de instalação do módulo.

### Código de Serviço Principal

Código de serviço que será usado como padrão para geração das notas fiscais pelo WHMCS.

> Configurado na etapa de instalação do módulo.

### Retenção de ISS

Alíquota em porcentagem (%) padrão de retenção de ISS. Será aplicado a todos os produtos/serviços.

### Deduzir descontos da fatura na NF

Deduzir descontos/abatimentos existentes na fatura do valor total da nota a ser emitida. Quando uma fatura possuir um item de desconto ou item com valor negativo, o mesmo será deduzido do valor total da nota a ser emitida. Se uma fatura possuir vários itens de desconto para diferentes serviços, os descontos serão somados e descontados com base no grupo de código de serviço.

Opção habilitada por padrão.

### Quando emitir NFE

Configuração global para emissão das nots ficais pelo WHMCS, as opções disponíveis são.

#### Quando a fatura é gerada

A NFSe será emitida assim que uma fatura seja publicada, ou seja, esteja disponível para o cliente.

#### Quando a fatura é paga

A NFSe será emitida apenas quando a fatura registrar um pagamento. Esse pagamento poderá ser registrado por qualquer portal de pagamento dentro do fluxo transacional padrão do WHMCS ou manualmente ao adicionar um pagamento em uma fatura.

### Agendar Emissão

Número de dias após o pagamento da fatura que as notas devem ser emitidas. Informe quantos dias após o registro do pagamento em uma fatura a NFSe será emitida.

**Atenção:** agendar emissão de notas desativa a configuração **Quando emitir NFE**.

### Cancelar NFE Quando Cancelar Fatura

Marque esta opção para cancelar automaticamente uma nota quando a fatura associada é cancelada.

### Inscrição Municipal

Selecione o campo personalizado criado anteriormente que será responsável por registrar o número de inscrição municipal do cliente.

### Campo Personalizado CPF

Selecione o campo personalizado criado anteriormente que será responsável pelo CPF do cliente. Este campo poderá ser o mesmo para CPF e CNPJ.

### Campo Personalizado CNPJ

Selecione o campo personalizado criado anteriormente que será responsável pelo CNPJ do cliente. Selecione o mesmo campo personalizado do CPF caso seja um campo único para ambos os números de documento (CPF/CNPJ).

### Descrição da NFSe

Selecione a informação que será exibida no campo de descrição da nota fiscal.

#### Número da fatura

Exibe apenas o número da fatura vinculada a NFSe.

#### Nome dos serviços

Exibe o nome de todos os serviços vinculados a fatura.

#### Número da fatura + Nome dos Serviços

Exibe o número da fatura em uma linha e o nome de todos os serviços vinculados a fatura em outra linha.

### Link da Fatura na NFSe

Inclui o link da fatura juntamente com a descrição da NFSe na mensagem da nota.

### Enviar e-mail

Habilita a opção de envio da nota fiscal por e-mail ao cliente.

> O e-mail será enviado para o endereço principal cadastrado no perfil do cliente diretamente pela NFE.io.

### Descrição Adicional

Campo livre para informação adicional que será exibida no campo mensagem da nota fiscal.

## Configurações dos Produtos/Serviços

Os produtos podem ter configurações de código de serviço individuais. É possível definir os códigos de serviços personalizado por produto em `Addons -> NFE.io NFSe -> Código de Serviço`

![](../assets/img/nfeio-whmcs-docs-configuracao-02.png)

Para definir um código de serviço personalizado, localize o produto/serviço desejado e no campo `Código do Serviço` informe o código de serviço desejado, em seguida clique no botão `Salvar Código`.

![](../assets/img/nfeio-whmcs-docs-configuracao-03.png)

> **Dica:** para alterar um código basta alterar o desejado e clicar no botão `Salvar Código` referente.

Para excluir um código personalizado de um produto, e voltar a utilizar a configuração global, localize o produto desejado e clique no botão `Excluir Código`.

![](../assets/img/nfeio-whmcs-docs-configuracao-04.png)

> **Dica:** use o campo `Pesquisar` localizado no canto superior da tabela para pesquisar os produtos desejados pelo nome ou ID.

## Alíquotas & Retenções

No menu **Alíquotas & Retenções** é possível definir alíquotas de retenção de ISS personalizadas para os diferentes códigos de serviços.

![image](https://user-images.githubusercontent.com/5316107/162669588-9e43281f-9b90-417e-873c-cebf2060e67b.png)

Caso existam códigos de serviços personalizados cadastrados, você poderá informar alíquotas diferentes para cada um, independente do valor definido na configuração global do módulo.

Códigos de serviço com **alíquota com valor 0 (zero)** não sofrerão cálculo de retenção de ISS.

## Emissão Personalizada por cliente

É possível definir uma **opção de emissão personalizada por cliente**, esta opção de emissão sobrescreve a configuração global de emissão configurada.

Para inserir uma opção personalizada de emissão, acesse o perfil do cliente desejado e localize o campo `Emitir nota fiscal quando` e selecione uma das opções de emissão da lista, como exemplificado na imagem a seguir.

![](../assets/img/nfeio-whmcs-docs-configuracao-01.png)

## Link da nota na fatura

Para inserir um link da nota fiscal do PDF e XML, edite o arquivo `viewinvoice.tpl` da pasta do template do WHMCS, utilize o exemplo abaixo:

```smarty
{include file="../../modules/addons/NFEioServiceInvoices/lib/templates/clientarea/viewinvoice.tpl"}
```

Recomendamos a inserção da tabela logo acima da linha:
```smarty
<p class="text-center d-print-none"><a href="clientarea.php?action=invoices">{lang key='invoicesbacktoclientarea'}</a></p>
```

Exemplo de exibição do downwload da NF na visualização da fatura pelo cliente.

![image](https://user-images.githubusercontent.com/5316107/162670459-e63ba40f-9d38-41dd-9f83-18123e5945fa.png)