{{
    config(
        unique_key="id",
        on_schema_changes="sync_all_columns",
        materialized="table"
    )
}}

WITH precos_fipe AS (
    SELECT 
        CONCAT(tb.fipe_code, tb.year_model) AS id_veiculo,
        CAST(CONCAT(tb.year_model ,'-', tb.month_of_reference,'-', '01') AS DATE) AS data,
        tb.avg_price_brl AS valor
    FROM public.fipe_2022 as tb
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['id_veiculo', 'data', 'valor']) }} AS id,
    id_veiculo,
    data,
    valor
FROM precos_fipe