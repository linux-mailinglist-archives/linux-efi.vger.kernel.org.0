Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080C13F9E2D
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbhH0Ro1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 13:44:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41610 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhH0Ro1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 13:44:27 -0400
Received: from zn.tnic (p200300ec2f111700cf40790d4c46ba75.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:cf40:790d:4c46:ba75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 887F01EC0537;
        Fri, 27 Aug 2021 19:43:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630086212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ksK72yJ3wySU/4v/Z0DqBPrVhHFzU36FDKHslitFLfs=;
        b=CnZ7xUnX3NltwfLtDCZBosHAKgNAyTK6OO9/+F36exMtD43KMTmwz5jrW/9RSQnPafC7ex
        V1OGb6wIYQBciY/0KWALp0WLIhIXvQulT61+QAsnWfQGKgl4LeO5QriszIWX+fC3A8nbVk
        8wnxrv59MVzTd3bMXDCEcNqxd9X6sbU=
Date:   Fri, 27 Aug 2021 19:44:09 +0200
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
Subject: Re: [PATCH Part1 v5 33/38] x86/sev: Provide support for SNP guest
 request NAEs
Message-ID: <YSkkaaXrg6+cnb9+@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-34-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-34-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:28AM -0500, Brijesh Singh wrote:
> +int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsigned long *fw_err)
> +{
> +	struct ghcb_state state;
> +	unsigned long id, flags;
> +	struct ghcb *ghcb;
> +	int ret;
> +
> +	if (!sev_feature_enabled(SEV_SNP))
> +		return -ENODEV;
> +
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
> +	if (type == GUEST_REQUEST) {
> +		id = SVM_VMGEXIT_GUEST_REQUEST;
> +	} else if (type == EXT_GUEST_REQUEST) {
> +		id = SVM_VMGEXIT_EXT_GUEST_REQUEST;
> +		ghcb_set_rax(ghcb, input->data_gpa);
> +		ghcb_set_rbx(ghcb, input->data_npages);

Hmmm, now I'm not sure. We did enum psc_op where you simply pass in the
op directly to the hardware because the enum uses the same numbers as
the actual command.

But here that @type thing is simply used to translate to the SVM_VMGEXIT
thing. So maybe you don't need it here and you can hand in the exit_code
directly:

int snp_issue_guest_request(u64 exit_code, struct snp_guest_request_data *input,
			    unsigned long *fw_err)

which you then pass in directly to...

> +	} else {
> +		ret = -EINVAL;
> +		goto e_put;
> +	}
> +
> +	ret = sev_es_ghcb_hv_call(ghcb, NULL, id, input->req_gpa, input->resp_gpa);

... this guy here:

	ret = sev_es_ghcb_hv_call(ghcb, NULL, exit_code, input->req_gpa, input->resp_gpa);

> +	if (ret)
> +		goto e_put;
> +
> +	if (ghcb->save.sw_exit_info_2) {
> +		/* Number of expected pages are returned in RBX */
> +		if (id == EXT_GUEST_REQUEST &&
> +		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
> +			input->data_npages = ghcb_get_rbx(ghcb);
> +
> +		if (fw_err)
> +			*fw_err = ghcb->save.sw_exit_info_2;
> +
> +		ret = -EIO;
> +	}
> +
> +e_put:
> +	__sev_put_ghcb(&state);
> +e_restore_irq:
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(snp_issue_guest_request);
> diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h

Why is this a separate header in the include/linux/ namespace?

Is SNP available on something which is !x86, all of a sudden?

> new file mode 100644
> index 000000000000..24dd17507789
> --- /dev/null
> +++ b/include/linux/sev-guest.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * AMD Secure Encrypted Virtualization (SEV) guest driver interface
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Brijesh Singh <brijesh.singh@amd.com>
> + *
> + */
> +
> +#ifndef __LINUX_SEV_GUEST_H_
> +#define __LINUX_SEV_GUEST_H_
> +
> +#include <linux/types.h>
> +
> +enum vmgexit_type {
> +	GUEST_REQUEST,
> +	EXT_GUEST_REQUEST,
> +
> +	GUEST_REQUEST_MAX
> +};
> +
> +/*
> + * The error code when the data_npages is too small. The error code
> + * is defined in the GHCB specification.
> + */
> +#define SNP_GUEST_REQ_INVALID_LEN	0x100000000ULL

so basically

BIT_ULL(32)

> +
> +struct snp_guest_request_data {

"snp_req_data" I guess is shorter. And having "guest" in there is
probably not needed because snp is always guest-related anyway.

> +	unsigned long req_gpa;
> +	unsigned long resp_gpa;
> +	unsigned long data_gpa;
> +	unsigned int data_npages;
> +};
> +
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
> +			    unsigned long *fw_err);
> +#else
> +
> +static inline int snp_issue_guest_request(int type, struct snp_guest_request_data *input,
> +					  unsigned long *fw_err)
> +{
> +	return -ENODEV;
> +}
> +
> +#endif /* CONFIG_AMD_MEM_ENCRYPT */
> +#endif /* __LINUX_SEV_GUEST_H__ */
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
