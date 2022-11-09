Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A465F622E9D
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 16:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiKIPBg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 10:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiKIPBf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 10:01:35 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0E814099
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 07:01:33 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 44A84423E1
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668006091;
        bh=G4QOG4dtw/tN0B16ymAz7WeEgd16alaEJ9siCOWszCc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FA2GhOKR+Ikw8AyWM/9dyU8bWpnbRF2wcBqfu7lXdHvHwA6takOlSU0vjeX51Dmh1
         NkOK4syV7AE5HVPN09w/bE3EVExa3BmgP4qwH8WOMTFMYfsTbwXvE8xX0op+66JTpU
         tb7lbXpKjJ+vZCww4RyK51t4ob+kSUHEZ0EVeLMnhcVP4+xoPHnqjiOKJ5M+uLLjIp
         vbPrYOdocQplmAhCY2VQB7d/wKAVBJ1/brAX9BabsN6aIc/xOgNHMXjg/xpvcskUwA
         saKD+TcGKiLKmZ/cuPainAEWSrvnGPHcOzeGU8KIJ/tE47hoMITVtAkUglnfpl2VVv
         VFvQoacslsvzg==
Received: by mail-ed1-f70.google.com with SMTP id b14-20020a056402278e00b004621a2642d7so12855983ede.1
        for <linux-efi@vger.kernel.org>; Wed, 09 Nov 2022 07:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4QOG4dtw/tN0B16ymAz7WeEgd16alaEJ9siCOWszCc=;
        b=1BstXIBPJL2kMM/U3WtHav4lVA1Dx4syswl8ThiETxwlgvpC15T1AYzGJTLKLmMZEf
         X4nWojiF7fp14wWCBrwF1DpgbRN60KWYgss3z79w14jVL5r+1LXf4DMLvQ1z/LR46EMw
         6NukVDRcVWWTPjLAzHNvZulI3aq1cNYlRFBuyYVpPNWVSSw0qsaVOkU+qHMxL4CqTHWt
         GUjfudYYLXYKgphykPml8mWTaNFPZn3gi0RjEtxfQW5OOjykcspKdVvU4CBM4wbtx0gS
         r2iWizEtHWhZpD6oIq6LEva0CCgO6NDWQmdhft/Y7lGXZavvbEMvHqWYI/W5n88k4ccr
         0vZw==
X-Gm-Message-State: ACrzQf22/0HTOvPqtoARESIV1mAp4RPJb88BewXrig13B1JOcTZd0K/+
        gbFVZrIdCRBDrsfptWHVgK9QLzBG/u1f/JvhCcCF5uxbmWKPZacauPxmexS1w8YpeM9gUKm0Mco
        CnMbz8fpBCcIysevQbbDAPDPlXu2LN3uBsVzsPA==
X-Received: by 2002:a17:906:5d10:b0:7ad:e132:bb85 with SMTP id g16-20020a1709065d1000b007ade132bb85mr46511698ejt.367.1668006090582;
        Wed, 09 Nov 2022 07:01:30 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4/SzYPZ7QBe2xV3nP+J0VmrSzi/uUZ+LqNALkI6eoFhNgEfWThdS6I2YoxV84saNb0jLotJQ==
X-Received: by 2002:a17:906:5d10:b0:7ad:e132:bb85 with SMTP id g16-20020a1709065d1000b007ade132bb85mr46511669ejt.367.1668006090087;
        Wed, 09 Nov 2022 07:01:30 -0800 (PST)
Received: from [192.168.123.67] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b007ad98918743sm5998681ejb.1.2022.11.09.07.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 07:01:28 -0800 (PST)
Message-ID: <594e304d-38f0-ed37-a2a8-7479ff850c8c@canonical.com>
Date:   Wed, 9 Nov 2022 16:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC PATCH] efi: Put Linux specific magic number in the DOS
 header
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     grub-devel@gnu.org, Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>,
        linux-efi@vger.kernel.org
References: <20221109141611.2788009-1-ardb@kernel.org>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20221109141611.2788009-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/9/22 15:16, Ard Biesheuvel wrote:
> GRUB currently relies on the magic number in the image header of ARM and
> arm64 EFI kernel images to decide whether or not the image in question
> is a bootable kernel.
> 
> However, the purpose of the magic number is to identify the image as one
> that implements the bare metal boot protocol, and so GRUB, which only
> does EFI boot, can only boot images that could potentially be booted in
> a non-EFI manner as well.
> 
> This is problematic for the new zboot decompressor image format, as it
> can only boot in EFI mode, and must therefore not use the bare metal
> boot magic number in its header.
> 
> For this reason, the strict magic number was dropped from GRUB, to
> permit essentially any kind of EFI executable to be booted via the
> 'linux' command, blurring the line between the linux loader and the
> chainloader.
> 
> So let's use the same field in the DOS header that RISC-V and arm64
> already use for their 'bare metal' magic numbers to store a 'generic
> Linux kernel' magic number, which can be used to identify bootable
> kernel images in PE format which don't necessarily implement a bare
> metal boot protocol in the same binary.
> 
> Let's set the generic magic number for x86 images as well: existing
> bootloaders already have their own methods to identify x86 Linux images
> that can be booted in a non-EFI manner, and having the magic number in
> place there will ease any future transitions in loader implementations
> to merge the x86 and non-x86 EFI boot paths.
> 
> Note that 32-bit ARM already uses the same location in the header for a
> different purpose, but the ARM support is already widely implemented and
> the EFI zboot decompressor is not available on ARM anyway, so we just
> disregard it here.
> 
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Atish Patra <atishp@rivosinc.com>
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: Daniel Kiper <daniel.kiper@oracle.com>
> Cc: Leif Lindholm <quic_llindhol@quicinc.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> The idea is that, with this in place, the existing arm64 support in GRUB
> can be made generic, with the arm64 variant of the arch image header
> typedef being made generic as well.
> 
> Any code that attempts to identify EFI images as kernel images should
> check for the arm64, RISC-V and generic values, and if the latter, look
> at the PE machine type if it wants to know the architecture.
> 
>   arch/loongarch/kernel/head.S                | 3 ++-
>   arch/x86/boot/header.S                      | 3 ++-
>   drivers/firmware/efi/libstub/zboot-header.S | 3 ++-
>   include/linux/pe.h                          | 7 +++++++
>   4 files changed, 13 insertions(+), 3 deletions(-)

We need files in Documentation/ that describes the meaning and value of 
the field per architecture.

We already have:

riscv: Documentation/riscv/boot-image-header.rst
arm64: Documentation/arm64/booting.rst

But other UEFI architectures are missing.

Otherwise I am fine with the change.

Best regards

Heinrich

> 
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 97425779ce9f3499..e1deea93aaafa069 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -25,7 +25,8 @@ _head:
>   	.dword	kernel_entry		/* Kernel entry point */
>   	.dword	_end - _text		/* Kernel image effective size */
>   	.quad	0			/* Kernel image load offset from start of RAM */
> -	.org	0x3c			/* 0x20 ~ 0x3b reserved */
> +	.org	0x38			/* 0x20 ~ 0x38 reserved */
> +	.long	LINUX_PE_MAGIC
>   	.long	pe_header - _head	/* Offset to the PE header */
>   
>   pe_header:
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index d31982509654dcb1..9338c68e7413d6e6 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -80,10 +80,11 @@ bs_die:
>   	ljmp	$0xf000,$0xfff0
>   
>   #ifdef CONFIG_EFI_STUB
> -	.org	0x3c
> +	.org	0x38
>   	#
>   	# Offset to the PE header.
>   	#
> +	.long	LINUX_PE_MAGIC
>   	.long	pe_header
>   #endif /* CONFIG_EFI_STUB */
>   
> diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
> index 9e6fe061ab07a008..97c2637337d79913 100644
> --- a/drivers/firmware/efi/libstub/zboot-header.S
> +++ b/drivers/firmware/efi/libstub/zboot-header.S
> @@ -20,7 +20,8 @@ __efistub_efi_zboot_header:
>   	.long		__efistub__gzdata_size - ZBOOT_SIZE_LEN	// payload size
>   	.long		0, 0					// reserved
>   	.asciz		COMP_TYPE				// compression type
> -	.org		.Ldoshdr + 0x3c
> +	.org		.Ldoshdr + 0x38
> +	.long		LINUX_PE_MAGIC
>   	.long		.Lpehdr - .Ldoshdr			// PE header offset
>   
>   .Lpehdr:
> diff --git a/include/linux/pe.h b/include/linux/pe.h
> index 1d3836ef9d92dcd8..fa176c24167c301c 100644
> --- a/include/linux/pe.h
> +++ b/include/linux/pe.h
> @@ -31,6 +31,13 @@
>   #define LINUX_EFISTUB_MAJOR_VERSION		0x1
>   #define LINUX_EFISTUB_MINOR_VERSION		0x0
>   
> +/*
> + * LINUX_PE_MAGIC appears at offset 0x30 into the MSDOS header of EFI bootable
> + * Linux kernel images that target the architecture as specified by the PE/COFF
> + * header machine type field.
> + */
> +#define LINUX_PE_MAGIC	0x818223cd
> +
>   #define MZ_MAGIC	0x5a4d	/* "MZ" */
>   
>   #define PE_MAGIC		0x00004550	/* "PE\0\0" */

