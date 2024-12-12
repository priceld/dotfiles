#!/usr/bin/env node

async function main() {
  for await (const chunk of process.stdin) {
    const line = chunk.toString().trim();
    console.log(line);
    // Process the input line
  }
}

main();
