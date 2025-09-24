# Variables
CC ?= gcc
CFLAGS ?= -Wall -Wextra -g -std=c99
SRC_DIR := src
TEST_DIR := tests
OBJ_DIR := build/obj
BIN_DIR := build/bin
TARGET := $(BIN_DIR)/p8emu

SRC_FILES := $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))

TEST_SRC_FILES := $(wildcard $(TEST_DIR)/*.c)
TEST_BIN := $(BIN_DIR)/tests_runner

# Default target
all: $(TARGET)

# Create build directories if missing
$(OBJ_DIR) $(BIN_DIR):
	mkdir -p $@

# Compile source files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -Iinclude -c $< -o $@

# Link executable
$(TARGET): $(OBJ_FILES) | $(BIN_DIR)
	$(CC) $(CFLAGS) $^ -o $@

# Build and run tests
test: $(TARGET) $(TEST_BIN)
	$(TEST_BIN)

# Compile tests
$(TEST_BIN): $(TEST_SRC_FILES) $(OBJ_FILES) | $(BIN_DIR)
	$(CC) $(CFLAGS) -Iinclude $^ -o $@

# Clean build artifacts
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

.PHONY: all test clean
