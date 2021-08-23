Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE583F517C
	for <lists+linux-efi@lfdr.de>; Mon, 23 Aug 2021 21:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhHWTpx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Aug 2021 15:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhHWTpu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Aug 2021 15:45:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF29BC061575;
        Mon, 23 Aug 2021 12:45:07 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07d9004625a010a35f3837.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d900:4625:a010:a35f:3837])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 40FB61EC0464;
        Mon, 23 Aug 2021 21:45:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629747902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7KwRhm2sTocXwEJarLiY5c63owI3J860DzvYo8UM4I8=;
        b=ZMOl0Uklc7bTZqwVps5ltCyOrz0+FYqz+dpP/aACFQ5Dos6WO4MgcEOy3r0FBiZjU+kJ+5
        N0XA+EgVhoccBaK31KeyV4yvoOZ6kurVQy4BmaOX4gvBTG52GczLHUiF4GOTbuMVEr85yf
        6fDl9R5iUfEDGLSzg2RsxzO59rtBet8=
Date:   Mon, 23 Aug 2021 21:45:44 +0200
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
Subject: [PATCH] x86/sev: Remove do_early_exception() forward declarations
Message-ID: <YSP66L7m4J6c5cNL@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-14-brijesh.singh@amd.com>
 <YSPcck0xAohlWHyd@zn.tnic>
 <815a054a-b0a2-e549-8d1c-086540521979@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <815a054a-b0a2-e549-8d1c-086540521979@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 23, 2021 at 01:56:06PM -0500, Brijesh Singh wrote:
> thanks, I will merge this in next version.

Thx.

One more thing I stumbled upon while staring at this, see below. Can you
add it to your set or should I simply apply it now?

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Mon, 23 Aug 2021 20:01:35 +0200
Subject: [PATCH] x86/sev: Remove do_early_exception() forward declarations

There's a perfectly fine prototype in the asm/setup.h header. Use it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/sev.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..700ef31d32f8 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -26,6 +26,7 @@
 #include <asm/fpu/internal.h>
 #include <asm/processor.h>
 #include <asm/realmode.h>
+#include <asm/setup.h>
 #include <asm/traps.h>
 #include <asm/svm.h>
 #include <asm/smp.h>
@@ -96,9 +97,6 @@ struct ghcb_state {
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
-/* Needed in vc_early_forward_exception */
-void do_early_exception(struct pt_regs *regs, int trapnr);
-
 static void __init setup_vc_stacks(int cpu)
 {
 	struct sev_es_runtime_data *data;
@@ -240,9 +238,6 @@ static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 	return ghcb;
 }
 
-/* Needed in vc_early_forward_exception */
-void do_early_exception(struct pt_regs *regs, int trapnr);
-
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
