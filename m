Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331E668255E
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 08:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjAaHG4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Jan 2023 02:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAaHGz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Jan 2023 02:06:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A61630FE;
        Mon, 30 Jan 2023 23:06:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46E13B81914;
        Tue, 31 Jan 2023 07:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FAAC433EF;
        Tue, 31 Jan 2023 07:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675148812;
        bh=VITKGPVDd2e1fUPIs+B1fK1+Py967sPPaq02shlQyx4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IEvh6PbZOt45Hn2UVMFd2wYOizxgSENUjzDkUa+612fM3GbFoHqV31BMTh3WFDodV
         UnSxWCbcBaZHtSQNOedzJqL7JsZ2AflxPzoaDh84IcoYhW++DG9Rk2ZFSoAYWTYv8i
         gUdKpJaAQW2mBrXg5LFMUzLLakEOhXEqAta/qcVy6OCMJ0L6tAhEIaHDHp/vNQc8U9
         3l43k7/fHYuCd0MRUSp6xbXsIMCPp0HVfq1laVFd05gq/iPg1vUmYzDpBrU9HZ+VEW
         oqY/jIhozqy5gEh6A4msmdY0m3VG/1BnFJVp2sXzYRCjlJTMSWp5XQ337/guaRaih8
         VpunGAlwvfzhA==
Received: by mail-lj1-f173.google.com with SMTP id y19so15024101ljq.7;
        Mon, 30 Jan 2023 23:06:51 -0800 (PST)
X-Gm-Message-State: AFqh2kpoA+x4jwYCoCTdf+gLzQIYBGMcUQijiXx+QL8G8iEtQEhkvycg
        aC0pToEvyBQ141k43W5+soecQdWr3D8OVSxvqrU=
X-Google-Smtp-Source: AMrXdXs+8ddDVIxY+EbdW5OMRQO2/HFx4j3PfX0LX90N1AC7u8sG4ILqFjilXQ93Qtd3xkvVQR9AMu3xXPS0hnqBc0k=
X-Received: by 2002:a2e:a812:0:b0:28b:9149:6291 with SMTP id
 l18-20020a2ea812000000b0028b91496291mr3660948ljq.142.1675148809930; Mon, 30
 Jan 2023 23:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20230131040355.3116-1-justin.he@arm.com> <20230131040355.3116-3-justin.he@arm.com>
In-Reply-To: <20230131040355.3116-3-justin.he@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 31 Jan 2023 08:06:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE5Ogcxi=Mk7rC8YDo7E825Lk6sxKeTwBmGM8TkrSPs2g@mail.gmail.com>
Message-ID: <CAMj1kXE5Ogcxi=Mk7rC8YDo7E825Lk6sxKeTwBmGM8TkrSPs2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: Introduce efi_get_supported_rt_services() to get
 the runtime services mask
To:     Jia He <justin.he@arm.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 31 Jan 2023 at 05:04, Jia He <justin.he@arm.com> wrote:
>
> Previously, efi.runtime_supported_mask will always be the initial value
> EFI_RT_SUPPORTED_ALL and can't be retrieved in efi_config_parse_tables()
> if rt_prop is EFI_INVALID_TABLE_ADDR. Thus this can cause the wrong
> return value of efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)
> on the Ampere Emag server.
>
> Besides, abstract the runtime services retrieving into a new exported
> helper efi_get_supported_rt_services() to set or clear the runtime service
> bit of efi.flags.
>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  drivers/firmware/efi/arm-runtime.c |  5 ++++-
>  drivers/firmware/efi/efi.c         | 28 +++++++++++++++++++---------
>  include/linux/efi.h                |  1 +
>  3 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 83f5bb57fa4c..ce93133f9abc 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -146,7 +146,10 @@ static int __init arm_enable_runtime_services(void)
>
>         /* Set up runtime services function pointers */
>         efi_native_runtime_setup();
> -       set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> +       if (efi_get_supported_rt_services())
> +               set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> +       else
> +               clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
>

This is not right. There are now other users of the EFI runtime
service infrastructure (ACPI PRM), so even if all EFI runtime services
are marked as unsupported, we should still set the
EFI_RUNTIME_SERVICES bit if the EFI runtime memory map is provided.


>         return 0;
>  }
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index a2b0cbc8741c..96475cb8088e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -595,6 +595,24 @@ static __init int match_config_table(const efi_guid_t *guid,
>         return 0;
>  }
>
> +unsigned int __init efi_get_supported_rt_services(void)
> +{
> +       unsigned int runtime_supported_mask = EFI_RT_SUPPORTED_ALL;
> +
> +       if (rt_prop != EFI_INVALID_TABLE_ADDR) {
> +               efi_rt_properties_table_t *tbl;
> +
> +               tbl = early_memremap(rt_prop, sizeof(*tbl));
> +               if (tbl) {
> +                       runtime_supported_mask &= tbl->runtime_services_supported;
> +                       early_memunmap(tbl, sizeof(*tbl));
> +               }
> +       } else
> +               runtime_supported_mask = 0;
> +
> +       return runtime_supported_mask;
> +}
> +
>  int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>                                    int count,
>                                    const efi_config_table_type_t *arch_tables)
> @@ -695,15 +713,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>                 }
>         }
>
> -       if (rt_prop != EFI_INVALID_TABLE_ADDR) {
> -               efi_rt_properties_table_t *tbl;
> -
> -               tbl = early_memremap(rt_prop, sizeof(*tbl));
> -               if (tbl) {
> -                       efi.runtime_supported_mask &= tbl->runtime_services_supported;
> -                       early_memunmap(tbl, sizeof(*tbl));
> -               }
> -       }
> +       efi.runtime_supported_mask &= efi_get_supported_rt_services();
>
>         if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
>             initrd != EFI_INVALID_TABLE_ADDR && phys_initrd_size == 0) {
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 4b27519143f5..fcaf0d7fc07e 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -717,6 +717,7 @@ extern void __init efi_esrt_init(void);
>  #else
>  static inline void efi_esrt_init(void) { }
>  #endif
> +extern unsigned int efi_get_supported_rt_services(void);
>  extern int efi_config_parse_tables(const efi_config_table_t *config_tables,
>                                    int count,
>                                    const efi_config_table_type_t *arch_tables);
> --
> 2.25.1
>
