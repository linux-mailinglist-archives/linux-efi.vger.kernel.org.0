Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787463FF1A1
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhIBQlE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 12:41:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57826 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234478AbhIBQlD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 Sep 2021 12:41:03 -0400
Received: from zn.tnic (p200300ec2f0ed100559a5c00047fe4a9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:559a:5c00:47f:e4a9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DB381EC051F;
        Thu,  2 Sep 2021 18:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630600799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tInBcwV8PPz5HgTlj8s9pKw/c3XcI6QQac6T1fjypAs=;
        b=DZzM4T7hNki0hfWFToM06T3uIqTpW3S1x3aH9e5p4NtsH7K6Jdwm5Z5VMiIfsO0s2cTTXw
        U+fCaPc/GyJmhSw7rXntDZUX6+BDp5bUMg+nlj6y21g2g1mWWZT9o8FZHVsus7nbxZUZug
        8wKREAEDQ63F73TH7zNyF13KdEvoIKk=
Date:   Thu, 2 Sep 2021 18:40:34 +0200
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
Subject: Re: [PATCH Part1 v5 35/38] x86/sev: Register SNP guest request
 platform device
Message-ID: <YTD+go747TIU6k9g@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-36-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210820151933.22401-36-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:30AM -0500, Brijesh Singh wrote:
> Version 2 of GHCB specification provides NAEs that can be used by the SNP

Resolve the "NAE" abbreviation here so that it is clear what this means.

> guest to communicate with the PSP without risk from a malicious hypervisor
> who wishes to read, alter, drop or replay the messages sent.

This here says "malicious hypervisor" from which we protect from...

> In order to communicate with the PSP, the guest need to locate the secrets
> page inserted by the hypervisor during the SEV-SNP guest launch. The

... but this here says the secrets page is inserted by the same
hypervisor from which we're actually protecting.

You wanna rephrase that to explain what exactly happens so that it
doesn't sound like we're really trusting the HV with the secrets page.

> secrets page contains the communication keys used to send and receive the
> encrypted messages between the guest and the PSP. The secrets page location
> is passed through the setup_data.
> 
> Create a platform device that the SNP guest driver can bind to get the
> platform resources such as encryption key and message id to use to
> communicate with the PSP. The SNP guest driver can provide userspace
> interface to get the attestation report, key derivation, extended
> attestation report etc.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev.c     | 68 +++++++++++++++++++++++++++++++++++++++
>  include/linux/sev-guest.h |  5 +++
>  2 files changed, 73 insertions(+)

...

> +static u64 find_secrets_paddr(void)
> +{
> +	u64 pa_data = boot_params.cc_blob_address;
> +	struct cc_blob_sev_info info;
> +	void *map;
> +
> +	/*
> +	 * The CC blob contains the address of the secrets page, check if the
> +	 * blob is present.
> +	 */
> +	if (!pa_data)
> +		return 0;
> +
> +	map = early_memremap(pa_data, sizeof(info));
> +	memcpy(&info, map, sizeof(info));
> +	early_memunmap(map, sizeof(info));
> +
> +	/* Verify that secrets page address is passed */

That's hardly verifying something - if anything, it should say

	/* smoke-test the secrets page passed */

> +	if (info.secrets_phys && info.secrets_len == PAGE_SIZE)
> +		return info.secrets_phys;

... which begs the question: how do we verify the HV is not passing some
garbage instead of an actual secrets page?

I guess it is that:

"SNP_LAUNCH_UPDATE can insert two special pages into the guest’s
memory: the secrets page and the CPUID page. The secrets page contains
encryption keys used by the guest to interact with the firmware. Because
the secrets page is encrypted with the guest’s memory encryption
key, the hypervisor cannot read the keys. The CPUID page contains
hypervisor provided CPUID function values that it passes to the guest.
The firmware validates these values to ensure the hypervisor is not
providing out-of-range values."

From "4.5 Launching a Guest" in the SNP FW ABI spec.

I think that explanation above is very important wrt to explaining the
big picture how this all works with those pages injected into the guest
so I guess somewhere around here a comment should say

"See section 4.5 Launching a Guest in the SNP FW ABI spec for details
about those special pages."

or so.

> +
> +	return 0;
> +}
> +
> +static int __init add_snp_guest_request(void)

If anything, that should be called

init_snp_platform_device()

or so.

> +{
> +	struct snp_secrets_page_layout *layout;
> +	struct snp_guest_platform_data data;
> +
> +	if (!sev_feature_enabled(SEV_SNP))
> +		return -ENODEV;
> +
> +	snp_secrets_phys = find_secrets_paddr();
> +	if (!snp_secrets_phys)
> +		return -ENODEV;
> +
> +	layout = snp_map_secrets_page();
> +	if (!layout)
> +		return -ENODEV;
> +
> +	/*
> +	 * The secrets page contains three VMPCK that can be used for

What's VMPCK?

> +	 * communicating with the PSP. We choose the VMPCK0 to encrypt guest

"We" is?

> +	 * messages send and receive by the Linux. Provide the key and

"... by the Linux."?! That sentence needs more love.

> +	 * id through the platform data to the driver.
> +	 */
> +	data.vmpck_id = 0;
> +	memcpy_fromio(data.vmpck, layout->vmpck0, sizeof(data.vmpck));
> +
> +	iounmap(layout);
> +
> +	platform_device_add_data(&guest_req_device, &data, sizeof(data));

Oh look, that function can return an error.

> +
> +	if (!platform_device_register(&guest_req_device))
> +		dev_info(&guest_req_device.dev, "secret phys 0x%llx\n", snp_secrets_phys);

Make that message human-readable - not a debug one.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
