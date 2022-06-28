Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE73155F21E
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jun 2022 01:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiF1XvK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 19:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiF1XvI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 19:51:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7580F39167;
        Tue, 28 Jun 2022 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656460267; x=1687996267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dI3HshvmacGZNIxLwiGqhbPCAPM3w/IVmJ97bcAXWCk=;
  b=hhjVFAynyHs9OpKy+aVFKi2I3K3ni/ar5bQhJP9UuCcz9l3J3BfpElNz
   lKv1EKUX2x+/a73+6gZAC+a6AsIgwTR3maTO/oCPvud7nwsQSX6pyqgxA
   IlBUfZvu65JCSb5iGnqQhefc04RI1zVc77FMXljvPhk1tZYuDsEXltKbY
   S8VZQLARDcJzDjHvDSf+NMbFdumF2xxymFcrvsJrtIjYrqzfPNOFv8bYJ
   uo6+58jdxFaO5mJV7BcogMDLAo/YHi2iswD2T74tyaKNJAhddoHCb8f0P
   FQd4EbRvpnggXvGoJ5kN5CopNQqbZ+dXkzKROcMjVgRk03BsJnAx/Q/3a
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262285954"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="262285954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 16:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="617363723"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 28 Jun 2022 16:50:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 95514CE; Wed, 29 Jun 2022 02:51:05 +0300 (EEST)
Date:   Wed, 29 Jun 2022 02:51:05 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted
 memory
Message-ID: <20220628235105.z6ytdzxofrdkjti4@black.fi.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
 <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com>
 <87a6a3aw50.fsf@email.froward.int.ebiederm.org>
 <20220624020005.txpxlsbjbebf6oq4@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624020005.txpxlsbjbebf6oq4@black.fi.intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 24, 2022 at 05:00:05AM +0300, Kirill A. Shutemov wrote:
> > If there is some deep and fundamental why this can not be supported
> > then it probably makes sense to put some code in the arch_kexec_load
> > hook that verifies that deep and fundamental reason is present.
> 
> Sounds straight-forward. I can do this.

What about the patch below?

From 0b758600e1eef5525f2a46630ab3559f118a272a Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Tue, 10 May 2022 19:02:18 +0300
Subject: [PATCH] x86: Disable kexec if system has unaccepted memory

On kexec, the target kernel has to know what memory has been accepted.
Information in EFI map is out of date and cannot be used.

boot_params.unaccepted_memory can be used to pass the bitmap between two
kernels on kexec, but the use-case is not yet implemented.

Disable kexec on machines with unaccepted memory for now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/unaccepted_memory.c | 16 ++++++++++++++++
 include/linux/kexec.h           |  2 ++
 kernel/kexec.c                  |  4 ++++
 kernel/kexec_core.c             |  5 +++++
 kernel/kexec_file.c             |  4 ++++
 5 files changed, 31 insertions(+)

diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 566c3a72aee8..529c3fd1dab3 100644
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
index ce6536f1d269..dfd9493d0b4b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -396,6 +396,8 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 void arch_kexec_protect_crashkres(void);
 void arch_kexec_unprotect_crashkres(void);
 
+int arch_kexec_load(void);
+
 #ifndef page_to_boot_pfn
 static inline unsigned long page_to_boot_pfn(struct page *page)
 {
diff --git a/kernel/kexec.c b/kernel/kexec.c
index b5e40f069768..352b3742f07a 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -195,6 +195,10 @@ static inline int kexec_load_check(unsigned long nr_segments,
 {
 	int result;
 
+	result = arch_kexec_load();
+	if (result)
+		return result;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..4d51b9271f6b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1238,3 +1238,8 @@ void __weak arch_kexec_protect_crashkres(void)
 
 void __weak arch_kexec_unprotect_crashkres(void)
 {}
+
+int __weak arch_kexec_load(void)
+{
+	return 0;
+}
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..d531df94ffbb 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -324,6 +324,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
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
 Kirill A. Shutemov
