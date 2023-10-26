{{
    config(
        unique_key="id_marca",
        on_schema_changes="sync_all_columns",
        materialized="table"
    )
}}

WITH marcas AS (
    SELECT DISTINCT(tb.brand) as nome_da_marca
    FROM public.fipe_2022 as tb 
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['nome_da_marca']) }} AS id_marca,
    nome_da_marca,
    CURRENT_TIMESTAMP AS data_criacao
FROM marcas