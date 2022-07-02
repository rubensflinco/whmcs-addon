{function name=statusLabel}
    {if $data == 'Waiting'}
        <span class="label label-warning">Aguardando</span>
    {elseif $data == 'Created'}
        <span class="label label-info">Processando</span>
    {elseif $data == 'Issued'}
        <span class="label label-success">Emitida</span>
    {elseif $data == 'Cancelled'}
        <span class="label label-danger">Cancelada</span>
    {elseif $data == 'Error'}
        <span class="label label-danger">Falha ao Emitir</span>
    {elseif $data == 'Error_cep'}
        <span class="label label-danger">CEP do cliente inválido</span>
    {elseif $data == 'None'}
        <span class="label label-primary">Nenhum</span>
    {else}
        <span class="label label-danger">{$data}</span>
    {/if}
{/function}

{function name=disableButtonAction}
    {if $data == 'Cancelled' OR $data == 'Waiting'}
        disabled="true"
    {/if}
{/function}

<div class="row">
    <div class="col-sm-12">
        <hr>
    </div>
        {if $totalServiceInvoices > 0}
            <div class="col-sm-12">
                <div class="table-responsive">
                    <table class="table table-borderless">
                        <tr>
                            <td>
                                {if $totalServiceInvoices > {$serviceInvoicesQueryLimit}}
                                    <span class="text-left pull-left"><strong>Nota Fiscal:</strong> exibindo <strong>{$serviceInvoicesQueryLimit}</strong> de <strong>{$totalServiceInvoices}</strong></span>
                                {else}
                                    <span class="text-left pull-left"><strong>Nota Fiscal</strong>: {$totalServiceInvoices} encontradas</span>
                                {/if}
                            </td>
                            <td class="text-right">
                                <form action="" method="post" id="nfeio_frm_reissue">
                                    <input type="hidden" name="nfeiosi" value="reissue">
                                </form>
                                <form action="" method="post" id="nfeio_frm_cancel">
                                    <input type="hidden" name="nfeiosi" value="cancel">
                                </form>
                                {if $hasAllNfCancelled}
                                    <button type="submit" class="btn btn-xs btn-primary" form="nfeio_frm_reissue" >Reemitir Notas</button>
                                {/if}
                                {if !$hasAllNfCancelled}
                                    <button type="submit" class="btn btn-xs btn-danger" form="nfeio_frm_cancel" >Cancelar NFS-e</button>
                                {/if}
                            </td>
                        </tr>
                    </table>
                </div>
             </div>
        {elseif $invoiceStatus != 'Draft'}
            <div class="col-sm-12 center-block">
            <form action="" method="post">
                <input type="hidden" name="nfeiosi" value="create">
                <button type="submit" class="btn btn-primary btn-sm">Emitir Nota Fiscal</button>
            </form>
            </div>
        {/if}

    {if $totalServiceInvoices > 0 && $localServiceInvoices}
        <div class="col-sm-12">
            <div class="table-responsive">
                <table class="table table-sm">
                    <thead>
                    <th class="text-center">ID</th>
                    <th class="text-center">Gerada Em</th>
                    <th class="text-center">Valor</th>
                    <th class="text-center">Status</th>
                    <th class="text-center">Ações</th>
                    </thead>
                    <tbody>
                    {foreach from=$localServiceInvoices item=nota name=nota}
                        <tr>
                            <td class="text-center">{$nota->nfe_id}</td>
                            <td class="text-center"><abbr title="{$nota->created_at|date_format:"%H:%M:%S"}">{$nota->created_at|date_format:"%d/%m/%Y"}</abbr></td>
                            <td class="text-center">{$nota->services_amount}</td>
                            <td class="text-center"><abbr title="Status Flow: {$nota->flow_status}">{statusLabel data=$nota->status}</abbr></td>
                            <td>
                                <form action="" method="post" id="nfeio_frm_email_{$smarty.foreach.nf.iteration}">
                                    <input type="hidden" name="nfeiosi" value="email">
                                    <input type="hidden" name="nfe_id" value="{$nota->nfe_id}">
                                </form>
                                <div class="btn-group btn-group-sm" role="group" aria-label="Ações">
                                    <button {disableButtonAction data=$nota->status} type="button" class="btn btn-success" onclick="goTo('https://app.nfe.io/companies/{$companyId}/service-invoices/{$nota->nfe_id}', '_blank')">Visualizar</button>
                                    <button {disableButtonAction data=$nota->status} type="submit" class="btn btn-info" form="nfeio_frm_email_{$smarty.foreach.nf.iteration}">Enviar e-mail</button>
                                </div>

                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    {/if}
</div>
{literal}
    <script>
        function goTo(link, target) {
            window.open(link, target);
        }
    </script>
{/literal}