# 🤖 AI Agent Workshop — Complete Setup Guide
## "Build Your Own Claude-Powered Database Agent"

---
## ⚠️ BEFORE THE WORKSHOP — Install These First

| Software | Download Link | Version |
|---|---|---|
| XAMPP | https://sourceforge.net/projects/xampp/files/XAMPP%20Windows/8.1.25/ | 8.1.25 |
| Python | https://www.python.org/ftp/python/3.11.8/python-3.11.8-amd64.exe | 3.11+ |
| Claude Desktop | https://claude.ai/download | Latest |
| VS Code | https://code.visualstudio.com/ | Latest |
---

## 📁 FOLDER STRUCTURE — Set This Up First

```
C:/xampp/htdocs/
    └── agent/
        ├── agent.py       ← Python MCP server
        └── agent.php      ← PHP API
```

Create a folder called `agent` inside `C:/xampp/htdocs/`  
Copy both `agent.py` and `agent.php` into it.

---

## 🛠️ STEP-BY-STEP SETUP

### STEP 1 — Install XAMPP
1. Run the XAMPP installer
2. Install with default settings
3. Open **XAMPP Control Panel**
4. Click **Start** next to **Apache**
5. Click **Start** next to **MySQL**
6. Both should show green "Running"

### STEP 2 — Set Up the Database
1. Open browser → go to: `http://localhost/phpmyadmin`
2. Click **SQL** tab at the top
3. Paste the entire contents of `setup.sql`
4. Click **Go**
5. You should see a table `students` with 20 rows ✅

### STEP 3 — Place PHP File
1. Copy `agent.php` into `C:/xampp/htdocs/agent/`
2. Test it: open browser → `https://localhost/agent/agent.php?action=get_students`
3. You should see JSON data of students ✅
   - If browser shows a warning about SSL → click "Advanced" → "Proceed anyway"

### STEP 4 — Set Up Python
Open VS Code terminal (Ctrl + `) and run:
```bash
pip install requests
pip install fastmcp
pip install uv
```

Copy `agent.py` into `C:/xampp/htdocs/agent/`

### STEP 5 — Configure Claude Desktop
1. Open Claude Desktop
2. Go to: **Settings → Developer → Edit Config**
3. Replace the file content with what's in `claude_desktop_config.json`
   - ⚠️ Make sure the path `C:/xampp/htdocs/agent/agent.py` is correct
4. **Completely close and reopen** Claude Desktop

### STEP 6 — Test the Agent
Open Claude Desktop and type:

> "Show me all students and their marks"

> "Who are the top 3 students?"

> "Search for student named Priya"

> "Give me a summary of the class performance"

If Claude gives real data from the database → **IT'S WORKING!** 🎉
---