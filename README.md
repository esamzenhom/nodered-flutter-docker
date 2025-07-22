# Node-RED + Flutter Web Docker Image

This Docker image provides an environment to run [Node-RED](https://nodered.org/) alongside [Flutter](https://flutter.dev/) for building and deploying Flutter Web applications.  
Optionally, it can include **Google Chrome** for web testing (`flutter run -d chrome` and `flutter test`).

---

## 📦 Features

- Node.js 20 (based on `node:20-bullseye-slim`)
- Node-RED (installed globally)
- Flutter SDK (Web support enabled)
- OpenJDK 17 (for Android builds, optional)
- Optional Google Chrome (for development & testing)
- Entrypoint script to manage environment startup

---

## 🐳 Usage

## Build the Docker image

```bash
docker build -t nodered-flutter .
To enable Chrome support, make sure the Dockerfile includes the relevant Chrome installation block.

Run the container
bash
Copy
Edit
docker run -p 1880:1880 -v $(pwd)/data:/data nodered-flutter
Node-RED will be available at: http://localhost:1880

Flutter can be used from within the container for flutter build web

🚀 Flutter Commands
Inside the container:

bash
Copy
Edit
# Check flutter setup
flutter doctor

# Build web output
flutter build web

# (Optional) Run on Chrome (only if Chrome is installed)
flutter run -d chrome
🔍 Healthcheck
The image includes a HEALTHCHECK to verify that Flutter is installed and working:

dockerfile
Copy
Edit
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD [ -x /opt/flutter/bin/flutter ] && /opt/flutter/bin/flutter --version || exit 1
📁 Project Structure
graphql
Copy
Edit
.
├── Dockerfile
├── entrypoint.sh
├── README.md
└── data/              # Your persistent Node-RED data
🛠 Requirements
Docker

(Optional) Volume mount for /data if you want persistence
