# Smart Waste Management & Recycling Mobile Application

## 📌 Problem Context
The world faces severe waste management issues due to improper waste segregation, lack of recycling awareness, inefficient collection routes, and a low level of user incentive. Current systems lack a centralized, gamified ecosystem to handle both municipal collection and end-user behavior.

## 🎯 Solution Architecture
We have developed a comprehensive **Flutter & Firebase** application using **Clean Architecture** and **MVVM**.

### Key Modules Implemented:
1. **User Authentication Module**: Robust signup and login via Firebase Auth. User state handled via ViewModels.
2. **Waste Logging System**: Allows users to log the type of waste (Organic, Plastic, E-Waste), add descriptions, and upload photos. Data is saved to Firestore.
3. **Pickup Scheduling**: Users can select custom dates and specify their address. Requests synchronize seamlessly to the admin dashboard.
4. **Recycling Center Locator**: Integrated Google Maps SDK showing exact pin-drops of nearby recycling plants and E-Waste processors.
5. **Admin / Municipal Dashboard**: Provides a real-time list of pending pickup requests, allowing municipal admins to mark them as completed as routes are executed.
6. **Reward System**: Gamified approach where each waste log adds +10 'Green Points'. Users can view their total on the dynamic dashboard and see redemption offers.
7. **Offline Support**: Handled via `hive` local NoSQL storage, guaranteeing users don't lose data tracking even in low-signal areas.

## 🧱 Architecture Decisions
- **Clean Architecture**: Separates models, repositories (data logic), services (Firebase/Hive wrappers), and viewmodels (state bridging), leading to highly testable code.
- **Provider**: Chosen for effective, non-boilerplate dependent state injection down the widget tree.
- **Firebase Firestore**: Chosen for its fast `snapshots()` real-time synching which perfectly handles the Admin Dashboard auto-updating when users log waste.

*(Note: Please export this Markdown file to a PDF using your IDE's 'Export to PDF' extension or a web converter, and name it `[YourStudentID]_ProblemStatement.pdf`)*
