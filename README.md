# Cold Storage WMS (Flutter Technical Test)

A mini warehouse management app built using **Flutter 3.x** for the Frontend Technical Test.

This project simulates a simple **Cold Storage Warehouse Management System** (WMS) with real-time temperature monitoring, inbound item input, and inventory listing — all using mock API data.

---

## Features

### Dashboard
- Displays 3 cold rooms (COLD-01, COLD-02, COLD-03) with real-time temperature updates (polling every 5 seconds).  
- Highlights rooms with temperatures outside the safe range **(-20°C to -16°C)**.  
- Includes navigation buttons to **Inbound** and **Inventory** pages.

### Inbound (Incoming Goods)
- Form fields: **SKU, Batch, Expiry, Quantity, Location**  
- “Scan” button (simulated) to auto-fill SKU with dummy data.  
- Validation rules:
  - All fields are required.
  - Quantity must be > 0.
  - Expiry date must be today or later.
- Location dropdown is loaded from mock API.
- Submit button is **disabled** if the selected location is full (capacity reached).

### Inventory List
- Displays all inbounded items stored locally (in memory).  
- Searchable by **SKU** or **Location ID**.  
- Shows “Near Expiry” badge for items expiring in less than 30 days.

---

## Architecture Overview

The app follows a simple layered structure inspired by clean architecture principles:

lib/
├─ data/
│ ├─ models/ # Data classes (Temperature, Location, Item)
│ ├─ mock_data/ # Simulated API responses (MockService)
│
├─ domain/
│ └─ repositories/ # Business logic layer (InventoryRepository)
│
├─ presentation/
│ ├─ screens/ # UI for Dashboard, Inbound, Inventory
│ └─ widgets/ # Reusable components (TemperatureCard, ExpiryBadge)
│
├─ providers/ # State management using Provider
│
└─ main.dart # App entry point

## Tech Stack

| Layer | Tools / Libraries |
|-------|-------------------|
| Framework | Flutter 3.x (null-safety) |
| Language | Dart |
| State Management | [Provider](https://pub.dev/packages/provider) |
| Mock API | Local in-memory data via `MockService` |
| UI | Material 3 (M3) widgets |

---

## Mock API Endpoints (Simulated)

| Endpoint | Description | Example Response |
|-----------|--------------|------------------|
| `/temperatures` | Current cold room temperatures | `[{"room_id":"COLD-01","temperature":-18.3}]` |
| `/locations` | Active warehouse locations | `[{"id":"A1-01","capacity":100,"current_load":72}]` |
| `/inbound` | Simulated POST (adds to local state only) | `{ status: "OK" }` |

---

## How to Run

1. **Clone this repo**
   ```bash
   git clone https://github.com/<your-username>/cold_storage.git
   cd cold_storage

2. **Get dependencies**
    ```bash
    flutter pub get

3. **Run the app**
    ```bash
    Run the app

## Author

Syahrul Maulana [rulsyahrulmaulana@gmail.com]