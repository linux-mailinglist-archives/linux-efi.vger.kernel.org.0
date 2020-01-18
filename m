Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3841418A3
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2020 18:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgARRQi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jan 2020 12:16:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44707 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgARRQi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 Jan 2020 12:16:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so25552368wrm.11;
        Sat, 18 Jan 2020 09:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t96K9yqyVEX3WlNB6mY1iEHeBKue1nFom+5GUOh9QI8=;
        b=S/iiXl+UPMKSKq3gJsNswV337GSpEV6mH/fvuOpe6td2ZhOUtvDCQM2X64Q5D+TfKi
         WlIdE5c4QF4p3fPJo0nAFWmbpCx3oC2pVt/Y+ebEb5OaHEo70hNVBQ2og46RuUohQHcS
         4iRxfJ0vS1UJQbjitduNenql8//BJpMyrgTRUMBhJshzEUGVhxiQUgGXi7xQ0ZqIsqzC
         TQB3Xm7vq/cW3o1ji64BHnr0zDIn9cTipzDv/x8Gfq9Odp4GSLPWbCkdzYP0/3DtEx6j
         9YCUxYi+SKy8GkKZoi2JS9OnOeqHKS5hH8IPZtEdMQLyfBQCeaRkA949Ocgb+J+ewtNJ
         a2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=t96K9yqyVEX3WlNB6mY1iEHeBKue1nFom+5GUOh9QI8=;
        b=cqdz8nLPmsJlSR5ZIJ6riIrSa9EVhoR5dFBgDgiYlw4NffA3oGNKqHFEVjTSjep2P1
         Agrq1V9tFLL61FZISGw4wH6CVDq34vzq8dGzRgfUBcPk6dpcYm7VthWlOWBHANeI8vKz
         LnXhsAc+Wo85/4yJUdRd2LE3Z8KiauZfvjJWYE1Mg2kX65NGHNIiEJaCrspfZm32xJQ4
         o2zpRivpFtl2Fg7+0vI9qIxQrYxcWi3LiqsVYXiqXWZnyvH/QT1Azhwps1VRjSeiLlIB
         Kl6uE0xnBAycI7LykEMDRhdDPr97yLWIySpFs/E3V4Q6vgufgNDqnfqLE6H55s3OX4Kd
         3EYw==
X-Gm-Message-State: APjAAAWGvTwpCFKk+B5v3YmTeASlLK6oIe41shhsHJMrecRguFfnS7SZ
        VPid9/KTID6hB1OzMrLUDJ5/DBYP
X-Google-Smtp-Source: APXvYqwVfrJHywbiiBsXPRQekZT4HB5Qe9Ib/vlHDLTcN5E8oA9fcc5hc8DDrvTisNhl8QSOrAplaw==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr9540897wrv.308.1579367795770;
        Sat, 18 Jan 2020 09:16:35 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a184sm5458070wmf.29.2020.01.18.09.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 09:16:35 -0800 (PST)
Date:   Sat, 18 Jan 2020 18:16:33 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [GIT PULL] EFI fixes
Message-ID: <20200118171633.GA28490@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linus,

Please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

   # HEAD: 4911ee401b7ceff8f38e0ac597cbf503d71e690c x86/efistub: Disable paging at mixed mode entry

Three EFI fixes:

 - Fix a slow-boot-scrolling regression but making sure we use WC for EFI 
   earlycon framebuffer mappings on x86

 - Fix a mixed EFI mode boot crash

 - Disable paging explicitly before entering startup_32() in mixed mode 
   bootup

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      x86/efistub: Disable paging at mixed mode entry

Arvind Sankar (1):
      efi/earlycon: Fix write-combine mapping on x86

Hans de Goede (1):
      efi/libstub/random: Initialize pointer variables to zero for mixed mode


 arch/x86/boot/compressed/head_64.S    |  5 +++++
 drivers/firmware/efi/earlycon.c       | 16 +++++++---------
 drivers/firmware/efi/libstub/random.c |  6 +++---
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 58a512e33d8d..ee60b81944a7 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -244,6 +244,11 @@ SYM_FUNC_START(efi32_stub_entry)
 	leal	efi32_config(%ebp), %eax
 	movl	%eax, efi_config(%ebp)
 
+	/* Disable paging */
+	movl	%cr0, %eax
+	btrl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
 	jmp	startup_32
 SYM_FUNC_END(efi32_stub_entry)
 #endif
diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index d4077db6dc97..5d4f84781aa0 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -17,7 +17,7 @@ static const struct console *earlycon_console __initdata;
 static const struct font_desc *font;
 static u32 efi_x, efi_y;
 static u64 fb_base;
-static pgprot_t fb_prot;
+static bool fb_wb;
 static void *efi_fb;
 
 /*
@@ -33,10 +33,8 @@ static int __init efi_earlycon_remap_fb(void)
 	if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
 		return 0;
 
-	if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
-		efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
-	else
-		efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
+	efi_fb = memremap(fb_base, screen_info.lfb_size,
+			  fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
 
 	return efi_fb ? 0 : -ENOMEM;
 }
@@ -53,9 +51,12 @@ late_initcall(efi_earlycon_unmap_fb);
 
 static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
 {
+	pgprot_t fb_prot;
+
 	if (efi_fb)
 		return efi_fb + start;
 
+	fb_prot = fb_wb ? PAGE_KERNEL : pgprot_writecombine(PAGE_KERNEL);
 	return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
 }
 
@@ -215,10 +216,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
 	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
 		fb_base |= (u64)screen_info.ext_lfb_base << 32;
 
-	if (opt && !strcmp(opt, "ram"))
-		fb_prot = PAGE_KERNEL;
-	else
-		fb_prot = pgprot_writecombine(PAGE_KERNEL);
+	fb_wb = opt && !strcmp(opt, "ram");
 
 	si = &screen_info;
 	xres = si->lfb_width;
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 35edd7cfb6a1..97378cf96a2e 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -33,7 +33,7 @@ efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table_arg,
 {
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_status_t status;
-	struct efi_rng_protocol *rng;
+	struct efi_rng_protocol *rng = NULL;
 
 	status = efi_call_early(locate_protocol, &rng_proto, NULL,
 				(void **)&rng);
@@ -162,8 +162,8 @@ efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg)
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_guid_t rng_algo_raw = EFI_RNG_ALGORITHM_RAW;
 	efi_guid_t rng_table_guid = LINUX_EFI_RANDOM_SEED_TABLE_GUID;
-	struct efi_rng_protocol *rng;
-	struct linux_efi_random_seed *seed;
+	struct efi_rng_protocol *rng = NULL;
+	struct linux_efi_random_seed *seed = NULL;
 	efi_status_t status;
 
 	status = efi_call_early(locate_protocol, &rng_proto, NULL,
