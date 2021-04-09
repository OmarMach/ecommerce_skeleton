import 'dart:convert';

import 'dart:ui';

const baseUrl = "https://goods.tn/";

// Auth informations
const consumerKey = "ck_553867198d1018a037183c1da7ee85bcd2955c3e";
const consumerSecret = "cs_873fe51026c07463bd0d6d4ab4f8b63bd98f5c35";

final String basicAuth =
    'Basic ' + base64Encode(utf8.encode('$consumerKey:$consumerSecret'));

// Requrest Headers
final Map<String, String> headers = {
  'content-type': 'application/json',
  'accept': 'application/json',
  'authorization': basicAuth,
};
const Color googleColor = Color(0xFFDB4437);
const Color facebookColor = Color(0xFF4267B2);

final item = """[
    {
        "id": 12131,
        "name": "Qianli Mega-Idea iShuriken BGA Reballing",
        "slug": "qianli-mega-idea-ishuriken-bga-reballing",
        "permalink": "https://goods.tn/product/qianli-mega-idea-ishuriken-bga-reballing/",
        "date_created": "2021-02-22T02:34:18",
        "date_created_gmt": "2021-02-22T01:34:18",
        "date_modified": "2021-04-02T14:10:57",
        "date_modified_gmt": "2021-04-02T13:10:57",
        "type": "variable",
        "status": "publish",
        "featured": true,
        "catalog_visibility": "visible",
        "description": "<h3>iShuriken BGA Reballing Scraper tin knife scraping soldering paste T0.2mm</h3>\n",
        "short_description": "",
        "sku": "",
        "price": "5",
        "regular_price": "",
        "sale_price": "",
        "date_on_sale_from": null,
        "date_on_sale_from_gmt": null,
        "date_on_sale_to": null,
        "date_on_sale_to_gmt": null,
        "on_sale": false,
        "purchasable": true,
        "total_sales": 27,
        "virtual": false,
        "downloadable": false,
        "downloads": [],
        "download_limit": -1,
        "download_expiry": -1,
        "external_url": "",
        "button_text": "",
        "tax_status": "taxable",
        "tax_class": "",
        "manage_stock": false,
        "stock_quantity": null,
        "backorders": "no",
        "backorders_allowed": false,
        "backordered": false,
        "sold_individually": false,
        "weight": "",
        "dimensions": {
            "length": "",
            "width": "",
            "height": ""
        },
        "shipping_required": true,
        "shipping_taxable": true,
        "shipping_class": "",
        "shipping_class_id": 0,
        "reviews_allowed": false,
        "average_rating": "0.00",
        "rating_count": 0,
        "upsell_ids": [],
        "cross_sell_ids": [],
        "parent_id": 0,
        "purchase_note": "",
        "categories": [
            {
                "id": 68,
                "name": "Hand tools",
                "slug": "hand-tools"
            }
        ],
        "tags": [],
        "images": [
            {
                "id": 12134,
                "date_created": "2021-02-22T03:30:33",
                "date_created_gmt": "2021-02-22T01:30:33",
                "date_modified": "2021-02-22T03:30:33",
                "date_modified_gmt": "2021-02-22T01:30:33",
                "src": "https://goods.tn/wp-content/uploads/2021/02/231401691A-5.jpg",
                "name": "231401691A-5",
                "alt": ""
            },
            {
                "id": 12137,
                "date_created": "2021-02-22T03:33:02",
                "date_created_gmt": "2021-02-22T01:33:02",
                "date_modified": "2021-02-22T03:33:02",
                "date_modified_gmt": "2021-02-22T01:33:02",
                "src": "https://goods.tn/wp-content/uploads/2021/02/231401691A-3.jpg",
                "name": "231401691A-3",
                "alt": ""
            }
        ],
        "attributes": [
            {
                "id": 0,
                "name": "Model",
                "position": 0,
                "visible": true,
                "variation": true,
                "options": [
                    "STRAIGHT",
                    "CURVED"
                ]
            }
        ],
        "default_attributes": [],
        "variations": [
            12135,
            12136
        ],
        "grouped_products": [],
        "menu_order": 142,
        "price_html": "<span class=\"woocommerce-Price-amount amount\"><bdi>5.00&nbsp;<span class=\"woocommerce-Price-currencySymbol\">TND</span></bdi></span>",
        "related_ids": [
            12064,
            11497
        ],
        "meta_data": [
            {
                "id": 53555,
                "key": "inline_featured_image",
                "value": "0"
            },
            {
                "id": 53642,
                "key": "_wp_page_template",
                "value": "default"
            },
            {
                "id": 53643,
                "key": "_swatch_type",
                "value": "default"
            },
            {
                "id": 53644,
                "key": "minimum_allowed_quantity",
                "value": ""
            },
            {
                "id": 53645,
                "key": "maximum_allowed_quantity",
                "value": ""
            },
            {
                "id": 53646,
                "key": "group_of_quantity",
                "value": ""
            },
            {
                "id": 53647,
                "key": "allow_combination",
                "value": "no"
            },
            {
                "id": 53648,
                "key": "minmax_do_not_count",
                "value": "no"
            },
            {
                "id": 53649,
                "key": "minmax_cart_exclude",
                "value": "no"
            },
            {
                "id": 53650,
                "key": "minmax_category_group_of_exclude",
                "value": "no"
            },
            {
                "id": 53651,
                "key": "sp_wc_barcode_type_field",
                "value": "none"
            },
            {
                "id": 53652,
                "key": "sp_wc_barcode_field",
                "value": ""
            },
            {
                "id": 54060,
                "key": "_swatch_type_options",
                "value": {
                    "20f35e630daf44dbfa4c3f68f5399d8c": {
                        "type": "default",
                        "layout": "default",
                        "size": "swatches_image_size",
                        "attributes": {
                            "3a7ec495eedbc3be120e8fd13e007b92": {
                                "type": "color",
                                "color": "#FFFFFF",
                                "image": "0"
                            },
                            "070134b368ebb94ebe2a87a4cd298a01": {
                                "type": "color",
                                "color": "#FFFFFF",
                                "image": "0"
                            }
                        }
                    }
                }
            }
        ],
        "stock_status": "instock",
        "_links": {
            "self": [
                {
                    "href": "https://goods.tn/wp-json/wc/v3/products/12131"
                }
            ],
            "collection": [
                {
                    "href": "https://goods.tn/wp-json/wc/v3/products"
                }
            ]
        }
    }
]""";
