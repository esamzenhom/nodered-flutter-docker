🐳 Node-RED + Flutter Docker Image
A Docker image combining Node-RED and the full Flutter SDK, perfect for prototyping automation systems, dashboards, or UI-backed logic flows with Flutter-powered web or mobile apps.

🔧 Features
✅ Pre-installed Node-RED (via npm)

✅ Pre-installed Flutter SDK (with flutter doctor run and dependencies cached)

✅ Volumes for persistent storage of:

Node-RED data

Flutter SDK

Pub package cache

Flutter build outputs

✅ Optimized for development and CI workflows

✅ Optionally supports Flutter Web out-of-the-box

📁 Project Structure
bash
Copy
Edit
.
├── Dockerfile             # Builds Node-RED + Flutter environment
├── docker-compose.yml     # Runs container with persistent volumes
└── README.md              # You are here
🚀 Getting Started
1. Clone the Repo
bash
Copy
Edit
git clone https://github.com/<your-username>/nodered-flutter-dev-env.git
cd nodered-flutter-dev-env
2. Build & Run with Docker Compose
bash
Copy
Edit
docker compose up --build -d
3. Access Node-RED
Open your browser:

arduino
Copy
Edit
http://localhost:1880
4. Use Flutter
To access the container and run Flutter commands:

bash
Copy
Edit
docker exec -it nodered_flutter bash
flutter doctor
flutter create myapp
cd myapp
flutter run -d web-server --web-port 8080
Then visit: http://localhost:8080

🔄 Volumes
Volume Name	Path in Container	Purpose
nodered_data	/data	Node-RED project and flows
flutter_sdk	/opt/flutter	Flutter SDK source
flutter_cache	/root/.pub-cache	Dart package cache
flutter_build	/root/build	Flutter build artifacts
android_home	/root/Android (optional)	Placeholder for Android SDK

📦 Publishing to GitHub Container Registry (Optional)
bash
Copy
Edit
docker tag nodered-flutter ghcr.io/<your-username>/nodered-flutter:latest
docker push ghcr.io/<your-username>/nodered-flutter:latest