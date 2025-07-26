# 📌 Node Index Resolver

**🏷️ Name:** Node Index Resolver  
**🛠️ GIANTS Editor Version:** 10.0.5  

---

## 📖 What It Does

This GIANTS Editor script helps you quickly find and select any node in the Scenegraph by entering its index path.  
It resolves the node’s true ID, displays its name, selects the node in the Scenegraph, and refreshes the view immediately — all while keeping the tool open.

Perfect for modders debugging or referencing complex `.i3d` structures with custom `<i3dMapping>` paths.

---

## ✏️ How to Install & Use

### 1️⃣ Install the Script

Place the script file into this directory:
```
C:\Users\YOURNAME\AppData\Local\GIANTS Editor 64bit 10.0.5\scripts
```

Then launch GIANTS Editor and navigate to:  
**Scripts > User Scripts > Node Index Resolver**

---

### 2️⃣ Enter Your Index Path

In the UI window, enter the full index path you want to resolve.  
**Example:**
```
0>4|0|0|0|0|1|1
```

---

### 3️⃣ Click 'Search'

The tool will automatically:
- ✔️ Resolve the node path
- ✔️ Display the actual node name (ID)
- ✔️ Select the node in the Scenegraph
- ✔️ Refresh the Scenegraph instantly so the selection is visible

---

### 4️⃣ Use or Copy the Result

- Use the selected node directly in your scene.
- Copy the resolved name if needed for scripting or mapping.
- The window remains open for further lookups.
- Closing the tool will not deselect your last active node.

---

## ✅ Compatibility

- Fully tested with **GIANTS Editor 10.0.5**
- No external dependencies required

---

## 📂 Example Use Case

A mod may include this mapping:
```xml
<i3dMapping id="logGrabClawLeft" node="0>1|0|0|0|0|1|0|0|0|0|0" />
```

But the actual node in the `.i3d` file is named `clawLeft`.  
This tool helps resolve that difference instantly.

---

## 🧠 Credits

Developed by **GamerDesigns & Roughneck Modding Crew**  
Maintained and supported by the FS modding community


