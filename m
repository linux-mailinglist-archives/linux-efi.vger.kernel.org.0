Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B7AD0FC9
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2019 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfJINSP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 09:18:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35167 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJINSP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Oct 2019 09:18:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so2963797wrt.2
        for <linux-efi@vger.kernel.org>; Wed, 09 Oct 2019 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INXcK2GnplApu1ZOLH2J8/8Oy/lhV6GWo+8ldVcmiL4=;
        b=vHZk4t7OhOSNwouV3msPm09MInphnDvIwokC0d0mpga7wv9d7UEeu2Rg1zd5ckt1MT
         LfxG629XzyXJBBUEitnS5NAg///xmMMb+XvS1NkpDryQ6cm9RUk5wArTFo5jqMklIDhs
         lXMrPmMR8jKc63h9rxtdaV9FzgDHtcYE15XSPEr5IU7kTO4IMzhq/QZjCDNVWkWR0imx
         /mKfwRepsbpRqgYezK+KcfXBZDIylAt/jQpHoZ/yJ+4SxSQZqGFKypx8S7Sj14F1XzGY
         dSEb9D7RjkLpFXErI3ukodblwrpAaaAkc0BVp7pOMM3E/okwnkPaY5ZlhFxd7Ybe6R0G
         uEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INXcK2GnplApu1ZOLH2J8/8Oy/lhV6GWo+8ldVcmiL4=;
        b=pvxmDxXVzENIyoFx1jKrm8S0s3V6dQNv0eAplJi2WlhvFaP0aB7Del58aG33T1s7SK
         3BwD4vB4O+r7QTH8W0t3SEH2mv40nP0CeNgi3c0Oq4conrvRPlklJQEwO8QvVPhHtrXF
         oF3eCvyYht2zjCyCvINmDaiGP0yxd2wOTBY8gyYUs4V65LXpa3/mmt42gNCbYzYSD8IY
         0e3i7Gmi2m/JOy3m++nSeCccB84sUU8IKDC085OUkRRAMdr7nCF1MoK3T4eRGZbj3AlN
         7rLVePeMOu+JyOooPNJPWR+ttXtC+/D2WpCC3AqLhje4HLFJvn9EqiYDGI5+T0AhgrKk
         RzKw==
X-Gm-Message-State: APjAAAXb3MoRUx3QXNAbSgSiHceiY9S+1ve0w5jGNNJTZRKdFnb/J8nb
        gaoDuklRB+hQXDv+3GChs2E9bRHTHM7B2BmZboVMJw==
X-Google-Smtp-Source: APXvYqxuq6QUw5tpsV/u+CoBX6zgHOXrizAe7EMcEFZOnLsJSqUWGlOzODsAqU7wOpMn1NywUB2DtSVnaWxeshzZdf8=
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr3130998wrp.0.1570627092531;
 Wed, 09 Oct 2019 06:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191005113753.GA77634@light.dominikbrodowski.net>
In-Reply-To: <20191005113753.GA77634@light.dominikbrodowski.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 9 Oct 2019 15:18:01 +0200
Message-ID: <CAKv+Gu-wN2HZXkkAfT_F3DVtpMVen2kbDbupyGMgdfrt5dcy7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] arch/x86: efistub: Invoke EFI_RNG_PROTOCOL to seed
 the UEFI RNG table
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 5 Oct 2019 at 13:38, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Implement the same mechanism for x86 efistub as introduced by commit
> 568bc4e87033 ("efi/arm*/libstub: Invoke EFI_RNG_PROTOCOL to seed the
> UEFI RNG table") for efi/arm*/libstub, and best described here and there
> as:
>
>     Invoke the EFI_RNG_PROTOCOL protocol in the context of the stub and
>     install the Linux-specific RNG seed UEFI config table. This will be
>     picked up by the EFI routines in the core kernel to seed the kernel
>     entropy pool.
>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
>
> ---
>
> As far as I can see, we do not yet make use of the UEFI RNG on x86 at all,
> but only on arm.

If you have a ChaosKey, you may be able to use this driver

http://people.linaro.org/~ard.biesheuvel/ChaosKey/ChaosKeyDxe.efi

to get UEFI to expose the EFI_RNG_PROTOCOL. (Use efibootmgr -r to
install it as Driver#### or load it from the UEFI shell using 'load
xxx.efi')

> Note that this works only when Linux is booted as an EFI
> stub, and that the EFI-provided randomness is not credited as entropy
> unless RANDOM_TRUST_BOOTLOADER is set _and_ another patch (on its way
> upstream; thanks Ard!) is applied, see
>         https://lore.kernel.org/lkml/20190928101428.GA222453@light.dominikbrodowski.net/
>
> Further note that this patch is untested, as the firmware on my old x86
> laptop only has UEFI v2.31. If you want to test it, you may wish to apply
>         https://lore.kernel.org/lkml/20191005113632.GA74715@light.dominikbrodowski.net/T/#u
> first to get a clear indication in dmesg.
>


>
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index d6662fdef300..4b909e5ab857 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -781,6 +781,9 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
>
>         /* Ask the firmware to clear memory on unclean shutdown */
>         efi_enable_reset_attack_mitigation(sys_table);
> +
> +       efi_random_get_seed(sys_table);
> +
>         efi_retrieve_tpm2_eventlog(sys_table);
>
>         setup_graphics(boot_params);
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 0460c7581220..ece24c60fc2c 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -38,7 +38,8 @@ OBJECT_FILES_NON_STANDARD     := y
>  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
>  KCOV_INSTRUMENT                        := n
>
> -lib-y                          := efi-stub-helper.o gop.o secureboot.o tpm.o
> +lib-y                          := efi-stub-helper.o gop.o secureboot.o tpm.o \
> +                                  random.o
>
>  # include the stub's generic dependencies from lib/ when building for ARM/arm64
>  arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
> @@ -47,7 +48,7 @@ arm-deps-$(CONFIG_ARM64) += sort.c
>  $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
>         $(call if_changed_rule,cc_o_c)
>
> -lib-$(CONFIG_EFI_ARMSTUB)      += arm-stub.o fdt.o string.o random.o \
> +lib-$(CONFIG_EFI_ARMSTUB)      += arm-stub.o fdt.o string.o \
>                                    $(patsubst %.c,lib-%.o,$(arm-deps-y))
>
>  lib-$(CONFIG_ARM)              += arm32-stub.o
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 7f1556fd867d..05739ae013c8 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -63,8 +63,6 @@ efi_status_t efi_random_alloc(efi_system_table_t *sys_table_arg,
>
>  efi_status_t check_platform_features(efi_system_table_t *sys_table_arg);
>
> -efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
> -
>  void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid);
>
>  /* Helper macros for the usual case of using simple C variables: */
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index bd3837022307..a17cc5841668 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1631,6 +1631,8 @@ static inline void
>  efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg) { }
>  #endif
>
> +efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
> +
>  void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table);
>
>  /*
