

Here is a quick step-by-step guide on push pull through VS code!
---

# Always Pull First!
Before you write a single line of code, always make sure you have the latest version of the project:
1. Open **VS Code**.
2. Open the **Source Control** tab on the left sidebar (looks like a branching tree icon with three circles that are connected).
3. Click the **...** (three dots) menu at the top of the panel and select **Pull**.

---

##  Step 1: Create a Branch for Your Work
Never work directly on the `main` branch when making new edits or adding features.

1. Look at the bottom-left corner of VS Code (it usually says `main`).
2. Click **`main`** ➔ select **Create Branch...**
3. Name your branch after what you are building (e.g., `add-about-page` or `fix-footer-css`).
4. Press `Enter`.

---

## 💾 Step 2: Save, Stage, and Commit Your Edits
As you write code, remember to save your files (`Ctrl + S` or `Cmd + S`).

1. Open the **Source Control** tab on the left.
2. Type a short message in the text box explaining what you changed (e.g., "Added logo to header").
3. Click the blue **Commit** button.

---

## 📤 Step 3: Send Your Branch to GitHub
Once your edits are committed:

1. Click the blue **Publish Branch** (or **Sync Changes**) button in the Source Control panel.
2. This uploads your branch and save point to GitHub without touching the live website code.

---

## 📩 Step 4: Propose Your Changes (Pull Request)
To merge your branch into the main project:

1. Go to our repo
2. Click the yellow banner at the top that says **"Compare & pull request"**.
3. Write a brief note about what you built.
4. Click **Create pull request**.
5. Once we review the code together, click **Merge pull request** to update the main branch

---

##  Quick Cheatsheet
* **Pull:** Download the newest project updates to your computer.
* **Branch:** Your workspace to build features safely seperate from main.
* **Commit:** Create a local save point with a message.
* **Push:** Send your save points up to GitHub.
* **Pull Request (PR):** Suggest merging your branch into `main`.
