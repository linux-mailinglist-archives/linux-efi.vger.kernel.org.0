Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A8654AFCC
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 14:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356325AbiFNMC7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 08:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356267AbiFNMCq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 08:02:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FF419C3D;
        Tue, 14 Jun 2022 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655208163; x=1686744163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5iNOOTJdL5ijo85SJxVFVHCZr4Xdf/z52sXS4dv1fJU=;
  b=GPjFgFOYMWyzEPeCBZomWjCIWOPZY522Dv6T3A92NE3e1aojWdYyCG1w
   JW048DJK2qH7U1NqIyT2v4/ln2nOihTRGuTDX+AaP7RwkJ+1uK1goMbwJ
   n2xIP/FKh4XOR5VbgPpJBKIN573jDjAmuIadD/qhcPPmgA3J7S5KnuQKW
   Go/d6YGRNtrJlEEqr9/zGko+AHssxlmPY9bYxfA4+mh9ephilIZAXevD2
   LslzqRgWmmmLD3OjlRs1dFT5L7yYNU3s8YHtomO/urnD/H59AmO74lGXc
   B+naq8J3fxpx0jmRv9LZ2EJMBWWM+uDj5Voe1JXbmF56seFMcsMrQhcXc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="276138238"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276138238"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="558311426"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2022 05:02:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DA1A7911; Tue, 14 Jun 2022 15:02:32 +0300 (EEST)
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted memory
Date:   Tue, 14 Jun 2022 15:02:28 +0300
Message-Id: <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 arch/x86/mm/unaccepted_memory.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index bcd56fe82b9e..05e216716690 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kexec.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/pfn.h>
@@ -95,3 +96,21 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
 
 	return ret;
 }
+
+static int __init unaccepted_init(void)
+{
+	if (!boot_params.unaccepted_memory)
+		return 0;
+
+#ifdef CONFIG_KEXEC_CORE
+	/*
+	 * TODO: Information on memory acceptance status has to be communicated
+	 * between kernel.
+	 */
+	pr_warn("Disable kexec: not yet supported on systems with unaccepted memory\n");
+	kexec_load_disabled = 1;
+#endif
+
+	return 0;
+}
+fs_initcall(unaccepted_init);
-- 
2.35.1

