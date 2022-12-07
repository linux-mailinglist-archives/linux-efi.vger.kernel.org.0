Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E806864517C
	for <lists+linux-efi@lfdr.de>; Wed,  7 Dec 2022 02:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiLGBuW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Dec 2022 20:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiLGBuS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Dec 2022 20:50:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847B4532C9;
        Tue,  6 Dec 2022 17:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670377801; x=1701913801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ZWHE8KNs9LD2gK29L+GSS8ovmdLBSodlS7K4yGoZwg=;
  b=b+tzc5iWH+w2K98w/pM61E3YYVoOZb81+1vo73SQNiZ2yMGzTmfuHtd/
   Pn14Ce8FY1LUUvp8GRDS0BdlZ7pDYz5bnTvb5LQ54kmiowrpC2Zf4seQE
   jCAFW+E7m44jf3j3ejGHBn1WLC6IsTd8qGHJhUqHUfnB/F/XpjsoaFaZG
   8f9reMzXbNLKAS5ZxzCI+UPaJMVokJYRQr4GbdSNE7M3poobqJtE14+bv
   7lQBfa2WwubxGmfH8Uc7aB4JxCJnn2rfdzCHdaf+yqnFv7MyfP/kHEAiP
   apo2GaSaOhALmu6Ppeud5in7vrCLyHGXK1HSeAfWCb8PtJrijWnYa6U5r
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="316794452"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="316794452"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:50:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="640082289"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="640082289"
Received: from puneets1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.38.123])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:49:53 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A268A109C8F; Wed,  7 Dec 2022 04:49:39 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv8 11/14] x86: Disable kexec if system has unaccepted memory
Date:   Wed,  7 Dec 2022 04:49:30 +0300
Message-Id: <20221207014933.8435-12-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On kexec, the target kernel has to know what memory has been accepted.
Information in EFI map is out of date and cannot be used.

boot_params.unaccepted_memory can be used to pass the bitmap between two
kernels on kexec, but the use-case is not yet implemented.

Disable kexec on machines with unaccepted memory for now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/kexec.h    |  5 +++++
 arch/x86/mm/unaccepted_memory.c | 16 ++++++++++++++++
 include/linux/kexec.h           |  7 +++++++
 kernel/kexec.c                  |  4 ++++
 kernel/kexec_file.c             |  4 ++++
 5 files changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..87abab578154 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -189,6 +189,11 @@ extern void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages);
 void arch_kexec_protect_crashkres(void);
 #define arch_kexec_protect_crashkres arch_kexec_protect_crashkres
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+int arch_kexec_load(void);
+#define arch_kexec_load arch_kexec_load
+#endif
+
 void arch_kexec_unprotect_crashkres(void);
 #define arch_kexec_unprotect_crashkres arch_kexec_unprotect_crashkres
 
diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index a0a58486eb74..1745e6a65024 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kexec.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/pfn.h>
@@ -98,3 +99,18 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
 
 	return ret;
 }
+
+#ifdef CONFIG_KEXEC_CORE
+int arch_kexec_load(void)
+{
+	if (!boot_params.unaccepted_memory)
+		return 0;
+
+	/*
+	 * TODO: Information on memory acceptance status has to be communicated
+	 * between kernel.
+	 */
+	pr_warn_once("Disable kexec: not yet supported on systems with unaccepted memory\n");
+	return -EOPNOTSUPP;
+}
+#endif
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 41a686996aaa..6b75051d5271 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -444,6 +444,13 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
+#ifndef arch_kexec_load
+static inline int arch_kexec_load(void)
+{
+	return 0;
+}
+#endif
+
 #ifndef page_to_boot_pfn
 static inline unsigned long page_to_boot_pfn(struct page *page)
 {
diff --git a/kernel/kexec.c b/kernel/kexec.c
index cb8e6e6f983c..65dff44b487f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -192,6 +192,10 @@ static inline int kexec_load_check(unsigned long nr_segments,
 {
 	int result;
 
+	result = arch_kexec_load();
+	if (result)
+		return result;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..8f1454c3776a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -329,6 +329,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	int ret = 0, i;
 	struct kimage **dest_image, *image;
 
+	ret = arch_kexec_load();
+	if (ret)
+		return ret;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
-- 
2.38.0

