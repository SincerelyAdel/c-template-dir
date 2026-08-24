CC = gcc
CFLAGS = -O2 -Wall -Wextra -std=c11
SRC_DIR = src
INC_DIR = include
BUILD_DIR = build
BIN_DIR = bin

LIB_SRCS = $(filter-out $(SRC_DIR)/main.c,$(wildcard $(SRC_DIR)/*.c))
LIB_OBJ = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(LIB_SRCS))

BIN = $(BIN_DIR)/app
MAIN_OBJ = $(BUILD_DIR)/main.o

TEST_BIN_DIR = $(BIN_DIR)/tests
TEST_SRCS = $(shell find tests -name '*.c')
TEST_BINS = $(patsubst tests/%.c,$(TEST_BIN_DIR)/%,$(TEST_SRCS))

all: $(BIN)

$(BIN): $(MAIN_OBJ) $(LIB_OBJ) | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $(MAIN_OBJ) $(LIB_OBJ) -lm

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -I$(INC_DIR) -c -o $@ $<

$(BUILD_DIR)/tests/%.o: tests/%.c | $(BUILD_DIR)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -I$(INC_DIR) -c -o $@ $<

$(TEST_BIN_DIR)/%: $(BUILD_DIR)/tests/%.o $(LIB_OBJ) | $(BIN_DIR)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ $< $(LIB_OBJ) -lm

$(BUILD_DIR) $(BIN_DIR):
	mkdir -p $@

run: $(BIN)
	./$(BIN)

test: $(TEST_BINS)
	@ok=1; \
	for t in $(TEST_BINS); do \
		echo "== $$t =="; \
		./$$t || ok=0; \
		echo; \
	done; \
	test $$ok -eq 1

clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

.PHONY: all run test clean
