# CSE 211 — Data Structures Term Project
## PROJ-13: Air Quality Sensor Network & Hotspot Tracker

<div align="center">
  <img src="https://yeditepe.edu.tr/themes/custom/yeditepe/logo.svg" width="120"/>
  <br><br>
  
  ![Language](https://img.shields.io/badge/Language-C++17-blue)
  ![Build](https://img.shields.io/badge/Build-Make-green)
  ![Status](https://img.shields.io/badge/Status-In%20Progress-orange)
</div>

### Project Summary
This project is a system designed to analyze data from city-wide air quality sensors, detect pollution hotspots, and track the movement of these hotspots over time.

**Important Note:** The use of STL containers (e.g., std::vector, std::map) is strictly prohibited in this project. All data structures (Graph, Hash Table, Heap, Linked List) have been implemented from scratch by the team using pointer-based logic.

### Team Members & Roles
* **Ceyda Şenay (ID: 20230702122):** Data Structures 
* **Hatice Aygan (ID: 20230702004):** Time Series & Memory Management 
* **Merve Naz Dikme (ID: 20240702031):** Algorithm & Core Logic 
* **Irmak Zehra Emri (ID: 20230703016-072):** Interface & Visualization 
* **Serra Pehlivanküçük (ID: 20240702111):** File I/O, Testing, and Integration 

---

### Project Structure


```text
project/
├── include/
│   ├── data_structures/  # Custom Data Structures (Graph, HashMap, Heap)
│   ├── core/             # Algorithms (HotspotDetector, AlertManager)
│   └── utils/            # Utilities (DataLoader)
├── src/                  # Source Code (.cpp)
├── tests/                # Integration Tests
├── data/                 # Sample JSON Data
└── libs/                 # External Libraries (nlohmann/json)