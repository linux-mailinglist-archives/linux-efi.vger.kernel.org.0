Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4945C5F85AA
	for <lists+linux-efi@lfdr.de>; Sat,  8 Oct 2022 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJHOvK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Oct 2022 10:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJHOvK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Oct 2022 10:51:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A504DB08;
        Sat,  8 Oct 2022 07:51:08 -0700 (PDT)
Received: from nazgul.tnic (unknown [46.183.103.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDA941EC0432;
        Sat,  8 Oct 2022 16:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665240663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gzxjyBK9Q/UjuOE0iJjf/g3i6ZX6Y8Nq+z1WQ+83Uyo=;
        b=gOtTmpSigCUq8gf4Pca0lcVR2vP+iOd5khO9+zByVM4nuK02dCZfdmYOpf8iciVtZMORWn
        ZVGJ88CW46ErTCIFzL9KB5gqxrJuxRbbuiuGP5G7XiDVS0P3yQOTxlXwT8hkH70Ml+dXgI
        VtinO09v6mUu+H6i01uatw95ltd/Zo4=
Date:   Sat, 8 Oct 2022 16:51:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: x86: Make the deprecated EFI handover protocol
 optional
Message-ID: <Y0GOKnD89SOjGzCf@nazgul.tnic>
References: <20221007172918.3131811-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221007172918.3131811-1-ardb@kernel.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 07, 2022 at 07:29:18PM +0200, Ard Biesheuvel wrote:
> Given that loaders such as GRUB already carried the bootparams handling
> in order to implement non-EFI boot, retaining that code and just passing
> bootparams to the EFI stub was a reasonable choice (although defining an
> alternate entrypoint could have been avoided.) However, the GRUB side
> changes never made it upstream, and are only shipped by some of the
	  ^^^^^^^^^^^^^^^^^^^^^^^

> distros in their downstream versions.

Gotta love that bit particularly. :-(

> In the meantime, EFI support has been added to other Linux architecture
> ports, as well as to U-boot and systemd, including arch-agnostic methods
> for passing initrd images in memory [1], and for doing mixed mode boot
> [2], none of them requiring anything like the EFI handover protocol. So
> given that only out-of-tree distro GRUB relies on this, let's permit it
> to be omitted from the build, in preparation for retiring it completely
> at a later date. (Note that systemd-boot does have an implementation as
> well, but only uses it as a fallback for booting images that do not
> implement the LoadFile2 based initrd loading method, i.e., v5.8 or older)
> 
> [0] https://lore.kernel.org/all/20220927085842.2860715-1-ardb@kernel.org/
> [1] ec93fc371f01 ("efi/libstub: Add support for loading the initrd ...")
> [2] 97aa276579b2 ("efi/x86: Add true mixed mode entry point into ...")
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/Kconfig                   | 12 ++++++++++++
>  arch/x86/boot/compressed/head_64.S |  4 +++-
>  arch/x86/boot/header.S             |  2 +-
>  arch/x86/boot/tools/build.c        |  2 ++
>  4 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f9920f1341c8..0c8fcb090232 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1964,6 +1964,18 @@ config EFI_STUB
>  
>  	  See Documentation/admin-guide/efi-stub.rst for more information.
>  
> +config EFI_HANDOVER_PROTOCOL
> +	bool "EFI handover protocol (DEPRECATED)"
> +	depends on EFI_STUB
> +	default y

I'd say "default n" here.

> +	help
> +	  Whether to include support for the deprecated EFI handover protocol,

"Select this in order to include..."

> +	  which defines alternative entry points into the EFI stub. This is a
> +	  practice that has no basis in the UEFI specification, and requires
> +	  a priori knowledge on the part of the bootloader about Linux/x86
> +	  specific ways of passing the command line and initrd, and where in
> +	  memory those assets may be loaded.

	"If in doubt, say N. This option and accompanying code will disappear
	in some future kernel as the corresponding GRUB support is not even
	present in upstream GRUB but only in some distros' versions."

> +
>  config EFI_MIXED
>  	bool "EFI mixed-mode support"
>  	depends on EFI_STUB && X86_64
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 6ba2c2142c33..7bcc50c6cdcc 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -286,7 +286,7 @@ SYM_FUNC_START(startup_32)
>  	lret
>  SYM_FUNC_END(startup_32)
>  
> -#ifdef CONFIG_EFI_MIXED
> +#if defined(CONFIG_EFI_MIXED) && defined(CONFIG_EFI_HANDOVER_PROTOCOL)

...

Can we use IS_ENABLED() in all that instead, in order to improve
readability?

In any case, looks good. I'm thinking I'll take it into tip after -rc1
and see who cries and why...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
