Return-Path: <linux-efi+bounces-2844-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71631A47DEE
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 13:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107063B6968
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 12:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821E9230272;
	Thu, 27 Feb 2025 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gJjdIbz2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD6230270
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659811; cv=none; b=aLVfJKqveMAV4EBzAHrkI9CgJ22Y7Dx+yJZXvBDraFrg/8IfFuvxEeQzWwcrKb/GHpqamO5q0lRBl4NoUnoE1cazBtz+ZRVnz8ZYI3XNmvdqCULEaLuVUGbqklKHhJpG9moK5MpcKKwc/5YvtXLQaSi2bOuOoolRGTB8w+ULSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659811; c=relaxed/simple;
	bh=TlIOJZgzYRa0uSdvlZ7h4NFliLwrLJg52Wgu33BrOfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwbeIXe8ph9QwIenEW3Eet43TExLR4deHgOUHPAnqeaNGTHCWedRQwrNBj7I05F65Oze+LJ6scP/GvYRYZ79uZ9qNBMJ6jNx22FPVotHo6CZojBJUjjFRev5DbHdTGt/beg3xu1KSj+huHFw8Ec8ilnGcxqYtxDyMIIynMQRRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gJjdIbz2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22128b7d587so15302825ad.3
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 04:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659809; x=1741264609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFXZa2m3ScC7B7xgAgov/Ch2E5BoKfJoACxjrPDC6sE=;
        b=gJjdIbz2EjD91RRxj+IUpT6zqd+Cccc1k4kTMQ1C20i+bS6x+pLAIWglGh3MkboIYm
         2ALG1E2Z2SrdPGq74iq4w+WwKHyvUWijaBmivZae96ExuCIUoToTYKuNhiH4aIuBqEG/
         z5AnFZHqLzwxvyXfYX+sZcJ1FVqehJnH9Q5f0AYLH2mJzdlporhyiGTbjwhUdO7PUcrd
         VRs6e9p05LfHI+dbFl4G2uLjz97PjzgYVaujMGoHl0OgatV6g5NRLfxIrBtsb7slPfvq
         ZjtLr2O1CAoYDODgWsgCfW7H6WkAPvdos/01aw9TOeVgxr7qHsrDtUAR9ZKmWcIB10ko
         DX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659809; x=1741264609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFXZa2m3ScC7B7xgAgov/Ch2E5BoKfJoACxjrPDC6sE=;
        b=doTPi8+MfNZ03hSVr2GHo5fHFOg9OcfVziFRcKeZ3yL8iBPiI3bFXfCqK4LXU6Tgbe
         7WaUGd0lEeIxukh+l9XfRm1+aywlE5G0v2zo891IEx5I6hopqAPRKXFqYcQZb1L3QzSd
         0c9yvyXq8ohqzi6x9tJ8836t4hiA/UHGy1Nw8sRpMucE58Hx7ah4MEPTZD0JI+cYkk/U
         HWSAV2e9QGau6DQ3GDjlz7DZlXqUj+iBGCpFAxhL0GktdvcMdkDS/w6+pOZ4UBwcDd9c
         yLK8cwTvmOAwyJuhMg7fmVKFDqIpyV1n5K1pv5ydPBOgH+C5u62TQrae8nFCOxMhCGIr
         nghg==
X-Forwarded-Encrypted: i=1; AJvYcCXpTZHFujtU0Ybj3Nw1qTn1QnEWJGRD6ztA3Wte7f/OGBrms8lMkSm20c99srTGXctbatAsBzd9JEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrMCPLNOzUDB2wPF+uHKorHMG5Zhf3elJe7yU4vZSXqXhZ7+Rr
	Yv9RbO2ZU6fLKuYj4nISyKpZwy4LLj5soy6SuAmW56BWr300tBCkgffz8KPNAbM=
X-Gm-Gg: ASbGnctrIm6pwnR5yE4scjBrQJNoT2Ns8/OBQoOYAUR5FAboXFYRjKwyz6FxyH59fzJ
	ek84aygKAHWXdSo2fsObuI34GK5F/WXtqK+sSFjyOzGkkK/EBjWK+RK+9c/gm3UVVtUh74wFJJM
	9ngyjPMz8gPDfVgTdJdHyGfbEeTcNzD5U5MMGQsTzBk4OIMC5TvGd+AlgmTFOVNF5AbZCdbzx/d
	/e1f2Z7NitZyRe9Ls915SddOPuwRc4OM5FjSJuzL9iLfMPmg5Hx1qv5zEqNRSEIJHRL+ggY+eor
	jLvEZzVC0ChiyI2zfmofeJNDWWiCp2El60zh
X-Google-Smtp-Source: AGHT+IGIh9E0vXJbqDwy2DSU2gnNrcolcT0Umoa7eQqwP9lNhXHlny+mB50OGnl9ch8jNaDBTVMb8Q==
X-Received: by 2002:a17:902:f706:b0:215:b058:289c with SMTP id d9443c01a7336-22320061fd6mr98812585ad.8.1740659809295;
        Thu, 27 Feb 2025 04:36:49 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:36:49 -0800 (PST)
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
Subject: [RFC PATCH v1 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
Date: Thu, 27 Feb 2025 18:06:20 +0530
Message-ID: <20250227123628.2931490-3-hchauhan@ventanamicro.com>
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

ghes_map function uses arch_apei_get_mem_attribute to get the
protection bits for a given physical address. These protection
bits are then used to map the physical address.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..0c599452ef48 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -27,6 +27,26 @@ extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
 
+#ifdef	CONFIG_ACPI_APEI
+/*
+ * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
+ * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
+ * with a kernel command line parameter "acpi=nocmcoff". But we don't
+ * have this IA-32 specific feature on ARM64, this definition is only
+ * for compatibility.
+ */
+#define acpi_disable_cmcff 1
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	/*
+	 * Until we have a way to look for EFI memory attributes.
+	 */
+	return PAGE_KERNEL;
+}
+#else /* CONFIG_ACPI_APEI */
+#define acpi_disable_cmcff 0
+#endif /* !CONFIG_ACPI_APEI */
+
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
-- 
2.43.0


