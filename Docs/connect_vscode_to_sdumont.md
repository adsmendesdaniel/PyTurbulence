# Connecting VSCode to Santos Dumont (SDumont) Supercomputer

This tutorial explains how to connect Visual Studio Code (VSCode) to the Santos Dumont (SDumont) supercomputer login node via SSH, allowing you to edit files, run terminal commands, and submit SLURM jobs from within VSCode.

---

## Prerequisites

- ✅ You have an active SDumont user account.
- ✅ Your SSH public key is already registered on SDumont.
- ✅ You are able to connect via terminal using:

    ```bash
    ssh YOUR_USERNAME@sdumont.lncc.br
    ```

---

## 1. Install VSCode Remote SSH Extension

1. Open VSCode.
2. Go to the Extensions sidebar (`Ctrl+Shift+X`).
3. Search for: **Remote - SSH**.
4. Click **Install**.

---

## 2. Configure SSH for SDumont

1. Open a terminal on your local machine.
2. Edit your SSH config file:

    ```bash
    nano ~/.ssh/config
    ```

3. Add the following configuration (replace `YOUR_USERNAME` as needed):

    ```ssh
    Host sdumont
        HostName sdumont.lncc.br
        User YOUR_USERNAME
        IdentityFile ~/.ssh/id_rsa    # Use your actual private key file
        ForwardAgent yes
    ```

4. Save and exit (`Ctrl+O`, `Enter`, then `Ctrl+X`).

---

## 3. Connect to SDumont from VSCode

1. Press `Ctrl+Shift+P` (or `F1`) to open the Command Palette.
2. Type and select: **Remote-SSH: Connect to Host...**
3. Choose: `sdumont`

✅ VSCode will open a new window connected to the SDumont login node.

---

## 4. Working on SDumont via VSCode

Once connected, you can:

- ✔ Browse and edit files in your SDumont home directory.
- ✔ Open a terminal (`Ctrl+``) and use Bash as if you were on the login node.
- ✔ Submit SLURM jobs using:

    ```bash
    sbatch my_script.slurm
    ```

---

## 5. (Optional) Save a Workspace for Easy Reconnect

1. Go to **File → Save Workspace As...**
2. Save it as `sdumont.code-workspace` (or another name).
3. Open this workspace later to automatically reconnect.

---
