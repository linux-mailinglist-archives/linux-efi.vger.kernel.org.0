Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE503A3019
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jun 2021 18:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFJQIP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Jun 2021 12:08:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49736 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhFJQIO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 10 Jun 2021 12:08:14 -0400
Received: from zn.tnic (p200300ec2f0cf600591105fc6a1dcc4d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:5911:5fc:6a1d:cc4d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDC801EC047E;
        Thu, 10 Jun 2021 18:06:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623341177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zvbfcUZdo2PPbCEC0uqqnYngk3JUoL4NdQDuqHiqROE=;
        b=rBw20HNvAR7V08L0GMft3uBM69albdHu50Ep8a4MZGOw3fZWG+UfB3UXav/Je4dU8ESW+y
        ZPIxa2Juwmr4HNYQKQxeYeb1iwJfGFSqgGKx7tso3pjW7zOM2p3d/IkqTN/QFnstvh28uU
        gtyPvIzRUxziNpMCQWbAfdkCvWqrpcU=
Date:   Thu, 10 Jun 2021 18:06:15 +0200
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 12/22] x86/kernel: Make the bss.decrypted
 section shared in RMP table
Message-ID: <YMI4dxkwes15c+lx@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-13-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-13-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:04:06AM -0500, Brijesh Singh wrote:
> The encryption attribute for the bss.decrypted region is cleared in the
> initial page table build. This is because the section contains the data
> that need to be shared between the guest and the hypervisor.
> 
> When SEV-SNP is active, just clearing the encryption attribute in the
> page table is not enough. The page state need to be updated in the RMP
> table.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/head64.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index de01903c3735..f4c3e632345a 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -288,7 +288,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  	if (mem_encrypt_active()) {
>  		vaddr = (unsigned long)__start_bss_decrypted;
>  		vaddr_end = (unsigned long)__end_bss_decrypted;
> +
>  		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> +			/*
> +			 * When SEV-SNP is active then transition the page to shared in the RMP
> +			 * table so that it is consistent with the page table attribute change.
> +			 */
> +			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
> +
>  			i = pmd_index(vaddr);
>  			pmd[i] -= sme_get_me_mask();
>  		}
> -- 

It seems to me that all that code from the sme_encrypt_kernel(bp); call
to the end of the function should be in a separate function in sev.c
called sev_prepare_kernel(...args...) to be at least abstracted away
from the main boot path.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
