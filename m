Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4FF3F4F90
	for <lists+linux-efi@lfdr.de>; Mon, 23 Aug 2021 19:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhHWRfy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Aug 2021 13:35:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43398 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhHWRfx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 23 Aug 2021 13:35:53 -0400
Received: from zn.tnic (p200300ec2f07d9009c2198849783fa17.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d900:9c21:9884:9783:fa17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 13E521EC0528;
        Mon, 23 Aug 2021 19:35:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629740105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TiZALGDSEWIiufJ1GIkWJr3HKfwJGDBp71m/QWnuYZs=;
        b=YkDCDo7P/QnwB/Jrx31RJAjVBTsWcd5qj8YgpONQ1x8EbWo7ctcvcYu5P1dW9oMHqdpGhh
        +gVuhIcDOlPUDx1WNR6Ag2yNNOvAhoxL8txwYh6ukepPYbWlhebXHKwOasCFnNGrWPNzVe
        tkRQfz/Yuowsq26rHyGYFNk1KqwYa/c=
Date:   Mon, 23 Aug 2021 19:35:46 +0200
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
Subject: Re: [PATCH Part1 v5 13/38] x86/sev: Register GHCB memory when
 SEV-SNP is active
Message-ID: <YSPcck0xAohlWHyd@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-14-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-14-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:08AM -0500, Brijesh Singh wrote:
> The SEV-SNP guest is required to perform GHCB GPA registration. This is
> because the hypervisor may prefer that a guest use a consistent and/or
> specific GPA for the GHCB associated with a vCPU. For more information,
> see the GHCB specification section GHCB GPA Registration.
> 
> During the boot, init_ghcb() allocates a per-cpu GHCB page. On very first
> VC exception, the exception handler switch to using the per-cpu GHCB page
> allocated during the init_ghcb(). The GHCB page must be registered in
> the current vcpu context.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev-internal.h | 12 ++++++++++++
>  arch/x86/kernel/sev.c          | 28 ++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 arch/x86/kernel/sev-internal.h
> 
> diff --git a/arch/x86/kernel/sev-internal.h b/arch/x86/kernel/sev-internal.h
> new file mode 100644
> index 000000000000..0fb7324803b4
> --- /dev/null
> +++ b/arch/x86/kernel/sev-internal.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Forward declarations for sev-shared.c
> + *
> + * Author: Brijesh Singh <brijesh.singh@amd.com>
> + */
> +
> +#ifndef __X86_SEV_INTERNAL_H__
> +
> +static void snp_register_ghcb_early(unsigned long paddr);
> +
> +#endif	/* __X86_SEV_INTERNAL_H__ */

I believe you don't need that header if you move __sev_get_ghcb()
and snp_register_ghcb() under the #include "sev-shared.c" so that
snp_register_ghcb_early() is visible by then.

diff --git a/arch/x86/kernel/sev-internal.h b/arch/x86/kernel/sev-internal.h
deleted file mode 100644
index 0fb7324803b4..000000000000
--- a/arch/x86/kernel/sev-internal.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Forward declarations for sev-shared.c
- *
- * Author: Brijesh Singh <brijesh.singh@amd.com>
- */
-
-#ifndef __X86_SEV_INTERNAL_H__
-
-static void snp_register_ghcb_early(unsigned long paddr);
-
-#endif	/* __X86_SEV_INTERNAL_H__ */
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 9ab541b893c2..0ec0602e4bed 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -31,8 +31,6 @@
 #include <asm/smp.h>
 #include <asm/cpu.h>
 
-#include "sev-internal.h"
-
 #define DR7_RESET_VALUE        0x400
 
 /* For early boot hypervisor communication in SEV-ES enabled guests */
@@ -200,69 +198,6 @@ void noinstr __sev_es_ist_exit(void)
 	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
 }
 
-static void snp_register_ghcb(struct sev_es_runtime_data *data, unsigned long paddr)
-{
-	if (data->snp_ghcb_registered)
-		return;
-
-	snp_register_ghcb_early(paddr);
-
-	data->snp_ghcb_registered = true;
-}
-
-/*
- * Nothing shall interrupt this code path while holding the per-CPU
- * GHCB. The backup GHCB is only for NMIs interrupting this path.
- *
- * Callers must disable local interrupts around it.
- */
-static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	WARN_ON(!irqs_disabled());
-
-	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
-
-	if (unlikely(data->ghcb_active)) {
-		/* GHCB is already in use - save its contents */
-
-		if (unlikely(data->backup_ghcb_active)) {
-			/*
-			 * Backup-GHCB is also already in use. There is no way
-			 * to continue here so just kill the machine. To make
-			 * panic() work, mark GHCBs inactive so that messages
-			 * can be printed out.
-			 */
-			data->ghcb_active        = false;
-			data->backup_ghcb_active = false;
-
-			instrumentation_begin();
-			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
-			instrumentation_end();
-		}
-
-		/* Mark backup_ghcb active before writing to it */
-		data->backup_ghcb_active = true;
-
-		state->ghcb = &data->backup_ghcb;
-
-		/* Backup GHCB content */
-		*state->ghcb = *ghcb;
-	} else {
-		state->ghcb = NULL;
-		data->ghcb_active = true;
-	}
-
-	/* SEV-SNP guest requires that GHCB must be registered. */
-	if (sev_feature_enabled(SEV_SNP))
-		snp_register_ghcb(data, __pa(ghcb));
-
-	return ghcb;
-}
-
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
@@ -518,6 +453,69 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
+static void snp_register_ghcb(struct sev_es_runtime_data *data, unsigned long paddr)
+{
+	if (data->snp_ghcb_registered)
+		return;
+
+	snp_register_ghcb_early(paddr);
+
+	data->snp_ghcb_registered = true;
+}
+
+/*
+ * Nothing shall interrupt this code path while holding the per-CPU
+ * GHCB. The backup GHCB is only for NMIs interrupting this path.
+ *
+ * Callers must disable local interrupts around it.
+ */
+static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	WARN_ON(!irqs_disabled());
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	if (unlikely(data->ghcb_active)) {
+		/* GHCB is already in use - save its contents */
+
+		if (unlikely(data->backup_ghcb_active)) {
+			/*
+			 * Backup-GHCB is also already in use. There is no way
+			 * to continue here so just kill the machine. To make
+			 * panic() work, mark GHCBs inactive so that messages
+			 * can be printed out.
+			 */
+			data->ghcb_active        = false;
+			data->backup_ghcb_active = false;
+
+			instrumentation_begin();
+			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
+			instrumentation_end();
+		}
+
+		/* Mark backup_ghcb active before writing to it */
+		data->backup_ghcb_active = true;
+
+		state->ghcb = &data->backup_ghcb;
+
+		/* Backup GHCB content */
+		*state->ghcb = *ghcb;
+	} else {
+		state->ghcb = NULL;
+		data->ghcb_active = true;
+	}
+
+	/* SEV-SNP guest requires that GHCB must be registered. */
+	if (sev_feature_enabled(SEV_SNP))
+		snp_register_ghcb(data, __pa(ghcb));
+
+	return ghcb;
+}
+
 static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
