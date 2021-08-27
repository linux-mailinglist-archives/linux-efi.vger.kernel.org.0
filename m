Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD33F9D43
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 19:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhH0RJ2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 13:09:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36594 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhH0RJ2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 13:09:28 -0400
Received: from zn.tnic (p200300ec2f111700cf40790d4c46ba75.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:cf40:790d:4c46:ba75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7EC41EC0537;
        Fri, 27 Aug 2021 19:08:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630084113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1IhDUATGjQR+rNHqh/+Uq/GmihBPipVlLtbpDqPMf0w=;
        b=NPnM1LkQ8ko86Qej3bIemFX98Q1lQZUx7A3DpeUdcaNjipgIb92mLttY4rMYgE4bmZWZfp
        EiMriHFIUeXbOPgwR6orQhai2yMP6lSOy+CQQGsROXRT8YM26tqGPJ+IIStc9/VTPF8ZOC
        QBm3uvJVTIx5swQMGCESZ4jpK5qi78Q=
Date:   Fri, 27 Aug 2021 19:09:10 +0200
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
Message-ID: <YSkcNmeDttTdX0ga@zn.tnic>
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
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 37aa77565726..3388db814fd0 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -74,6 +74,8 @@
>  enum psc_op {
>  	SNP_PAGE_STATE_PRIVATE = 1,
>  	SNP_PAGE_STATE_SHARED,
> +	SNP_PAGE_STATE_PSMASH,
> +	SNP_PAGE_STATE_UNSMASH,

Those two are unused in this set, AFAICT.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
