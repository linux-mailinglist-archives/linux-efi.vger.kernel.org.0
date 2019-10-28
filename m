Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B1CE70E7
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2019 13:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbfJ1MDI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Oct 2019 08:03:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38170 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388781AbfJ1MDI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Oct 2019 08:03:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so8715354wms.3
        for <linux-efi@vger.kernel.org>; Mon, 28 Oct 2019 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MINb6pmbpsZ7+5iM9oRBDdf7Mbp4IMovLENtWJjlx/Q=;
        b=pNpr9/rnZFwohOes5w8VG9RkvpyBt9muFj/zZBng5BiS9Y4X8vcAEvybCdMjU3gkBu
         dgvGdZxk9rb20XQYjwW4VewyXYe6QhbjHs6vU+9EL3pTQDVQm2JCP0jkzOdidYTbKKKX
         7KfZ+alN46OcFgWTZDs6kbpie+/2VNlK+JY2h30PMmncbAe4d7d1v4j3x1zo0MBChNV7
         zfLvvqKOAmdaeuFpvUDsdGRMqSj+7Qnx3+DBy0YMK1Mox0CRY+ZQWhEcMF3XR+UeSxiY
         TEWMWVihsdOf1oV3mAGzzP72LpP8V7X2vjmlkJ3MXfKN0So9ZY0rYfjcNS0Ev+OYGpWR
         S6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MINb6pmbpsZ7+5iM9oRBDdf7Mbp4IMovLENtWJjlx/Q=;
        b=CEJhMOFUmHqnihAllGTzADQD40O09Dv07zI5troLJyAm7LdIaGOQWwP8u9R9IyNuOy
         IgvOVZcTX1RQYExnDsCPmySOYMyBBig146PQGQnh2KCkoJzVOnAwcVvxlO3VtHbqYiUu
         1K5Jg6BqGLcnIfoAIVeqHJBt2y9qmdxtWTuxDSKisiJAnOQzgSjz8Mb2FTi/MK479zSJ
         s5xy0//iHz4g9j8gmkuscPmj01FvBtktxmWNxhnQALW9DxaO9xOK1fA5OZ2A6xJrFxTn
         nYweL6XHQZJ8eGmP9Ix4RfYt8inKE/7lIWKgcYvsj7Ge+U0hZjtbplD0zyJIsKdUbevD
         OnEA==
X-Gm-Message-State: APjAAAXw4vdPWNuTtT67Oy4naGN+hAR/aOCxNi6bfg7ggoxgI4toIN23
        40fxHGfeeUbR+Veht8MOCkjt2DuvSj3BPHHn6SogN5BlPk3Mbg==
X-Google-Smtp-Source: APXvYqz9tPQHntxd7O1DLd/q3Zcmj9bpCiMViGBB36XLgfM5E7CXpMOEpeW+DE0xEHM7b9YiQGhz6h14W07gfjdjzj8=
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr15415858wme.53.1572264185566;
 Mon, 28 Oct 2019 05:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191005113753.GA77634@light.dominikbrodowski.net>
 <20191028072036.GA113601@owl.dominikbrodowski.net> <CAKv+Gu-RcHfupXzZaK3UK1x+fkffGind8JP_4fZ95wBXuasJoQ@mail.gmail.com>
 <20191028084019.GA2392@owl.dominikbrodowski.net> <CAKv+Gu9gp+BUhf3KJMCTFuon9o1mUGv9UxWQ=A==-gLiAjRNNQ@mail.gmail.com>
 <CAKv+Gu-D4uvf5iyBKoRkantFVx4292da4BD8wuqC1uOZOhWegQ@mail.gmail.com> <20191028114741.GA2343@owl.dominikbrodowski.net>
In-Reply-To: <20191028114741.GA2343@owl.dominikbrodowski.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 28 Oct 2019 13:02:53 +0100
Message-ID: <CAKv+Gu9OytG5G11HVBiusFwjCfOM10Lfqg9Jsj3-3dWqbgUvMQ@mail.gmail.com>
Subject: Re: efistub: EFI_RNG_PROTOCOL on Dell Inc. Latitude 7390
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 28 Oct 2019 at 12:47, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> On Mon, Oct 28, 2019 at 11:51:01AM +0100, Ard Biesheuvel wrote:
> > > It might be an issue with the size of the output.
> > >
> > > The original RDRAND based driver in EDK2 contains an apparent
> > > misconception that, due to the fact that certain SP800-90-CTR-256
> > > DRBGs require 32 bytes of raw entropy as a seed, it is only valid for
> > > the RAW algorithm to be called with an output size of 32.
> > >
> > > So in this case, it might be that 32 is treated as a magic number too,
> > > and any other size is rejected by the RAW algorithm.
> > >
> > > Not sure why the other one fails, though, but the fact that RAW and
> > > SP800-90-CTR-256 are the only supported algorithms suggests that your
> > > implementation is at least similar to the RDRAND based RngDxe
> > > implementation in EDK2.
> >
> > I've updated the RngTest-X64.efi binary with a version that invokes
> > both the RAW and the default algorithm twice with a request for 64
> > bytes of entropy, like we do in the kernel. It runs fine on my
> > Thinkpad, can you check whether it works on your Dell system as well?
>
> RngTest-X64.efi seems to run through fine.[*] Additionally, if I modify the
> kernel code to request only 32 bytes, it returns EFI_INVALID_PARAMETER as
> well. So something else seems to be missing... Just to verify: does
> efi_random_get_seed() work on your Thinkpad, if called from efi_main()? Have
> you tested that, by chance?[**]
>

I have just tried a v5.4-rc5 kernel built with your patch applied, and
it does not boot at all in EFI mode, without any output whatsoever.

Unfortunately, I don't have the bandwidth currently to dig into this,
but I should be able to help out a bit more next week.

>
> [*] As a sidenote: I say "seems" as the screen is immediately blanked
> once the RngTest-X64.efi binary has run through, so I have to capture the
> output with a camera. Maybe add a delay of some sort to the RngTest-X86.efi
> binary?
>

Are you running it from the UEFI shell?

> [**] patch with additional debug outputs (on top of Linus' tree) here:
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
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index de434feb873a..45572b7e0548 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -2515,6 +2515,14 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
>   */
>  void add_bootloader_randomness(const void *buf, unsigned int size)
>  {
> +       unsigned long *data = buf;
> +
> +       pr_notice("random: adding %u bits of %sbootloader-provided randomness",
> +               size * 8,
> +               IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER) ? "trusted " : "");
> +
> +       pr_notice("random: is this random? %lx", *data);
> +
>         if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
>                 add_hwgenerator_randomness(buf, size, size * 8);
>         else
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 69f00f7453a3..e98bbf8e56d9 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -554,7 +554,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
>                                               sizeof(*seed) + size);
>                         if (seed != NULL) {
>                                 pr_notice("seeding entropy pool\n");
> -                               add_device_randomness(seed->bits, seed->size);
> +                               add_bootloader_randomness(seed->bits, seed->size);
>                                 early_memunmap(seed, sizeof(*seed) + size);
>                         } else {
>                                 pr_err("Could not map UEFI random seed!\n");
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
> diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
> index b4b1d1dcb5fd..70612cdd62c8 100644
> --- a/drivers/firmware/efi/libstub/random.c
> +++ b/drivers/firmware/efi/libstub/random.c
> @@ -152,33 +152,49 @@ efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg)
>
>         status = efi_call_early(locate_protocol, &rng_proto, NULL,
>                                 (void **)&rng);
> -       if (status != EFI_SUCCESS)
> +       if (status != EFI_SUCCESS) {
> +               pr_efi_err(sys_table_arg, "random: no protocol");
>                 return status;
> +       }
>
>         status = efi_call_early(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
>                                 sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
>                                 (void **)&seed);
> -       if (status != EFI_SUCCESS)
> +       if (status != EFI_SUCCESS){
> +               pr_efi_err(sys_table_arg, "random: no pool");
>                 return status;
> +       }
>
>         status = rng->get_rng(rng, &rng_algo_raw, EFI_RANDOM_SEED_SIZE,
>                               seed->bits);
> -       if (status == EFI_UNSUPPORTED)
> +       if (status == EFI_DEVICE_ERROR)
> +               pr_efi_err(sys_table_arg, "random: device error");
> +       if (status == EFI_NOT_READY)
> +               pr_efi_err(sys_table_arg, "random: not ready");
> +       if (status == EFI_INVALID_PARAMETER)
> +               pr_efi_err(sys_table_arg, "random: invalid parameter"); // that's the reason...
> +       if (status == EFI_UNSUPPORTED) {
>                 /*
>                  * Use whatever algorithm we have available if the raw algorithm
>                  * is not implemented.
>                  */
> +
>                 status = rng->get_rng(rng, NULL, EFI_RANDOM_SEED_SIZE,
>                                       seed->bits);
> +       }
>
> -       if (status != EFI_SUCCESS)
> +       if (status != EFI_SUCCESS) {
> +               pr_efi_err(sys_table_arg, "random: no bytes");
>                 goto err_freepool;
> +       }
>
>         seed->size = EFI_RANDOM_SEED_SIZE;
>         status = efi_call_early(install_configuration_table, &rng_table_guid,
>                                 seed);
> -       if (status != EFI_SUCCESS)
> +       if (status != EFI_SUCCESS) {
> +               pr_efi_err(sys_table_arg, "random: install_configuration_table");
>                 goto err_freepool;
> +       }
>
>         return EFI_SUCCESS;
>
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
