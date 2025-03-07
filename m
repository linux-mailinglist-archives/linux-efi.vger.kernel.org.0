Return-Path: <linux-efi+bounces-2911-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A561CA5612C
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 07:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991D93AF77C
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 06:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823F519F13F;
	Fri,  7 Mar 2025 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foE95Wbj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3511632D9;
	Fri,  7 Mar 2025 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330265; cv=none; b=IMcUEidwn0Wdg+Hi9fJPiAtdnlPIvLQ4Sq96hLlTf5SRH2LjzEVvG1zosfil/IdO1SMnksoVbBoZ0VOn0CsGW0fjJ9uYO720FQu899rpiAauzM41sd3rYUnU3sXe/fSxeHvUUCxxtpNk7JrG92ZNnfezsGqvD9oK1ABjI1fR1p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330265; c=relaxed/simple;
	bh=6ZI3dCObpML4Ufp4w1iQZ0U98W7z0VOCfaMcxrJlCIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOpj1IluhnNkZ0VXi2oZ2mx7PK5i3qdVS9SUIKz43gai601kaH3gZE0eDSPl01sfDNuzF4me8Eosa6JIC40ohvoEX/L+oXGoXTZZFlrMzSGTSgqMFlNgnE74wVd4PnE0k5+G0U0CmDDPfwCEeuptCRP+EAIbUUL37kSRFlVy7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foE95Wbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A99DC4CED1;
	Fri,  7 Mar 2025 06:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741330264;
	bh=6ZI3dCObpML4Ufp4w1iQZ0U98W7z0VOCfaMcxrJlCIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foE95WbjLJUGTYyscTXMtsFf9MeH/But/AEKvbezNXoxDg6qRlEz4XfAzplYYZQem
	 raf6W+rXGPu8aIEO1ZZY78yBG1EHTpXKoh5n0sFncxZgkba8GpPsiskg/UKP0sNJ4V
	 ozkLvrit/URKrTMhsyDSUkkzHvI8LFMiJehSw0j0PwyYaQ4DjHQrEP4YhLA5oP/mg8
	 ABvwQspdwsa2Elj4PiDw9z/+o2qd5xqVB+Ht4KKRLtoRSiOAzo2ONaKnu+mxXN3omZ
	 JkqAGDps79dDUt7fi9DxoMFXfTukI+i5r0rqSMV3MBcD83z2PluXhRvaie+exIx3u8
	 xF1jQAyUUU/0Q==
Date: Fri, 7 Mar 2025 08:51:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 08/19] x86/boot: Place TXT MLE header in the
 kernel_info section
Message-ID: <Z8qXVLiab5L-XkgP@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-9-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-9-ross.philipson@oracle.com>

On Thu, Dec 19, 2024 at 11:42:05AM -0800, Ross Philipson wrote:
> The MLE (measured launch environment) header must be locatable by the
> boot loader and TXT must be setup to do a launch with this header's

(cutting the hairs) nit: /TXT/Intel TXT/

> location. While the offset to the kernel_info structure does not need
> to be at a fixed offset, the offsets in the header must be relative
> offsets from the start of the setup kernel. The support in the linker
> file achieves this.

This is too obfuscated and also sort of misses the action taken by
the patch.

I presume the goal here is to add relative offset to the MLE header?
Please state that explicitly.

Like for any possible kernel patch:

1. Come out clean 110% transparent.
2. Full exposure what you're doing.

;-)

That's the fastest possible path to actual results. 

> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/kernel_info.S | 50 +++++++++++++++++++++++---
>  arch/x86/boot/compressed/vmlinux.lds.S |  7 ++++
>  2 files changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
> index f818ee8fba38..a0604a0d1756 100644
> --- a/arch/x86/boot/compressed/kernel_info.S
> +++ b/arch/x86/boot/compressed/kernel_info.S
> @@ -1,12 +1,20 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
> +#include <linux/linkage.h>
>  #include <asm/bootparam.h>
>  
> -	.section ".rodata.kernel_info", "a"
> +/*
> + * The kernel_info structure is not placed at a fixed offest in the
> + * kernel image. So this macro and the support in the linker file
> + * allow the relative offsets for the MLE header within the kernel
> + * image to be configured at build time.
> + */
> +#define roffset(X) ((X) - kernel_info)
>  
> -	.global kernel_info
> +	.section ".rodata.kernel_info", "a"
>  
> -kernel_info:
> +	.balign	16
> +SYM_DATA_START(kernel_info)
>  	/* Header, Linux top (structure). */
>  	.ascii	"LToP"
>  	/* Size. */
> @@ -17,6 +25,40 @@ kernel_info:
>  	/* Maximal allowed type for setup_data and setup_indirect structs. */
>  	.long	SETUP_TYPE_MAX
>  
> +	/* Offset to the MLE header structure */
> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> +	.long	roffset(mle_header_offset)
> +#else
> +	.long	0
> +#endif
> +
>  kernel_info_var_len_data:
>  	/* Empty for time being... */
> -kernel_info_end:
> +SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> +
> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> +	/*
> +	 * The MLE Header per the TXT Specification, section 2.1
> +	 * MLE capabilities, see table 4. Capabilities set:
> +	 * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
> +	 * bit 1: Support for RLP wakeup using MONITOR address
> +	 * bit 2: The ECX register will contain the pointer to the MLE page table
> +	 * bit 5: TPM 1.2 family: Details/authorities PCR usage support
> +	 * bit 9: Supported format of TPM 2.0 event log - TCG compliant
> +	 */
> +SYM_DATA_START(mle_header)
> +	.long	0x9082ac5a  /* UUID0 */
> +	.long	0x74a7476f  /* UUID1 */
> +	.long	0xa2555c0f  /* UUID2 */
> +	.long	0x42b651cb  /* UUID3 */
> +	.long	0x00000034  /* MLE header size */
> +	.long	0x00020002  /* MLE version 2.2 */
> +	.long	roffset(sl_stub_entry_offset) /* Linear entry point of MLE (virt. address) */
> +	.long	0x00000000  /* First valid page of MLE */
> +	.long	0x00000000  /* Offset within binary of first byte of MLE */
> +	.long	roffset(_edata_offset) /* Offset within binary of last byte + 1 of MLE */
> +	.long	0x00000227  /* Bit vector of MLE-supported capabilities */
> +	.long	0x00000000  /* Starting linear address of command line (unused) */
> +	.long	0x00000000  /* Ending linear address of command line (unused) */

Nit: I'd consider aligning these to few tab offsets after even tho it
might cause checkpatch complain (which is fine when there are legitimite
reasons to do so).

Would be easier to read.

> +SYM_DATA_END(mle_header)
> +#endif
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 083ec6d7722a..f82184801462 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -118,3 +118,10 @@ SECTIONS
>  	}
>  	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
>  }
> +
> +#ifdef CONFIG_SECURE_LAUNCH
> +PROVIDE(kernel_info_offset      = ABSOLUTE(kernel_info - startup_32));
> +PROVIDE(mle_header_offset       = kernel_info_offset + ABSOLUTE(mle_header - startup_32));
> +PROVIDE(sl_stub_entry_offset    = kernel_info_offset + ABSOLUTE(sl_stub_entry - startup_32));
> +PROVIDE(_edata_offset           = kernel_info_offset + ABSOLUTE(_edata - startup_32));

I'd enumerate these one by one in the commit message. I.e. what is added
explicitly.

> +#endif
> -- 
> 2.39.3
> 

BR, Jarkko

