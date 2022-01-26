Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F7A49C85E
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 12:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbiAZLN5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jan 2022 06:13:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46998 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiAZLN5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jan 2022 06:13:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FF1AB81620;
        Wed, 26 Jan 2022 11:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF200C340EF;
        Wed, 26 Jan 2022 11:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643195634;
        bh=XM/Db7XSGpUQAZICPTrs3C2ME/dQWmo0rbes+fxO+a0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iO5RMBPGEds4p+yMag3ze50gepOaar+jaeociy+ticNNjhNsb8rsdBlZgB1EYPCHM
         lyz8Lqm5H0uCdrx3uxL19tQxnDcW7WeoKwMFcInKlf5Io8I/Cl/e4UirTfKypFW7FU
         L5peNUkhMpSDWbeVrOL5TqB4iMx8Z9Yooz+bvwzXsZgeV2EAeDD4K1izot+6VVjwwE
         zeHmwVzmKN6vSZ0RnhXGKyzXWf8MNsLgjc4gbZV6jK7ZwbJhLlAaiJkkdi2ki6Hm8U
         YaBPVm64OczQMqvMxFAgHWnXMTbAb+SeFKJYwBYrtbOy85nObP4iXp2kplCwhD47hQ
         /cxCgP9WDKFRQ==
Received: by mail-wr1-f45.google.com with SMTP id r25so8443531wrc.12;
        Wed, 26 Jan 2022 03:13:54 -0800 (PST)
X-Gm-Message-State: AOAM532SbJ+n2EMi9/e6NEoczIadKpQabDNMmzvyAMuV+dHC+9n9Zanc
        bxnqByVT2KN9UctLw5EDWAEqGZSQcdpurqQMjrY=
X-Google-Smtp-Source: ABdhPJwS0KJhYDwcunbECK8QjzphnXPHe5+y9Vh5Bp6dYp0Zsh5y/pH7rHyLH6SnUcjfCB/PIJ4UrcZhU/WAgye4O3k=
X-Received: by 2002:a5d:4944:: with SMTP id r4mr22242724wrs.550.1643195632984;
 Wed, 26 Jan 2022 03:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20220126110615.33371-1-sunilvl@ventanamicro.com> <20220126110615.33371-2-sunilvl@ventanamicro.com>
In-Reply-To: <20220126110615.33371-2-sunilvl@ventanamicro.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Jan 2022 12:13:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGaBJX9qVXQXiFHPySfDz7SWYQ6+cbHvV5v3sw3tEv0Ow@mail.gmail.com>
Message-ID: <CAMj1kXGaBJX9qVXQXiFHPySfDz7SWYQ6+cbHvV5v3sw3tEv0Ow@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Abner Chang <abner.chang@hpe.com>,
        Jessica Clarke <jrtc27@jrtc27.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Sunil,

On Wed, 26 Jan 2022 at 12:06, Sunil V L <sunilvl@ventanamicro.com> wrote:
>
> This patch adds the support for getting the boot hart ID in
> Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/firmware/efi/libstub/efistub.h    | 15 ++++++++++++
>  drivers/firmware/efi/libstub/riscv-stub.c | 28 ++++++++++++++++++++---
>  include/linux/efi.h                       |  1 +
>  3 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index edb77b0621ea..0428f8816942 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -720,6 +720,21 @@ union efi_tcg2_protocol {
>         } mixed_mode;
>  };
>
> +typedef union riscv_efi_boot_protocol riscv_efi_boot_protocol_t;
> +
> +union riscv_efi_boot_protocol {
> +       struct {
> +               u64 revision;
> +               efi_status_t (__efiapi *get_boot_hartid)(
> +                                                        riscv_efi_boot_protocol_t *,
> +                                                        size_t *);
> +       };
> +       struct {
> +               u32 revision;
> +               u32 get_boot_hartid;
> +       } mixed_mode;
> +};
> +

You don't the mixed mode member here - this is for X64 kernels on IA32
firmware only.

>  typedef union efi_load_file_protocol efi_load_file_protocol_t;
>  typedef union efi_load_file_protocol efi_load_file2_protocol_t;
>
> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> index 380e4e251399..c7add4eb5453 100644
> --- a/drivers/firmware/efi/libstub/riscv-stub.c
> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> @@ -46,12 +46,34 @@ static u32 get_boot_hartid_from_fdt(void)
>         return fdt32_to_cpu(*prop);
>  }
>
> +static u32 get_boot_hartid_from_efi(void)
> +{
> +       efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
> +       efi_status_t status;
> +       riscv_efi_boot_protocol_t *boot_protocol;
> +       size_t boot_hart_id;
> +
> +       status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
> +                            (void **)&boot_protocol);
> +       if (status == EFI_SUCCESS) {
> +               status = efi_call_proto(boot_protocol,
> +                                       get_boot_hartid, &boot_hart_id);
> +               if (status == EFI_SUCCESS) {
> +                       return (u32)boot_hart_id;
> +               }
> +       }
> +       return U32_MAX;
> +}
> +
>  efi_status_t check_platform_features(void)
>  {
> -       hartid = get_boot_hartid_from_fdt();
> +       hartid = get_boot_hartid_from_efi();
>         if (hartid == U32_MAX) {
> -               efi_err("/chosen/boot-hartid missing or invalid!\n");
> -               return EFI_UNSUPPORTED;
> +               hartid = get_boot_hartid_from_fdt();
> +               if (hartid == U32_MAX) {
> +                       efi_err("/chosen/boot-hartid missing or invalid!\n");
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
