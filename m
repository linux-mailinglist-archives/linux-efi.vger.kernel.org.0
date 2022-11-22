Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A738E633DE3
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 14:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiKVNj4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 08:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiKVNjw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 08:39:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD3B59FE6;
        Tue, 22 Nov 2022 05:39:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9EA7B819ED;
        Tue, 22 Nov 2022 13:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557BEC43470;
        Tue, 22 Nov 2022 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669124388;
        bh=bAhkPmpXqz2tFgI523IWjd0wI9fHjPVBJ+d3LM6chXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dPtI3XTfZ+GXeh7ghtt9lRdvV7euOHLo5WUTqNWNmfdOgx9PJ4ID1AmZ6CPEoAvET
         8OpbOactRW1fKwcfflpIEtWAOqQoXaX0NZ7YefNP6CDij2VsRXSXGDEUSTKMwtZyBu
         Ed1Tewc8Mq0vP3zLkj0FpQ9ojKlEFz0BpUgeUZ7yKQbBOOyHc6rbFtkhdL9Urta8un
         4TRwLtcbHZtBnJp+diJayiETtHWVL9eD6nmuyXoXoWzKIiJzdGECNLcO4SwZlO2K//
         drZhox4NOBsAg9V3DXEs/TdUA0aqxACv16zmFN2g9I3SiB41sEiJGSeZRAwmIyVioy
         kFAl9C/luuqBg==
Received: by mail-lf1-f42.google.com with SMTP id g12so23632788lfh.3;
        Tue, 22 Nov 2022 05:39:48 -0800 (PST)
X-Gm-Message-State: ANoB5plicwdItKEI33M8wqXHHWSJjHOUkDWif4C9ULh5JvNM8uREWydY
        9ZNN8P5wNZDlw4zHoBdNZkUX120KdJRRPxJ7xvI=
X-Google-Smtp-Source: AA0mqf46UEJFNPXFwvfOsEYYZp/AJYJPYPw2s9cT/PGT5cOmy93kGtPcgNJvFpcL5IiI4gBligWcB1CLgtplRZNBEnc=
X-Received: by 2002:a05:6512:3c89:b0:4a2:bfd2:b218 with SMTP id
 h9-20020a0565123c8900b004a2bfd2b218mr7757722lfv.228.1669124386229; Tue, 22
 Nov 2022 05:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20221118133239.2515648-1-Jason@zx2c4.com> <20221118133239.2515648-6-Jason@zx2c4.com>
In-Reply-To: <20221118133239.2515648-6-Jason@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Nov 2022 14:39:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEQNuGXoHaL3xEEXE5V8QhV75xP7J9oGn+cnL=Aog+J8Q@mail.gmail.com>
Message-ID: <CAMj1kXEQNuGXoHaL3xEEXE5V8QhV75xP7J9oGn+cnL=Aog+J8Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] efi: random: refresh non-volatile random seed when
 RNG is initialized
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 18 Nov 2022 at 14:34, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> EFI has a rather unique benefit that it has access to some limited
> non-volatile storage, where the kernel can store a random seed. Register
> a notification for when the RNG is initialized, and at that point, store
> a new random seed.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/firmware/efi/efi.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>

Not sure why I don't see v3 in my inbox. In any case,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

for this patch, or the one with the varname wide string literal used
in place instead of via a CPP macro.

> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index f12cc29bd4b8..f8edf6164833 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -337,6 +337,24 @@ static void __init efi_debugfs_init(void)
>  static inline void efi_debugfs_init(void) {}
>  #endif
>
> +static void refresh_nv_rng_seed(struct work_struct *work)
> +{
> +       u8 seed[EFI_RANDOM_SEED_SIZE];
> +
> +       get_random_bytes(seed, sizeof(seed));
> +       efi.set_variable(LINUX_EFI_RANDOM_NV_SEED_VAR, &LINUX_EFI_RANDOM_SEED_TABLE_GUID,
> +                        EFI_VARIABLE_NON_VOLATILE | EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                        EFI_VARIABLE_RUNTIME_ACCESS, sizeof(seed), seed);
> +       memzero_explicit(seed, sizeof(seed));
> +}
> +static int refresh_nv_rng_seed_notification(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +       static DECLARE_WORK(work, refresh_nv_rng_seed);
> +       schedule_work(&work);
> +       return 0;
> +}
> +static struct notifier_block refresh_nv_rng_seed_nb = { .notifier_call = refresh_nv_rng_seed_notification };
> +
>  /*
>   * We register the efi subsystem with the firmware subsystem and the
>   * efivars subsystem with the efi subsystem, if the system was booted with
> @@ -413,6 +431,7 @@ static int __init efisubsys_init(void)
>                 platform_device_register_simple("efi_secret", 0, NULL, 0);
>  #endif
>
> +       execute_with_initialized_rng(&refresh_nv_rng_seed_nb);
>         return 0;
>
>  err_remove_group:
> --
> 2.38.1
>
