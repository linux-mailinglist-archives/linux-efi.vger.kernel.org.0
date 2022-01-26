Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D1049D1C5
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 19:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbiAZSfQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jan 2022 13:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244223AbiAZSfO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jan 2022 13:35:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1738C06173B;
        Wed, 26 Jan 2022 10:35:13 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E87731EC0523;
        Wed, 26 Jan 2022 19:35:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643222108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=96A3476Qu+7SjsWY2hSBFw1C0Xznd/Zn6tLR1Pkup4Q=;
        b=jmiefYcsIsHCM6x1nXxo3vEUg7F1AGEwOS9cHwytrWbNL/9AD1ypRH2QAD6Tl6zikwBu0d
        aQKA2K0jhIfsl4e3eBUV8VyXS1d6ygLtnULQpASCWSDAmLARaktXvbZlmc1Sv9Cr64YOiX
        J1apVcrQoag5o9EvKUnS6zi8V7qwRGo=
Date:   Wed, 26 Jan 2022 19:35:04 +0100
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
Subject: Re: [PATCH v8 35/40] x86/sev: use firmware-validated CPUID for
 SEV-SNP guests
Message-ID: <YfGUWLmg82G+l4jU@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-36-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-36-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:27AM -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> SEV-SNP guests will be provided the location of special 'secrets' and
> 'CPUID' pages via the Confidential Computing blob. This blob is
> provided to the run-time kernel either through bootparams field that
						^
						a


> was initialized by the boot/compressed kernel, or via a setup_data
> structure as defined by the Linux Boot Protocol.
> 
> Locate the Confidential Computing from these sources and, if found,
				   ^
				   blob

> use the provided CPUID page/table address to create a copy that the
> run-time kernel will use when servicing cpuid instructions via a #VC
					  ^^^^^

Please capitalize all instruction mnemonics in text.

> +/*
> + * It is useful from an auditing/testing perspective to provide an easy way
> + * for the guest owner to know that the CPUID table has been initialized as
> + * expected, but that initialization happens too early in boot to print any
> + * sort of indicator, and there's not really any other good place to do it. So
> + * do it here, and while at it, go ahead and re-verify that nothing strange has
> + * happened between early boot and now.
> + */
> +static int __init snp_cpuid_check_status(void)

That function's redundant now, I believe, since we terminate the guest
if there's something wrong with the CPUID page.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
