Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD92B559523
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiFXIQm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 04:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiFXIQm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 04:16:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E96F485;
        Fri, 24 Jun 2022 01:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5FDCB827BC;
        Fri, 24 Jun 2022 08:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78538C341CA;
        Fri, 24 Jun 2022 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656058598;
        bh=jWpHXWlGqc4Z0J1vvGJZN3RIBEMWZLt5R5rFiivhRQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iJChLPgVV8wr+MUF13gVCra/GQlpqJA7N620ahB99PBLE3kJ7vXsCTJPzcOdQMm//
         p1lCJ6W9+FKCxS1al+pn9loJcvyux8JpAxyE7MAqUxiQ7i5pINXSw0xDabaRA4qeoS
         WbsK7KWkPZUw90Us4+4Wswec3soX+RgZiqJvbTg4SKa7A2mYZqRIiNvjU7xXlyoXIy
         PLb6ALeTdODqKUX1nzqwma/XtQGe9QN4n1v80bB4LRaOGh3b9RThHYXPnYcpKrbV1K
         aEBuKLZ74m98YoT1xXOW539MSW7iqJfFyIUJo2UgwecsYoPHGnqgulutq8+6NKE2c2
         tH+Pq/1qt2rzg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-101cdfddfacso2811441fac.7;
        Fri, 24 Jun 2022 01:16:38 -0700 (PDT)
X-Gm-Message-State: AJIora93y5xMtjHGLTX1qhNjUe68k7TZKRkp3yUIvWmMbq3/ipI2L5+Q
        0pFLwYa2QN3gcHpX18XBbM+KQNWaN1yGOjZdABA=
X-Google-Smtp-Source: AGRyM1vjOvx9tFgwlcG8UvBr5ri2ogVJI4fNjHBtGEIiYbZ/bX90t2oFgFqWprXFsVm0fclrfFbDHI6uAuibIsTZ6ks=
X-Received: by 2002:a05:6870:e98b:b0:fe:219a:2449 with SMTP id
 r11-20020a056870e98b00b000fe219a2449mr1240963oao.228.1656058597624; Fri, 24
 Jun 2022 01:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220617174851.1286026-1-ardb@kernel.org> <20220617174851.1286026-3-ardb@kernel.org>
In-Reply-To: <20220617174851.1286026-3-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Jun 2022 10:16:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGyjhYFAefU4JSXchV5T-w3YuWh1B4+sgsLHoi+KLeACw@mail.gmail.com>
Message-ID: <CAMj1kXGyjhYFAefU4JSXchV5T-w3YuWh1B4+sgsLHoi+KLeACw@mail.gmail.com>
Subject: Re: [PATCH 2/4] Input: applespi - avoid efivars API and invoke EFI
 services directly
To:     linux-efi <linux-efi@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 17 Jun 2022 at 19:49, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> This driver abuses the efivar API, by using a few of its helpers on
> entries that were not instantiated by the API itself. This is a problem
> as future cleanup work on efivars is complicated by this.
>
> So let's just switch to the get/set variable runtime wrappers directly.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Unless anyone minds, I will queue this up in efi/next

> ---
>  drivers/input/keyboard/applespi.c | 42 +++++++-------------
>  1 file changed, 14 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> index d1f5354d5ea2..cbc6c0d4670a 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1597,52 +1597,38 @@ static u32 applespi_notify(acpi_handle gpe_device, u32 gpe, void *context)
>
>  static int applespi_get_saved_bl_level(struct applespi_data *applespi)
>  {
> -       struct efivar_entry *efivar_entry;
> +       efi_status_t sts = EFI_NOT_FOUND;
>         u16 efi_data = 0;
> -       unsigned long efi_data_len;
> -       int sts;
> -
> -       efivar_entry = kmalloc(sizeof(*efivar_entry), GFP_KERNEL);
> -       if (!efivar_entry)
> -               return -ENOMEM;
> -
> -       memcpy(efivar_entry->var.VariableName, EFI_BL_LEVEL_NAME,
> -              sizeof(EFI_BL_LEVEL_NAME));
> -       efivar_entry->var.VendorGuid = EFI_BL_LEVEL_GUID;
> -       efi_data_len = sizeof(efi_data);
> +       unsigned long efi_data_len = sizeof(efi_data);
>
> -       sts = efivar_entry_get(efivar_entry, NULL, &efi_data_len, &efi_data);
> -       if (sts && sts != -ENOENT)
> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
> +               sts = efi.get_variable(EFI_BL_LEVEL_NAME, &EFI_BL_LEVEL_GUID,
> +                                      NULL, &efi_data_len, &efi_data);
> +       if (sts != EFI_SUCCESS && sts != EFI_NOT_FOUND)
>                 dev_warn(&applespi->spi->dev,
> -                        "Error getting backlight level from EFI vars: %d\n",
> +                        "Error getting backlight level from EFI vars: 0x%lx\n",
>                          sts);
>
> -       kfree(efivar_entry);
> -
> -       return sts ? sts : efi_data;
> +       return sts != EFI_SUCCESS ? -ENODEV : efi_data;
>  }
>
>  static void applespi_save_bl_level(struct applespi_data *applespi,
>                                    unsigned int level)
>  {
> -       efi_guid_t efi_guid;
> +       efi_status_t sts = EFI_UNSUPPORTED;
>         u32 efi_attr;
> -       unsigned long efi_data_len;
>         u16 efi_data;
> -       int sts;
>
> -       /* Save keyboard backlight level */
> -       efi_guid = EFI_BL_LEVEL_GUID;
>         efi_data = (u16)level;
> -       efi_data_len = sizeof(efi_data);
>         efi_attr = EFI_VARIABLE_NON_VOLATILE | EFI_VARIABLE_BOOTSERVICE_ACCESS |
>                    EFI_VARIABLE_RUNTIME_ACCESS;
>
> -       sts = efivar_entry_set_safe((efi_char16_t *)EFI_BL_LEVEL_NAME, efi_guid,
> -                                   efi_attr, true, efi_data_len, &efi_data);
> -       if (sts)
> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
> +               sts = efi.set_variable(EFI_BL_LEVEL_NAME, &EFI_BL_LEVEL_GUID,
> +                                      efi_attr, sizeof(efi_data), &efi_data);
> +       if (sts != EFI_SUCCESS)
>                 dev_warn(&applespi->spi->dev,
> -                        "Error saving backlight level to EFI vars: %d\n", sts);
> +                        "Error saving backlight level to EFI vars: 0x%lx\n", sts);
>  }
>
>  static int applespi_probe(struct spi_device *spi)
> --
> 2.35.1
>
