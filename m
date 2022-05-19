Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD6552CF8A
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 11:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbiESJjU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiESJjS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 05:39:18 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99105793AF
        for <linux-efi@vger.kernel.org>; Thu, 19 May 2022 02:39:17 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id a9so2543936pgv.12
        for <linux-efi@vger.kernel.org>; Thu, 19 May 2022 02:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mLcbwj32rdj40iW44+duGhfUCpi8Xywy8Dql/7GVxog=;
        b=HRetMmQnRH96uhorno98Hawv3lvxCCBh8FpbHGB10ofuBOLNOJBcvp1mxldyvtB+zg
         XydyL+DF1kRbyuT9fya2ym6SeIzMUNJ4Pp/TzbGGJIGxDjTXe3yuE6NgmqLXgNzbALzc
         54hHYss0sACylfqtcs/plm6/83VKJlt/QhqV6fkcidO4ee6Wnh5tWOkKXIGvy97y2tyn
         5MNxraQBmI8/q4qY+OgE2cf+lhkytVzJetmoFta57CNmu6GGcpoAlsy7XpkbElBeusH3
         5R8ZfEQVgHgwSU2kX8YQkrUJinddGpFgUMKw8pCbKSlBRYjBmCy9HZtfK6WqPylJABSc
         JWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mLcbwj32rdj40iW44+duGhfUCpi8Xywy8Dql/7GVxog=;
        b=q91Utkc95BfShLhDdQZqfwJt9dsvY4vfzuPvAeA9hNvcumPs6Eb+XxNOG5UGACeYKF
         nhB0hvN3uD5cueFfUuSzHJ+9Iwm3eTPLr99k4qQc4mHj64mQzgQEbucslHtkqN8ewqiP
         s8JQ2HfDY4E2+gpvGL7tIq/jYEk995dYSuYzmP/MKBmNPbyrdUD04zK/fes7bsOvAmVG
         FiMi/y9c1fTLuA2myxz/wOI29KvXrkr/X/ZgDOXQCBbGpNIWGU5cQF2GN7vTUddwNbUe
         5D8instoPnim5pMErDisNxNBjF8raa129QEHZvZeFuQcathEjTUAZBtrEvnaTfMIy6SR
         H0WA==
X-Gm-Message-State: AOAM533dt6oRRY8mH/j3rIUgTs3m6vsE6d+h/xvHlnFDkzNTctjDrIFQ
        hJ/eqk8OOy57rSCVqkicHnNyHQ==
X-Google-Smtp-Source: ABdhPJxQu6DtfFjo6+chXKKIZiJGwOJDreDTn7NfBzt4Qr6PeHY8zCMvhS/f3BXs6KmcoJ8grOR6xA==
X-Received: by 2002:a05:6a00:1ad1:b0:50d:f07a:3eb8 with SMTP id f17-20020a056a001ad100b0050df07a3eb8mr3785680pfv.25.1652953157089;
        Thu, 19 May 2022 02:39:17 -0700 (PDT)
Received: from sunil-laptop ([49.206.10.235])
        by smtp.gmail.com with ESMTPSA id er14-20020a17090af6ce00b001cd4989fecesm5176371pjb.26.2022.05.19.02.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 02:39:16 -0700 (PDT)
Date:   Thu, 19 May 2022 15:09:09 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [PATCH V5 1/1] riscv/efi_stub: Add support for
 RISCV_EFI_BOOT_PROTOCOL
Message-ID: <20220519093909.GA20599@sunil-laptop>
References: <20220519051512.136724-1-sunilvl@ventanamicro.com>
 <20220519051512.136724-2-sunilvl@ventanamicro.com>
 <CAMj1kXHPXqXndUK408W9kB9VrOy_zXfAaXFiLhzXBs_FVYnXmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHPXqXndUK408W9kB9VrOy_zXfAaXFiLhzXBs_FVYnXmQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 19, 2022 at 10:24:44AM +0200, Ard Biesheuvel wrote:
> On Thu, 19 May 2022 at 07:15, Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > This patch adds the support for getting the boot hart ID in
> > Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL. This protocol
> > is preferred method over existing DT based solution since it
> > works irrespective of DT or ACPI.
> >
> > The specification of the protocol is hosted at:
> > https://github.com/riscv-non-isa/riscv-uefi
> >
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> Queued in efi/next, thanks all.
> 
> Sunil: I made some minor tweaks for coding style, whitespace etc when
> applying, please double check that I did not make any mistakes.
> Thanks.

Yes, it looks good, Ard. Many thanks!

Regards
Sunil
> 
> 
> > ---
> >  drivers/firmware/efi/libstub/efistub.h    |  7 +++++
> >  drivers/firmware/efi/libstub/riscv-stub.c | 31 ++++++++++++++++++-----
> >  include/linux/efi.h                       |  1 +
> >  3 files changed, 33 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > index edb77b0621ea..87aa66e8ef43 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -720,6 +720,13 @@ union efi_tcg2_protocol {
> >         } mixed_mode;
> >  };
> >
> > +struct riscv_efi_boot_protocol {
> > +       u64 revision;
> > +
> > +       efi_status_t (__efiapi * get_boot_hartid)(struct riscv_efi_boot_protocol *this,
> > +                                                 unsigned long *boot_hartid);
> > +};
> > +
> >  typedef union efi_load_file_protocol efi_load_file_protocol_t;
> >  typedef union efi_load_file_protocol efi_load_file2_protocol_t;
> >
> > diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> > index 9c460843442f..10c59295f379 100644
> > --- a/drivers/firmware/efi/libstub/riscv-stub.c
> > +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> > @@ -21,9 +21,9 @@
> >  #define MIN_KIMG_ALIGN         SZ_4M
> >  #endif
> >
> > -typedef void __noreturn (*jump_kernel_func)(unsigned int, unsigned long);
> > +typedef void __noreturn (*jump_kernel_func)(unsigned long, unsigned long);
> >
> > -static u32 hartid;
> > +static unsigned long hartid;
> >
> >  static int get_boot_hartid_from_fdt(void)
> >  {
> > @@ -47,14 +47,33 @@ static int get_boot_hartid_from_fdt(void)
> >         return 0;
> >  }
> >
> > +static efi_status_t get_boot_hartid_from_efi(void)
> > +{
> > +       efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
> > +       efi_status_t status;
> > +       struct riscv_efi_boot_protocol *boot_protocol;
> > +
> > +       status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
> > +                            (void **)&boot_protocol);
> > +       if (status == EFI_SUCCESS) {
> > +               status = efi_call_proto(boot_protocol,
> > +                                       get_boot_hartid, &hartid);
> > +       }
> > +       return status;
> > +}
> > +
> >  efi_status_t check_platform_features(void)
> >  {
> >         int ret;
> > +       efi_status_t status;
> >
> > -       ret = get_boot_hartid_from_fdt();
> > -       if (ret) {
> > -               efi_err("/chosen/boot-hartid missing or invalid!\n");
> > -               return EFI_UNSUPPORTED;
> > +       status = get_boot_hartid_from_efi();
> > +       if (status != EFI_SUCCESS) {
> > +               ret = get_boot_hartid_from_fdt();
> > +               if (ret) {
> > +                       efi_err("Failed to get boot hartid!\n");
> > +                       return EFI_UNSUPPORTED;
> > +               }
> >         }
> >         return EFI_SUCCESS;
> >  }
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index ccd4d3f91c98..9822c730207c 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -380,6 +380,7 @@ void efi_native_runtime_setup(void);
> >  #define EFI_CONSOLE_OUT_DEVICE_GUID            EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
> >  #define APPLE_PROPERTIES_PROTOCOL_GUID         EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
> >  #define EFI_TCG2_PROTOCOL_GUID                 EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
> > +#define RISCV_EFI_BOOT_PROTOCOL_GUID           EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
> >  #define EFI_LOAD_FILE_PROTOCOL_GUID            EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> >  #define EFI_LOAD_FILE2_PROTOCOL_GUID           EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
> >  #define EFI_RT_PROPERTIES_TABLE_GUID           EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
> > --
> > 2.25.1
> >
