#!/bin/bash
# Replace Placeholder "${upstream}" with test env upstream "dummy_servers_html"
find . -type f -name ".conf" -exec sed -i 's/${upstream}/dummy_servers_html/g' {} +
