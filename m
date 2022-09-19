Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42255BD249
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 18:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiISQfr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Sep 2022 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiISQfr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 12:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5F5356E0
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 09:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AA4060F25
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 16:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE0EC433B5
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 16:35:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="n8XY2FBF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663605342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nqMzSXUJsdO4vsxdti3jmbZnt7bLop8U1TXnpZk65+k=;
        b=n8XY2FBFyLyoq9ctTdgsfqr8qu3EfORPgLlOhJiSeAaH+GcrLxltME9KR050SsbQ0HUYSL
        300cIYtSF5Z9tp5r9qErzt1kfnw5gc1uQsUgMU3dj3P/rkDOocDJV5z+213DQFLAyeYDwC
        hlBNYweEdxPwOwer+mUv2pvbmgzjvjw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5c6d0e0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-efi@vger.kernel.org>;
        Mon, 19 Sep 2022 16:35:41 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id u14so10691905ual.3
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 09:35:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf1hmR6Q5EIR/lzwwOqvT85dRQZEDE8sb+IoJEtwOBcHrubm93Pb
        diJDM8Dt4jCRoYmLSj5n71ALJHdlPGDJ6+nXY5g=
X-Google-Smtp-Source: AMsMyM4Dpe2Y5YpbwKzjvRWrDThvWd81vXp0UK2T4iWKX1Q/ttRI++Y3x65rX0/g8Zi8CQAIgunTSyhJLDPPdOq4I/M=
X-Received: by 2002:ab0:758a:0:b0:3af:2b2d:dae7 with SMTP id
 q10-20020ab0758a000000b003af2b2ddae7mr6512657uap.24.1663605340543; Mon, 19
 Sep 2022 09:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220919160931.2945427-1-ardb@kernel.org> <20220919160931.2945427-4-ardb@kernel.org>
In-Reply-To: <20220919160931.2945427-4-ardb@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 19 Sep 2022 18:35:29 +0200
X-Gmail-Original-Message-ID: <CAHmME9qUM94zcqm3pO4-GoUVQrhBy7X+mhZoaVubNQ6H6FNsWg@mail.gmail.com>
Message-ID: <CAHmME9qUM94zcqm3pO4-GoUVQrhBy7X+mhZoaVubNQ6H6FNsWg@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi: random: combine bootloader provided RNG seed
 with RNG protocol output
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 19, 2022 at 6:09 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Instead of blindly creating the EFI random seed configuration table if
> the RNG protocol is implemented and works, check whether such a EFI
> configuration table was provided by an earlier boot stage and if so,
> combine its contents with a Linux specific personalization string, and
> if available, mix in the output of the RNG protocol as well.
>
> This can be used for, e.g., systemd-boot, to pass an additional seed to
> Linux in a way that can be consumed by the kernel very early. In that
> case, the following definitions should be used to pass the seed to the
> EFI stub:
>
>   struct linux_efi_random_seed {
>           u32     size; // of the 'seed' array in bytes
>           u8      seed[];
>   };
>
> The memory for the struct must be allocated as EFI_ACPI_RECLAIM_MEMORY
> pool memory, and the address of the struct in memory should be installed
> as a EFI configuration table using the following GUID:
>
> LINUX_EFI_RANDOM_SEED_TABLE_GUID        1ce1e5bc-7ceb-42f2-81e5-8aadf180f57b
>
> Note that doing so is safe even on kernels that were built without this
> patch applied, but the seed will simply be overwritten with a seed
> derived from the EFI RNG protocol, if available. The recommended seed
> size is 32 bytes, anything beyond that is mixed in but not reflected in
> the final seed size.
>
> Suggested-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/Makefile  |  4 +
>  drivers/firmware/efi/libstub/efistub.h |  2 +
>  drivers/firmware/efi/libstub/random.c  | 79 ++++++++++++--------
>  include/linux/efi.h                    |  2 -
>  lib/crypto/blake2s-generic.c           |  2 +
>  lib/crypto/blake2s.c                   |  7 +-
>  6 files changed, 60 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index d0537573501e..3b3c67001566 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -55,6 +55,7 @@ KCOV_INSTRUMENT                       := n
>  lib-y                          := efi-stub-helper.o gop.o secureboot.o tpm.o \
>                                    file.o mem.o random.o randomalloc.o pci.o \
>                                    skip_spaces.o lib-cmdline.o lib-ctype.o \
> +                                  libcrypto-blake2s.o libcrypto-blake2s-generic.o \
>                                    alignedmem.o relocate.o vsprintf.o
>
>  # include the stub's generic dependencies from lib/ when building for ARM/arm64
> @@ -63,6 +64,9 @@ efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
>  $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
>         $(call if_changed_rule,cc_o_c)
>
> +$(obj)/libcrypto-%.o: $(srctree)/lib/crypto/%.c FORCE
> +       $(call if_changed_rule,cc_o_c)
> +
>  lib-$(CONFIG_EFI_GENERIC_STUB) += efi-stub.o fdt.o string.o \
>                                    $(patsubst %.c,lib-%.o,$(efi-deps-y))
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index b0ae0a454404..fc32897de5e8 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -873,6 +873,8 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
>  efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
>                               unsigned long *addr, unsigned long random_seed);
>
> +void efi_random_get_seed(void);
> +
>  efi_status_t check_platform_features(void);
>
>  void *get_efi_config_table(efi_guid_t guid);
> diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
> index 183dc5cdb8ed..87fcd73ef615 100644
> --- a/drivers/firmware/efi/libstub/random.c
> +++ b/drivers/firmware/efi/libstub/random.c
> @@ -5,6 +5,7 @@
>
>  #include <linux/efi.h>
>  #include <asm/efi.h>
> +#include <crypto/blake2s.h>
>
>  #include "efistub.h"
>
> @@ -49,60 +50,74 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out)
>         return efi_call_proto(rng, get_rng, NULL, size, out);
>  }
>
> +static char const pstr[] = "Linux EFI Stub RNG Seed Label v1";
> +
>  /**
>   * efi_random_get_seed() - provide random seed as configuration table
>   *
>   * The EFI_RNG_PROTOCOL is used to read random bytes. These random bytes are
>   * saved as a configuration table which can be used as entropy by the kernel
>   * for the initialization of its pseudo random number generator.
> - *
> - * If the EFI_RNG_PROTOCOL is not available or there are not enough random bytes
> - * available, the configuration table will not be installed and an error code
> - * will be returned.
> - *
> - * Return:     status code
>   */
> -efi_status_t efi_random_get_seed(void)
> +void efi_random_get_seed(void)
>  {
>         efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
>         efi_guid_t rng_algo_raw = EFI_RNG_ALGORITHM_RAW;
>         efi_guid_t rng_table_guid = LINUX_EFI_RANDOM_SEED_TABLE_GUID;
>         efi_rng_protocol_t *rng = NULL;
>         struct linux_efi_random_seed *seed = NULL;
> +       struct blake2s_state state;
> +       unsigned int total_len = 0;
>         efi_status_t status;
>
> -       status = efi_bs_call(locate_protocol, &rng_proto, NULL, (void **)&rng);
> -       if (status != EFI_SUCCESS)
> -               return status;
> +       // grab the EFI RNG protocol, if it exists
> +       efi_bs_call(locate_protocol, &rng_proto, NULL, (void **)&rng);
>
> -       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> -                            sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
> -                            (void **)&seed);
> -       if (status != EFI_SUCCESS)
> -               return status;
> +       // grab the seed provided by the previous boot stages
> +       seed = get_efi_config_table(LINUX_EFI_RANDOM_SEED_TABLE_GUID);
> +
> +       // if neither exists, there is little we can do
> +       if (!seed && !rng)
> +               return;
> +
> +       blake2s_init(&state, EFI_RANDOM_SEED_SIZE);
> +       blake2s_update(&state, pstr, sizeof(pstr) - 1);
> +
> +       if (seed) {
> +               blake2s_update(&state, (void *)&seed->size, sizeof(seed->size));
> +               blake2s_update(&state, seed->bits, seed->size);

Since this is never freed, and also just for hygiene, add:

memzero_explicit(seed, sizeof(seed));
