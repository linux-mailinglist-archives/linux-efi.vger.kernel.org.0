Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8A23F4474
	for <lists+linux-efi@lfdr.de>; Mon, 23 Aug 2021 06:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhHWEuV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Aug 2021 00:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhHWEuV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Aug 2021 00:50:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2320C061575;
        Sun, 22 Aug 2021 21:49:38 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07d90037f6d6bcf935006e.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d900:37f6:d6bc:f935:6e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 510D11EC0464;
        Mon, 23 Aug 2021 06:49:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629694172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wemuc7ifFKY1JG/J29bORf/DK0p/Jh7ow0XTFAR5vaQ=;
        b=GWFpORbvrZ8l8jHKGAzgi+Cz1txdHdZz8F9sjQY9xBZvlXhqDXf+r0vx5NE81Hj6mQ8dlo
        +IAvWd5e/mO995J1rlhjfLNvLK6UguEzHzL5ps2RT1YPXRl84mVgESeSiD7AG2hGH8zBHe
        mNWAN3/Z4gJGd5z3iKn0CHCn+yqr8j0=
Date:   Mon, 23 Aug 2021 06:50:06 +0200
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
Message-ID: <YSMo/stGWxQgqC+Q@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-23-brijesh.singh@amd.com>
 <YR4oP+PDnmJbvfKR@zn.tnic>
 <20210819153741.h6yloeihz5vl6hvu@amd.com>
 <YR6K+BzCB9Tokw85@zn.tnic>
 <20210820032908.vqnptvjqnp7xxa6i@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820032908.vqnptvjqnp7xxa6i@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 19, 2021 at 10:29:08PM -0500, Michael Roth wrote:
> The select cases where we still fetch CPUID values from hypervisor in
> SNP need careful consideration, so for the purposes of auditing the code
> for security, or just noticing things in patches, I think it's important
> to make it clear what is the "normal" SNP case (not trusting hypervisor
> CPUID values) and what are exceptional cases (getting select values from
> hypervisor). If something got added in the future, I think something
> like:
> 
>   +sev_cpuid_hv(0x8000001f, ...)
> 
> would be more likely to raise eyebrows and get more scrutiny than:
> 
>   +sev_cpuid(0x8000001f, ...)
> 
> where it might get lost in the noise or mistaken as similar to
> sev_snp_cpuid().
> 
> Maybe a bit contrived, and probably not a big deal in practice, but
> conveying the source it in the naming does seem at least seem slightly
> better than not doing so.

Ok, makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
