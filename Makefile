# ============================================================================
# CSE 211 - Data Structures Term Project
# ============================================================================

# ----------------------------------------------------------------------------
# 1. Compiler and Flags
# ----------------------------------------------------------------------------
CXX := g++
# -Ilibs: Required to locate the nlohmann/json library
CXXFLAGS := -std=c++17 -Wall -Wextra -g -Iinclude -Ilibs
LDFLAGS :=

# ----------------------------------------------------------------------------
# 2. Directory Definitions
# ----------------------------------------------------------------------------
SRC_DIR := src
INC_DIR := include
TEST_DIR := tests
BUILD_DIR := build
OBJ_DIR := $(BUILD_DIR)/obj
BIN_DIR := $(BUILD_DIR)/bin
LIBS_DIR := libs

# ----------------------------------------------------------------------------
# 3. Target Files
# ----------------------------------------------------------------------------
TARGET := $(BIN_DIR)/main
TEST_TARGET := $(BIN_DIR)/tests

# Source Files (.cpp)
SOURCES := $(shell find $(SRC_DIR) -name '*.cpp')
# Object Files (.o)
OBJECTS := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SOURCES))

# Test Files
TEST_SOURCES := $(shell find $(TEST_DIR) -name '*.cpp')
TEST_OBJECTS := $(patsubst $(TEST_DIR)/%.cpp,$(OBJ_DIR)/tests/%.o,$(TEST_SOURCES))

# Exclude main.o for the test build (to prevent multiple 'main' definition errors)
LIB_OBJECTS := $(filter-out $(OBJ_DIR)/main.o, $(OBJECTS))

# ----------------------------------------------------------------------------
# 4. Default Target (make)
# ----------------------------------------------------------------------------
.PHONY: all
all: directories $(TARGET)
	@echo "Build complete: $(TARGET)"

# ----------------------------------------------------------------------------
# 5. Directory Creation Rule
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
# 6. Dependency Download Rule (make deps)
# ----------------------------------------------------------------------------
.PHONY: deps
deps:
	@echo "Checking dependencies..."
	@mkdir -p $(LIBS_DIR)
	@if [ ! -f $(LIBS_DIR)/json.hpp ]; then \
		echo "Downloading nlohmann/json library..."; \
		curl -sL https://github.com/nlohmann/json/releases/download/v3.11.3/json.hpp -o $(LIBS_DIR)/json.hpp; \
		echo "Download complete: $(LIBS_DIR)/json.hpp"; \
	else \
		echo "nlohmann/json already exists."; \
	fi

# ----------------------------------------------------------------------------
# 7. Linking Main Program
# ----------------------------------------------------------------------------
$(TARGET): $(OBJECTS)
	@echo "Linking main program..."
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

# ----------------------------------------------------------------------------
# 8. Linking Test Program
# ----------------------------------------------------------------------------
$(TEST_TARGET): $(LIB_OBJECTS) $(TEST_OBJECTS)
	@echo "Linking test program..."
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

# ----------------------------------------------------------------------------
# 9. Compiling Source Code (.cpp -> .o)
# ----------------------------------------------------------------------------
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR)/tests/%.o: $(TEST_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# ----------------------------------------------------------------------------
# 10. Helper Commands
# ----------------------------------------------------------------------------
# Run the program (make run)
.PHONY: run
run: all
	@echo "Running program..."
	@./$(TARGET)

# Run tests (make test)
.PHONY: test
test: directories $(TEST_TARGET)
	@echo "Running tests..."
	@./$(TEST_TARGET)

# Clean build files (make clean)
.PHONY: clean
clean:
	@echo "Cleaning up..."
	@rm -rf $(BUILD_DIR)

# Memory Check (make memcheck)
.PHONY: memcheck
memcheck: all
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(TARGET)