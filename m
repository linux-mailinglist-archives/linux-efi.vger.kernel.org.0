Return-Path: <linux-efi+bounces-3957-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEFAAE65D8
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 15:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E957A175B65
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1011F2980A1;
	Tue, 24 Jun 2025 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aoRIx3fg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8797A28D8FA;
	Tue, 24 Jun 2025 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770142; cv=none; b=L65Ip0GxyP8G9J03a0GhSct9LrKn92L1BorYjxkASI/RH6EVQXcvsiI+1Mrzfxfm7J6Oqkvxz3lFFq/27j7TCdFzfCue8wtdMLT3LlwCAhl8Vya/tDVDWIwyOh8XHWTUUuL6ozNOaiZKIWBZKrRalkhRamPxAGj/ZdURGi6grq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770142; c=relaxed/simple;
	bh=5b48PxvdWOCAFOl31cdiOUwXzDYiUBixnJcaU6ejEl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnLJpX80LIqk231BKWSkegTj7lQuv1lZ4XoBWfQOTCdkLjcBg7rY4VzXOWrwTfodNYfIyT2oExBjOFY5qt2K9cSfPmxBEIJN8XYK2husn7hQ1ydBWHRtp5ikbGwzSV3qINUJxxc4tD7vOwfp3V0CJzRb7i4JnEFtSkHZwL4DmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aoRIx3fg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 931CA40E00DE;
	Tue, 24 Jun 2025 13:02:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZiMvgR5epIuE; Tue, 24 Jun 2025 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750770130; bh=qZPkqHa+agmymJRsvd0GsTVbCxTMUMcr+mpRiXqakQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aoRIx3fgKpgg/GXMI6/W9Hmd+BznlUx7ue5dYy0C0q2SvNAtIaPD633WybKPu1esh
	 CB4zK0IXhrCFI42TRpXxXZee9zy5YrYn/czVpJm/lfzQXt0BghfZW/A8OOLcBOoxOn
	 AuM7hd/fnVpLOzPYjVn7al3q1nJkMhem6mcb5XEGMI8rb9COkmd2CZQ36x5L+2XcCA
	 Bq60m/6vlL7kW+1qeZp//k2l5yA7Kfgf3ayaxIBgOBvdOjM8mY0HuNeqL0GZ73kAkn
	 3cvJJTdI+zjbsvNcAj/MC/zrRtujxnsDSrM3leMhXLlioP7jqFIyZWgA67r7D0AA5I
	 RSCPAVpbq8kkxjPbmqvSY2uZvCgmq+FfD6GbFc/dYkryFDIoRpsdPyZ97athk/yYcU
	 yYyi9WbcDlMpJMyibmTGWqVWPjnnAVJIwfUUDVV+fN45xOqQVsV6Gz15EvrUW5qX7K
	 2HP0Hg/q6+Gd8W6XbE4D1A/zQgqed3bKac6Qpm9/mo6KsnwQq144QF5+3w749UeExg
	 LwLh1Rl2jX/BGkF5P09ZsZP+X3bqlgDDV92zH+3OzdHLRpLmyUXljRGhuuIkXmot4f
	 sXdhEXm6mc6sCrH7yCMjffSB2mtEq41jL3H2KE/TSk4wek7rrzUBrZwvBnd9I/YZ1J
	 4/O0QIDBdQD9HEkRCv7Y85KU=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4743240E019C;
	Tue, 24 Jun 2025 13:01:59 +0000 (UTC)
Date: Tue, 24 Jun 2025 15:01:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/sev: let sev_es_efi_map_ghcbs map the caa
 pages too
Message-ID: <20250624130158.GIaFqhxjE8-lQqq7mt@fat_crate.local>
References: <20250602105050.1535272-1-kraxel@redhat.com>
 <20250602105050.1535272-3-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250602105050.1535272-3-kraxel@redhat.com>

I got this now:

---
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 2 Jun 2025 12:50:49 +0200
Subject: [PATCH] x86/sev: Let sev_es_efi_map_ghcbs() map the caa pages too

OVMF EFI firmware needs access to the CAA page to do SVSM protocol calls. For
example, when the SVSM implements an EFI variable store, such calls will be
necessary.

So add that to sev_es_efi_map_ghcbs() and also rename the function to reflect
the additional job it is doing now.

  [ bp: Massage. ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250602105050.1535272-3-kraxel@redhat.com
---
 arch/x86/coco/sev/core.c       | 15 +++++++++++++--
 arch/x86/include/asm/sev.h     |  4 ++--
 arch/x86/platform/efi/efi_64.c |  4 ++--
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 8375ca7fbd8a..6af3e94ba0ee 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1045,11 +1045,13 @@ int __init sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
  * This is needed by the OVMF UEFI firmware which will use whatever it finds in
  * the GHCB MSR as its GHCB to talk to the hypervisor. So make sure the per-cpu
  * runtime GHCBs used by the kernel are also mapped in the EFI page-table.
+ *
+ * When running under SVSM the CCA page is needed too, so map it as well.
  */
-int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
+int __init sev_es_efi_map_ghcbs_caas(pgd_t *pgd)
 {
+	unsigned long address, pflags, pflags_enc;
 	struct sev_es_runtime_data *data;
-	unsigned long address, pflags;
 	int cpu;
 	u64 pfn;
 
@@ -1057,6 +1059,7 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 		return 0;
 
 	pflags = _PAGE_NX | _PAGE_RW;
+	pflags_enc = cc_mkenc(pflags);
 
 	for_each_possible_cpu(cpu) {
 		data = per_cpu(runtime_data, cpu);
@@ -1066,6 +1069,14 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 
 		if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags))
 			return 1;
+
+		address = per_cpu(svsm_caa_pa, cpu);
+		if (!address)
+			return 1;
+
+		pfn = address >> PAGE_SHIFT;
+		if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags_enc))
+			return 1;
 	}
 
 	return 0;
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index fbb616fcbfb8..5b809f0ef207 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -446,7 +446,7 @@ static __always_inline void sev_es_nmi_complete(void)
 	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		__sev_es_nmi_complete();
 }
-extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+extern int __init sev_es_efi_map_ghcbs_caas(pgd_t *pgd);
 extern void sev_enable(struct boot_params *bp);
 
 /*
@@ -554,7 +554,7 @@ static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
-static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+static inline int sev_es_efi_map_ghcbs_caas(pgd_t *pgd) { return 0; }
 static inline void sev_enable(struct boot_params *bp) { }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e7e8f77f77f8..97e8032db45d 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -216,8 +216,8 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	 * When SEV-ES is active, the GHCB as set by the kernel will be used
 	 * by firmware. Create a 1:1 unencrypted mapping for each GHCB.
 	 */
-	if (sev_es_efi_map_ghcbs(pgd)) {
-		pr_err("Failed to create 1:1 mapping for the GHCBs!\n");
+	if (sev_es_efi_map_ghcbs_caas(pgd)) {
+		pr_err("Failed to create 1:1 mapping for the GHCBs and CAAs!\n");
 		return 1;
 	}
 
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

