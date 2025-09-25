#  Middle-App
A modern, responsive marketplace app built with FlutterFlow and Firebase. This app connects buyers and sellers through trusted middlemen who handle product delivery, ensuring safe and reliable transactions. Inspired by platforms like OLX, but with a focus on mediated delivery for peace of mind.

<img width="400" height="500" alt="WhatsApp Image 2025-09-24 at 04 38 13_8d9fea66" src="https://github.com/user-attachments/assets/d8445170-f8c1-4047-b0de-1fc00ac9ac16" />
<img width="400" height="500" alt="WhatsApp Image 2025-09-24 at 04 38 18_d58ecd8c" src="https://github.com/user-attachments/assets/3e77cef8-f935-4893-ab61-4db33084abd3" />

# 📸 Screenshots
<img width="400" height="500" alt="WhatsApp Image 2025-09-24 at 04 38 18_db6b6ce0" src="https://github.com/user-attachments/assets/bff60f32-bdea-4f53-978c-9bd04ff946c8" />
<img width="400" height="500" alt="WhatsApp Image 2025-09-24 at 04 38 17_7892d7e7" src="https://github.com/user-attachments/assets/72c31cb1-1d09-4575-a232-1ff2dd8ec954" />
<img width="400" height="500" alt="WhatsApp Image 2025-09-24 at 04 38 10_f8ae6ff6 (1)" src="https://github.com/user-attachments/assets/97ba5993-f0c4-4a70-90d3-f365a327c25f" />



# Sign-up/Login Screen: 
Clean form with email/password fields, "Create Account" button, and login link. Branded with "The Middle" logo.
Home Screen: Welcome message, search bar for products, and product cards (e.g., PlayStation 5 listing with Arabic/English support, price in EGP).
Orders Screen: Tabs for Upcoming/Completed, showing order cards with product image, dates, seller name, and total price.
Order Details Screen: Trip dates, product image/details, price breakdown, "Mark as Complete" button, and seller info with chat/call options.
Profile Screen: User avatar/email, account options (Edit Profile, Payment Info, Change Password), "My Products" with badge, "Add Product" button, and Log Out.

# 🚀 Features
❤ Authentication: Secure user sign-up/login with Firebase Auth (email/password). Supports profile editing and password changes.
🔥 Product Browsing & Search: Real-time search with debounce for products. Browse listings with images, descriptions, prices in EGP, and Arabic/English UI support.
📦 Orders Management: View upcoming/completed orders. Detailed order views with trip dates, destinations, price breakdowns, and status updates (e.g., mark as complete).
💬 Chat & Communication: In-app chat between buyers, sellers, and middlemen. Seller info includes profile pic, name, and call button for quick coordination.
🛒 Mediated Marketplace: Like OLX, but with a twist—middlemen (trusted couriers) handle delivery. Buyers post needs or browse; sellers list products; middlemen facilitate secure handoff. No direct P2P shipping risks.
📱 Responsive Design: Smooth, neon-inspired UI (blues, greens, purples) optimized for mobile. Dark mode toggle in profile.
🌐 Firebase Backend: Firestore for products/orders/chats, Storage for images, Cloud Functions for notifications. Handles offline sync and real-time updates.
🧪 Error Handling: Graceful handling of network issues, validation for forms, and user-friendly alerts.
🔁 Async Operations: Optimized loading for lists and details using FutureBuilder.
👥 User Roles: Buyers (browse/order), Sellers (add/list products), Middlemen (manage deliveries—future expansion).
#Additional Modules:

Auth Module: Firebase Auth integration for secure login.
Home Module: Product discovery and search.
Orders Module: Full CRUD for orders with status tracking.
Chat Module: Real-time messaging via Firestore streams.
Profile Module: User management and settings.
Network Layer: Firebase SDKs for seamless data sync.

# 🧰 Prerequisites

Flutter SDK installed (stable channel).
FlutterFlow account (for UI building/exporting code).
Firebase project set up (with Auth, Firestore, Storage enabled).
No external API needed—everything powered by Firebase.

# 🛠 Getting Started
This project uses FlutterFlow for rapid UI development and Firebase for backend. Export the code from FlutterFlow and run locally.

Set up FlutterFlow Project:

Create a new project in FlutterFlow named "The Middle".
Import the provided screenshots as references for UI design.
Build pages: Auth (Sign-up/Login), Home (Search/Browse), Orders (List/Details), Profile, Chat.
Use FlutterFlow's Firebase integration to connect Auth, Firestore collections (e.g., products, orders, chats), and Storage for images.
Add actions: Real-time queries for orders/chats, form validations, navigation.
Export generated Flutter code.


# Local Setup (Post-Export):
textgit clone <(https://github.com/mohamed12339/Middle-App)>  
cd the_middle
flutter pub get


# 🔌 Backend Usage
Powered by Firebase:

Auth: Email/password sign-in.
Firestore: Collections for users, products (title, description, price, images, sellerId), orders (productId, buyerId, middlemanId, status, dates), chats (real-time messages).
Storage: Upload product/seller images.
Rules: Secure reads/writes based on user auth (e.g., only owners edit products).

# 🤝 Contributing
All contributions are welcome!
If you spot an issue or have an idea for a new feature:

Fork the repo
Create a new branch
Commit clean and well-tested code
Open a Pull Request 🚀

🙏 Acknowledgments
Thanks to FlutterFlow for UI magic  and Firebase for scalable backend.
Big thanks to the open-source community 💙. Inspired by OLX's marketplace model with a mediated delivery twist.
📬 Contact
Built by Mohamed Magdy and omarEsam and sehabEldin and HassanSami and AliYassin
📧 Email: mhoda7891@gmail.com
📱 Phone: +201111641701
🔗 GitHub: https://github.com/mohamed12339
