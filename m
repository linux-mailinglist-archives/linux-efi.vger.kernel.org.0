Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1366544EB9C
	for <lists+linux-efi@lfdr.de>; Fri, 12 Nov 2021 17:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbhKLQzw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 Nov 2021 11:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbhKLQzv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 Nov 2021 11:55:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB034C06127A;
        Fri, 12 Nov 2021 08:53:00 -0800 (PST)
Received: from zn.tnic (p200300ec2f10ce00d18a941e5c4028b8.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:ce00:d18a:941e:5c40:28b8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E5D11EC0529;
        Fri, 12 Nov 2021 17:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636735978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ak71EQ10flZ9mSL5t3yAY84vbHU7lTvGX8oMRPD6V6c=;
        b=OB9978bNoyrAGItBapfcHEPriavDmwwDxUAYZTJjbe8XFjSFFOihO099GfQKUkbt63fx/a
        UzITfeMcbJKcdeX3L94bx+BiNt7Y7Ll3TSr3O6m8PuqRGADJ88+fDdlpBDYlfQyovqWvOv
        acwfFYvUpJOB7Rt91bZMunJPwNPw4lo=
Date:   Fri, 12 Nov 2021 17:52:51 +0100
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
Subject: Re: [PATCH v7 01/45] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YY6b4y8Shi5dBlCK@zn.tnic>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-2-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110220731.2396491-2-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 10, 2021 at 04:06:47PM -0600, Brijesh Singh wrote:
> +void sev_enable(struct boot_params *bp)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	/* Check for the SME/SEV support leaf */
> +	eax = 0x80000000;
> +	ecx = 0;
> +	native_cpuid(&eax, &ebx, &ecx, &edx);
> +	if (eax < 0x8000001f)
> +		return;
> +
> +	/*
> +	 * Check for the SME/SEV feature:
> +	 *   CPUID Fn8000_001F[EAX]
> +	 *   - Bit 0 - Secure Memory Encryption support
> +	 *   - Bit 1 - Secure Encrypted Virtualization support
> +	 *   CPUID Fn8000_001F[EBX]
> +	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> +	 */
> +	eax = 0x8000001f;
> +	ecx = 0;
> +	native_cpuid(&eax, &ebx, &ecx, &edx);
> +	/* Check whether SEV is supported */
> +	if (!(eax & BIT(1)))
> +		return;
> +
> +	/* Check the SEV MSR whether SEV or SME is enabled */
> +	sev_status   = rd_sev_status_msr();
> +
> +	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
> +		error("SEV support indicated by CPUID, but not SEV status MSR.");

What is the practical purpose of this test?

> +	sme_me_mask = 1UL << (ebx & 0x3f);

	sme_me_mask = BIT_ULL(ebx & 0x3f);

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
