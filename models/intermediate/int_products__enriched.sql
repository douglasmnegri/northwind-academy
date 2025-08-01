with
    -- import models
    products as (
        select *
        from {{ ref('stg_erp__products') }}
    )
    , suppliers as (
        select *
        from {{ ref('stg_erp__suppliers') }}
    )
    , categories as (
        select *
        from {{ ref('stg_erp__categories') }}
    )
    -- transformation
    , joined as (
        select
             products.product_pk
             , products.product_name
             , products.supplier_fk
             , products.category_fk
             , products.quantity_per_unit
             , products.unit_price
             , products.units_in_stock
             , products.units_on_order
             , products.reoder_level
             , products.is_discontinued
        from products
        left join suppliers on products.supplier_fk = suppliers.supplier_pk
        left join categories on products.category_fk = categories.category_pk
    )
select *
from joined