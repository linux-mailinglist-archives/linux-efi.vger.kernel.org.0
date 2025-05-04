Return-Path: <linux-efi+bounces-3567-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D97AA85BD
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792EE3ACB60
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE21E5B9A;
	Sun,  4 May 2025 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y152u7Ck"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632721E9907
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352421; cv=none; b=boz4EhRYPPvp7jG4KUHjaUt9vddxol0kXM022OraZXgsoAUK8BjCf2SSLbWt7/koHXX3/A+4Q4OhMyN0FjAe8N6MNRcCfhhZ320VRuYdHPc1Qckw3aTWPDypFlwW0u+fsIYI7cwfdRsVKvNwgpgkFwuETD9lHB864CjIfD1O8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352421; c=relaxed/simple;
	bh=aHloFHnPa0bpo40NNxCXch1Gt5dJk47uA3Hl9cxt5Dc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OavxfCYyNhmreHg3wKY/0O99UEk+4eSQxoyM/fkSn6ZOgKHShlTLC/OauKwt3N4intvsV+XzPq2xEPHOyETe5jAs/AINlqex0wtxVZJ3NwDRRqEZ3/c2T/4M3bkxPIOUkibXJDibN4Wgyh2SEqcXu3PRtsfzZM4wuLmp0FkDFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y152u7Ck; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-39141ffa913so1624424f8f.2
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352418; x=1746957218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0qjh3aA4OXGqpKzUr6s6nXvvtZjVv7X5+NLywnovwT8=;
        b=y152u7CktdNDld+IA4sf/+2eZxYYWvegL6/4BJ3Z+5TRjjVdQ0znyLHPn4JolOvzS3
         JT2Kz+cywj9oIsbwmK1GrrfFE7FEBW03rE8n9sz4h7Tk9vFPf61P40a0k3LoRWCyzx6q
         ZIfdFNIjSHYK+tTXzzU0ncdWAY9JsgoZDAJU3k0OWgq+uWxoEDcECNHeFe2S3LQmFof3
         hO6kXi7SjOZ/YtR/u8uHZJnoe29Ae9YWTjase5qc9sdjYZfWNxGcl3xvUaLqRFgkHirO
         gcpmRyXWKkBHVDNRdF1AsswhR35y4z0geGB3GaKHEe7iRhe2PHEJAYmeV1vvpD8qLA2R
         HaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352418; x=1746957218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qjh3aA4OXGqpKzUr6s6nXvvtZjVv7X5+NLywnovwT8=;
        b=fkCRqC670WFyQLDOCCQOmchPjEDaxOefpUkrFJTj4RXYoCJ+ILHxYVWdjhozpoIwlQ
         PMlriwVLTO97vmrha8/6TVueok2B/5cyXVXomGrF7DO21K4SkR1VDD2qH+1tdiwyfpNy
         d3WE4ZkGeyEGREG2kibIFI0XrWEvr/dcA9wa1PerueIN2DKwp6iIk4YWQe4oPNLrgs1x
         /Mlb3vPIRxvUSpMyx4RFmqjF1HEPmW39Gpx16t4D7FF9qsDS5bcwEoQrjg3R5aQpzJYd
         01iDsr8u8Hml4jR9VjDsvwBsKwOWBR+FtbWm1/YD2aY/xHwjDTBpUrDN+XJh6LFAZWAN
         bdUw==
X-Gm-Message-State: AOJu0Yyj94URRx8X0deUtwl9Pdm5SliuDBhpvTfB7B/7/3CxWPeTpPBT
	+JABPIL9XzPYgXlIWgMUn5faopLpPpoeyChZwdI+wC09n3kI1M0oEla1udZfO8xp1LwU+g==
X-Google-Smtp-Source: AGHT+IFyEvpKlKi4oAJU+SLd/0+ezNebN25q32YXRpUDQMUSoQruZndAojpWGPc582aK3iHaU0tPRNKJ
X-Received: from wrbfo4.prod.google.com ([2002:a05:6000:2904:b0:39a:be42:4b14])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2481:b0:3a0:90c3:dd90
 with SMTP id ffacd0b85a97d-3a09fd6d9ddmr3209750f8f.11.1746352417796; Sun, 04
 May 2025 02:53:37 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:46 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5163; i=ardb@kernel.org;
 h=from:subject; bh=k2TTUi4nLqQXdxGniT4a97pQU/HXQmCwOe1Xt6uAJe0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4rN2uW9WZE+NM5/SipvKpouSkqLaV/fdDWEze5yt8
 3bH6TcdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJq1YwM1yZvL2tMmLdA2f3I
 nJhHmrJdoWeaG9mmWnyJMdHX/cp5h+F/7pa6pjM2m5ckS6zguFBhfbOX+0VGQNWflg2r9wct+B/ BBAA=
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-41-ardb+git@google.com>
Subject: [RFT PATCH v2 16/23] x86/sev: Provide PIC aliases for SEV related
 data objects
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      |  4 ++
 arch/x86/boot/startup/sev-shared.c  | 20 --------
 arch/x86/boot/startup/sev-startup.c | 17 -------
 arch/x86/coco/sev/core.c            | 48 ++++++++++++++++++++
 4 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 79550736ad2a..8118a270485f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -38,6 +38,10 @@ struct ghcb *boot_ghcb;
 #define __BOOT_COMPRESSED
 
 u8 snp_vmpl;
+u16 ghcb_version;
+
+struct svsm_ca *boot_svsm_caa;
+u64 boot_svsm_caa_pa;
 
 /* Include code for early handlers */
 #include "../../boot/startup/sev-shared.c"
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index b72c2b9c40c3..9ab132bed77b 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -19,26 +19,6 @@
 #define WARN(condition, format...) (!!(condition))
 #endif
 
-/*
- * SVSM related information:
- *   During boot, the page tables are set up as identity mapped and later
- *   changed to use kernel virtual addresses. Maintain separate virtual and
- *   physical addresses for the CAA to allow SVSM functions to be used during
- *   early boot, both with identity mapped virtual addresses and proper kernel
- *   virtual addresses.
- */
-struct svsm_ca *boot_svsm_caa __ro_after_init;
-u64 boot_svsm_caa_pa __ro_after_init;
-
-/*
- * Since feature negotiation related variables are set early in the boot
- * process they must reside in the .data section so as not to be zeroed
- * out when the .bss section is later cleared.
- *
- * GHCB protocol version negotiated with the hypervisor.
- */
-u16 ghcb_version __ro_after_init;
-
 /* Copy of the SNP firmware's CPUID page. */
 static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
 
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index ca6a9863ffab..2c2a5a043f18 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -41,23 +41,6 @@
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
 
-/* For early boot hypervisor communication in SEV-ES enabled guests */
-struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
-
-/*
- * Needs to be in the .data section because we need it NULL before bss is
- * cleared
- */
-struct ghcb *boot_ghcb __section(".data");
-
-/* Bitmap of SEV features supported by the hypervisor */
-u64 sev_hv_features __ro_after_init;
-
-/* Secrets page physical address from the CC blob */
-u64 sev_secrets_pa __ro_after_init;
-
-/* For early boot SVSM communication */
-struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
 
 /*
  * Nothing shall interrupt this code path while holding the per-CPU
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 106c231d8ded..33332c4299b9 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -45,6 +45,43 @@
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
 
+/* For early boot hypervisor communication in SEV-ES enabled guests */
+struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
+SYM_PIC_ALIAS(boot_ghcb_page);
+
+/*
+ * Needs to be in the .data section because we need it NULL before bss is
+ * cleared
+ */
+struct ghcb *boot_ghcb __section(".data");
+SYM_PIC_ALIAS(boot_ghcb);
+
+/* Bitmap of SEV features supported by the hypervisor */
+u64 sev_hv_features __ro_after_init;
+SYM_PIC_ALIAS(sev_hv_features);
+
+/* Secrets page physical address from the CC blob */
+u64 sev_secrets_pa __ro_after_init;
+SYM_PIC_ALIAS(sev_secrets_pa);
+
+/* For early boot SVSM communication */
+struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
+SYM_PIC_ALIAS(boot_svsm_ca_page);
+
+/*
+ * SVSM related information:
+ *   During boot, the page tables are set up as identity mapped and later
+ *   changed to use kernel virtual addresses. Maintain separate virtual and
+ *   physical addresses for the CAA to allow SVSM functions to be used during
+ *   early boot, both with identity mapped virtual addresses and proper kernel
+ *   virtual addresses.
+ */
+struct svsm_ca *boot_svsm_caa __ro_after_init;
+SYM_PIC_ALIAS(boot_svsm_caa);
+
+u64 boot_svsm_caa_pa __ro_after_init;
+SYM_PIC_ALIAS(boot_svsm_caa_pa);
+
 DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
 DEFINE_PER_CPU(u64, svsm_caa_pa);
 
@@ -118,6 +155,17 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
  */
 u8 snp_vmpl __ro_after_init;
 EXPORT_SYMBOL_GPL(snp_vmpl);
+SYM_PIC_ALIAS(snp_vmpl);
+
+/*
+ * Since feature negotiation related variables are set early in the boot
+ * process they must reside in the .data section so as not to be zeroed
+ * out when the .bss section is later cleared.
+ *
+ * GHCB protocol version negotiated with the hypervisor.
+ */
+u16 ghcb_version __ro_after_init;
+SYM_PIC_ALIAS(ghcb_version);
 
 static u64 __init get_snp_jump_table_addr(void)
 {
-- 
2.49.0.906.g1f30a19c02-goog


