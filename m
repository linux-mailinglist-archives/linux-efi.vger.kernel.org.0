Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF073F1E41
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhHSQrB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 12:47:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39558 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhHSQqz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Aug 2021 12:46:55 -0400
Received: from zn.tnic (p200300ec2f0f6a00ce256b49be690694.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6a00:ce25:6b49:be69:694])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E6841EC036B;
        Thu, 19 Aug 2021 18:46:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629391573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fIwP1+vEtACNuhDJX1089jOgPxnYArbRitc0H03M4jk=;
        b=G7FIywfCO3FzHcSZo6uJxFKDypgTWl3QpsMOQwYIHr8Aj0u5NhjsPUQYUhbNukPre1B3mJ
        ZrB9vGLLF2oT1Q9/lYAsLtv6ENPS2Ajr1TI20FVF9VQuMW7i4iKC2Dx+5anOnGhWfvR2oP
        P/8V4kfLy1Jfr9qisxvNsRJpg/mJ2nU=
Date:   Thu, 19 Aug 2021 18:46:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 22/36] x86/sev: move MSR-based VMGEXITs for
 CPUID to helper
Message-ID: <YR6K+BzCB9Tokw85@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-23-brijesh.singh@amd.com>
 <YR4oP+PDnmJbvfKR@zn.tnic>
 <20210819153741.h6yloeihz5vl6hvu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210819153741.h6yloeihz5vl6hvu@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 19, 2021 at 10:37:41AM -0500, Michael Roth wrote:
> That makes sense, but I think it helps in making sense of the security
> aspects of the code to know that sev_cpuid() would be fetching cpuid
> information from the hypervisor.

Why is it important for the callers to know where do we fetch the CPUID
info from?

> "msr_proto" is meant to be an indicator that it will be using the GHCB
> MSR protocol to do it, but maybe just "_hyp" is enough to get the idea
> across? I use the convention elsewhere in the series as well.
>
> So sev_cpuid_hyp() maybe?

sev_cpuid_hv() pls. We abbreviate the hypervisor as HV usually.

> In "enable SEV-SNP-validated CPUID in #VC handler", it does:
>
>   sev_snp_cpuid() -> sev_snp_cpuid_hyp(),
>
> which will call this with NULL e{a,b,c,d}x arguments in some cases. There
> are enough call-sites in sev_snp_cpuid() that it seemed worthwhile to
> add the guards so we wouldn't need to declare dummy variables for arguments.

Yah, saw that in the later patches.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
