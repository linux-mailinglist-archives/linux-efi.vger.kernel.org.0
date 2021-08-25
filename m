Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4073F7402
	for <lists+linux-efi@lfdr.de>; Wed, 25 Aug 2021 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhHYLGU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Aug 2021 07:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbhHYLGU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Aug 2021 07:06:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9086C061757;
        Wed, 25 Aug 2021 04:05:34 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ea70083109ebf80d1db9a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a700:8310:9ebf:80d1:db9a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 301C91EC036B;
        Wed, 25 Aug 2021 13:05:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629889529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FmlAznHkQY06DZXhalxR6XDiPNF7pgBGfOoUZA3D+vo=;
        b=jy+S22x5BGqIj6wZ/EDYcRcJ7KPx0io4/u4mhOd7rT/8pZqVzhf5Cv5q8b5BXMaTO9Timc
        ZVVHryDmAoSKY5ydD29ngcwnWz0d+uh9eroCZsSt0bdmcrorGFplMCnF55w0a8eFPJAonF
        XDRO2IL3+/d30AH0qTY8rSaSuGIxBaU=
Date:   Wed, 25 Aug 2021 13:06:06 +0200
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
Subject: Re: [PATCH Part1 v5 17/38] x86/mm: Add support to validate memory
 when changing C-bit
Message-ID: <YSYkHhAMSOotEzXQ@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-18-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-18-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:12AM -0500, Brijesh Singh wrote:
> +	while (hdr->cur_entry <= hdr->end_entry) {
> +		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
> +
> +		ret = sev_es_ghcb_hv_call(ghcb, NULL, SVM_VMGEXIT_PSC, 0, 0);
> +
> +		/*
> +		 * Page State Change VMGEXIT can pass error code through
> +		 * exit_info_2.
> +		 */
> +		if (WARN(ret || ghcb->save.sw_exit_info_2,
> +			 "SEV-SNP: PSC failed ret=%d exit_info_2=%llx\n",
> +			 ret, ghcb->save.sw_exit_info_2)) {
> +			ret = 1;
> +			goto out;
> +		}
> +
> +		/*
> +		 * Sanity check that entry processing is not going backward.
> +		 * This will happen only if hypervisor is tricking us.
> +		 */
> +		if (WARN(hdr->end_entry > end_entry || cur_entry > hdr->cur_entry,
> +			 "SEV-SNP:  PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",

I really meant putting the beginning of that string at the very first
position on the line:

                if (WARN(hdr->end_entry > end_entry || cur_entry > hdr->cur_entry,
"SEV-SNP: PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
                         end_entry, hdr->end_entry, cur_entry, hdr->cur_entry)) {

Exactly like this!

...

> +static void set_page_state(unsigned long vaddr, unsigned int npages, int op)
> +{
> +	unsigned long vaddr_end, next_vaddr;
> +	struct snp_psc_desc *desc;
> +
> +	vaddr = vaddr & PAGE_MASK;
> +	vaddr_end = vaddr + (npages << PAGE_SHIFT);
> +
> +	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);

And again, from previous review:

kzalloc() so that you don't have to memset() later in
__set_page_state().

> +	if (!desc)
> +		panic("SEV-SNP: failed to alloc memory for PSC descriptor\n");

"allocate" fits just fine too.

> +
> +	while (vaddr < vaddr_end) {
> +		/*
> +		 * Calculate the last vaddr that can be fit in one
> +		 * struct snp_psc_desc.
> +		 */
> +		next_vaddr = min_t(unsigned long, vaddr_end,
> +				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
> +
> +		__set_page_state(desc, vaddr, next_vaddr, op);
> +
> +		vaddr = next_vaddr;
> +	}
> +
> +	kfree(desc);
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
