Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B52152CE02
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiESIOC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 04:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiESIOB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 04:14:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D5F5F259;
        Thu, 19 May 2022 01:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38217B8237F;
        Thu, 19 May 2022 08:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2870C34119;
        Thu, 19 May 2022 08:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652948037;
        bh=4plX3uAS0SdnNX/Myvz2UrgGFPyHEHdk2KPq8Rkr4mc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p0HxlkY0Ho5DNCZnUU1uEZNgZf5rGqqa0iGKzJxvwq9h74upAs5gnVnK1AMIh0kI2
         oZnxix2xtNoqa4FoVFc5J586PcQm14fhJ0W6vZLz+oXyE8bz12NBVmZqfjsdUOwnlH
         IWC/elkhrLHAQ8BpeR4Z4Rkb2ehit8my6ADlrASp2GhEAGuRGSZY0eFW1y4GzGs0GQ
         8xSLc8/M2aNvESilk8RD3WhfJKNGnsTc1SgRsn+USrhqZSGuJ5D+kLBZIe7RmrxkVp
         DW0Nq/fMQuJwDsuujio2cu9AGJpMbkS0qZYbkWxjP4idCgPsctWOF1fMG9EuX85g9Z
         ZXom/N0rMMh2w==
Received: by mail-ot1-f45.google.com with SMTP id p12-20020a9d4e0c000000b00606b40860a3so3033762otf.11;
        Thu, 19 May 2022 01:13:57 -0700 (PDT)
X-Gm-Message-State: AOAM532Wq8n6NetVUbJbkqQAGCAcMu/dc0WBeKpz8VPPhlQ6Dtd8ccL5
        yvGDtTSIIH8TLOkU1NicOHiRxt4non57ZZzm/Tg=
X-Google-Smtp-Source: ABdhPJwAAiXUyk+6r2tu1xnOHDPmu3iQD/VTSnREM+hS2xEtjPlVcokUQo0nNQ+np9MYI+FTF10/GOrHTvdCeXNeVvg=
X-Received: by 2002:a9d:84f:0:b0:605:e229:3c82 with SMTP id
 73-20020a9d084f000000b00605e2293c82mr1435134oty.71.1652948036975; Thu, 19 May
 2022 01:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220518095646.47548-1-sunilvl@ventanamicro.com>
 <20220518095646.47548-2-sunilvl@ventanamicro.com> <CAMj1kXF2N+0zRCNg0Aq9Y8Y35FUaQ1V+swzY__y86sayKW7PPA@mail.gmail.com>
 <04ed20b1-e312-dfc2-c314-02750c076681@canonical.com>
In-Reply-To: <04ed20b1-e312-dfc2-c314-02750c076681@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 19 May 2022 10:13:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEX0DWprb7cv_js1=M1J1hSXLBa=cOOjVo3tTVyGT0siQ@mail.gmail.com>
Message-ID: <CAMj1kXEX0DWprb7cv_js1=M1J1hSXLBa=cOOjVo3tTVyGT0siQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/1] riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Sunil V L <sunilvl@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Abner Chang <abner.chang@hpe.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
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

On Thu, 19 May 2022 at 08:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> On 5/18/22 23:03, Ard Biesheuvel wrote:
> > On Wed, 18 May 2022 at 11:57, Sunil V L <sunilvl@ventanamicro.com> wrote:
> >>
> >> This patch adds the support for getting the boot hart ID in
> >> Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL. This protocol
> >> is preferred method over existing DT based solution since it
> >> works irrespective of DT or ACPI.
> >>
> >> The specification of the protocol is hosted at:
> >> https://github.com/riscv-non-isa/riscv-uefi
> >>
> >> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> >> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> >> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
> >>   drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
> >>   include/linux/efi.h                       |  1 +
> >>   3 files changed, 32 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> >> index edb77b0621ea..aced62a0907e 100644
> >> --- a/drivers/firmware/efi/libstub/efistub.h
> >> +++ b/drivers/firmware/efi/libstub/efistub.h
> >> @@ -720,6 +720,13 @@ union efi_tcg2_protocol {
> >>          } mixed_mode;
> >>   };
> >>
> >> +struct riscv_efi_boot_protocol {
> >> +       u64 revision;
> >> +
> >> +       efi_status_t (__efiapi * get_boot_hartid)(struct riscv_efi_boot_protocol *this,
> >> +                                                 size_t *boot_hartid);
> >
> > size_t is not a EFI type, and your spec uses UINTN here, which is
> > equivalent to 'unsigned long'. However, jump_kernel_func() takes a
> > unsigned int for the hartid. Please clean this up.
>
> unsigned long and size_t have the same number of bits. This seems to be
> a question of taste where we should follow the maintainer.
>

We use unsigned long wherever the UEFI spec uses UINTN. This is not a
matter of taste, really.

> jump_kernel_func() assuming boot hart ID to be an unsigned int is not in
> line with the RISC-V ISA which allows to use all xlen bits.
>
> >
> >
> >> +};
> >> +
> >>   typedef union efi_load_file_protocol efi_load_file_protocol_t;
> >>   typedef union efi_load_file_protocol efi_load_file2_protocol_t;
> >>
> >> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> >> index 9c460843442f..012504f6f9a4 100644
> >> --- a/drivers/firmware/efi/libstub/riscv-stub.c
> >> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> >> @@ -23,7 +23,7 @@
> >>
> >>   typedef void __noreturn (*jump_kernel_func)(unsigned int, unsigned long);
> >>
> >> -static u32 hartid;
> >> +static size_t hartid;
> >>
> >
> > and here
> >
> >>   static int get_boot_hartid_from_fdt(void)
> >>   {
> >> @@ -47,14 +47,33 @@ static int get_boot_hartid_from_fdt(void)
> >>          return 0;
> >>   }
> >>
> >> +static efi_status_t get_boot_hartid_from_efi(void)
> >> +{
> >> +       efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
> >> +       efi_status_t status;
> >> +       struct riscv_efi_boot_protocol *boot_protocol;
> >> +
> >> +       status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
> >> +                            (void **)&boot_protocol);
> >> +       if (status == EFI_SUCCESS) {
> >> +               status = efi_call_proto(boot_protocol,
> >> +                                       get_boot_hartid, &hartid);
>
> A lot of the kernel code seems to be unfit to handle hart IDs exceeding
> INT_MAX (e.g. sbi_cpu_is_stopped()). Until this is fixed we have to
> treat hartid > INT_MAX as an error.
>

This is an issue in the core kernel code, not in the EFI stub. As you
pointed out, the ISA implies UINTN / unsigned long here, and if the
startup code cannot deal with that, it can be fixed separately.
