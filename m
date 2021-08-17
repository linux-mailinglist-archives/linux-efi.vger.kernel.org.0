Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B128D3EF304
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 22:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhHQUEW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhHQUEW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 16:04:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A138C061764;
        Tue, 17 Aug 2021 13:03:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f117500b0ae8110978caeec.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:b0ae:8110:978c:aeec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4D9E1EC0345;
        Tue, 17 Aug 2021 22:03:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629230623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hlrAOTjcGhSiVF38sesNGSXysJAosWC4JS6gPbRDYjE=;
        b=lEBb9cFqHss2Qh+SWkKaPfkcT+XCWQi6ZwRJO1znLMRyHy8ndzt+bMBbQGKHfgpR/Mi5UK
        xp+FNG1a5wfY0SRimD370ynq5yQG0hm/AGaYbLNBugb+YiEOpbgsIS9PSONZNC++SVKjlb
        zhefgWkKrFZmOWf0nrXPRLZ/eBQKh80=
Date:   Tue, 17 Aug 2021 22:04:26 +0200
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
Subject: Re: [PATCH Part1 RFC v4 20/36] x86/sev: Use SEV-SNP AP creation to
 start secondary CPUs
Message-ID: <YRwWSizr/xoWXivV@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-21-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-21-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:50PM -0500, Brijesh Singh wrote:
> @@ -854,6 +858,207 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
>  	pvalidate_pages(vaddr, npages, 1);
>  }
>  
> +static int vmsa_rmpadjust(void *va, bool vmsa)

I know, I know it gets a bool vmsa param but you can still call it
simply rmpadjust() because this is what it does - it is a wrapper around
the insn. Just like pvalidate() and so on.

...

> +static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
> +{
> +	struct sev_es_save_area *cur_vmsa, *vmsa;
> +	struct ghcb_state state;
> +	unsigned long flags;
> +	struct ghcb *ghcb;
> +	int cpu, err, ret;
> +	u8 sipi_vector;
> +	u64 cr4;
> +
> +	if ((sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION) != GHCB_HV_FT_SNP_AP_CREATION)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Verify the desired start IP against the known trampoline start IP
> +	 * to catch any future new trampolines that may be introduced that
> +	 * would require a new protected guest entry point.
> +	 */
> +	if (WARN_ONCE(start_ip != real_mode_header->trampoline_start,
> +		      "unsupported SEV-SNP start_ip: %lx\n", start_ip))

"Unsupported... " - with a capital letter

> +		return -EINVAL;
> +
> +	/* Override start_ip with known protected guest start IP */
> +	start_ip = real_mode_header->sev_es_trampoline_start;
> +

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
