# ============================================================================
# CSE 211 - Data Structures Term Project
# ============================================================================

# ----------------------------------------------------------------------------
# 1. Derleyici ve Bayraklar
# ----------------------------------------------------------------------------
CXX := g++
# -Ilibs: nlohmann/json kütüphanesini bulması için gerekli
CXXFLAGS := -std=c++17 -Wall -Wextra -g -Iinclude -Ilibs
LDFLAGS :=

# ----------------------------------------------------------------------------
# 2. Klasör Tanımları
# ----------------------------------------------------------------------------
SRC_DIR := src
INC_DIR := include
TEST_DIR := tests
BUILD_DIR := build
OBJ_DIR := $(BUILD_DIR)/obj
BIN_DIR := $(BUILD_DIR)/bin
LIBS_DIR := libs

# ----------------------------------------------------------------------------
# 3. Hedef Dosyalar
# ----------------------------------------------------------------------------
TARGET := $(BIN_DIR)/main
TEST_TARGET := $(BIN_DIR)/tests

# Kaynak Dosyalar (.cpp)
SOURCES := $(shell find $(SRC_DIR) -name '*.cpp')
# Nesne Dosyaları (.o)
OBJECTS := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SOURCES))

# Test Dosyaları
TEST_SOURCES := $(shell find $(TEST_DIR) -name '*.cpp')
TEST_OBJECTS := $(patsubst $(TEST_DIR)/%.cpp,$(OBJ_DIR)/tests/%.o,$(TEST_SOURCES))

# Test build'i için main.o'yu hariç tut (çakışma olmasın diye)
LIB_OBJECTS := $(filter-out $(OBJ_DIR)/main.o, $(OBJECTS))

# ----------------------------------------------------------------------------
# 4. Varsayılan Hedef (make)
# ----------------------------------------------------------------------------
.PHONY: all
all: directories $(TARGET)
	@echo "Derleme tamamlandi: $(TARGET)"

# ----------------------------------------------------------------------------
# 5. Klasör Oluşturma Kuralı
# ----------------------------------------------------------------------------
.PHONY: directories
directories:
	@mkdir -p $(OBJ_DIR)/core
	@mkdir -p $(OBJ_DIR)/utils
	@mkdir -p $(OBJ_DIR)/data_structures
	@mkdir -p $(OBJ_DIR)/tests/integration
	@mkdir -p $(BIN_DIR)
	@mkdir -p $(LIBS_DIR)

# ----------------------------------------------------------------------------
# 6. Bağımlılıkları İndirme Kuralı (make deps) - SENİN GÖREVİN
# ----------------------------------------------------------------------------
.PHONY: deps
deps:
	@echo "Bagimliliklar kontrol ediliyor..."
	@mkdir -p $(LIBS_DIR)
	@if [ ! -f $(LIBS_DIR)/json.hpp ]; then \
		echo "nlohmann/json kutuphanesi indiriliyor..."; \
		curl -sL https://github.com/nlohmann/json/releases/download/v3.11.3/json.hpp -o $(LIBS_DIR)/json.hpp; \
		echo "Indirme tamamlandi: $(LIBS_DIR)/json.hpp"; \
	else \
		echo "nlohmann/json zaten mevcut."; \
	fi

# ----------------------------------------------------------------------------
# 7. Ana Programı Linkleme
# ----------------------------------------------------------------------------
$(TARGET): $(OBJECTS)
	@echo "Ana program linkleniyor..."
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

# ----------------------------------------------------------------------------
# 8. Test Programını Linkleme
# ----------------------------------------------------------------------------
$(TEST_TARGET): $(LIB_OBJECTS) $(TEST_OBJECTS)
	@echo "Test programi linkleniyor..."
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

# ----------------------------------------------------------------------------
# 9. Kaynak Kodları Derleme (.cpp -> .o)
# ----------------------------------------------------------------------------
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR)/tests/%.o: $(TEST_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# ----------------------------------------------------------------------------
# 10. Yardımcı Komutlar
# ----------------------------------------------------------------------------
# Programı çalıştır (make run)
.PHONY: run
run: all
	@echo "Program calistiriliyor..."
	@./$(TARGET)

# Testleri çalıştır (make test)
.PHONY: test
test: directories $(TEST_TARGET)
	@echo "Testler calistiriliyor..."
	@./$(TEST_TARGET)

# Temizlik (make clean)
.PHONY: clean
clean:
	@echo "Temizlik yapiliyor..."
	@rm -rf $(BUILD_DIR)

# Memory Check (make memcheck)
.PHONY: memcheck
memcheck: all
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(TARGET)