Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018A43F1710
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 12:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbhHSKIA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 06:08:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39222 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237746AbhHSKH7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Aug 2021 06:07:59 -0400
Received: from zn.tnic (p200300ec2f0f6a00d82486aa7bad8753.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6a00:d824:86aa:7bad:8753])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2673C1EC046C;
        Thu, 19 Aug 2021 12:07:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629367638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sk5ZD+uyIjjDf0+aatLf0S7xfivyYV6bPrM1F6VipEk=;
        b=Y6FVeyAYXMeHPizyC5o6zJzLiuV/IhxAjDLo6FCKzcMLEDjVwawaEoZEfI1d09NV3g86Gb
        /OHjrCMIO3pHa/Hz0SpocJgGnMVprSJh/GXv8fp4B/pnD1yoxoo989RTjkJxcEffrshvM/
        o18P6GSHp4ATumKPb7v6v2tacColPgw=
Date:   Thu, 19 Aug 2021 12:07:56 +0200
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
        brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 23/36] KVM: x86: move lookup of indexed
 CPUID leafs to helper
Message-ID: <YR4tfIp+wjlaZNI/@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-24-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-24-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:53PM -0500, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> Determining which CPUID leafs have significant ECX/index values is
> also needed by guest kernel code when doing SEV-SNP-validated CPUID
> lookups. Move this to common code to keep future updates in sync.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/cpuid-indexed.h | 26 ++++++++++++++++++++++++++
>  arch/x86/kvm/cpuid.c                 | 17 ++---------------
>  2 files changed, 28 insertions(+), 15 deletions(-)
>  create mode 100644 arch/x86/include/asm/cpuid-indexed.h
> 
> diff --git a/arch/x86/include/asm/cpuid-indexed.h b/arch/x86/include/asm/cpuid-indexed.h
> new file mode 100644
> index 000000000000..f5ab746f5712
> --- /dev/null
> +++ b/arch/x86/include/asm/cpuid-indexed.h

Just call it arch/x86/include/asm/cpuid.h

And if you feel bored, you can move the cpuid* primitives from
asm/processor.h to it, in another patch so that processor.h gets
slimmer.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
