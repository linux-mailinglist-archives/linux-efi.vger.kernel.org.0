Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CF53F1776
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbhHSKsD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 06:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238318AbhHSKsC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 06:48:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A80EC061575;
        Thu, 19 Aug 2021 03:47:26 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f6a00d82486aa7bad8753.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6a00:d824:86aa:7bad:8753])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 078381EC046C;
        Thu, 19 Aug 2021 12:47:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629370041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sMPlIl0Hz40M1f3YPGZe0Jffy/8QBdXGitdWTD9fvQE=;
        b=Zk5WbWk88Bwd/ar+HuFJKTkOFMbe1OEJlM433bqbt6HY16PKJe3KGAk67rCVcLfsR6fniX
        hQ/NGyRH0pkk0dkr0ma74JiSWcOdVsGrRqvKUsac0Ud+avXe7gBHEuEI4/X8S5OJDFZhQG
        CCWIW1u7f+LlC42eHiH2SJEGBHiifOQ=
Date:   Thu, 19 Aug 2021 12:47:59 +0200
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
Subject: Re: [PATCH Part1 RFC v4 24/36] x86/compressed/acpi: move EFI config
 table access to common code
Message-ID: <YR42323cUxsbQo5h@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-25-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-25-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:54PM -0500, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> Future patches for SEV-SNP-validated CPUID will also require early
> parsing of the EFI configuration. Move the related code into a set of
> helpers that can be re-used for that purpose.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/Makefile           |   1 +
>  arch/x86/boot/compressed/acpi.c             | 124 +++++---------
>  arch/x86/boot/compressed/efi-config-table.c | 180 ++++++++++++++++++++
>  arch/x86/boot/compressed/misc.h             |  50 ++++++
>  4 files changed, 272 insertions(+), 83 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/efi-config-table.c

arch/x86/boot/compressed/efi.c

should be good enough.

And in general, this patch is hard to review because it does a bunch of
things at the same time. You should split it:

- the first patch sould carve out only the functionality into helpers
without adding or changing the existing functionality.

- later ones should add the new functionality, in single logical steps.

Some preliminary comments below as far as I can:

> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 431bf7f846c3..b41aecfda49c 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -100,6 +100,7 @@ endif
>  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>  
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
> +vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi-config-table.o
>  efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
>  
>  $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 8bcbcee54aa1..e087dcaf43b3 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -24,42 +24,36 @@ struct mem_vector immovable_mem[MAX_NUMNODES*2];
>   * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
>   * ACPI_TABLE_GUID are found, take the former, which has more features.
>   */
> +#ifdef CONFIG_EFI
> +static bool
> +rsdp_find_fn(efi_guid_t guid, unsigned long vendor_table, bool efi_64,
> +	     void *opaque)
> +{
> +	acpi_physical_address *rsdp_addr = opaque;
> +
> +	if (!(efi_guidcmp(guid, ACPI_TABLE_GUID))) {
> +		*rsdp_addr = vendor_table;
> +	} else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID))) {
> +		*rsdp_addr = vendor_table;
> +		return false;

No "return false" in the ACPI_TABLE_GUID branch above? Maybe this has to
do with the preference to ACPI_20_TABLE_GUID.

In any case, this looks silly. Please do the iteration simple
and stupid without the function pointer and get rid of that
efi_foreach_conf_entry() thing - this is not firmware.

> diff --git a/arch/x86/boot/compressed/efi-config-table.c b/arch/x86/boot/compressed/efi-config-table.c
> new file mode 100644
> index 000000000000..d1a34aa7cefd
> --- /dev/null
> +++ b/arch/x86/boot/compressed/efi-config-table.c

...

> +/*

If you're going to add proper comments, make them kernel-doc. I.e., it
should start with

/**

and then use

./scripts/kernel-doc -none arch/x86/boot/compressed/efi-config-table.c

to check them all they're proper.


> + * Given boot_params, retrieve the physical address of EFI system table.
> + *
> + * @boot_params:        pointer to boot_params
> + * @sys_table_pa:       location to store physical address of system table
> + * @is_efi_64:          location to store whether using 64-bit EFI or not
> + *
> + * Returns 0 on success. On error, return params are left unchanged.
> + */
> +int
> +efi_bp_get_system_table(struct boot_params *boot_params,

There's no need for the "_bp_" - just efi_get_system_table(). Ditto for
the other naming.

I'll review the rest properly after you've split it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
