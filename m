Return-Path: <linux-efi+bounces-223-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B378147FD
	for <lists+linux-efi@lfdr.de>; Fri, 15 Dec 2023 13:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130B7285DF4
	for <lists+linux-efi@lfdr.de>; Fri, 15 Dec 2023 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1842D04E;
	Fri, 15 Dec 2023 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X/7I8fRr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JCPzv0rT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X/7I8fRr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JCPzv0rT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF222C6A9;
	Fri, 15 Dec 2023 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01A46220D6;
	Fri, 15 Dec 2023 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702643178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIKNTENIo3WMFUa1p7gLGW1/C1ipjjdUcxT2AmkwTno=;
	b=X/7I8fRryaEc8HSxjBRqjkSOkZ2vOmwM0RwlzqCtKCqcTYiRWUMx8zpO09Bk678SwRml81
	G6df7QWcFeoR5+SGZISyuGiMEMkOvgfD2+qhJtQKQ/HjjnnNjRE9t6SNFTxaoSkYP92/G0
	VguBAJ13XAtF64jIFbuFB7duWj57p+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702643178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIKNTENIo3WMFUa1p7gLGW1/C1ipjjdUcxT2AmkwTno=;
	b=JCPzv0rTI4f8Ny5kjCMdBmJMNcx546v7M5ueqkgVoZXpnP1DW12ed5AnYfLGxx+1idtRob
	zRlMpDWh6clhFuBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702643178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIKNTENIo3WMFUa1p7gLGW1/C1ipjjdUcxT2AmkwTno=;
	b=X/7I8fRryaEc8HSxjBRqjkSOkZ2vOmwM0RwlzqCtKCqcTYiRWUMx8zpO09Bk678SwRml81
	G6df7QWcFeoR5+SGZISyuGiMEMkOvgfD2+qhJtQKQ/HjjnnNjRE9t6SNFTxaoSkYP92/G0
	VguBAJ13XAtF64jIFbuFB7duWj57p+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702643178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIKNTENIo3WMFUa1p7gLGW1/C1ipjjdUcxT2AmkwTno=;
	b=JCPzv0rTI4f8Ny5kjCMdBmJMNcx546v7M5ueqkgVoZXpnP1DW12ed5AnYfLGxx+1idtRob
	zRlMpDWh6clhFuBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E31213A08;
	Fri, 15 Dec 2023 12:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2BmqHelFfGVIRwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Fri, 15 Dec 2023 12:26:17 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bhelgaas@google.com,
	arnd@arndb.de,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	javierm@redhat.com
Cc: linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/3] arch/x86: Add <asm/ima-efi.h> for arch_ima_efi_boot_mode
Date: Fri, 15 Dec 2023 13:18:13 +0100
Message-ID: <20231215122614.5481-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215122614.5481-1-tzimmermann@suse.de>
References: <20231215122614.5481-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 2.23
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: **
X-Spam-Score: 2.23
X-Spamd-Result: default: False [2.23 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLthqzz6q5hnubohss7ffybi86)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.17)[-0.833];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

The header file <asm/efi.h> contains the macro arch_ima_efi_boot_mode,
which expands to use struct boot_params from <asm/bootparams.h>. Many
drivers include <linux/efi.h>, but do not use boot parameters. Changes
to bootparam.h or its included headers can easily trigger large,
unnessary rebuilds of the kernel.

Moving x86's arch_ima_efi_boot_mode to <asm/ima-efi.h> and including
<asm/setup.h> separates that dependency from the rest of the EFI
interfaces. The only user is in ima_efi.c. As the file already declares
a default value for arch_ima_efi_boot_mode, move this define into
asm-generic for all other architectures.

With arch_ima_efi_boot_mode removed from efi.h, <asm/bootparam.h> can
later be removed from further x86 header files.

v2:
	* remove extra declaration of boot_params (Ard)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/x86/include/asm/efi.h       |  3 ---
 arch/x86/include/asm/ima-efi.h   | 11 +++++++++++
 include/asm-generic/Kbuild       |  1 +
 include/asm-generic/ima-efi.h    | 16 ++++++++++++++++
 security/integrity/ima/ima_efi.c |  5 +----
 5 files changed, 29 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/include/asm/ima-efi.h
 create mode 100644 include/asm-generic/ima-efi.h

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index c4555b269a1b..99f31176c892 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -418,9 +418,6 @@ extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
 extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
 				     void *buf, struct efi_mem_range *mem);
 
-#define arch_ima_efi_boot_mode	\
-	({ extern struct boot_params boot_params; boot_params.secure_boot; })
-
 #ifdef CONFIG_EFI_RUNTIME_MAP
 int efi_get_runtime_map_size(void);
 int efi_get_runtime_map_desc_size(void);
diff --git a/arch/x86/include/asm/ima-efi.h b/arch/x86/include/asm/ima-efi.h
new file mode 100644
index 000000000000..b4d904e66b39
--- /dev/null
+++ b/arch/x86/include/asm/ima-efi.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IMA_EFI_H
+#define _ASM_X86_IMA_EFI_H
+
+#include <asm/setup.h>
+
+#define arch_ima_efi_boot_mode boot_params.secure_boot
+
+#include <asm-generic/ima-efi.h>
+
+#endif /* _ASM_X86_IMA_EFI_H */
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index def242528b1d..4fd16e71e8cd 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -26,6 +26,7 @@ mandatory-y += ftrace.h
 mandatory-y += futex.h
 mandatory-y += hardirq.h
 mandatory-y += hw_irq.h
+mandatory-y += ima-efi.h
 mandatory-y += io.h
 mandatory-y += irq.h
 mandatory-y += irq_regs.h
diff --git a/include/asm-generic/ima-efi.h b/include/asm-generic/ima-efi.h
new file mode 100644
index 000000000000..f87f5edef440
--- /dev/null
+++ b/include/asm-generic/ima-efi.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ASM_GENERIC_IMA_EFI_H_
+#define __ASM_GENERIC_IMA_EFI_H_
+
+#include <linux/efi.h>
+
+/*
+ * Only include this header file from your architecture's <asm/ima-efi.h>.
+ */
+
+#ifndef arch_ima_efi_boot_mode
+#define arch_ima_efi_boot_mode efi_secureboot_mode_unset
+#endif
+
+#endif /* __ASM_GENERIC_FB_H_ */
diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 138029bfcce1..56bbee271cec 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -6,10 +6,7 @@
 #include <linux/module.h>
 #include <linux/ima.h>
 #include <asm/efi.h>
-
-#ifndef arch_ima_efi_boot_mode
-#define arch_ima_efi_boot_mode efi_secureboot_mode_unset
-#endif
+#include <asm/ima-efi.h>
 
 static enum efi_secureboot_mode get_sb_mode(void)
 {
-- 
2.43.0


