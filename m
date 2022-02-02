Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD5D4A74CF
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 16:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345551AbiBBPl6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 10:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiBBPlw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 10:41:52 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B5BC061714;
        Wed,  2 Feb 2022 07:41:52 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7AA111EC059D;
        Wed,  2 Feb 2022 16:41:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643816506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Cwn6fgc2bkMiYdHSqTZKAKhqw+1pduKMoFZH27YbT8Y=;
        b=o29kCM74d+MyTiTqpcCxRpbljquvzyplNJBA+CMkf8knQDxYiY21qy8QBJGKGgAy1eum37
        TpbIkuA177QV71dnBX46PXwEGcU86EURDpaXwBrW6u7QPwYWPhR8yBGcwwX4EnlOnVcpRZ
        GdB+9E+CacxFSZxCsUivyJA0/dxmY80=
Date:   Wed, 2 Feb 2022 16:41:46 +0100
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
Subject: Re: [PATCH v9 18/43] x86/kernel: Validate ROM memory before
 accessing when SEV-SNP is active
Message-ID: <YfqmOritPOTDZTEx@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-19-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-19-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:39AM -0600, Brijesh Singh wrote:
> @@ -197,11 +198,21 @@ static int __init romchecksum(const unsigned char *rom, unsigned long length)
>  
>  void __init probe_roms(void)
>  {
> -	const unsigned char *rom;
>  	unsigned long start, length, upper;
> +	const unsigned char *rom;
>  	unsigned char c;
>  	int i;
>  
> +	/*
> +	 * The ROM memory is not part of the E820 system RAM and is not pre-validated
> +	 * by the BIOS. The kernel page table maps the ROM region as encrypted memory,
> +	 * the SEV-SNP requires the encrypted memory must be validated before the
> +	 * access. Validate the ROM before accessing it.
> +	 */

Lemme massage it:

        /*
         * The ROM memory range is not part of the e820 table and is therefore not
         * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
         * memory, and SEV-SNP requires encrypted memory to be validated before access.
         * Do that here.
         */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
