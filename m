Return-Path: <linux-efi+bounces-1608-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A0C96076C
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 12:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81938281F42
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 10:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8EF19DFB3;
	Tue, 27 Aug 2024 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muwGsXsC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6819DF94;
	Tue, 27 Aug 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754614; cv=none; b=TzJMA33Tobbe/F2kAwwOn7HkSYrNSLcusjmcmtnUzj6y9oFfi4VlgEXEdJJbBb8J1I6W0IRNsFCGl7pUrxu2ls/2U8WwRUavkmjUzUNXjJuPN24DhXr/VYDr7DtszTr9NI4BLgdFVz2+Umgr/GrF4sJZO/jMKz3N5BERiV1DsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754614; c=relaxed/simple;
	bh=+g9xoCkYNp53kFgqB/xv9zVOr2LekqHj3NvYFP/LbgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOAbRiKTj2m3uHAaL7+L2gDnikLiZXvpBhR1fed6MGfHHG2Js+aMKj5/TVEfpltuhLLg8yQur1skrFgzIe0/5v5XXn+tBPyrGrn0EAPNUfIKsqvV4oTGoT2KsO1DcC0rcy4UAMn0Wxn/4QjjXfELCUj2+TjCYg+3mdN5jWBGNq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muwGsXsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BD0C8B7A9;
	Tue, 27 Aug 2024 10:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724754613;
	bh=+g9xoCkYNp53kFgqB/xv9zVOr2LekqHj3NvYFP/LbgI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=muwGsXsCs+5oDw8h6m3kVAeJwH+4vqrsluVM+YV9jVC9b2KI1cPOry+W3f4LDXz70
	 0UGl1YKxwGX5cSZ4w53YRXRcaEQJCnQdX2fNxkKr7s9inaJK7qqvah2f3FKvihjTs8
	 y+0orJy3Iqxeqhl0DzNUE1pbvLeg2ar7ZB263ErtW32XjplFdHMX4TP19ed+z9rwq2
	 L/L8GRNOHKE3jDcfMyWy7Fx9uid3IuCUX++ZuQ9OMYoxHIbEOaNZjEwaRFV5dMgcay
	 0BPwBDoJJGZYDkVaGeUQIo97LiEu/IMzSQ4RezqNNtiYiKZoW97CAMu8cYMGbjPdJJ
	 1+X2IlloW49Qw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53346132348so6287109e87.2;
        Tue, 27 Aug 2024 03:30:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJ8CvvOhyWi19EzULM+NG3pqX2JazGsEOcDaQfxhCWJGYBUKiy7+J9LOiQb7ZaCXqQ4g1mNYAJWyIcdaORAuIF@vger.kernel.org, AJvYcCVGL9XwkHhu8fYn9Ukhy0Kyc0Oh/R4C+AR6eC5XI9WCcAKAeetNb9WaV2n7Pi/7dAjRkpwUkoUmG22u@vger.kernel.org, AJvYcCVambZZCvs5xO353+6dnteuUl9neqHqO79L7CZ/nWCfjTta9taG4H5pcQ/PJuOOjgjrp/6aWoH+Cl1E@vger.kernel.org, AJvYcCVjXcKb0ZBJmWAnvDZSxF6QQntY9CndwPzSfl1+rc12GMElGJNh4Rc+o+ZhOGDx2RLO3OYc5w6o/9BHYoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYNoabXU7TsVjcXYCjazkoYMob4DfPwd//iNaXxBgl7PviU/v
	meaV3KjrrrMK4qRh9+MpnlD0uT3BnkS3Htzcm4vSyzcuksJMlGWK45KNQemREVeIySsw1XZv6Q7
	ISyL7c5olhD9OBbtB26LB4oBppxE=
X-Google-Smtp-Source: AGHT+IHkZQ1KnddghDNMKm850oN8OkL7VQ4mHclRlcVnbsvfr1cg7Nl96LUFIwu6PQVJKn87y1kakTQ21hDf2PiXD6o=
X-Received: by 2002:a05:6512:2812:b0:530:e323:b1ca with SMTP id
 2adb3069b0e04-534387850e7mr7594496e87.25.1724754611868; Tue, 27 Aug 2024
 03:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826223835.3928819-1-ross.philipson@oracle.com> <20240826223835.3928819-9-ross.philipson@oracle.com>
In-Reply-To: <20240826223835.3928819-9-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Aug 2024 12:29:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGMMsB6BMAC9eWd2gKdEHHXGCLTXjavAK70dCz=-OyJug@mail.gmail.com>
Message-ID: <CAMj1kXGMMsB6BMAC9eWd2gKdEHHXGCLTXjavAK70dCz=-OyJug@mail.gmail.com>
Subject: Re: [PATCH v10 08/20] x86/boot: Place TXT MLE header in the
 kernel_info section
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 00:42, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> The MLE (measured launch environment) header must be locatable by the
> boot loader and TXT must be setup to do a launch with this header's
> location. While the offset to the kernel_info structure does not need
> to be at a fixed offset, the offsets in the header must be relative
> offsets from the start of the setup kernel. The support in the linker
> file achieves this.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

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
> -       .section ".rodata.kernel_info", "a"
> +/*
> + * The kernel_info structure is not placed at a fixed offest in the
> + * kernel image. So this macro and the support in the linker file
> + * allow the relative offsets for the MLE header within the kernel
> + * image to be configured at build time.
> + */
> +#define roffset(X) ((X) - kernel_info)
>
> -       .global kernel_info
> +       .section ".rodata.kernel_info", "a"
>
> -kernel_info:
> +       .balign 16
> +SYM_DATA_START(kernel_info)
>         /* Header, Linux top (structure). */
>         .ascii  "LToP"
>         /* Size. */
> @@ -17,6 +25,40 @@ kernel_info:
>         /* Maximal allowed type for setup_data and setup_indirect structs. */
>         .long   SETUP_TYPE_MAX
>
> +       /* Offset to the MLE header structure */
> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> +       .long   roffset(mle_header_offset)
> +#else
> +       .long   0
> +#endif
> +
>  kernel_info_var_len_data:
>         /* Empty for time being... */
> -kernel_info_end:
> +SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> +
> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> +       /*
> +        * The MLE Header per the TXT Specification, section 2.1
> +        * MLE capabilities, see table 4. Capabilities set:
> +        * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
> +        * bit 1: Support for RLP wakeup using MONITOR address
> +        * bit 2: The ECX register will contain the pointer to the MLE page table
> +        * bit 5: TPM 1.2 family: Details/authorities PCR usage support
> +        * bit 9: Supported format of TPM 2.0 event log - TCG compliant
> +        */
> +SYM_DATA_START(mle_header)
> +       .long   0x9082ac5a  /* UUID0 */
> +       .long   0x74a7476f  /* UUID1 */
> +       .long   0xa2555c0f  /* UUID2 */
> +       .long   0x42b651cb  /* UUID3 */
> +       .long   0x00000034  /* MLE header size */
> +       .long   0x00020002  /* MLE version 2.2 */
> +       .long   roffset(sl_stub_entry_offset) /* Linear entry point of MLE (virt. address) */
> +       .long   0x00000000  /* First valid page of MLE */
> +       .long   0x00000000  /* Offset within binary of first byte of MLE */
> +       .long   roffset(_edata_offset) /* Offset within binary of last byte + 1 of MLE */
> +       .long   0x00000227  /* Bit vector of MLE-supported capabilities */
> +       .long   0x00000000  /* Starting linear address of command line (unused) */
> +       .long   0x00000000  /* Ending linear address of command line (unused) */
> +SYM_DATA_END(mle_header)
> +#endif
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 083ec6d7722a..f82184801462 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -118,3 +118,10 @@ SECTIONS
>         }
>         ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
>  }
> +
> +#ifdef CONFIG_SECURE_LAUNCH
> +PROVIDE(kernel_info_offset      = ABSOLUTE(kernel_info - startup_32));
> +PROVIDE(mle_header_offset       = kernel_info_offset + ABSOLUTE(mle_header - startup_32));
> +PROVIDE(sl_stub_entry_offset    = kernel_info_offset + ABSOLUTE(sl_stub_entry - startup_32));
> +PROVIDE(_edata_offset           = kernel_info_offset + ABSOLUTE(_edata - startup_32));
> +#endif
> --
> 2.39.3
>

