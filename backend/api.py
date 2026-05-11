from flask import Flask, request, jsonify
import joblib
import re

app = Flask(__name__)

# =========================
# Load Model + Vectorizer
# =========================
url_model = joblib.load("url_model.pkl")
url_vectorizer = joblib.load("url_vectorizer.pkl")


# =========================
# Rule-Based Detection Layer
# =========================
def rule_based_check(url):
    url_lower = url.lower()

    suspicious_keywords = [
        "login", "secure", "verify", "update",
        "bank", "paypal", "account", "password"
    ]

    keyword_hits = sum(1 for k in suspicious_keywords if k in url_lower)

    suspicious_patterns = [
        r"https?://.*paypal.*[^.]\.com",
        r"https?://.*login.*[^.]\.com",
        r"https?://.*secure.*[^.]\.com"
    ]

    pattern_hit = any(re.search(p, url_lower) for p in suspicious_patterns)

    score = keyword_hits + (2 if pattern_hit else 0)

    if score >= 2:
        return "PHISHING", "HIGH", True

    return None, None, False


# =========================
# Health Check
# =========================
@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"})


# =========================
# Main Prediction Endpoint
# =========================
@app.route("/predict_url", methods=["POST"])
def predict_url():
    data = request.get_json(silent=True) or {}
    url = (data.get("url") or "").strip()

    if not url:
        return jsonify({"error": "url is required"}), 400

    # -------------------------
    # Step 1: Rule-based check
    # -------------------------
    rule_verdict, rule_risk, rule_hit = rule_based_check(url)

    if rule_hit:
        verdict = rule_verdict
        risk_level = rule_risk
        confidence = 1.0
        signals = ["RULE_BASED"]
    else:
        # -------------------------
        # Step 2: ML Model
        # -------------------------
        X = url_vectorizer.transform([url])
        pred = int(url_model.predict(X)[0])

        if hasattr(url_model, "predict_proba"):
            confidence = float(max(url_model.predict_proba(X)[0]))
        else:
            confidence = 0.0

        if pred == 1:
            verdict = "PHISHING"
            risk_level = "HIGH"
        else:
            verdict = "SAFE"
            risk_level = "LOW"

        signals = ["AI_URL_MODEL"]

    # -------------------------
    # Response
    # -------------------------
    return jsonify({
        "engine": "PhishGuard-AI",
        "verdict": verdict,
        "risk_level": risk_level,
        "confidence": round(confidence, 2),
        "signals": signals,
        "note": "Hybrid detection (Rules + AI Model)",
        "url": url
    })


# =========================
# Run Server
# =========================
if __name__ == "__main__":
  import os
port = int(os.environ.get("PORT", 5000))
app.run(host="0.0.0.0", port=port)
