Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96271EF72B
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 14:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgFEMUe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 08:20:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:50071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgFEMUb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Jun 2020 08:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591359617;
        bh=QuVh4tXlmbo59wrgM3ihTxLLVs+WNtFLVjEY0PQ0Aso=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BS1bc3sqGuLDK3QeM0esVXJN/B/iSTYlKCQnd/mTUSaVwqF/Z0aJCkvddceXzMXUV
         s4U1dtK+Ykc5OWhFxzn+W+HnAykDLFF8od/4AxBaMweC712VhUpNUxbu//uV9SQKPd
         yJC4zN4vP1806DPB+xWxblNK55hrpRgWC4Cp2OK4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([88.152.145.75]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1jKPIC1s6P-00Pay4; Fri, 05
 Jun 2020 14:20:17 +0200
Subject: Re: [PATCH] efi/arm: decompressor: deal with HYP mode boot gracefully
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        linux@armlinux.org.uk
References: <20200605115200.413921-1-ardb@kernel.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <4498d910-f5cb-8559-afba-34710e9ca730@gmx.de>
Date:   Fri, 5 Jun 2020 14:20:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605115200.413921-1-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rz1so8X0ObrIQ4OXXaWAvEdPfRUTeO+MJ2zyi7omyTNVxREWm5P
 L19rpRfW/hWKHqCTpf5oxLyfBbcJsFRVddit4JORRESVdKQ+++2sWX+bwL9OYwwTEMEB3yb
 kGJ9dd2/fMpDy6RXNjYzZ5AQydezrj7OC7VW5G8pf+gQlglvCjMdIQ8/TjWo+NuLFmS35Hc
 0/cUiHE83Bw8p6pmL2Ejw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7w/4Swdt7mE=:4bLsfTEoDT0pVdTLs7EC8Q
 Ul/T/ch/80wIxN9kkVTkgocbuOItp0f4fsJq5L2NfSLCAM0eBCmeYJtRp1sGeXB7CPWJhq9Yd
 sokYK5LIy/YHNxrwQ/S+TQTbL6UJWAyX0/09eiHBIbrtCq/c02e1W8G5EAdGjazs0tXh0BXly
 U2glRM/x2m/EpVsK/gPrrrrAMFWpsvdYSol+8JV33SO2BwI+AHOhYwbmvzPzaaQx0IOzT0Q78
 nMRK5Pn1zAMAUfmS14tBiifFtTeFZOuRlETEhAHeRAnL3pSWT/LDohLRS/YophE9XSL9Q5qN6
 SIeSQ4sZwd5Nl70rf9HwAT4unvjrdNqjJyFtNc4fxLYL5mXPy7iFbRRLXb9xtvKIS5/WP1tkp
 LDfnXdMZ73bVWm1F5F6TgjVqcQlq/GezYL8NzCAWmy94OHCc+YpDoUWuKzjOGh3iY0EnG/pfd
 RlUTqt8OAvYk0KRuNyKUQFx+fmO7Puqr4SIYxAocH1NA8qGoTFnJGhP8fqHEhQ5NpJFjTzRk4
 LLp6YuXAqNp7ByXgRfx1oST9jpsAN+TWBAtwjDlZS2RHiFAA5e74vXwJFqks4ibXQnqLao1fn
 dtjl+fMyH2ASOwlSmNHPGG7T8Hc6CwHvHzaAQjRuQkHc+/S0kCYlCZE1egJiPy4NMNbrW0J5G
 JaeBlhHN5AnHO/+kJ6dL/ef2V597J5HyXNVTvLvUwO3px0b1lkWj9TZ1xi59apcItEWOXHL7z
 8x/6UeaZq1XLqy0z9ofdelMEurEn5g0f/PWIg7I4Z5ll+zQA/3h7nIF8gtxdYH6/M4EQARkp9
 IYeu8NqD3dIPUK2SoWhVKp7kPgf1Y8sZmK3zU2pEKwIQ8TSMjhXfQn+Mp6rhwjZZL9rFKnMtF
 uApmGnWRXbHPeRARnzr4eKdxRgQH/ov4qM9gPtKeL93NTsjV5ORDvGR3sEyrq+t4AvjMFrVAK
 9dw59ofJthSyqclMlS9gYT5dfoKI+4RwpfsWALkEtsVApUbJKoxxBWXYSAUp77YBBriTxH9uy
 oajcBEI9+Djf1VZQtAXqSFg8KiJmm6KLrJ3DvgnGy6tuzGmpRErdGx8x2pFX1Xqtu+8w6LS0I
 F2t1ovvaHn/cylKMRysGvG0NeMMmUU2z4L8eQJxqU1XfIO7IWpo1jF7rFMSGTeXzGB6pS0vOs
 raR8IlnsjdRebnFXcQMQ3OZ/dyaC8FO/1oywBHFNnt+J4NeHRdUHc1z0/lZBAekZObB9L2+JX
 GgZCg0xpsKlFAypRF
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 05.06.20 13:52, Ard Biesheuvel wrote:
> EFI on ARM only supports short descriptors, and given that it mandates
> that the MMU and caches are on, it is implied that booting in HYP mode
> is not supported.
>
> However, implementations of EFI exist (i.e., U-Boot) that ignore this
> requirement, which is not entirely unreasonable, given that it does
> not make a lot of sense to begin with.

Hello Ard,

thanks for investigating the differences between EDK2 and U-Boot.

What I still do not understand is if there is a bug in U-Boot where
U-Boot does not conform to the UEFI specification? In this case I would
expect a fix in U-Boot.

Or is it simply a deficiency of Linux that it does not properly support
HYP/EL2 mode on 32-bit ARM?

Up to now I never experience a problem booting a 32bit board via U-Boot
-> GRUB-EFI -> Linux. Where did you have a problem when booting via
U-Boot's UEFI implementation and the current Linux kernel?

Does this patch relate to the retirement of KVM on 32 ARM in Linux 5.7
541ad0150ca4 ("arm: Remove 32bit KVM host support")? Without that patch
I would have expected Linux to work fine in HYP mode.

Best regards

Heinrich

>
> So let's make sure that we can deal with this condition gracefully.
> We already tolerate booting the EFI stub with the caches off (even
> though this violates the EFI spec as well), and so we should deal
> with HYP mode boot with MMU and caches either on or off.
>
> - When the MMU and caches are on, we can ignore the HYP stub altogether,
>   since we can just use the existing mappings, and just branch into
>   the decompressed kernel as usual after disabling MMU and caches.
>
> - When the MMU and caches are off, we have to drop to SVC mode so that
>   we can set up the page tables using short descriptors. In this case,
>   we need to install the HYP stub so that we can return to HYP mode
>   when handing over to the kernel proper.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm/boot/compressed/head.S | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/=
head.S
> index c79db44ba128..986db86ba334 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -1436,6 +1436,35 @@ ENTRY(efi_enter_kernel)
>  		mrc	p15, 0, r0, c1, c0, 0	@ read SCTLR
>  		tst	r0, #0x1		@ MMU enabled?
>  		orreq	r4, r4, #1		@ set LSB if not
> +#ifdef CONFIG_ARM_VIRT_EXT
> +		@
> +		@ The EFI spec does not support booting on ARM in HYP mode,
> +		@ since it mandates that the MMU and caches are on, with all
> +		@ 32-bit addressable DRAM mapped 1:1 using short descriptors.
> +		@ While the EDK2 reference implementation adheres to this,
> +		@ U-Boot might decide to enter the EFI stub in HYP mode anyway,
> +		@ with the MMU and caches either on or off.
> +		@ In the former case, we're better off just carrying on using
> +		@ the cached 1:1 mapping that the firmware provided, and pretend
> +		@ that we are in SVC mode as far as the decompressor is
> +		@ concerned. However, if the caches are off, we need to drop
> +		@ into SVC mode now, and let the decompressor set up its cached
> +		@ 1:1 mapping as usual.
> +		@
> +		mov	r0, #SVC_MODE
> +		msr	spsr_cxsf, r0		@ record that we are in SVC mode
> +		bne	1f			@ skip HYP stub install if MMU is on
> +
> +		mov	r9, r4			@ preserve image base
> +		bl	__hyp_stub_install	@ returns boot mode in r4
> +		cmp	r4, #HYP_MODE		@ did we boot in HYP?
> +		bne	1f			@ skip drop to SVC if we did not
> +
> +		safe_svcmode_maskall	r0
> +		msr	spsr_cxsf, r4		@ record boot mode
> +		mov	r4, r9			@ restore image base
> +1:
> +#endif
>
>  		mov	r0, r8			@ DT start
>  		add	r1, r8, r2		@ DT end
>

