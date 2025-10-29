Return-Path: <linux-efi+bounces-5221-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3C1C1A114
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 12:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBBC56561C
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 11:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BF0328626;
	Wed, 29 Oct 2025 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Lln9hUDO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13215334684
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737276; cv=none; b=CCBqR+eM3VzDlvHVdulit7o28zc8Cm078W/caDUiQsfxNvdpGAxdwaiWaVmWkOmeSrKRuJFqrG+H6OOBqH76acx8TYcEstvbJ5bONZWY0UGtZkBv6BVj/KPJCo1/e3Mo6ohKHdW0OhPOlU+iLRps48U3ryI+lIxIHlddBlmIYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737276; c=relaxed/simple;
	bh=iaxzzzfbF/Bf+RL8UjVT7dkfdCOWfh0hkHaopBJWsmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utAGFoH7ffJczHXlM93ix3xs5h/TIxOHQFVGkrGC9S9ASJW5D6o4JM5Dp4T2dBtn0y1F0gvD03PBoOXt2faJCpIpFreeKwBVHBn0NQmAZv+qDrFo9hhFSDbZhVCrQ1XYNspZiJtiJB37mrFMXtHAwUHDbCFRsnf3+CUECLC9BfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Lln9hUDO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-340299fe579so2387091a91.2
        for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737269; x=1762342069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp1nIH/UcUWGrGQTMqAlrnMpZhTNysKVdYoaQCQ6E6E=;
        b=Lln9hUDOl4LwwPKXsuIvzKI4kpw2C0uJt9VM4hzCejTxVpKArQAyBcOGaYMBJTySvk
         U7LqWxj3s6f1Y7fPOouvLAONxuqbtfIY6kp1NF9W+lVSF2V3HFSN0fEyx01IbhZzTiBZ
         hBZyMXIrotqqYWsAyQMXcH93GNBGqCchb2feAs8QtCJ9ELAbhF+j/ixmh3a5PjlSWCeE
         b36RvFJkkErFk2PdyoGJ/D0nJmL87Uu+peU0DYdAOQtt85+nSUq396RifHjXvG5G4nhQ
         EzPx7s63hBWHW/+RNXo4KB1RyYagRx8iYVVV1rlrwLmApy9j+76Jk8o27FA51h1IXywt
         meUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737269; x=1762342069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kp1nIH/UcUWGrGQTMqAlrnMpZhTNysKVdYoaQCQ6E6E=;
        b=TbyI7fnW4fjORmgAd8idDd1nPZzrjHDKHAOZT97mbHuoMIrmFJ7IDPD/RuAEpckMdO
         gKVGVuXk6fp0cP1YoUW+dRcGZrfKdY2q6YDsxmCLQSVgmsNb06LTd8Vis8aTfdhUtZTn
         5iArQf8nI4bl/9vUQ3elFVC7lfbRv+CyR0oiO4236PbkwjCN96WtrXqPTsXeF3mgAs/t
         5pU8fU1BtJpQThsDUKiYXH13o7JS2dYj+V1arkEt85VExGilZIc+aZkAflYhTzKvydEV
         aAeAFXK/2Bs7jbiPPxT63vVYIYDZje9peF/nBJ1o22jB2M5eVO2meE2u4j7QthBXPZJD
         L2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlAYg8BfrH3xCp1dzO2HZo/Wl3dEtcO2pOciczfJV3377zLQBRitrqInSitFXCtq0wZ0agu4+oYnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0U5q2NcOYbw67QdKXxmjYUf4VqGNlkno+8VqYnMAn5pvIsi0
	MQwdJXczGlfk1sEvCDfFD0z8JK9aejJ3OvRO2BV/wsH7jSjZ3yVJnsRw9bH5sv+E/AE=
X-Gm-Gg: ASbGncsfM82foQMjbMXmLCcw5X7rTysVt1BMmIdW21vXMBqK0g5kRG5eqhn//gSamnx
	dYoSJl4deucymur+YJxNx/wNFy8pjlSAU5rYVFnd9mhTAN1U9XoobLt8/8iqYZoMPxwepKVLt2r
	XFvAybJi2nQo4SFd47xa4e9l05vBhzZJDEQ8KcM/iJXqjAqMfvml0LTnYAK4AYERCzuafz6rGny
	W1in8XfmCM6xRB75PtdEvliFiy2M5OR2HBpJ25y5NLWzbTwSPTf2iXnvjW2A5+MrqjdNBSsoqgM
	t+IpjOxEFH6G5LWWAwiyhaHMbGL9nZWJxanR6FsCUWEihMrTV0PdriPFFivKLLB/WZKFi5ZZCgX
	3bUyZKjBDoCPbl4zpl2nCt+1jC0DccXKkFXsRKr/uSfQURCXrz3rwK02TkeXOsUUS/45R32Efme
	Z7iohFkbRoKvzN9dGJFt3vvV+l5obV
X-Google-Smtp-Source: AGHT+IFARlQT4wxU5rIAA9JBJXOgqU4ng9/zvGb3HdF6wqemjXQ0P2gKhLivhx1oGEPscd3xyn6Eow==
X-Received: by 2002:a17:90b:5188:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-3403a2fece5mr2816754a91.33.1761737264495;
        Wed, 29 Oct 2025 04:27:44 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:44 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/10] riscv: Introduce HEST SSE notification handlers
Date: Wed, 29 Oct 2025 16:56:46 +0530
Message-ID: <20251029112649.3811657-9-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add config option to enable SSE in APEI. When it is enabled, functions
to register/unregister a ghes entry with SSE are avilable along with
low and high priority event handers. If a SSE notification type is
determined, a ghes common handler to handle an error event is registered.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/Kconfig |   5 ++
 drivers/acpi/apei/ghes.c  | 101 +++++++++++++++++++++++++++++++++-----
 2 files changed, 95 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 070c07d68dfb..ada95a50805f 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -46,6 +46,11 @@ config ACPI_APEI_SEA
 	depends on ARM64 && ACPI_APEI_GHES
 	default y
 
+config ACPI_APEI_SSE
+	bool
+	depends on RISCV && RISCV_SBI_SSE && ACPI_APEI_GHES
+	default y
+
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
 	depends on ACPI_APEI && MEMORY_FAILURE
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f2cbd7414faf..3c47249245d1 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -17,6 +17,8 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/err.h>
+#include <linux/riscv_sbi_sse.h>
 #include <linux/arm_sdei.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
@@ -97,6 +99,11 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
+#ifndef CONFIG_RISCV_SBI_SSE
+#define FIX_APEI_GHES_SSE_LOW_PRIORITY	__end_of_fixed_addresses
+#define FIX_APEI_GHES_SSE_HIGH_PRIORITY	__end_of_fixed_addresses
+#endif
+
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
@@ -1530,6 +1537,63 @@ static int apei_sdei_unregister_ghes(struct ghes *ghes)
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
@@ -1576,6 +1640,15 @@ static int ghes_probe(struct platform_device *ghes_dev)
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
@@ -1639,6 +1712,18 @@ static int ghes_probe(struct platform_device *ghes_dev)
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
@@ -1668,7 +1753,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 static void ghes_remove(struct platform_device *ghes_dev)
 {
-	int rc;
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
 
@@ -1702,16 +1786,11 @@ static void ghes_remove(struct platform_device *ghes_dev)
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


