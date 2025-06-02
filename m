Return-Path: <linux-efi+bounces-3808-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC735ACACC9
	for <lists+linux-efi@lfdr.de>; Mon,  2 Jun 2025 12:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2E617710E
	for <lists+linux-efi@lfdr.de>; Mon,  2 Jun 2025 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6191FBCAA;
	Mon,  2 Jun 2025 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgegRQ4a"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6020B80E
	for <linux-efi@vger.kernel.org>; Mon,  2 Jun 2025 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748861463; cv=none; b=bV8/DmHK0+sszW6EqACLR0DRQraAQ7uLq3acn0cmLRMx5DIFgu52ZJ/aNhACg+KUbpiGYqSpI9EQn6H1IrIhkta3fx0289AEWcTVjyXVWeJNxhBWIgdcewHV28cjaUXO5PxcM0ceXmzAAVeT6m/nZ8LYposwM5jHMXfesbbhqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748861463; c=relaxed/simple;
	bh=yvJh4bvjwJWvwmhp2nxCLl64gwNeP4C7z/uxvgfpHGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewlu3uCIC2KC6WpRrPHkVYigAoNYXgJpAWcG2RFq3hihu6R3WVe8HUeAhysCLifBqbfTIXdT6LePtsTsB3Nz8JOLaM4oGSdMCaO827XhaO0g3Ww6nEg2zgn/nq/O2nxA1csuNAhG10PGn82tVyF6s0PwIswd3YhMhCOxQIyzf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgegRQ4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748861461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuEEvv+92fO5OTnIlEAGlwCiJip9RXuTFHiD9Ei8oBo=;
	b=BgegRQ4aJcA18Ij+7abRp6ZyYIdAR3bEEJ0+YWR1x3EAIdS1xhUSgJVYJiy73qXxY4egDe
	vE4CiYziUZfbyMT60LCSUUVit/rQiyjz7sotFipfY1DDUnmiDlQ+wYjRaRFAhM4aEPiAwX
	+GDJEawbKVgZhsGHUpvxIBfsIlpjocw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-YrCPgNQoNLKlgGbCcUXWsQ-1; Mon,
 02 Jun 2025 06:50:59 -0400
X-MC-Unique: YrCPgNQoNLKlgGbCcUXWsQ-1
X-Mimecast-MFC-AGG-ID: YrCPgNQoNLKlgGbCcUXWsQ_1748861457
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24EB41800373;
	Mon,  2 Jun 2025 10:50:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.29])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B68619560B7;
	Mon,  2 Jun 2025 10:50:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 281F7180078F; Mon, 02 Jun 2025 12:50:51 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: linux-coco@lists.linux.dev
Cc: kvm@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE (EFI))
Subject: [PATCH v2 2/2] x86/sev: let sev_es_efi_map_ghcbs map the caa pages too
Date: Mon,  2 Jun 2025 12:50:49 +0200
Message-ID: <20250602105050.1535272-3-kraxel@redhat.com>
In-Reply-To: <20250602105050.1535272-1-kraxel@redhat.com>
References: <20250602105050.1535272-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

OVMF EFI firmware needs access to the CAA page to do SVSM protocol
calls.  So add that to sev_es_efi_map_ghcbs and also rename the function
to reflect the additional job it is doing now.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/x86/include/asm/sev.h     |  4 ++--
 arch/x86/coco/sev/core.c       | 14 ++++++++++++--
 arch/x86/platform/efi/efi_64.c |  4 ++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 58e028d42e41..6e0ef192f23b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -445,7 +445,7 @@ static __always_inline void sev_es_nmi_complete(void)
 	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		__sev_es_nmi_complete();
 }
-extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+extern int __init sev_es_efi_map_ghcbs_caas(pgd_t *pgd);
 extern void sev_enable(struct boot_params *bp);
 
 /*
@@ -556,7 +556,7 @@ static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
-static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+static inline int sev_es_efi_map_ghcbs_caas(pgd_t *pgd) { return 0; }
 static inline void sev_enable(struct boot_params *bp) { }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index fbc1215d2746..7ab9fc0ea180 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1054,11 +1054,13 @@ int __init sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
  * This is needed by the OVMF UEFI firmware which will use whatever it finds in
  * the GHCB MSR as its GHCB to talk to the hypervisor. So make sure the per-cpu
  * runtime GHCBs used by the kernel are also mapped in the EFI page-table.
+ *
+ * When running under SVSM the CCA page is needed too, so map it as well.
  */
-int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
+int __init sev_es_efi_map_ghcbs_caas(pgd_t *pgd)
 {
 	struct sev_es_runtime_data *data;
-	unsigned long address, pflags;
+	unsigned long address, pflags, pflags_enc;
 	int cpu;
 	u64 pfn;
 
@@ -1066,6 +1068,7 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 		return 0;
 
 	pflags = _PAGE_NX | _PAGE_RW;
+	pflags_enc = cc_mkenc(pflags);
 
 	for_each_possible_cpu(cpu) {
 		data = per_cpu(runtime_data, cpu);
@@ -1075,6 +1078,13 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 
 		if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags))
 			return 1;
+
+		address = per_cpu(svsm_caa_pa, cpu);
+		if (address) {
+			pfn = address >> PAGE_SHIFT;
+			if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags_enc))
+				return 1;
+		}
 	}
 
 	return 0;
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
2.49.0


