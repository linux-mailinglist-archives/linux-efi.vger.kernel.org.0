Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9A3E5905
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 13:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhHJLYz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 07:24:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43204 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhHJLYy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Aug 2021 07:24:54 -0400
Received: from zn.tnic (p200300ec2f0d6500ceb5d19a4916b1c0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6500:ceb5:d19a:4916:b1c0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9716D1EC0345;
        Tue, 10 Aug 2021 13:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628594662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6S+ETniR7WhqqlO2dSqQJM2eqSUaUqBNPhhFnNKJ9cU=;
        b=dFA4QAN1+pvTGtiXZZkPLc/N+UbZ8l9GSpS+VKA6mjulGQJwNAT6u/fAFFB/sOH7It96ik
        uTbTx3CIBStUSXy0J8iJjFs7wlCyH/RcNhXfcaD/Jjx8Ri8OUH1RlBOLv2pilm5/kpzu7X
        /vUxoD3TXAgx8B/iAQHICkq8PvYBdN4=
Date:   Tue, 10 Aug 2021 13:25:07 +0200
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
Subject: Re: [PATCH Part1 RFC v4 04/36] x86/mm: Add sev_feature_enabled()
 helper
Message-ID: <YRJiEwvUJpO9LUfC@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-5-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-5-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:34PM -0500, Brijesh Singh wrote:
> The sev_feature_enabled() helper can be used by the guest to query whether
> the SNP - Secure Nested Paging feature is active.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h |  8 ++++++++
>  arch/x86/include/asm/msr-index.h   |  2 ++
>  arch/x86/mm/mem_encrypt.c          | 14 ++++++++++++++
>  3 files changed, 24 insertions(+)

This will get replaced by this I presume:

https://lkml.kernel.org/r/cover.1627424773.git.thomas.lendacky@amd.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
