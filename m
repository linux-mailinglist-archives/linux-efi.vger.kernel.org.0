Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB45222061D
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jul 2020 09:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgGOHWs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jul 2020 03:22:48 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:22991 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgGOHWr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jul 2020 03:22:47 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 06F7M7QO031597;
        Wed, 15 Jul 2020 16:22:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 06F7M7QO031597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594797728;
        bh=w3JbW09mtoeE98TWzXBL1LmtIUCrjbrYaU4GyXXoQ4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KE7n4oSkpr4uW9J+/oFTuVtoFLcgVoosn+86ciSZgCJ1HtPLFYm8CHSnvqnhfjUJC
         5sf/Nc8t+ReC9oUEKvMQVFsDFgnYnE/HrO29qiI+P/ogTZTdxqhSoo0wnEUHIyDH9M
         CmJ5+g4DLGNFsrBMvSzqOhTfJixzKqXhJfzhL8FTqBjg6ng+1/Hs9QBKCBaozSsawx
         PzSHCqfb/9AAxEhT9bHlrGp2lgdyveQ0yH3eIPf11hWEs1K9dUaP7uGmdumdsCO3//
         9f1UNKqdJQjDaTrJBQt9ussCzwf4C4w/3KMGxaEPzmUrTsBvJQCVHfrJnKLAEgOnhl
         cOW7MuoJ7HcFQ==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id g4so280210uaq.10;
        Wed, 15 Jul 2020 00:22:07 -0700 (PDT)
X-Gm-Message-State: AOAM53272+RRs5bisZutAcQknJrmeIJ8SC2MGFfb85CqyaVeFvd32zAs
        Kj/2Nddz1ryStE/odyuWLVz4FTN+X8twzVfndvU=
X-Google-Smtp-Source: ABdhPJzniKddUQu2JP4MRRzQSLJmu66OKv+Gt9OUATG6zNkhKWMie+WW0snL77VGMIYWVgVjhoN2r9IkM4IAsJ9NJ8Q=
X-Received: by 2002:ab0:44e5:: with SMTP id n92mr6138229uan.121.1594797726600;
 Wed, 15 Jul 2020 00:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200715032631.1562882-1-nivedita@alum.mit.edu>
In-Reply-To: <20200715032631.1562882-1-nivedita@alum.mit.edu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 15 Jul 2020 16:21:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARqLfYmEomDyzc9iXrk7hKKpGg-nKXpM22V4UYCrXzXAg@mail.gmail.com>
Message-ID: <CAK7LNARqLfYmEomDyzc9iXrk7hKKpGg-nKXpM22V4UYCrXzXAg@mail.gmail.com>
Subject: Re: [PATCH] arch/x86/boot: Don't add the EFI stub to targets
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 15, 2020 at 12:26 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> vmlinux-objs-y is added to targets, which currently means that the EFI
> stub gets added to the targets as well. It shouldn't be added since it
> is built elsewhere.
>
> This confuses Makefile.build which interprets the EFI stub as a target
>         $(obj)/$(objtree)/drivers/firmware/efi/libstub/lib.a
> and will create drivers/firmware/efi/libstub/ underneath
> arch/x86/boot/compressed, to hold this supposed target, if building
> out-of-tree. [0]
>
> Fix this by pulling the stub out of vmlinux-objs-y into efi-obj-y.
>
> [0] See scripts/Makefile.build near the end:
>     # Create directories for object files if they do not exist
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>



>  arch/x86/boot/compressed/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 7619742f91c9..5a828fde7a42 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -90,8 +90,8 @@ endif
>
>  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>
> -vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
> +efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
>
>  # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
>  # can place it anywhere in memory and it will still run. However, since
> @@ -115,7 +115,7 @@ endef
>  quiet_cmd_check-and-link-vmlinux = LD      $@
>        cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
>
> -$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> +$(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
>         $(call if_changed,check-and-link-vmlinux)
>
>  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
> --
> 2.26.2
>


-- 
Best Regards
Masahiro Yamada
