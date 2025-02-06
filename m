Return-Path: <linux-efi+bounces-2762-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E6AA2A9A1
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 14:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E55169A61
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD3D2451E8;
	Thu,  6 Feb 2025 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eg+qu9yA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C254D246350
	for <linux-efi@vger.kernel.org>; Thu,  6 Feb 2025 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848022; cv=none; b=UliizaGbIN0vc5kmGenhz9FbggmZlhSafnYRDAROnAzB9I/PNtLnh1s1ej8lwPB65GV1U1IkLIiM1Bhd8jdd+wAoB5Wx2ZZ6GDyKo/+UMYKrYO9x45KAghwZSqQmZfww9r13qNa5a3IbHRI5gE0gry6wGpiGWZ3L190fV1m9fXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848022; c=relaxed/simple;
	bh=CyIeWg1B56bF5Vmqh8TDQAwEQXNhWeXPgR5Lr1nU1/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qikk0za1uVVq0mEMwB151vtEl1WhOx5Uvuzwb04Zmr+8JUAOk1DWtAEKVxzR63JZ8y9VjROAf+nadWaVd6g1TyfTdsUzZ0A2LHBiHVBwUGXKXcsr3nw8v7L1WhebLc9kXtd17vR//zP3W+tsXcFnrDkt5q3rSqsiXBvU6kV0BmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eg+qu9yA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-219f8263ae0so17777195ad.0
        for <linux-efi@vger.kernel.org>; Thu, 06 Feb 2025 05:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738848020; x=1739452820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrDRN4Xst5SkS3JM77fVw4KRP+DFTnf94c/mEjZvbjk=;
        b=eg+qu9yAsAzJDEX9+JXlClGz1m7Gc05X5dBgSrNoglXdhWf2AVqQFP0xHR0sSRC0DY
         3uUJjDrUJIVAFHXQkZaRXBtN83yv5nwvjZpsUrqsBVux+NCgUi15YWhJpeEfjtTqEB8o
         lAhUk+zY8Pm72KMizOEozBuNLpIwZQNR/GVNK5sysCWnbnDcEFJpO8NNLxpVoP8Qow/I
         m/5AegbmL63tr+Qpml4TBAMmKIBahd56/nNY40Qc5NH2/UV4zgcrRSfBZIJPE0snYbjo
         yxFEcD+pOaJlHM1cH0J7KDWegyDr0Yd4ODq2lJeF7w8Jq/Cl5BA4X+Ljm4DQFYKQbtJe
         LRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738848020; x=1739452820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrDRN4Xst5SkS3JM77fVw4KRP+DFTnf94c/mEjZvbjk=;
        b=FtY509ZHgcJydOpwcX8YDgA9hg6TgqCM+X377f0R/67ITojvS2gM0qNJpiVofpVtQ/
         godeq3eTMV5XU5gVB7cgwUUen9Jq81jYEmNi2tvKTYtWYZihtH9YQy26oA26/rEYlpId
         Kw/cKZRzEr8j5Hz1nJ4wAWpC/dLfvQut7lUJgFRWp8hudMNzWx/3chAZElNd+Rn0Vaku
         pLfEUCLHAfUBju6XBbJCu+EbrFh6vjAniHBRBlKF4B0Y0pRMsaJdj2dNCqOlHysjpFiE
         l4c6xPkBQcV4viRiWGVQIOgcXNJEeLEOPtcHvaIfanMFC4k2jNwVW6mPuc5WQn+Jj1+g
         v/uw==
X-Forwarded-Encrypted: i=1; AJvYcCUq+pROUlnPq6D+spXrlv1L3u0CFZUZgiJAkm6KUy95Bea7X4+/Dvase8gqUUtBd6EFyfrP+DF5bv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8SDJnsVY3vzw/1paZ1qZt3hQKy1wbTHPWB2saeWZlp5EnsZf
	4Av967acVouV4Eddyl342YPUB/9MXpotZb9frsre0p6j6opu1CCeOCn6lIGWQrE=
X-Gm-Gg: ASbGnctUM+Xu0dwKQWbabTGkxzomqyNIBUrNazqJgTx5S8+2vHu61/Sr2g6mIXrd0O2
	wbabdws9JDbgd29gDg3EAOFABHXV85KHwICBGfmi01W/kC7en7uBm9ZZL78QH9gho0YtLlf8y8s
	xGESsWt2/CQdjbO8C+2x3mXCEcHYpPNi9Gshqqgq99tL79SZFRd/GVb6TTMXJXhMiXfjjAQispg
	QnZ5Gabupr3KEIGNGwLhpTp0TWVubIkagi8lzyuTz3t1m98m7FYm2pe3VCFD15DmQLVVDL0XyEs
	maW4NEkZ45pngtuyUA==
X-Google-Smtp-Source: AGHT+IFoKcEdPqNHWZEzdZAOUsizoappgIzPDtN89x/XcnGf3N+z1xzF2ftk+OYeq3D0U9lyU9Xq3Q==
X-Received: by 2002:a17:903:2406:b0:215:8dd3:536a with SMTP id d9443c01a7336-21f17e2a49fmr111715285ad.4.1738848019982;
        Thu, 06 Feb 2025 05:20:19 -0800 (PST)
Received: from L4CR4519N7.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d987sm12170775ad.120.2025.02.06.05.20.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Feb 2025 05:20:19 -0800 (PST)
From: Rui Qi <qirui.001@bytedance.com>
X-Google-Original-From: Rui Qi
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	haibo1.xu@intel.com,
	guohanjun@huawei.com,
	sunilvl@ventanamicro.com,
	samuel.holland@sifive.com,
	parri.andrea@gmail.com,
	ericchancf@google.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Subject: [RFC 4/5] RISC-V: ACPI: define arch_apei_get_mem_attribute
Date: Thu,  6 Feb 2025 21:19:25 +0800
Message-Id: <20250206131926.91289-5-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250206131926.91289-1-qirui.001@bytedance.com>
References: <20250206131926.91289-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rui Qi <qirui.001@bytedance.com>

we need arch_apei_get_mem_attribute to get protection bits
for a given physical address. These protection
bits are then used to map the physical address.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 arch/riscv/include/asm/acpi.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..c35dd4e5a84d 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -90,6 +90,24 @@ static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
 
 #endif /* CONFIG_ACPI */
 
+#ifdef CONFIG_ACPI_APEI
+/*
+ * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
+ * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
+ * with a kernel command line parameter "acpi=nocmcoff". But we don't
+ * have this IA-32 specific feature on RISC-V, this definition is only
+ * for compatibility.
+ */
+#define acpi_disable_cmcff 1
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	return PAGE_KERNEL_IO;
+}
+
+#else
+#define acpi_disable_cmcff 0
+#endif
+
 #ifdef CONFIG_ACPI_NUMA
 void acpi_map_cpus_to_nodes(void);
 #else
-- 
2.20.1


