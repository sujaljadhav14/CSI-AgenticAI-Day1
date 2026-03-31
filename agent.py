import requests
import urllib3
from mcp.server.fastmcp import FastMCP

# Disable SSL warnings for localhost (XAMPP uses self-signed cert)
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

mcp = FastMCP("agentMCP")

# ✅ Change this if your XAMPP runs on a different port
BASE_URL ="https://localhost/agent/agent.php"

# ──────────────────────────────────────────────
# TOOL 1: Get all students
# ──────────────────────────────────────────────
@mcp.tool()
def get_all_students():
    """Get the full list of all students with their marks and details."""
    try:
        response = requests.get(f"{BASE_URL}?action=get_students", timeout=10, verify=False)
        response.raise_for_status()
        return response.json()
    except Exception as e:
        return {"error": str(e)}

# ──────────────────────────────────────────────
# TOOL 2: Search student by name
# ──────────────────────────────────────────────
@mcp.tool()
def search_student(name: str):
    """Search for a specific student by name. Returns their marks and info."""
    try:
        response = requests.get(f"{BASE_URL}?action=search&name={name}", timeout=10, verify=False)
        response.raise_for_status()
        return response.json()
    except Exception as e:
        return {"error": str(e)}

# ──────────────────────────────────────────────
# TOOL 3: Get top performers
# ──────────────────────────────────────────────
@mcp.tool()
def get_top_students(limit: int = 5):
    """Get the top N students ranked by total marks. Default is top 5."""
    try:
        response = requests.get(f"{BASE_URL}?action=top&limit={limit}", timeout=10, verify=False)
        response.raise_for_status()
        return response.json()
    except Exception as e:
        return {"error": str(e)}

# ──────────────────────────────────────────────
# TOOL 4: Get class summary / statistics
# ──────────────────────────────────────────────
@mcp.tool()
def get_class_summary():
    """Get overall class statistics: average marks, highest, lowest, pass/fail count."""
    try:
        response = requests.get(f"{BASE_URL}?action=summary", timeout=10, verify=False)
        response.raise_for_status()
        return response.json()
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    mcp.run()