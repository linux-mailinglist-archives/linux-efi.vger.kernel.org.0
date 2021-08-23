Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522213F47E7
	for <lists+linux-efi@lfdr.de>; Mon, 23 Aug 2021 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhHWJrs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Aug 2021 05:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhHWJrr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Aug 2021 05:47:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A71AC061575;
        Mon, 23 Aug 2021 02:47:05 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07d9000a71bbbd2fefb12e.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d900:a71:bbbd:2fef:b12e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C78C11EC0236;
        Mon, 23 Aug 2021 11:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629712019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hTGqJSB99PZEZoaa2JK7dAiOoUAbusV7wq0edRHIa4g=;
        b=Xl+0l4zzO8gkqhdQvxLoxh3KL93gUcH3KDD59hvOgRQE36+mZUnrVYTwCnD+iTjmwHCIiP
        osVL7c/3rUhL3Adl9pKRURCPUI5Q8LTL2zMZhvpc1mdFy8wydrUlp+nOJZXEKF1/wJX6Gb
        OG9ruTq3Y/JCAN274stHJ5fgoZNgwzo=
Date:   Mon, 23 Aug 2021 11:47:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 07/38] x86/sev: Add support for hypervisor
 feature VMGEXIT
Message-ID: <YSNutt/E0bm0kKsl@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-8-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-8-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:02AM -0500, Brijesh Singh wrote:
> Version 2 of GHCB specification introduced advertisement of a features
> that are supported by the hypervisor. Add support to query the HV
> features on boot.
> 
> Version 2 of GHCB specification adds several new NAEs, most of them are
> optional except the hypervisor feature. Now that hypervisor feature NAE
> is implemented, so bump the GHCB maximum support protocol version.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h |  2 ++
>  arch/x86/include/asm/sev-common.h  |  3 +++
>  arch/x86/include/asm/sev.h         |  2 +-
>  arch/x86/include/uapi/asm/svm.h    |  2 ++
>  arch/x86/kernel/sev-shared.c       | 23 +++++++++++++++++++++++
>  5 files changed, 31 insertions(+), 1 deletion(-)

I think you can simplify more.

The HV features are read twice - once in the decompressor stub and again
in kernel proper - but I guess that's not such a big deal.

Also, sev_hv_features can be static.

Diff ontop:

---
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index fb857f2e72cb..df14291d65de 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -26,7 +26,6 @@ enum sev_feature_type {
 
 extern u64 sme_me_mask;
 extern u64 sev_status;
-extern u64 sev_hv_features;
 
 void sme_encrypt_execute(unsigned long encrypted_kernel_vaddr,
 			 unsigned long decrypted_kernel_vaddr,
@@ -67,7 +66,6 @@ bool sev_feature_enabled(unsigned int feature_type);
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
-#define sev_hv_features	0ULL
 
 static inline void __init sme_early_encrypt(resource_size_t paddr,
 					    unsigned long size) { }
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 8bd67087d79e..d657c2c5a1ee 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -24,7 +24,7 @@
 static u16 __ro_after_init ghcb_version;
 
 /* Bitmap of SEV features supported by the hypervisor */
-u64 __ro_after_init sev_hv_features = 0;
+static u64 __ro_after_init sev_hv_features;
 
 static bool __init sev_es_check_cpu_features(void)
 {
@@ -51,10 +51,18 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
+/*
+ * The hypervisor features are available from GHCB version 2 onward.
+ */
 static bool get_hv_features(void)
 {
 	u64 val;
 
+	sev_hv_features = 0;
+
+	if (ghcb_version < 2)
+		return false;
+
 	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
 	VMGEXIT();
 
@@ -85,8 +93,7 @@ static bool sev_es_negotiate_protocol(void)
 
 	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
 
-	/* The hypervisor features are available from version 2 onward. */
-	if (ghcb_version >= 2 && !get_hv_features())
+	if (!get_hv_features())
 		return false;
 
 	return true;


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
