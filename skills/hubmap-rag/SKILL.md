---
name: hubmap-rag
description: RAG over HuBMAP-related PDFs using the local FAISS index and OpenAI embeddings. Use for questions that mention HuBMAP docs, policies, or data, or when you need to index/search PDFs stored in `servers/pdfs` via the `update_index` and `search_pdfs` MCP tools.
---

# HuBMAP RAG

## Overview

Index and search HuBMAP PDFs with a local FAISS vector store to support RAG-style answers, grounded in `servers/pdfs` content.

## Workflow

1. Confirm prerequisites. PDFs are stored in `servers/pdfs`, `OPENAI_API_KEY` is available for embeddings, and the MCP server running `servers/pdf_server.py` is available so tools can be called.
2. Ensure the index is ready. Call `update_index` once if the index is missing or PDFs changed. The FAISS index is stored at `servers/pdfs/pdf_index`.
3. Retrieve passages. Call `search_pdfs` with the user's query and optional `k` (default `3`). Use the returned `pdf`, `page`, and `excerpt` fields to ground the answer.
4. Respond with RAG-style output. Cite which PDF and page each excerpt came from. If results are empty or irrelevant, ask for a narrower query or confirm the PDFs are present.

## Tool Notes

- `update_index()` scans `servers/pdfs` and builds/updates the FAISS index.
- `search_pdfs(query: str, k: int = 3)` returns a list of dicts with `pdf`, `page`, and `excerpt`.

## Example Triggers

- "Search the HuBMAP policy documents for data retention rules."
- "What do the HuBMAP docs say about tissue data formats?"
- "Find passages about HuBMAP data access policy."
