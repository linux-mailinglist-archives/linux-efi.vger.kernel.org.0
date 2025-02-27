Return-Path: <linux-efi+bounces-2850-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59185A47DFF
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 13:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BB01761F2
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 12:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95522DF92;
	Thu, 27 Feb 2025 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TTBTbf3p"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82058233152
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659842; cv=none; b=B9Zdwn0Ygeg/AXcqYCKpcwXqDCg8kWcW6wCJyOv31s0/qDHMHPKbHZtq3BOxe00AxCDQS4FJh9qJqCgetdqss4GiemxwmFgRhb0zIOXBVtXnSGTmAP8fCCXfMbMDpWXDkg4ncdPIKkVe+Pl8UBSpU/C4ZO3WemLOLdcZxKeBwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659842; c=relaxed/simple;
	bh=Q5uxxUx6KeY4zwC8bnmu7iQA3t7vZqPvLL2pQYA7C38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/t4V7d/3Gwufg96VQ/F+dVgw21/DywhETDO1Awkws83qla44T5nrBkTqext6qJ0VKZyitNQZf/h/qZfzjNm0Ni35a5InH2pYoXxaxlun6B4HzMCeFXq78js8d+qYPuisr7BInSHkqzketGCLyyba+lwsDdoCX2GvJYiwybjZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TTBTbf3p; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2235189adaeso9820735ad.0
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659840; x=1741264640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXVhLjcRoeCf2V/5WVQuQKEAR2qmhhl0hOLkmr0AsUA=;
        b=TTBTbf3p9mtat1hJOe3zuTTPvJL9QNYkfiejdQLuxo3foRymrjl6q3NvaSuNvubbz6
         lKZyeVVoOlpcIIfXDgMMfMCnfxliOYrzIKxqkN51GLfGNaDVBJYWV9SMk60h7HMAHbhR
         0VGpm5KvRUDppIElj36N1xcQd8HllUVWoiYFfKGdBHl3x1go1hAsvzOIX4bGA4ZXXOHh
         wM6aj6ZLpAJiAskOk8DLmmuhvSVGgJ0xJVh9+cQTLWQWslzViJa4SxgTgNQCIQr4ez0e
         xVHapLBSXizZLuBTcnrvfN7LKUZ0LA9TR70al96awVWiefgAOzMdekDbZSDR3uFo//TE
         y+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659840; x=1741264640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXVhLjcRoeCf2V/5WVQuQKEAR2qmhhl0hOLkmr0AsUA=;
        b=Fu+1ckI6mT6mKbZ9xecehBk98KN8N8CJtYnfwNUMjGa6LtCbCjlcez2C+vgA6s/AD1
         NCniXBmxy2pSejMmfvTq+/T6gq0FDV5Xqr31BWlhB3GLDldC9fj88doL5i0gGQqwn3jS
         AVMrA2kLdMmReLwKeXYcOVO9vsmnx7/gVb0joZz1rJbb29g0WLT4F2yAENBopepbWdJC
         YeCaxUVyHzrejwmYr09KAv9dX/2GrUHpZFu1M+GPtYjugHtj0ELIAkWPLWOWGY+mQ9TY
         NnNhYpYZlGt5VKe0bgJtl2omBHdhVKEyHn75lzRMNBGQADW77SYXaWhIYQOGbIh3F8QP
         JTSA==
X-Forwarded-Encrypted: i=1; AJvYcCVeHDpp1KHnho4TrJySMu8JOksa8yHqPi16HuliOxn1rVbTWL740FkWZEJhn6z8a/d/22WfRXuLAmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQH7LthSE3myCQcZjr6eMzJe5ZpDqvV5KYiqeE8bObnoKD+vv8
	w9H/k5baKoiHIhQ6V5hILnoSNABuyxvStaNSId5vMAtpQHzOMTW021qSUGl4jgg=
X-Gm-Gg: ASbGncvhdOjMnR5377qPduBA9bUkiXd6eGJ0922gn4o8OcAlV4x+Ze8vHGvlUlOm6Rw
	lTw17FYee4cj3TGstbM9cNacUgMaMpXaUd1N5T6/SyX/C72LfAeGthFtyizoxM6rCTYQ6PV6j9r
	8Kpwto+H/KMYGqJuEEqvX0ViGVoiOWg5EFJtbrKbI+P1TTZ69ykFUJaes6xD2hDLBfkSaxduQRe
	IXWp4g9ve/cXK3I9WUjGmU/+QF5uxQ297kDhXq/TQWx3OL+dwvNVHYY3zx4T9zXfyJOXz41f+fI
	xwzNz0TppHSwnqPKFLEdFg/ip9fUypPIFkve
X-Google-Smtp-Source: AGHT+IE/pZ3e6JonJxeQe62tq8o12LGMwm5f6Ts5InGRCEUeYVZmSfCnd9ZWVdPIH36ibrRnGp55zA==
X-Received: by 2002:a17:902:d507:b0:21f:1348:10e6 with SMTP id d9443c01a7336-2234a57fd4fmr60713595ad.13.1740659839830;
        Thu, 27 Feb 2025 04:37:19 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:19 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 08/10] riscv: Introduce HEST SSE notification handlers
Date: Thu, 27 Feb 2025 18:06:26 +0530
Message-ID: <20250227123628.2931490-9-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Functions to register a ghes entry with SSE
- Add Handlers for low/high priority events
- Call ghes common handler to handle an error event

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/ghes.c | 100 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8a1029163799..59abb89d3547 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -17,6 +17,7 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/riscv_sse.h>
 #include <linux/arm_sdei.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
@@ -97,6 +98,11 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
+#ifndef CONFIG_RISCV_SSE
+#define FIX_APEI_GHES_SSE_LOW_PRIORITY	__end_of_fixed_addresses
+#define FIX_APEI_GHES_SSE_HIGH_PRIORITY	__end_of_fixed_addresses
+#endif
+
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
@@ -1405,6 +1411,63 @@ static int apei_sdei_unregister_ghes(struct ghes *ghes)
 	return sdei_unregister_ghes(ghes);
 }
 
+#if defined(CONFIG_ACPI_APEI_SSE)
+/* SSE Handlers */
+static int __ghes_sse_callback(struct ghes *ghes,
+			       enum fixed_addresses fixmap_idx)
+{
+	if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx)) {
+		irq_work_queue(&ghes_proc_irq_work);
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+/* Low priority */
+static int ghes_sse_lo_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_lo);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_lo);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_LOW_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_lo);
+
+	return err;
+}
+
+/* High priority */
+static int ghes_sse_hi_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_hi);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_hi);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_HIGH_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_hi);
+
+	return err;
+}
+
+static int apei_sse_register_ghes(struct ghes *ghes)
+{
+	return sse_register_ghes(ghes, ghes_sse_lo_callback,
+				 ghes_sse_hi_callback);
+}
+
+static int apei_sse_unregister_ghes(struct ghes *ghes)
+{
+	return sse_unregister_ghes(ghes);
+}
+#else /* CONFIG_ACPI_APEI_SSE */
+static int apei_sse_register_ghes(struct ghes *ghes) { return -ENOTSUPP; }
+static int apei_sse_unregister_ghes(struct ghes *ghes) { return -ENOTSUPP; }
+#endif
+
 static int ghes_probe(struct platform_device *ghes_dev)
 {
 	struct acpi_hest_generic *generic;
@@ -1451,6 +1514,15 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		pr_warn(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
 			generic->header.source_id);
 		goto err;
+	case ACPI_HEST_NOTIFY_SSE:
+		if (!IS_ENABLED(CONFIG_ACPI_APEI_SSE)) {
+			pr_warn(GHES_PFX "Generic hardware error source: %d "
+				"notified via SSE is not supported\n",
+				generic->header.source_id);
+			rc = -ENOTSUPP;
+			goto err;
+		}
+		break;
 	default:
 		pr_warn(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
 			generic->notify.type, generic->header.source_id);
@@ -1514,6 +1586,18 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		if (rc)
 			goto err;
 		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		rc = apei_sse_register_ghes(ghes);
+		if (rc) {
+			pr_err(GHES_PFX "Failed to register for SSE notification"
+			       " on vector %d\n",
+			       generic->notify.vector);
+			goto err;
+		}
+		pr_err(GHES_PFX "Registered SSE notification on vector %d\n",
+		       generic->notify.vector);
+		break;
 	default:
 		BUG();
 	}
@@ -1543,7 +1627,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 static void ghes_remove(struct platform_device *ghes_dev)
 {
-	int rc;
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
 
@@ -1577,16 +1660,11 @@ static void ghes_remove(struct platform_device *ghes_dev)
 		ghes_nmi_remove(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
-		rc = apei_sdei_unregister_ghes(ghes);
-		if (rc) {
-			/*
-			 * Returning early results in a resource leak, but we're
-			 * only here if stopping the hardware failed.
-			 */
-			dev_err(&ghes_dev->dev, "Failed to unregister ghes (%pe)\n",
-				ERR_PTR(rc));
-			return;
-		}
+		apei_sdei_unregister_ghes(ghes);
+		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		apei_sse_unregister_ghes(ghes);
 		break;
 	default:
 		BUG();
-- 
2.43.0


