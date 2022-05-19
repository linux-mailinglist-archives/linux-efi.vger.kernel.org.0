Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD7A52CE42
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 10:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiESIZA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 04:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiESIY7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 04:24:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0D76A012;
        Thu, 19 May 2022 01:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D7ECB8238B;
        Thu, 19 May 2022 08:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EF9C34117;
        Thu, 19 May 2022 08:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652948696;
        bh=ZEJekTBIhFTQMReJEVjcc3RAMBP+23vqG3lt6ArNBuY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dEtFcmxiEJ6sgHea4RZuUAZeGzEUGhX2674PO0HO1NrXxAsQyAs01hHiWqDggHvZF
         ksbhD6muJDuWDZqJTCgiehzNMdeISNEgSVhe30iK0+7RPQpwkvYHNGGtzuvaRXGGUB
         rCNudm9716X8VSpVFry6DzPAhmEbeGfDbFTx8eD5jcABUQ5x243MPYCaVbB+XFtIsK
         9IebHbX8NqMwqI7iaCu+UeEN50FvOZmJBXaUERVG8VzMhsQBdfAwz9Rf+eJOBHQ92h
         nmpMeG6fuzlCOOEVxDqCmbunfu9rKm2ls2bKoxfVPvYr/UKzQSKLrJXhsaMxN7BG/q
         IxjoKb5Rk/Ezg==
Received: by mail-oo1-f43.google.com with SMTP id c19-20020a4a3813000000b0035ea4a3b97eso858431ooa.12;
        Thu, 19 May 2022 01:24:55 -0700 (PDT)
X-Gm-Message-State: AOAM533u8b+XTWWUKUmoqnutjK9deC5HVU3ZB0yoBJ57bhuGMzy1y7Oj
        hHZwHJABk0Zkzymn4JRYC67qXoMGpYlfnWwr/As=
X-Google-Smtp-Source: ABdhPJyXvlMk/ygLVnefCeYTBQZGYT2K371fd41lrDtSmbtessxv4fo/MoxgnCYY9+sbNWg3+ZcsQE3BVONYvS8ty3Q=
X-Received: by 2002:a4a:314f:0:b0:35e:9802:1ce5 with SMTP id
 v15-20020a4a314f000000b0035e98021ce5mr1476434oog.60.1652948695168; Thu, 19
 May 2022 01:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220519051512.136724-1-sunilvl@ventanamicro.com> <20220519051512.136724-2-sunilvl@ventanamicro.com>
In-Reply-To: <20220519051512.136724-2-sunilvl@ventanamicro.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 19 May 2022 10:24:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHPXqXndUK408W9kB9VrOy_zXfAaXFiLhzXBs_FVYnXmQ@mail.gmail.com>
Message-ID: <CAMj1kXHPXqXndUK408W9kB9VrOy_zXfAaXFiLhzXBs_FVYnXmQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/1] riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Abner Chang <abner.chang@hpe.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sunil V L <sunil.vl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 19 May 2022 at 07:15, Sunil V L <sunilvl@ventanamicro.com> wrote:
>
> This patch adds the support for getting the boot hart ID in
> Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL. This protocol
> is preferred method over existing DT based solution since it
> works irrespective of DT or ACPI.
>
> The specification of the protocol is hosted at:
> https://github.com/riscv-non-isa/riscv-uefi
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Queued in efi/next, thanks all.

Sunil: I made some minor tweaks for coding style, whitespace etc when
applying, please double check that I did not make any mistakes.
Thanks.


> ---
>  drivers/firmware/efi/libstub/efistub.h    |  7 +++++
>  drivers/firmware/efi/libstub/riscv-stub.c | 31 ++++++++++++++++++-----
>  include/linux/efi.h                       |  1 +
>  3 files changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index edb77b0621ea..87aa66e8ef43 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -720,6 +720,13 @@ union efi_tcg2_protocol {
>         } mixed_mode;
>  };
>
> +struct riscv_efi_boot_protocol {
> +       u64 revision;
> +
> +       efi_status_t (__efiapi * get_boot_hartid)(struct riscv_efi_boot_protocol *this,
> +                                                 unsigned long *boot_hartid);
> +};
> +
>  typedef union efi_load_file_protocol efi_load_file_protocol_t;
>  typedef union efi_load_file_protocol efi_load_file2_protocol_t;
>
> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> index 9c460843442f..10c59295f379 100644
> --- a/drivers/firmware/efi/libstub/riscv-stub.c
> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> @@ -21,9 +21,9 @@
>  #define MIN_KIMG_ALIGN         SZ_4M
>  #endif
>
> -typedef void __noreturn (*jump_kernel_func)(unsigned int, unsigned long);
> +typedef void __noreturn (*jump_kernel_func)(unsigned long, unsigned long);
>
> -static u32 hartid;
> +static unsigned long hartid;
>
>  static int get_boot_hartid_from_fdt(void)
>  {
> @@ -47,14 +47,33 @@ static int get_boot_hartid_from_fdt(void)
>         return 0;
>  }
>
> +static efi_status_t get_boot_hartid_from_efi(void)
> +{
> +       efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
> +       efi_status_t status;
> +       struct riscv_efi_boot_protocol *boot_protocol;
> +
> +       status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
> +                            (void **)&boot_protocol);
> +       if (status == EFI_SUCCESS) {
> +               status = efi_call_proto(boot_protocol,
> +                                       get_boot_hartid, &hartid);
> +       }
> +       return status;
> +}
> +
>  efi_status_t check_platform_features(void)
>  {
>         int ret;
> +       efi_status_t status;
>
> -       ret = get_boot_hartid_from_fdt();
> -       if (ret) {
> -               efi_err("/chosen/boot-hartid missing or invalid!\n");
> -               return EFI_UNSUPPORTED;
> +       status = get_boot_hartid_from_efi();
> +       if (status != EFI_SUCCESS) {
> +               ret = get_boot_hartid_from_fdt();
> +               if (ret) {
> +                       efi_err("Failed to get boot hartid!\n");
> +                       return EFI_UNSUPPORTED;
> +               }
>         }
>         return EFI_SUCCESS;
>  }
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index ccd4d3f91c98..9822c730207c 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -380,6 +380,7 @@ void efi_native_runtime_setup(void);
>  #define EFI_CONSOLE_OUT_DEVICE_GUID            EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>  #define APPLE_PROPERTIES_PROTOCOL_GUID         EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
>  #define EFI_TCG2_PROTOCOL_GUID                 EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
> +#define RISCV_EFI_BOOT_PROTOCOL_GUID           EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
>  #define EFI_LOAD_FILE_PROTOCOL_GUID            EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
>  #define EFI_LOAD_FILE2_PROTOCOL_GUID           EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
>  #define EFI_RT_PROPERTIES_TABLE_GUID           EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
> --
> 2.25.1
>
