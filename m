Return-Path: <linux-efi+bounces-3793-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B17AAC5135
	for <lists+linux-efi@lfdr.de>; Tue, 27 May 2025 16:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F27B189C3FE
	for <lists+linux-efi@lfdr.de>; Tue, 27 May 2025 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91B5263C8F;
	Tue, 27 May 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkJg5R/6"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95D279916
	for <linux-efi@vger.kernel.org>; Tue, 27 May 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357175; cv=none; b=Npv+4/mY3IggcZWdJfL2a6qy3s2/LZD/1ysPl5rja44mFmikE5VY73FgDMyIGPWg3gsOqBZ6PgjF62saEbFX81v2meYEXMVdK1ztl+CLqpIGoAwMk3KNG4q0sOeGU1rlrsBD2dWzvVU/Zuso3inyofw2hcZij2qt+yyjUEYDPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357175; c=relaxed/simple;
	bh=UQp09avFH8xgeYerTkwf4UoPXmwKxzIXnY83QqUxR54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0rzwerHRq6nUSZFTV4PYOqWm30+SJTLYnhM5DoBMxdB7U5i8ehmKFQeW/PeObaNA7wz78lBD6HyG1fPBARl/RBoAzi59qTBOwDkq5yWNOIXOT7TltIQIkhc8K49z9e7XgWXKHvAOSjyUep4FyN8KqYZ88OmK/qX00acWQWYhe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkJg5R/6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748357173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sa/wIGm5nRAZlTb1UlvruTlcCiWXHo8pM4cZQoZaSZU=;
	b=SkJg5R/6eE01OAdewVcD4RUxX68km4xlFGMYLRhUJxA/axTBw66pruko4Z+pKSbKz+ci2O
	cLbGXBSyNpC1R/hCJrjulePLjA/0rrplCcbdGx3gtnXCe+DM5QEPj5Sv+2nkQ06yXwA6ry
	qd3Bxi9BW4rXySrNh4sGrMlUqLXN03w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-2LoxhscaOcCIARcKL32Hjw-1; Tue,
 27 May 2025 10:46:09 -0400
X-MC-Unique: 2LoxhscaOcCIARcKL32Hjw-1
X-Mimecast-MFC-AGG-ID: 2LoxhscaOcCIARcKL32Hjw_1748357167
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6144D1955D88;
	Tue, 27 May 2025 14:46:07 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.45.226.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E33C18003FC;
	Tue, 27 May 2025 14:46:03 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
	id 4D2CC44FBC4; Tue, 27 May 2025 16:46:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	Gerd Hoffmann <kraxel@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 2/2] x86/sev: let sev_es_efi_map_ghcbs map the caa pages too
Date: Tue, 27 May 2025 16:45:45 +0200
Message-ID: <20250527144546.42981-2-kraxel@redhat.com>
In-Reply-To: <20250527144546.42981-1-kraxel@redhat.com>
References: <20250527144546.42981-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

OVMF EFI firmware needs access to the CAA page to do SVSM protocol
calls.  So add that to sev_es_efi_map_ghcbs and also rename the function
to reflect the additional job it is doing now.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/x86/coco/sev/core.c       | 14 ++++++++++++--
 arch/x86/include/asm/sev.h     |  4 ++--
 arch/x86/platform/efi/efi_64.c |  2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 145f594d7e6b..1cf2a8757ad6 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1466,11 +1466,13 @@ int __init sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
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
 
@@ -1478,6 +1480,7 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 		return 0;
 
 	pflags = _PAGE_NX | _PAGE_RW;
+	pflags_enc = cc_mkenc(pflags);
 
 	for_each_possible_cpu(cpu) {
 		data = per_cpu(runtime_data, cpu);
@@ -1487,6 +1490,13 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 
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
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ba7999f66abe..6b4f8b55e214 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -410,7 +410,7 @@ static __always_inline void sev_es_nmi_complete(void)
 	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		__sev_es_nmi_complete();
 }
-extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+extern int __init sev_es_efi_map_ghcbs_caas(pgd_t *pgd);
 extern void sev_enable(struct boot_params *bp);
 
 /*
@@ -491,7 +491,7 @@ static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
-static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+static inline int sev_es_efi_map_ghcbs_caas(pgd_t *pgd) { return 0; }
 static inline void sev_enable(struct boot_params *bp) { }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index a4b4ebd41b8f..1136c576831f 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -215,7 +215,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	 * When SEV-ES is active, the GHCB as set by the kernel will be used
 	 * by firmware. Create a 1:1 unencrypted mapping for each GHCB.
 	 */
-	if (sev_es_efi_map_ghcbs(pgd)) {
+	if (sev_es_efi_map_ghcbs_caas(pgd)) {
 		pr_err("Failed to create 1:1 mapping for the GHCBs!\n");
 		return 1;
 	}
-- 
2.49.0


