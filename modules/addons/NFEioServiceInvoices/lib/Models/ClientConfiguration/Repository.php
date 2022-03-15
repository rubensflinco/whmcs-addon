<?php

namespace NFEioServiceInvoices\Models\ClientConfiguration;

use \WHMCS\Database\Capsule;

/**
 * Classe responsável pela definição do modelo de dados
 * da tabela mod_nfeio_si_custom_configs
 */
class Repository extends \WHMCSExpert\mtLibs\models\Repository
{

    public $tableName = 'mod_nfeio_si_custom_configs';
    public $fieldDeclaration = array(
        'client_id',
        'key',
        'value',
    );

    public function tableName()
    {
        return $this->tableName;
    }

    public function fieldDeclaration()
    {
        return $this->fieldDeclaration;
    }

    function getModelClass()
    {
        return __NAMESPACE__ . '\Repository';
    }

    public function get()
    {
        return Capsule::table($this->tableName)->first();
    }

    public function dropProductCodeTable()
    {
        if (Capsule::schema()->hasTable($this->tableName))
        {
            Capsule::schema()->dropIfExists($this->tableName);
        }
    }

    /**
     * Cria a tabela mod_nfeio_si_custom_configs responsável por armazenar
     * os registros personalizados de emissão de nota para um cliente
     */
    public function createClientCustomConfigTable()
    {
        if (!Capsule::schema()->hasTable($this->tableName))
        {
            Capsule::schema()->create($this->tableName, function($table)
            {
                $table->increments('id');
                $table->integer('client_id');
                $table->string('key');
                $table->string('value');
            });
        }
    }

    public function getClientIssueCondition($clientId)
    {
        $issueCondition = 'seguir configuração do módulo nfe.io';

            $value = Capsule::table($this->tableName)
                ->where('client_id', $clientId)
                ->where('key', 'issue_nfe_cond')
                ->value('value');

            $value = strtolower($value);

            if (!is_null($value) OR $value !== $issueCondition) {
                $issueCondition = $value;
            }

        return $issueCondition;
    }

}