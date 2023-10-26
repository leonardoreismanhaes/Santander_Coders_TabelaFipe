{{
    config(
        unique_key="id",
        on_schema_changes="sync_all_columns",
        materialized="table"
    )
}}

SELECT 
    tm.nome_da_marca, 
    AVG((tpf.valor)::NUMERIC), 
    EXTRACT('MONTH' FROM tpf.data) AS mes
FROM public.marcas as tm 
INNER JOIN public.veiculos AS tv
ON tm.id_marca = tv.id_marca
INNER JOIN public.precos_fipe AS tpf
ON tv.codigo_fipe = tpf.id_veiculo
GROUP BY tm.nome_da_marca, mes