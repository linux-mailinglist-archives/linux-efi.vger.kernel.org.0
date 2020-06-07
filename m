Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4251F0D56
	for <lists+linux-efi@lfdr.de>; Sun,  7 Jun 2020 19:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgFGRYz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Jun 2020 13:24:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:38901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgFGRYy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 7 Jun 2020 13:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591550672;
        bh=prmDdHGznxEpRFD6qAZXytWIpuhGL6ohzpD4KpRxtZs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FdvCe4vSfuo0ppSsAdk5B8HC5Frbwgabvyv/fN3MZkE0kuYLmgxw72SoYLa6CbBFY
         t5st3wyVj/Jzmtz8GdcEi4eL+wRC1F9mooJ7Ld/lNbAM4qg/qew1J7wR5aQKbKFOOk
         ZgZ0f8RDZpZGUW93a0iWOjwHmL/M2DXKGsgdA+MQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([88.152.145.75]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKKh-1jjtur1GKf-00FoF0; Sun, 07
 Jun 2020 19:24:32 +0200
Subject: Re: [PATCH v2 1/2] efi/arm: decompressor: deal with HYP mode boot
 gracefully
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        linux@armlinux.org.uk, Chen-Yu Tsai <wens@csie.org>
References: <20200607135834.898294-1-ardb@kernel.org>
 <20200607135834.898294-2-ardb@kernel.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <96a36110-68e1-89e3-2d59-b16f01abae21@gmx.de>
Date:   Sun, 7 Jun 2020 19:24:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200607135834.898294-2-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yl00i5pEvP9g3dZ8sbtpZupknrHAgj6gLzFxvMC/IUpoSRBNcnu
 PVqj+0BmpN+X38nHN8AYdu/x4X2WmJBlTNrfJvwlyfISCeDuQcRY0xRtP980hW2gGzPEwJv
 0EqmFOeoxwnC6WrlF8B114szrVcat2M3Yo/t30MV1V4mLrp7UB/jrEr1QrlkdBBdvpBQ7Bg
 PUI+D6ADnkBq0x/vuis4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uFC9UluCpPA=:H3z5/XeJ/k+t/1WRyoFuSQ
 csA2qDu1QdkNIB/5L3bIvPFT72C6jTJcODCGuQf5e3eZGbb0Y5HP8u/xsGtvrcYC+zuke3P45
 vBlN2EIbH18qY0ulEfBU4QN6rWct6xHCmTz30AtR0EgXeQZV5tniG1SAtbXyqXQTr2ptScTni
 I+7CNdJH9Z4ByOPWbDC0/RfqnZB8aLZTwACVw6cTZZDqDoCcjD4Lh4bHAgmjabL98XTNgpnXo
 sZ7VkrUtS8xrmXmCktSn1UAEEkIvaXm8rU7XUCJUIukocypGiG1927UnbtDmDV2sF1708Vo1q
 Uxef8DhjrNFHBG211m/ZYpKXNn7FyRtiDKXEelEzvLYE6OPs7SonwMdwsZbiOrG2ON+0LzcYI
 FGcbEuehWWbzKpGlshYXuXBavy0N9gBZ0wHrznfFUjMiWg4kOAr/DGiu198HIIe4dfIpdtmd1
 J7NoOO5DC58rJOjhgUa8rOq2PHFI7+w3q/PM4FhgL3f8ZMx2oHVfeh7BQVssA33YageYrCEU0
 ATxQMF8Aaemo6W7b+VEHClfP/BcvK2ff84SSQYxsvS6RE+rg7r0AIKWDPoZmHDCt0s2B03Qee
 UKZ05IYG6oe06f9RFgYowxhHh41oIGUonTc8ixmguqNdKIbYT1gcKupiZQ3KSNAOx+y5bdrnC
 Gh6TyTP5JLrUf4f/6Ql6yJQ9CgEpXZBpuI5XyotT/0I/wouqO5qPzOyFeFUYOyNLV5R+IgG1O
 PDgCPAFJCO1mAotwJmTizeFKCMdcWH5/BhDoE+YJCHX2KXnwGekveJSAfEPIxfS3uyY1DApIv
 XU6DYXfiCy06/i1WqEQHCPR/YEPCfoDIv23BpLRJdAaQWkslyey+aAytizB8EGg3x/jr/8ExE
 rrvFQvIDdiJRR5pBZ5Jz/Qlj1nF1/n+eFBjr7HhM+HOigX1ansX5+rsvlTsVh6LtLtRoAUZkB
 J04NGeMtdmvNCQuf8Bx8mCq6+6RPOwGAMxfLOAhDxzv1VP3jMnIj9/ncKjOm3MRsup3IjX7mU
 v0MZLUcE0h9fyVeqWXnziRpdeFJoQtgMWaUHxLpb/jsqhrLHa7phOaJAiCUXEGgutLWSyIevj
 4q1ehhX76G8eYlacFITWGJggU/kVW29EJIKVECf4oEdWZNlqySZBljou2uaLmbrjX0X9Yd/kw
 G1uCZ0PuCg3SAPf63nPQzdOJijmGKcjeVaKZOSPfPM5SCPAmaNDCVKDJv4zeir+v9cw4vrNHI
 4mjUo4sgaiuzUNSvR
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/7/20 3:58 PM, Ard Biesheuvel wrote:
> EFI on ARM only supports short descriptors, and given that it mandates
> that the MMU and caches are on, it is implied that booting in HYP mode
> is not supported.
>
> However, implementations of EFI exist (i.e., U-Boot) that ignore this
> requirement, which is not entirely unreasonable, given that it makes
> HYP mode inaccessible to the operating system.
>
> So let's make sure that we can deal with this condition gracefully.
> We already tolerate booting the EFI stub with the caches off (even
> though this violates the EFI spec as well), and so we should deal
> with HYP mode boot with MMU and caches either on or off.
>
> - When the MMU and caches are on, we can ignore the HYP stub altogether,
>   since we can carry on executing at HYP. We do need to ensure that we
>   disable the MMU at HYP before entering the kernel proper.
>
> - When the MMU and caches are off, we have to drop to SVC mode so that
>   we can set up the page tables using short descriptors. In this case,
>   we need to install the HYP stub as usual, so that we can return to HYP
>   mode before handing over to the kernel proper.

To me it is still unclear why you need this patch. Please, describe the
problem this patch fixes.

Is there any device that you cannot boot without the patch?

>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm/boot/compressed/head.S | 61 ++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/=
head.S
> index c79db44ba128..3476e85c31e7 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -1410,7 +1410,11 @@ memdump:	mov	r12, r0
>  __hyp_reentry_vectors:
>  		W(b)	.			@ reset
>  		W(b)	.			@ undef
> +#ifdef CONFIG_EFI_STUB
> +		W(b)	__enter_kernel_from_hyp	@ hvc from HYP
> +#else
>  		W(b)	.			@ svc
> +#endif
>  		W(b)	.			@ pabort
>  		W(b)	.			@ dabort
>  		W(b)	__enter_kernel		@ hyp
> @@ -1429,14 +1433,71 @@ __enter_kernel:
>  reloc_code_end:
>
>  #ifdef CONFIG_EFI_STUB
> +__enter_kernel_from_hyp:
> +		mrc	p15, 4, r0, c1, c0, 0	@ read HSCTLR
> +		bic	r0, r0, #0x5		@ disable MMU and caches
> +		mcr	p15, 4, r0, c1, c0, 0	@ write HSCTLR
> +		isb
> +		b	__enter_kernel
> +
>  ENTRY(efi_enter_kernel)
>  		mov	r4, r0			@ preserve image base
>  		mov	r8, r1			@ preserve DT pointer
>
> + ARM(		adrl	r0, call_cache_fn	)
> + THUMB(		adr	r0, call_cache_fn	)
> +		adr	r1, 0f			@ clean the region of code we
> +		bl	cache_clean_flush	@ may run with the MMU off
> +
> +#ifdef CONFIG_ARM_VIRT_EXT
> +		@
> +		@ The EFI spec does not support booting on ARM in HYP mode,
> +		@ since it mandates that the MMU and caches are on, with all
> +		@ 32-bit addressable DRAM mapped 1:1 using short descriptors.
> +		@
> +		@ While the EDK2 reference implementation adheres to this,
> +		@ U-Boot might decide to enter the EFI stub in HYP mode
> +		@ anyway, with the MMU and caches either on or off.
> +		@
> +		mrs	r0, cpsr		@ get the current mode
> +		msr	spsr_cxsf, r0		@ record boot mode
> +		and	r0, r0, #MODE_MASK	@ are we running in HYP mode?
> +		cmp	r0, #HYP_MODE
> +		bne	.Lefi_svc
> +
> +		mrc	p15, 4, r1, c1, c0, 0	@ read HSCTLR
> +		tst	r1, #0x1		@ MMU enabled at HYP?
> +		beq	1f
> +
> +		@
> +		@ When running in HYP mode with the caches on, we're better
> +		@ off just carrying on using the cached 1:1 mapping that the
> +		@ firmware provided. Set up the HYP vectors so HVC instructions
> +		@ issued from HYP mode take us to the correct handler code. We
> +		@ will disable the MMU before jumping to the kernel proper.
> +		@
> +		adr	r0, __hyp_reentry_vectors
> +		mcr	p15, 4, r0, c12, c0, 0	@ set HYP vector base (HVBAR)
> +		isb
> +		b	.Lefi_hyp
> +
> +		@
> +		@ When running in HYP mode with the caches off, we need to drop
> +		@ into SVC mode now, and let the decompressor set up its cached
> +		@ 1:1 mapping as usual.
> +		@
> +1:		mov	r9, r4			@ preserve image base
> +		bl	__hyp_stub_install	@ install HYP stub vectors
> +		safe_svcmode_maskall	r1	@ drop to SVC mode

Are you returning to HYP mode somewhere?

What is the effect on PSCI?

The Allwinner/Sunxi boards must be booted in HYP mode to have PSCI
according to https://linux-sunxi.org/PSCI

Did you test that you still can reboot those boards?

Cc: Chen-Yu Tsai <wens@csie.org>
    (maintainer ARM/Allwinner sunXi SoC support)

Best regards

Heinrich

> +		orr	r4, r9, #1		@ restore image base and set LSB
> +		b	.Lefi_hyp
> +.Lefi_svc:
> +#endif
>  		mrc	p15, 0, r0, c1, c0, 0	@ read SCTLR
>  		tst	r0, #0x1		@ MMU enabled?
>  		orreq	r4, r4, #1		@ set LSB if not
>
> +.Lefi_hyp:
>  		mov	r0, r8			@ DT start
>  		add	r1, r8, r2		@ DT end
>  		bl	cache_clean_flush
>

