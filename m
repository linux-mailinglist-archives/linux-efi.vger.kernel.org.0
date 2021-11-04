Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B667C445465
	for <lists+linux-efi@lfdr.de>; Thu,  4 Nov 2021 14:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhKDOBl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Nov 2021 10:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhKDOBk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Nov 2021 10:01:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD1EC061714;
        Thu,  4 Nov 2021 06:59:02 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f2b00292987ac0c06fcda.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:2929:87ac:c06:fcda])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07B031EC0570;
        Thu,  4 Nov 2021 14:59:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636034341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7LX03mAYK04otWZOoY71ALabwci0dk1MWKslK4zWu2I=;
        b=KR+lLKKLVG+OimGX0G+TVfeAzPp3+DAiK71o99+TN8MKguX6+YMASSnyMiA33sWx6z9RXk
        PtVWl2Hv+ntT4D5AF+ZUH0n29RNRaoDCwwzmVLEOIeXtzSFlfK82CoRS/vUfvkp7K/I00A
        cmZCFAiEROjuNQ7+z/kvpv4vyBBOcTY=
Date:   Thu, 4 Nov 2021 14:58:49 +0100
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
Subject: Re: [PATCH v6 14/42] x86/sev: Register GHCB memory when SEV-SNP is
 active
Message-ID: <YYPnGeW+8tlNgW34@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-15-brijesh.singh@amd.com>
 <YYFs+5UUMfyDgh/a@zn.tnic>
 <aea0e0c8-7f03-b9db-3084-f487a233c50b@amd.com>
 <YYGGv6EtWrw7cnLA@zn.tnic>
 <a975dfbf-f9bb-982e-9814-7259bc075b71@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a975dfbf-f9bb-982e-9814-7259bc075b71@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 03, 2021 at 03:10:16PM -0500, Brijesh Singh wrote:
> Looking at the secondary CPU bring up path it seems that we will not be
> getting #VC until the early_setup_idt() is called. I am thinking to add
> function to register the GHCB from the early_setup_idt()
> 
> early_setup_idt()
> {
>   ...
>   if (IS_ENABLED(CONFIG_MEM_ENCRYPT))
>     sev_snp_register_ghcb()
>   ...
> }
> 
> The above will cover the APs

That will cover the APs during early boot as that is being called from
asm.

> and for BSP case I can call the same function just after the final IDT
> is loaded

Why after and not before?

> cpu_init_exception_handling()
> {
>    ...
>    ...
>    /* Finally load the IDT */
>    load_current_idt();
> 
>    if (IS_ENABLED(CONFIG_MEM_ENCRYPT))
>      sev_snp_register_ghcb()
> 
> }

That is also called on the APs - not only the BSP. trap_init() calls it
from start_kernel() which is the BSP and cpu_init_secondary() calls it
too, which is ofc the APs.

I guess that should be ok since you're calling the same function from
both but WTH do I know...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
