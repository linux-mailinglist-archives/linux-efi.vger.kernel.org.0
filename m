Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3413CA59C
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhGOSk0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 14:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhGOSkY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Jul 2021 14:40:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFDFC061764
        for <linux-efi@vger.kernel.org>; Thu, 15 Jul 2021 11:37:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p22so6292924pfh.8
        for <linux-efi@vger.kernel.org>; Thu, 15 Jul 2021 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b0k1g7//WbCfpqVPknCaS62XmrgAPcdGgqibAcypVAA=;
        b=ZuFddVCnGCX2gwIB5owc8oQOjN5zz0iQq+GFG5cfKoR26QRYNgdBRLlV3L/mvPgaVz
         3RSdZ1WZmIi6LR4QnYs4JYaAWwwS3PhNqzoc1HTPdWdiSB5oVyimTgEpYxvbGd32qPXV
         SOz3HElhRqllBnhDZ5bF58P3tzlMN3fbvCPenHgvmO64sLAyHp/ufhZGI0KPeyP9ynbR
         eTFn1muNqJuSgge26KfL3qPMjaxtfPP6p821CXz1OjEck/wH1Ves4PKSg51ImOEyq6io
         ycwb28L2SK3acNcoroR5aFuYlh4D5XqwRE601MJZRiXt2Uv7GELoNr7jC3gwYtNmeagF
         mRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b0k1g7//WbCfpqVPknCaS62XmrgAPcdGgqibAcypVAA=;
        b=jYPghDJHfLCy9ZreqhLNSgblTkuL8bh9N0vumvrcuPlnPWohmUhoCHvzYM+NzitRg1
         YwL3mRSwsVFqDSFOJr6eJvi31JmkmQzIm/tmoTYn1RE7U/NiiGEVlcuAuOm61rc+LBMM
         PFfIeodg3xKBJV28DWixtD9LfesdkRJGi5Ym8TDzplPMbO2hsjN/Gnn1LPa09Wo7n83Z
         IRXvP6k92j+Toxg2IRSS+82aSd4WgvOsNKxSUz5Lkt/HoU7TvVxwBTS+zrOdQfK8p06M
         dgSQNPfMhwAnaXFBXlQIoT0SYPAaaGvgI2YKVoMpOd7USYgmFNc1kzNtrjZeIRhs1eXm
         jRvQ==
X-Gm-Message-State: AOAM530yLbdKc90tSUCj9XSXM1M5dae86csyCuNi37NsvEfxgOBk5sSr
        83xN0/gAEKQqcKHd+IqKY/OvCA==
X-Google-Smtp-Source: ABdhPJxqkYY9aLIvqtUQ9od6UU93/eKmeKYJstKVrJ9ha/ruBvMB7R0iAD4iuyNlkS3yLOCj5ZJZtw==
X-Received: by 2002:aa7:8154:0:b029:310:70d:a516 with SMTP id d20-20020aa781540000b0290310070da516mr6181701pfn.63.1626374249730;
        Thu, 15 Jul 2021 11:37:29 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y82sm7396193pfb.121.2021.07.15.11.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:37:29 -0700 (PDT)
Date:   Thu, 15 Jul 2021 18:37:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 05/40] x86/sev: Add RMP entry lookup helpers
Message-ID: <YPCAZaROOHNskGlO@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-6-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-6-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> The snp_lookup_page_in_rmptable() can be used by the host to read the RMP
> entry for a given page. The RMP entry format is documented in AMD PPR, see
> https://bugzilla.kernel.org/attachment.cgi?id=296015.

Ewwwwww, the RMP format isn't architectural!?

  Architecturally the format of RMP entries are not specified in APM. In order
  to assist software, the following table specifies select portions of the RMP
  entry format for this specific product.

I know we generally don't want to add infrastructure without good reason, but on
the other hand exposing a microarchitectural data structure to the kernel at large
is going to be a disaster if the format does change on a future processor.

Looking at the future patches, dump_rmpentry() is the only power user, e.g.
everything else mostly looks at "assigned" and "level" (and one ratelimited warn
on "validated" in snp_make_page_shared(), but I suspect that particular check
can and should be dropped).

So, what about hiding "struct rmpentry" and possibly renaming it to something
scary/microarchitectural, e.g. something like

/*
 * Returns 1 if the RMP entry is assigned, 0 if it exists but is not assigned,
 * and -errno if there is no corresponding RMP entry.
 */
int snp_lookup_rmpentry(struct page *page, int *level)
{
	unsigned long phys = page_to_pfn(page) << PAGE_SHIFT;
	struct rmpentry *entry, *large_entry;
	unsigned long vaddr;

	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
		return -ENXIO;

	vaddr = rmptable_start + rmptable_page_offset(phys);
	if (unlikely(vaddr > rmptable_end))
		return -EXNIO;

	entry = (struct rmpentry *)vaddr;

	/* Read a large RMP entry to get the correct page level used in RMP entry. */
	vaddr = rmptable_start + rmptable_page_offset(phys & PMD_MASK);
	large_entry = (struct rmpentry *)vaddr;
	*level = RMP_TO_X86_PG_LEVEL(rmpentry_pagesize(large_entry));

	return !!entry->assigned;
}


And then move dump_rmpentry() (or add a helper) in sev.c so that "struct rmpentry"
can be declared in sev.c.

> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev.h |  4 +--
>  arch/x86/kernel/sev.c      | 26 +++++++++++++++++++
>  include/linux/sev.h        | 51 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/sev.h
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 6c23e694a109..9e7e7e737f55 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -9,6 +9,7 @@
>  #define __ASM_ENCRYPTED_STATE_H
>  
>  #include <linux/types.h>
> +#include <linux/sev.h>

Why move things to linux/sev.h?  AFAICT, even at the end of the series, the only
users of anything in this file all reside somewhere in arch/x86.

>  #include <asm/insn.h>
>  #include <asm/sev-common.h>
>  #include <asm/bootparam.h>
> @@ -75,9 +76,6 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>  /* Software defined (when rFlags.CF = 1) */
>  #define PVALIDATE_FAIL_NOUPDATE		255
>  
> -/* RMP page size */
> -#define RMP_PG_SIZE_4K			0
> -
>  #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
>  
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index f9d813d498fa..1aed3d53f59f 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -49,6 +49,8 @@
>  #define DR7_RESET_VALUE        0x400
>  
>  #define RMPTABLE_ENTRIES_OFFSET        0x4000
> +#define RMPENTRY_SHIFT			8
> +#define rmptable_page_offset(x)	(RMPTABLE_ENTRIES_OFFSET + (((unsigned long)x) >> RMPENTRY_SHIFT))
>  
>  /* For early boot hypervisor communication in SEV-ES enabled guests */
>  static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
> @@ -2319,3 +2321,27 @@ static int __init snp_rmptable_init(void)
>   * passthough state, and it is available after subsys_initcall().
>   */
>  fs_initcall(snp_rmptable_init);
> +
> +struct rmpentry *snp_lookup_page_in_rmptable(struct page *page, int *level)

Maybe just snp_get_rmpentry?  Or snp_lookup_rmpentry?  I'm guessing the name was
chosen to align with e.g. lookup_address_in_mm, but IMO the lookup_address helpers
are oddly named.

> +{
> +	unsigned long phys = page_to_pfn(page) << PAGE_SHIFT;
> +	struct rmpentry *entry, *large_entry;
> +	unsigned long vaddr;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
> +		return NULL;
> +
> +	vaddr = rmptable_start + rmptable_page_offset(phys);
> +	if (unlikely(vaddr > rmptable_end))
> +		return NULL;
> +
> +	entry = (struct rmpentry *)vaddr;
> +
> +	/* Read a large RMP entry to get the correct page level used in RMP entry. */
> +	vaddr = rmptable_start + rmptable_page_offset(phys & PMD_MASK);
> +	large_entry = (struct rmpentry *)vaddr;
> +	*level = RMP_TO_X86_PG_LEVEL(rmpentry_pagesize(large_entry));
> +
> +	return entry;
> +}
