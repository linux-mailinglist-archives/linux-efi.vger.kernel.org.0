Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61114A6341
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 19:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbiBASIc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 13:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240279AbiBASIc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 13:08:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B7AC061714;
        Tue,  1 Feb 2022 10:08:32 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 516CF1EC0513;
        Tue,  1 Feb 2022 19:08:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643738905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HcxfykENH1gJphgVT/KA5LzM4HTc3s8TrkMJadPsK0o=;
        b=KXbXzL/iB0jKOsbk9qpYGF6/22Lz5a/yb/4wRPItKGq08Nf9mtYk6z8AxfiRU+3tIkIfEG
        FoO2WzE7cON07bDcMWOi4HfjZrFU5nNqFueDJlN3mRccAQLFfYx5q0RsEhan2J+KoAC6il
        ptqdQQQZkYvoCP+d82KprLCa/WIl2XQ=
Date:   Tue, 1 Feb 2022 19:08:21 +0100
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
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 05/43] x86/compressed/64: Detect/setup SEV/SME
 features earlier in boot
Message-ID: <Yfl3FaTGPxE7qMCq@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-6-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-6-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:26AM -0600, Brijesh Singh wrote:
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index fd9441f40457..49064a9f96e2 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -191,9 +191,8 @@ SYM_FUNC_START(startup_32)
>  	/*
>  	 * Mark SEV as active in sev_status so that startup32_check_sev_cbit()
>  	 * will do a check. The sev_status memory will be fully initialized

That "sev_status memory" formulation is just weird. Pls fix it while
you're touching that comment.

> +static inline u64 rd_sev_status_msr(void)
> +{
> +	unsigned long low, high;
> +
> +	asm volatile("rdmsr" : "=a" (low), "=d" (high) :
> +			"c" (MSR_AMD64_SEV));
> +
> +	return ((high << 32) | low);
> +}

Don't you see sev_es_rd_ghcb_msr() in that same file above? Do a common
rdmsr() helper and call it where needed, pls, instead of duplicating
code.

misc.h looks like a good place.

Extra bonus points will be given if you unify callers in
arch/x86/boot/cpucheck.c too but you don't have to - I can do that
ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
