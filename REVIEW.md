# Review – YumQuick

> Now connected to the NTI e-commerce API (same server as Stylish). See README.md for the endpoint table.

## What was there
A nice UI, but **no screen was connected to an API**. `end_points.dart` listed paths that were
never called, and every screen showed fixed sample data ("Mexican Appetizer", "$50.00", "John Smith").

| Screen | Before | Now |
|---|---|---|
| Welcome | OK (lorem ipsum) | Real text; logged-in users go straight to Home |
| Log In | Button just opened Home | POST login (email, password), saves access + refresh token |
| Sign Up | Button just went back | POST register, validation (match passwords), logs in |
| Home | Fake icons, fixed banner, search / View All did nothing | GET sliders, best_seller_products, top_rated_products, search, View All |
| Menu | Fake categories + 3 fixed dishes | GET categories + products filtered by category, search |
| Item details | Fixed dish, heart not clickable, Add to cart only popped | Real dish, POST add_to_favorite, add to cart with quantity |
| Cart | Fixed items and totals | Real cart saved on the device, remove item, totals |
| Confirm Order | Fixed address and items | POST place_order with the cart items |
| My Orders | Fixed rows | GET orders split by status, cancel active orders |
| My Favorites | Menu item did nothing (no screen) | **New screen**: dishes added with add_to_favorite |
| Profile | "John Smith" fixed | GET get_user_data, logout, delete account |
| My Profile | Fields not saved | PUT update_profile (name, phone) |
| Settings | Language button changed only its color | Language saved on the device and applied (AR = right-to-left) |

## Other fixes
* Bottom tabs rebuilt every time → now `IndexedStack` (tabs keep their data).
* Password "eye" icon did nothing → now shows / hides the password.
* "Good Morning / Breakfast Time" fixed text → changes with the time of day.
* Access token (15 min) is refreshed automatically with the refresh token.
* `shared_preferences` + `flutter_localizations` added.

## Refactor
One class per file (a StatefulWidget and its private State stay together).
The yellow header + white rounded body was copied in 10 screens → now one widget `CurvedPage`.
Other widgets: SliderBanner, SlideCard, ConfirmDialog, FoodGridCard, FoodGrid, FoodListCard, BestSellerList, CategoriesBar, CategoryItem,
BottomNavBar, HomeHeader, SectionHeader, CartItemTile, CartSummary, PriceRow,
OrderTile, OrdersList, OrdersTabBar, ProfileHeader, ProfileTile, LanguageButton, SearchField …
