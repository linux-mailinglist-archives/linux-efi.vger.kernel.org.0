Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104F649E755
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jan 2022 17:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbiA0QVR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Jan 2022 11:21:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49234 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238119AbiA0QVQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Jan 2022 11:21:16 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F39D1EC051E;
        Thu, 27 Jan 2022 17:21:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643300470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JV2DpgJLMt5fK61b8cQw16AJuA9Yd0fzMbdEJ84O1bI=;
        b=DYVY3w3MlRb/vS+Uoa0UNXjOHvdGQJvfENWZIgRm9CKBGmOIsZB/aUtz6WnHSEiS1BzdPL
        ZXRMTdQ6KSQIEWzu3DIxLtPvR/68xS1elZsq0cP/EF6jlpKI1Z1Zt5ku4IdgdFMhD8HRbv
        /OGEY01w0PdI/APwHhVGffqHITSR6Rc=
Date:   Thu, 27 Jan 2022 17:21:06 +0100
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 36/40] x86/sev: Provide support for SNP guest request
 NAEs
Message-ID: <YfLGcp8q5f+OW72p@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-37-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-37-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:28AM -0600, Brijesh Singh wrote:
> Version 2 of GHCB specification provides SNP_GUEST_REQUEST and
> SNP_EXT_GUEST_REQUEST NAE that can be used by the SNP guest to communicate
> with the PSP.
> 
> While at it, add a snp_issue_guest_request() helper that can be used by

Not "that can" but "that will".

> driver or other subsystem to issue the request to PSP.
> 
> See SEV-SNP and GHCB spec for more details.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev-common.h |  3 ++
>  arch/x86/include/asm/sev.h        | 14 +++++++++
>  arch/x86/include/uapi/asm/svm.h   |  4 +++
>  arch/x86/kernel/sev.c             | 51 +++++++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 673e6778194b..346600724b84 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -128,6 +128,9 @@ struct snp_psc_desc {
>  	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
>  } __packed;
>  
> +/* Guest message request error code */
> +#define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)

SZ_4G is more descriptive, perhaps...

> +int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
> +{
> +	struct ghcb_state state;
> +	unsigned long flags;
> +	struct ghcb *ghcb;
> +	int ret;
> +
> +	if (!cc_platform_has(CC_ATTR_SEV_SNP))
> +		return -ENODEV;
> +
> +	/* __sev_get_ghcb() need to run with IRQs disabled because it using per-cpu GHCB */

			   needs 				it is using a

> +	local_irq_save(flags);
> +
> +	ghcb = __sev_get_ghcb(&state);
> +	if (!ghcb) {
> +		ret = -EIO;
> +		goto e_restore_irq;
> +	}
> +
> +	vc_ghcb_invalidate(ghcb);
> +
> +	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
> +		ghcb_set_rax(ghcb, input->data_gpa);
> +		ghcb_set_rbx(ghcb, input->data_npages);
> +	}
> +
> +	ret = sev_es_ghcb_hv_call(ghcb, true, NULL, exit_code, input->req_gpa, input->resp_gpa);
					      ^^^^^

That's ctxt which is accessed without a NULL check in
verify_exception_info().

Why aren't you allocating a ctxt on stack like the other callers do?


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
