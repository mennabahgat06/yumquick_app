# YumQuick – Food Delivery App (Flutter + Dio)

Connected to the **NTI e-commerce API** (`ecommerce.json` in this folder) – the same server as Stylish.
Dishes are the API "products".
```
https://nti-ecommerce-api-production-8a47.up.railway.app/api/
```
The url is in `lib/core/network/end_points.dart` (the only place to change it).

Run: `flutter pub get` then `flutter run`.

## Endpoints used by the app
| Screen | Method | Endpoint | Body |
|---|---|---|---|
| Sign Up | POST | register | form-data: name, email, phone, password |
| Log In | POST | login | form-data: email, password |
| (automatic, every 15 min) | POST | refresh_token | Bearer **refresh** token |
| Profile | GET | get_user_data | – |
| My Profile (edit) | PUT | update_profile | form-data: name, phone |
| Profile → Delete Account | DELETE | delete_user | – |
| Home banner | GET | sliders | – (no token) |
| Home – Best Seller | GET | best_seller_products | – |
| Home – Recommend | GET | top_rated_products | – |
| Menu categories | GET | categories | – |
| Menu list | GET | products | – (filtered by category_id) |
| Search | GET | products/search?q= | – |
| Dish → heart | POST | add_to_favorite | form-data: product_id |
| Confirm Order | POST | place_order | JSON: {"items": [{"product_id": 1, "quantity": 2}]} |
| My Orders | GET | orders | – |
| My Orders → Cancel | POST | orders/cancel/{id} | – |

## What the API does not have (handled in the app)
* **Cart** – saved on the device, sent with `place_order`.
* **Favorites list / remove** – only `add_to_favorite`; the list is also saved on the device.
* **Dish details / by category** – details come from the list; Menu filters `products` by `category_id`.
* No address field in `place_order`, so Confirm Order has no address box.

## Structure (one class per file)
```
lib/
  main.dart
  core/
    network/  api_consumer, api_exception, dio_consumer, dio_factory, auth_interceptor, end_points
    storage/  token_storage, cart_storage, favorite_storage, language_storage
    utils/    app_colors, app_navigator, app_snack_bar, greeting_helper, json_helper,
              price_formatter, validators
    widgets/  curved_page, custom_button, custom_text_field, search_field, app_network_image,
              confirm_dialog, loading_view, error_view, empty_view
  features/
    auth/ home/ categories/ foods/ item_details/ cart/ orders/ favorites/ profile/
```
