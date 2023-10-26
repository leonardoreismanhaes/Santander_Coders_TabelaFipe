{{
    config(
        unique_key="id",
        on_schema_changes="sync_all_columns",
        materialized="table"
    )
}}

SELECT 
    tm.nome_da_marca, 
    tv.nome_veiculo,
    AVG((tpf.valor)::NUMERIC), 
    EXTRACT(YEAR FROM tpf.data) AS ano
FROM public.marcas as tm 
INNER JOIN public.veiculos AS tv
ON tm.id_marca = tv.id_marca
INNER JOIN public.precos_fipe AS tpf
ON tv.codigo_fipe = tpf.id_veiculo
GROUP BY tm.nome_da_marca, tv.nome_veiculo, EXTRACT(YEAR FROM tpf.data)
ORDER BY tm.nome_da_marca, tv.nome_veiculo, ano