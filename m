Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACEF47D2F2
	for <lists+linux-efi@lfdr.de>; Wed, 22 Dec 2021 14:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhLVNQo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Dec 2021 08:16:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37512 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236982AbhLVNQo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 22 Dec 2021 08:16:44 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 16E271EC053B;
        Wed, 22 Dec 2021 14:16:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640178998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ldBbr5F47BRkNwI3KCFQS/UodY8GZ2FSKRo/NdAeHoA=;
        b=e69K3Rot7r+DAZgXj9o0t3pGLM4ORQDocgHgt/iL0f+XvQ11GV/SzjuIH9Zjvnw9lvaLp4
        fmyEq6Rixyg4hGNaZ1bl0Tcga3404uXxPkVRnzjAke6Q6llvGHEkMlJBlaYa+JCKI+w0dv
        9a0WJ1k2HOZsvuXUs5ZjYmGdvr7X/zs=
Date:   Wed, 22 Dec 2021 14:16:40 +0100
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
Subject: Re: [PATCH v8 11/40] x86/sev: Register GHCB memory when SEV-SNP is
 active
Message-ID: <YcMlOOPp2rTFKkeW@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-12-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-12-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:03AM -0600, Brijesh Singh wrote:
> @@ -652,7 +652,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>   * This function runs on the first #VC exception after the kernel
>   * switched to virtual addresses.
>   */
> -static bool __init sev_es_setup_ghcb(void)
> +static bool __init setup_ghcb(void)
>  {
>  	/* First make sure the hypervisor talks a supported protocol. */
>  	if (!sev_es_negotiate_protocol())

Ok, let me stare at this for a while:

This gets called by handle_vc_boot_ghcb() which gets set at build time:

arch/x86/kernel/head_64.S:372:SYM_DATA(initial_vc_handler,      .quad handle_vc_boot_ghcb)

initial_vc_handler() gets called by vc_boot_ghcb() which gets set in

early_setup_idt()

and that function already does sev_snp_register_ghcb().

So why don't you concentrate the work setup_ghcb() does before the first
#VC and call it in early_setup_idt(), before the IDT is set?

And then you get rid of yet another setup-at-first-use case?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
