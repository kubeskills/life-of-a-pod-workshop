## 🎓 Badge Submission Instructions — *The Life of a Pod and Its Network Footprint on LKE*

Thanks for participating in the KubeSkills workshop at **KCD Colombia**!

To receive your **verifiable badge (issued via Verix)**, please follow the steps below.

## ✅ What You Need to Show

Submit **one screenshot** (two if you want distinction):

1. **Required:**
    
    Run the following command from your namespace and show the output:
    
    ```bash
    curl -s http://app.${LB_IP}.sslip.io/hostname
    
    ```
    
    - Output should return your **pod hostname**.
    - This proves your pod is deployed and accessible through **Ingress + Service + Pod**.

2. **Optional (for distinction):**
    
    Capture your pod being removed from **endpoints** during termination. Run:
    
    ```bash
    kubectl -n <your-namespace> get endpoints web -w
    
    ```
    
    - Then delete one pod:
        
        ```bash
        kubectl -n <your-namespace> delete pod <pod-name>
        
        ```
        
    - Show the moment your pod is **removed from the endpoints list**.

## 📸 How to Submit

- Take a screenshot of your terminal output.
- Post your screenshot as a reply in the [Badge Submission thread](https://community.kubeskills.com/c/kcd-colombia-workshop-2025/) in the KubeSkills Community.
- Include your **namespace name** (e.g., `workshop-bogota`).

## 🎖️ What You’ll Earn

- **Standard Badge:** Proof of deployment + ingress request (curl output).
- **Badge with Distinction:** Deployment proof **and** lifecycle termination proof.

Your badge will be issued via **Verix** within 7 days of submission.

👉 **Pro Tip:** Make sure your screenshot shows both the **command** and the **output** clearly so we can verify it.