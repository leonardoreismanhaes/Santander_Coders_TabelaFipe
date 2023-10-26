{{
    config(
        unique_key="codigo_fipe",
        on_schema_changes="sync_all_columns",
        materialized="table"
    )
}}


SELECT 
    CONCAT(tb.fipe_code, tb.year_model) AS codigo_fipe,
    marcas.id_marca AS id_marca,
    tb.model AS nome_veiculo,
    tb.gear AS cambio,
    tb.fuel AS combustivel,
    tb.year_model AS ano,
    tb.engine_size AS motor
FROM public.fipe_2022 as tb 
INNER JOIN {{ ref('marcas') }}
    ON tb.brand = marcas.nome_da_marca

