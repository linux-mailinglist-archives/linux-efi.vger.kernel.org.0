Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C237152DC62
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 20:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbiESSHp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 14:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243604AbiESSHo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 14:07:44 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D96D941AF
        for <linux-efi@vger.kernel.org>; Thu, 19 May 2022 11:07:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f863469afbso65665137b3.0
        for <linux-efi@vger.kernel.org>; Thu, 19 May 2022 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcjVw/C61oH9MO2vq0TEosk2QoMcMTcOP6iTXwM1Imk=;
        b=Bly4/VIk2mp1Zm47Z/R9VCAnjQXGxCkstcgbPY9u9zlTpUFi/hyiG6VJBRjZk7F7yS
         Te3BRmhK4WXN5cOqtwQ34P9mq0DlEwkn/nDsng7QxQKAo3XESNflSuenlim2O6Oy0Ctd
         B6VRybdO47cd2XGSrFZlWgFgaMQlmLPnGXFyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcjVw/C61oH9MO2vq0TEosk2QoMcMTcOP6iTXwM1Imk=;
        b=OuSTlv+4DVzppE9RTVzQyILsPBWPq6cUSjIs/0ko1nn8/GMxl0hpP9NbI6t2y7+jj7
         scc3JEA8jbwjMV8Haf6YOwn8zDL22Fjmo8tbpSdzGh/yW30mx16KMY8IfCF4F4I1xwGu
         Nrt+RnHspzA5D1WEQXpXsyi3bIzIqKn6Vz9V6VEb8dr9v6NNamRgisbKjydFEp+tcXKb
         Ibu1N33cAX9lkquYoxFS5xrmnKgnb8kvnDCNfMNQWnw4OLaaxfrX+pkN04ku8oAvn3VU
         ojERmKkNIK/bzs5eRBVPtkilQ8NkxhcKyhJEUUW3bkI5DiFpKGmYW96WTJsmUu4839pL
         rbUQ==
X-Gm-Message-State: AOAM532NRqlNxsawQCA/XHTwsiYLUeJgkqWg7Br88R6ppVFKBfjIzubg
        +D7wDdYI36rYW/PTRAfLoO/TEiwHDhpIyZcMwqQR
X-Google-Smtp-Source: ABdhPJzoPGSuS7/uwFvjd9b5dItfqWlDbb3NqKkTyeYmTFTSu7vWkaWgdbD31EmpuTMbzawsYzbFEl9Gvt+LTBESob0=
X-Received: by 2002:a81:8494:0:b0:2fe:ff73:cdb7 with SMTP id
 u142-20020a818494000000b002feff73cdb7mr5778647ywf.373.1652983660355; Thu, 19
 May 2022 11:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220518095646.47548-1-sunilvl@ventanamicro.com>
 <20220518095646.47548-2-sunilvl@ventanamicro.com> <CAMj1kXF2N+0zRCNg0Aq9Y8Y35FUaQ1V+swzY__y86sayKW7PPA@mail.gmail.com>
 <04ed20b1-e312-dfc2-c314-02750c076681@canonical.com> <CAMj1kXEX0DWprb7cv_js1=M1J1hSXLBa=cOOjVo3tTVyGT0siQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEX0DWprb7cv_js1=M1J1hSXLBa=cOOjVo3tTVyGT0siQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 19 May 2022 11:07:28 -0700
Message-ID: <CAOnJCULUoedeARe0J=aduAVD35uHMe0MN9Pc_LDkavWZ-VtOkg@mail.gmail.com>
Subject: Re: [PATCH V4 1/1] riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 19, 2022 at 1:14 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 19 May 2022 at 08:17, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> >
> >
> > On 5/18/22 23:03, Ard Biesheuvel wrote:
> > > On Wed, 18 May 2022 at 11:57, Sunil V L <sunilvl@ventanamicro.com> wrote:
> > >>
> > >> This patch adds the support for getting the boot hart ID in
> > >> Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL. This protocol
> > >> is preferred method over existing DT based solution since it
> > >> works irrespective of DT or ACPI.
> > >>
> > >> The specification of the protocol is hosted at:
> > >> https://github.com/riscv-non-isa/riscv-uefi
> > >>
> > >> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > >> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > >> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >> ---
> > >>   drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
> > >>   drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
> > >>   include/linux/efi.h                       |  1 +
> > >>   3 files changed, 32 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > >> index edb77b0621ea..aced62a0907e 100644
> > >> --- a/drivers/firmware/efi/libstub/efistub.h
> > >> +++ b/drivers/firmware/efi/libstub/efistub.h
> > >> @@ -720,6 +720,13 @@ union efi_tcg2_protocol {
> > >>          } mixed_mode;
> > >>   };
> > >>
> > >> +struct riscv_efi_boot_protocol {
> > >> +       u64 revision;
> > >> +
> > >> +       efi_status_t (__efiapi * get_boot_hartid)(struct riscv_efi_boot_protocol *this,
> > >> +                                                 size_t *boot_hartid);
> > >
> > > size_t is not a EFI type, and your spec uses UINTN here, which is
> > > equivalent to 'unsigned long'. However, jump_kernel_func() takes a
> > > unsigned int for the hartid. Please clean this up.
> >
> > unsigned long and size_t have the same number of bits. This seems to be
> > a question of taste where we should follow the maintainer.
> >
>
> We use unsigned long wherever the UEFI spec uses UINTN. This is not a
> matter of taste, really.
>
> > jump_kernel_func() assuming boot hart ID to be an unsigned int is not in
> > line with the RISC-V ISA which allows to use all xlen bits.
> >
> > >
> > >
> > >> +};
> > >> +
> > >>   typedef union efi_load_file_protocol efi_load_file_protocol_t;
> > >>   typedef union efi_load_file_protocol efi_load_file2_protocol_t;
> > >>
> > >> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> > >> index 9c460843442f..012504f6f9a4 100644
> > >> --- a/drivers/firmware/efi/libstub/riscv-stub.c
> > >> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> > >> @@ -23,7 +23,7 @@
> > >>
> > >>   typedef void __noreturn (*jump_kernel_func)(unsigned int, unsigned long);
> > >>
> > >> -static u32 hartid;
> > >> +static size_t hartid;
> > >>
> > >
> > > and here
> > >
> > >>   static int get_boot_hartid_from_fdt(void)
> > >>   {
> > >> @@ -47,14 +47,33 @@ static int get_boot_hartid_from_fdt(void)
> > >>          return 0;
> > >>   }
> > >>
> > >> +static efi_status_t get_boot_hartid_from_efi(void)
> > >> +{
> > >> +       efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
> > >> +       efi_status_t status;
> > >> +       struct riscv_efi_boot_protocol *boot_protocol;
> > >> +
> > >> +       status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
> > >> +                            (void **)&boot_protocol);
> > >> +       if (status == EFI_SUCCESS) {
> > >> +               status = efi_call_proto(boot_protocol,
> > >> +                                       get_boot_hartid, &hartid);
> >
> > A lot of the kernel code seems to be unfit to handle hart IDs exceeding
> > INT_MAX (e.g. sbi_cpu_is_stopped()). Until this is fixed we have to
> > treat hartid > INT_MAX as an error.
> >
>
> This is an issue in the core kernel code, not in the EFI stub. As you
> pointed out, the ISA implies UINTN / unsigned long here, and if the
> startup code cannot deal with that, it can be fixed separately.

It was kept as unsigned int because hartid > INT_MAX is very unlikely to happen.
But I agree that we should just follow the spec(allowing XLEN bits for
hartid) and
change "unsigned int" to "unsigned long" wherever hartid is concerned.

As the hartid is changed to unsigned long, get_boot_hartid_from_fdt
should be fixed as well.
Currently, it is using fdt32_to_cpu.



--
Regards,
Atish
