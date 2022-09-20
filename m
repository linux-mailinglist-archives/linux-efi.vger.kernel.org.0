Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ACF5BE49C
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 13:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiITLhm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 07:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiITLhl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 07:37:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887E36D9DE
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 04:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 33411CE149E
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 11:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A31EC4347C
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 11:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663673854;
        bh=4HkJGI7vcp5NPe8wJTiLRo76AmE2ncCmwGpekpx0LZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WITgcroz+NPsWk+3BBOG235xev1pEv8RGAX0ZcKatjLL2HLyyfl5z19a/fVOZAgmP
         JRGUX4869w/PDN7VKMqpCkDBqQQy40F7CivLPzpPm/fS2JkTfW6KN6EP5/tHgOFcTY
         7ofuZDTczUaz19mt/6yhOO612V6qntoqwz7H1jgd3V3w0h1LFJAr8HcmS4iF+OqoMu
         csUaV9h65fyGaiKG9a6Tvegs2Q4p+/YLU8Wu8VxoWw1wgmbQquhSeSDjU6Mkdg51mR
         IUQjYGXx2BhSS0AaBwBu7PMC1ZEnmI65SE5iL3wweG/VkATac0hmk1jX+A1a7w4CCD
         /zB7AuqRamMTw==
Received: by mail-lj1-f172.google.com with SMTP id a14so2610718ljj.8
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 04:37:34 -0700 (PDT)
X-Gm-Message-State: ACrzQf0JCiH1CTnSfgIJy/bfvJV3u5BeJjoaS0EaPcppo+Ea+CPBbIoB
        IOS2fnJWe63reEeTsXwun1DRr6N5A1fHAOWYdFo=
X-Google-Smtp-Source: AMsMyM6qokKzH3/yI1xaa5nmQ8Kf6+qvx/rdx4eTcID0ek16JDS9JkiZHW358GeYhw6XqRuH+M2/c2OSalqiNMs2oAc=
X-Received: by 2002:a2e:2d0a:0:b0:26c:a1c:cdf with SMTP id t10-20020a2e2d0a000000b0026c0a1c0cdfmr7464119ljt.352.1663673852081;
 Tue, 20 Sep 2022 04:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220918213544.2176249-1-ardb@kernel.org> <20220918213544.2176249-10-ardb@kernel.org>
 <20220920104045.GA18686@e124191.cambridge.arm.com>
In-Reply-To: <20220920104045.GA18686@e124191.cambridge.arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Sep 2022 13:37:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGj3h8XyEKBN0NRpzYqs-F3PvSqHGH5dbJUZpmZOYWnmA@mail.gmail.com>
Message-ID: <CAMj1kXGj3h8XyEKBN0NRpzYqs-F3PvSqHGH5dbJUZpmZOYWnmA@mail.gmail.com>
Subject: Re: [PATCH 09/12] efi: libstub: install boot-time memory map as
 config table
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
        linux@armlinux.org.uk, Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>, nd@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 20 Sept 2022 at 12:41, Joey Gouly <joey.gouly@arm.com> wrote:
>
> Hi Ard,
>
> On Sun, Sep 18, 2022 at 11:35:41PM +0200, Ard Biesheuvel wrote:
> > Expose the EFI boot time memory map to the kernel via a configuration
> > table. This is arch agnostic and enables future changes that remove the
> > dependency on DT on architectures that don't otherwise rely on it.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/libstub/arm64-stub.c      |  2 +-
> >  drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +-
> >  drivers/firmware/efi/libstub/efistub.h         |  3 ++-
> >  drivers/firmware/efi/libstub/mem.c             | 26 ++++++++++++++++++--
> >  drivers/firmware/efi/libstub/randomalloc.c     |  2 +-
> >  drivers/firmware/efi/libstub/relocate.c        |  2 +-
> >  include/linux/efi.h                            |  1 +
> >  7 files changed, 31 insertions(+), 7 deletions(-)
> >
> [..]
> > diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> > index 40721573e494..ed4c145afe11 100644
> > --- a/drivers/firmware/efi/libstub/mem.c
> > +++ b/drivers/firmware/efi/libstub/mem.c
> > @@ -9,14 +9,20 @@
> >   * efi_get_memory_map() - get memory map
> >   * @map:             pointer to memory map pointer to which to assign the
> >   *                   newly allocated memory map
> > + * @install_cfg_tbl: whether or not to install the boot memory map as a
> > + *                   configuration table
> >   *
> >   * Retrieve the UEFI memory map. The allocated memory leaves room for
> >   * up to EFI_MMAP_NR_SLACK_SLOTS additional memory map entries.
> >   *
> >   * Return:   status code
> >   */
> > -efi_status_t efi_get_memory_map(struct efi_boot_memmap **map)
> > +efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
> > +                             bool install_cfg_tbl)
> >  {
> > +     int memtype = install_cfg_tbl ? EFI_ACPI_RECLAIM_MEMORY
> > +                                   : EFI_LOADER_DATA;
> > +     efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
> >       struct efi_boot_memmap *m, tmp;
> >       efi_status_t status;
> >       unsigned long size;
> > @@ -28,11 +34,23 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap **map)
> >               return EFI_LOAD_ERROR;
> >
> >       size = tmp.map_size + tmp.desc_size * EFI_MMAP_NR_SLACK_SLOTS;
> > -     status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*m) + size,
> > +     status = efi_bs_call(allocate_pool, memtype, sizeof(*m) + size,
> >                            (void **)&m);
> >       if (status != EFI_SUCCESS)
> >               return status;
> >
> > +     if (install_cfg_tbl) {
> > +             /*
> > +              * Installing a configuration table might allocate memory, and
> > +              * this may modify the memory map. This means we should install
> > +              * the configuration table first, and re-install or delete it
> > +              * as needed.
> > +              */
> > +             status = efi_bs_call(install_configuration_table, &tbl_guid, m);
> > +             if (status != EFI_SUCCESS)
> > +                     goto free_map;
> > +     }
> > +
> >       m->buff_size = m->map_size = size;
> >       status = efi_bs_call(get_memory_map, &m->map_size, m->map, &m->map_key,
> >                            &m->desc_size, &m->desc_ver);
> > @@ -40,6 +58,10 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap **map)
> >       if (status == EFI_SUCCESS) {
> >               *map = m;
> >       } else {
> > +             if (install_cfg_tbl)
> > +                     efi_bs_call(install_configuration_table, &tbl_guid,
> > +                                 NULL);
> > +free_map:
> >               efi_bs_call(free_pool, m);
> >       }
>
> You have another commit about removing goto kludges, so maybe write this like the following,
> rather than a goto into an 'else' statement?
>
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index feef8d4be113..2f22ef7c5232 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -64,10 +64,12 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
>                         *map->key_ptr = key;
>                 if (map->desc_ver)
>                         *map->desc_ver = desc_version;
> -       } else {
> -               efi_bs_call(free_pool, m);
>         }
>
> +free_map:
> +       if (status != EFI_SUCCESS)
> +               efi_bs_call(free_pool, m);
> +
>  fail:
>         *map->map = m;
>         return status;
>

Yeah that might be better. Thanks for the suggestion.
