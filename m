Return-Path: <linux-efi+bounces-5215-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102F9C1A102
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 12:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3293BEFD6
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E5232E13A;
	Wed, 29 Oct 2025 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="em1SahIN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B0333720
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737235; cv=none; b=tJ0RroVzsS0rg+t5xxtF44cv0vqPEpOuGzcqj8OGSz5govXZXlPzOd4hwcWBlfZhuq1d92D1H0cec8g2j14rDG582Iok0BPrWUOE7pzQuy8LTlCgfjOgde+LDyz2gQazad5PA48f2ac1HjF2b9xxsvWSaC9x6zekdANFzSLh8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737235; c=relaxed/simple;
	bh=TlIOJZgzYRa0uSdvlZ7h4NFliLwrLJg52Wgu33BrOfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ks1YZtnVyaN3sGr1CBi93eeHdz/vxzr1Y38oQyjU3ChR4lhL6WUA5ArME7GXvStdHr2pSVCENzN/bTSCZjNZmADBk/v0ZB78ER+XW4poua3mPxGgEOki0rA0QkFzjc5lmstPyZ1J0us9vrV8QgJGDHg/VsKMotnD5RxXE2t/gdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=em1SahIN; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33d896debe5so7876681a91.0
        for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737233; x=1762342033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFXZa2m3ScC7B7xgAgov/Ch2E5BoKfJoACxjrPDC6sE=;
        b=em1SahINqI9aligF0Gu6ZxnaWEOy3AyeSt/BH5otjJ5N6Guxb7T15aPyvpikXyvIOB
         PAeaK7x1ebaA5l0tbRtFEaG7oXzbwrNdWN8v2fHuDlqgAvP689okJocJHrhvo1A+O8yQ
         T/oV5Gv+Ciu7mu/HNX2mwh7t1eLXVArP4yCkOSvDVyNtyQD0hi/CCWueL+EcFMWvTIeo
         WdQtEdz5iUmh3hXRi/sXCIAAxSuajDs6gBPT3Bv7V8xCgC5GV2eNvJnqQoMeaBFRlsWM
         6U2wnjBM7fkqNILfUm/hlm1nJcseJ7oEcaXv8QY/7XZpEavz1infr969bu7OPiCyWGU8
         VkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737233; x=1762342033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFXZa2m3ScC7B7xgAgov/Ch2E5BoKfJoACxjrPDC6sE=;
        b=Qm50f8itwTl2d0yFHeyNrn2Z4LsUgOQOgIF200PRK8K0fpZ7rcDRQ7yBHThIv0AXlI
         ZXzdPjLdCmLvQBw9YXcstJh3BcXuF6ls4BV6lVj4kGWCJ6l0YCBOCUabhJKLK18cbR5+
         YWVVS0+T6LdIEYDv3QwK5OjmMnMyFt/rAFob8mzKxnsqWX9dHVsIkTsfFI2o/H/yq4zL
         sQjvNbGBZwSflZdg/06GN4neG3Uh+VE1pugi/sJsHHwt789L/8nsRe9yMUbLQz1ouHjP
         CZKb62ywFL4HULZ3DbkQMtQqOcljsu33ddNtUMiQq7XmvdnUljKZsQukOIiO4ucamadp
         nF/A==
X-Forwarded-Encrypted: i=1; AJvYcCWWGw/x0efjimpPcXtU1SLd+Ua4Vq5Qr/u/j64GII/wqM+vlkmuFLPbnacU/dS8UJ7JbJEL0OHqWgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZjodno5fPIX56l7ShyZJ7A7e/IFKNOaTd3b9DFzyP3GdM5zDI
	nEQBFtSfrYhICSJ0mMam9UUjeRgQ/IexyUxdTNEYC32yiG8aDgPwGT4F3KgbV04PtPY=
X-Gm-Gg: ASbGncuTSgyQpBPtHC+QNQRmt9KzykRS1tYTbG/yZOJTVsaRjDq1qwFaTzVvICfwUUv
	M7MhV4uMwLKwxXkK4MKCB/f13D8pjfRRkfkiRZhYweBfj/jc/gkzHKV4bf19WLiVtpfUmbBmJjx
	T7gOgSE63s8FO17+9iLkTfyJUd/jPjKpdB8pESUcy0Q8ui/cn1Ihrk91lwpXKDeqy/7tgPCS4/2
	Ndhj1b3cVmWI8xAwYpxJknM8B2KzNlqystX0m6SCHcIdeQNFQCO5t7QQE2Y5IoFkFsYVNlKWW9Q
	KJlrEJFoF2+ND0XSMG3G2iTkmFDD74TVfO+TfGtIrBpLJl/z2Ilwfa+bOT0XQ1KpmVEnV+7obl+
	6zYmj4WdXBG2ScbfRTvvExUYdBFsAIynmop6ryyDtfTT5Dvpk7lTIGMG0zPSf67nd/e6pcSF+dA
	Be8v2n57ni2Bpwv5TKM1VQGvfgmqaQ
X-Google-Smtp-Source: AGHT+IFGkvDWy4UC3Hg/jmsLKRMLWCVuS3Q0brKoM+EvGQYG5cGXwRa91mgG3g+8I8GSaWTf36w5eA==
X-Received: by 2002:a17:90b:4a11:b0:330:6c5a:4af4 with SMTP id 98e67ed59e1d1-3403a29bc2cmr3385152a91.35.1761737233246;
        Wed, 29 Oct 2025 04:27:13 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:13 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
Date: Wed, 29 Oct 2025 16:56:40 +0530
Message-ID: <20251029112649.3811657-3-hchauhan@ventanamicro.com>
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


