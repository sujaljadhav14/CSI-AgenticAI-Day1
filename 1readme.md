# 🎓 AI Agent — Student Marks MCP Server

> A **Model Context Protocol (MCP)** server that connects Claude AI to a live MySQL student database hosted on XAMPP. Ask Claude natural-language questions about student performance and get real-time answers pulled directly from the database.

---

## 📌 What Is This Project?

This project is a **beginner-friendly MCP (Model Context Protocol) server** built as a hands-on workshop to demonstrate how AI agents can interact with real-world databases. It bridges **Claude Desktop** (or any MCP-compatible AI client) with a **PHP + MySQL backend** running on XAMPP.

Instead of writing SQL manually, you simply ask Claude:
- *"Who are the top 5 students?"*
- *"What are Rahul Sharma's marks?"*
- *"Give me a summary of how the class performed."*

Claude calls the right tool, queries the database, and returns a structured, readable answer.

---

## 🏗️ Architecture

```
Claude Desktop (AI Client)
        │
        │  MCP Protocol (stdio)
        ▼
  agent.py  ──────────────────────────────┐
  (FastMCP Server)                        │
        │                                 │
        │  HTTP GET requests              │
        ▼                                 │
  agent.php (PHP REST API)               │
        │                                 │
        │  MySQL queries                  │
        ▼                                 │
  ai_agent Database (MySQL / XAMPP)  ◄───┘
```

### Key Components

| File | Role |
|------|------|
| `agent.py` | MCP server — exposes tools to Claude via the MCP protocol |
| `agent.php` | PHP REST API — receives HTTP requests from Python and queries MySQL |
| `setup.sql` | Database schema + 20 sample student records |
| `claude_desktop_config.json` | MCP server registration config for Claude Desktop |

---

## 🛠️ MCP Tools (What Claude Can Do)

The MCP server exposes **4 tools** that Claude can call:

### 1. `get_all_students()`
Returns the full list of all students with their marks, grade, and details, ordered by total marks (highest first).

### 2. `search_student(name: str)`
Searches for a student by name (partial match supported). Returns their subject-wise marks and grade.

### 3. `get_top_students(limit: int = 5)`
Returns the top N students ranked by total marks. Defaults to top 5. Configurable.

### 4. `get_class_summary()`
Returns aggregated class statistics:
- Total number of students
- Class average marks
- Highest and lowest marks
- Pass / Fail count (pass threshold: 150 / 500)

---

## 🗄️ Database Schema

**Database:** `ai_agent`
**Table:** `students`

| Column | Type | Description |
|--------|------|-------------|
| `id` | INT (AUTO) | Primary key |
| `name` | VARCHAR(100) | Student full name |
| `roll_number` | VARCHAR(20) | Unique roll number (e.g., SE001) |
| `class` | VARCHAR(20) | Class name (default: SE-AI) |
| `maths` | INT | Marks out of 100 |
| `science` | INT | Marks out of 100 |
| `english` | INT | Marks out of 100 |
| `programming` | INT | Marks out of 100 |
| `dbms` | INT | Marks out of 100 |
| `total_marks` | INT (STORED) | Auto-calculated sum of all 5 subjects |
| `grade` | VARCHAR(5) | Grade (A+, A, B+, B, C, D, F) |
| `created_at` | TIMESTAMP | Record creation time |

The `setup.sql` file pre-loads **20 students** from the SE-AI class with realistic mark distributions.

---

## ⚙️ Tech Stack

| Layer | Technology |
|-------|-----------|
| AI Interface | Claude Desktop (MCP Client) |
| MCP Server | Python 3.11 + `FastMCP` (`mcp[cli]`) |
| HTTP Bridge | PHP 8.x (XAMPP) |
| Database | MySQL (XAMPP / phpMyAdmin) |
| Package Runner | `uv` (Python package manager) |

---

## 🚀 Setup & Installation

### Prerequisites
- [XAMPP](https://www.apachefriends.org/) with Apache + MySQL running
- [Claude Desktop](https://claude.ai/download) installed
- [`uv`](https://docs.astral.sh/uv/) Python package manager installed

### Step 1 — Set Up the Database
1. Open **phpMyAdmin** → `http://localhost/phpmyadmin`
2. Go to the **SQL** tab
3. Paste and run the contents of `setup.sql`
4. This creates the `ai_agent` database with 20 sample students

### Step 2 — Deploy the PHP API
The `agent.php` file should be at:
```
C:/xampp/htdocs/agent/agent.php
```
Verify it is accessible at:
👉 `https://localhost/agent/agent.php?action=get_students`

### Step 3 — Register the MCP Server with Claude
Copy the contents of `claude_desktop_config.json` and merge them into Claude Desktop's config file, typically at:
```
%APPDATA%\Claude\claude_desktop_config.json
```

The config registers this server:
```json
{
  "mcpServers": {
    "agentMCP": {
      "command": "uv",
      "args": ["run", "--python", "3.11", "--with", "mcp[cli]", "--with", "requests", "--with", "urllib3", "mcp", "run", "C:/xampp/htdocs/agent/agent.py"]
    }
  }
}
```

### Step 4 — Restart Claude Desktop
Restart Claude Desktop. You should see **agentMCP** in the tool list. Start asking questions!

---

## 💬 Example Prompts for Claude

```
"Show me all students sorted by their marks."
"Who scored the highest in programming?"
"Search for student named Priya."
"What is the class average and how many students failed?"
"Give me the top 3 performers."
```

---

## 📁 Project Structure

```
agent/
├── agent.py                   # MCP server (Python) — tool definitions
├── agent.php                  # PHP REST API — DB queries
├── setup.sql                  # Database schema + 20 seed records
├── claude_desktop_config.json # Claude Desktop MCP registration config
├── .gitignore
└── README.md
```

---

## 🔑 Key Concepts Demonstrated

- **Model Context Protocol (MCP)** — how AI agents expose tools to LLM clients
- **PHP as a REST API bridge** — lightweight data layer between Python and MySQL
- **FastMCP** — rapid MCP server development in Python
- **Real-time AI + Database integration** — no RAG, no embeddings, live SQL queries
- **Natural Language → SQL** — via Claude's reasoning over tool responses

---

## 📝 Notes

- SSL verification is disabled for `localhost` since XAMPP uses a self-signed certificate (`urllib3.disable_warnings`)
- The PHP API uses `real_escape_string()` for basic SQL injection prevention on search queries
- This project was built as a **workshop/educational project** to teach MCP concepts with a real database
