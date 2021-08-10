Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E708B3E57DF
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 12:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbhHJKBs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 06:01:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58868 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238651AbhHJKBn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Aug 2021 06:01:43 -0400
Received: from zn.tnic (p200300ec2f0d6500ceb5d19a4916b1c0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6500:ceb5:d19a:4916:b1c0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5ADF1EC0345;
        Tue, 10 Aug 2021 12:01:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628589673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oTu32iVimlCJBEs9G1dT+aamyt1Soz6HOUNPS9Il/NU=;
        b=TKlN1ORdP1WE5hFE8kj3cV4QVXztsG+Uhq/HNqW/PUNvAPMXh9iebvzxOqUgmOn9CEUyg9
        H2Ah1rvZ/TxW5aJyn+hR2a3k/BzYHVrYksOd7opuEhBdNF4GReu+6sXDIgaqXEsu5dtTE2
        n0I7l+sppyJahrjxyF5KpRagkqDQxJU=
Date:   Tue, 10 Aug 2021 12:01:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 02/36] x86/sev: Save the negotiated GHCB
 version
Message-ID: <YRJOkQe0W9/HyjjQ@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-3-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-3-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:32PM -0500, Brijesh Singh wrote:
> The SEV-ES guest calls the sev_es_negotiate_protocol() to negotiate the
> GHCB protocol version before establishing the GHCB. Cache the negotiated
> GHCB version so that it can be used later.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev.h   |  2 +-
>  arch/x86/kernel/sev-shared.c | 17 ++++++++++++++---
>  2 files changed, 15 insertions(+), 4 deletions(-)

Also, while looking at this, all those defines in sev-common.h were
bothering me for a while now because they're an unreadable mess because
I have to go look at the GHCB spec, decode the corresponding MSR
protocol request and then go and piece together each request value by
verifying the masks...

So I did the below which is, IMO, a lot more readable as you can follow
it directly with the spec opened in parallel.

Thus, if you don't have a better idea, I'd ask you to please add this to
your set and continue defining the new MSR protocol requests this way so
that it can be readable.

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Tue, 10 Aug 2021 11:39:57 +0200
Subject: [PATCH] x86/sev: Get rid of excessive use of defines

Remove all the defines of masks and bit positions for the GHCB MSR
protocol and use comments instead which correspond directly to the spec
so that following those can be a lot easier and straightforward with the
spec opened in parallel to the code.

Aligh vertically while at it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/sev-common.h | 51 +++++++++++++++++--------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 855b0ec9c4e8..28244f8ebde2 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -18,20 +18,19 @@
 /* SEV Information Request/Response */
 #define GHCB_MSR_SEV_INFO_RESP		0x001
 #define GHCB_MSR_SEV_INFO_REQ		0x002
-#define GHCB_MSR_VER_MAX_POS		48
-#define GHCB_MSR_VER_MAX_MASK		0xffff
-#define GHCB_MSR_VER_MIN_POS		32
-#define GHCB_MSR_VER_MIN_MASK		0xffff
-#define GHCB_MSR_CBIT_POS		24
-#define GHCB_MSR_CBIT_MASK		0xff
-#define GHCB_MSR_SEV_INFO(_max, _min, _cbit)				\
-	((((_max) & GHCB_MSR_VER_MAX_MASK) << GHCB_MSR_VER_MAX_POS) |	\
-	 (((_min) & GHCB_MSR_VER_MIN_MASK) << GHCB_MSR_VER_MIN_POS) |	\
-	 (((_cbit) & GHCB_MSR_CBIT_MASK) << GHCB_MSR_CBIT_POS) |	\
+
+#define GHCB_MSR_SEV_INFO(_max, _min, _cbit)	\
+	/* GHCBData[63:48] */			\
+	((((_max) & 0xffff) << 48) |		\
+	 /* GHCBData[47:32] */			\
+	 (((_min) & 0xffff) << 32) |		\
+	 /* GHCBData[31:24] */			\
+	 (((_cbit) & 0xff)  << 24) |		\
 	 GHCB_MSR_SEV_INFO_RESP)
+
 #define GHCB_MSR_INFO(v)		((v) & 0xfffUL)
-#define GHCB_MSR_PROTO_MAX(v)		(((v) >> GHCB_MSR_VER_MAX_POS) & GHCB_MSR_VER_MAX_MASK)
-#define GHCB_MSR_PROTO_MIN(v)		(((v) >> GHCB_MSR_VER_MIN_POS) & GHCB_MSR_VER_MIN_MASK)
+#define GHCB_MSR_PROTO_MAX(v)		(((v) >> 48) & 0xffff)
+#define GHCB_MSR_PROTO_MIN(v)		(((v) >> 32) & 0xffff)
 
 /* CPUID Request/Response */
 #define GHCB_MSR_CPUID_REQ		0x004
@@ -46,27 +45,33 @@
 #define GHCB_CPUID_REQ_EBX		1
 #define GHCB_CPUID_REQ_ECX		2
 #define GHCB_CPUID_REQ_EDX		3
-#define GHCB_CPUID_REQ(fn, reg)		\
-		(GHCB_MSR_CPUID_REQ | \
-		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
-		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
+#define GHCB_CPUID_REQ(fn, reg)				\
+	/* GHCBData[11:0] */				\
+	(GHCB_MSR_CPUID_REQ |				\
+	/* GHCBData[31:12] */				\
+	(((unsigned long)reg & 0x3) << 30) |		\
+	/* GHCBData[63:32] */				\
+	(((unsigned long)fn) << 32))
 
 /* AP Reset Hold */
-#define GHCB_MSR_AP_RESET_HOLD_REQ		0x006
-#define GHCB_MSR_AP_RESET_HOLD_RESP		0x007
+#define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
+#define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
 /* GHCB Hypervisor Feature Request/Response */
-#define GHCB_MSR_HV_FT_REQ			0x080
-#define GHCB_MSR_HV_FT_RESP			0x081
+#define GHCB_MSR_HV_FT_REQ		0x080
+#define GHCB_MSR_HV_FT_RESP		0x081
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
 #define GHCB_MSR_TERM_REASON_POS	16
 #define GHCB_MSR_TERM_REASON_MASK	0xff
-#define GHCB_SEV_TERM_REASON(reason_set, reason_val)						  \
-	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
-	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
+
+#define GHCB_SEV_TERM_REASON(reason_set, reason_val)	\
+	/* GHCBData[15:12] */				\
+	(((((u64)reason_set) &  0xf) << 12) |		\
+	 /* GHCBData[23:16] */				\
+	((((u64)reason_val) & 0xff) << 16))
 
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
