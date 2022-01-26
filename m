Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0581D49C904
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 12:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbiAZLqF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jan 2022 06:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiAZLqD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jan 2022 06:46:03 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF8FC061759
        for <linux-efi@vger.kernel.org>; Wed, 26 Jan 2022 03:45:59 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g20so2788784pgn.10
        for <linux-efi@vger.kernel.org>; Wed, 26 Jan 2022 03:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b2YyWOge0M5kIT2ntqlrnr8NQs2OgZVVCHIbAnzaaKE=;
        b=WWfym4P+R3+IwpIxkHRmeB3tynZEscCZnnZFQ1YzNukA01mkuDYl6d6i0ahPydblHO
         AtQpFKqiEmopvLkUdF8SPT3UCWN2zo2PkJlketuHAyWOJs1Egydvx1C7wfNtGJK3pGsx
         DIv2rwUpj/l6XDgrxw6d+aHzeeIJY8aBeKMyjw4HWN5NOIWWRTfyS4FCNE9ccyWlkGdb
         Zf1j5vo2fJosqpjNgc7nwLvJaGWi9wGl1DB3ZFhfTbcFI9HvS1pX3SnT2qLvg3fnH0Ey
         NWyuC6ckMkdcCBYNd2PTyVoqfPtqgAPpS6Lg/cUpo1nJY6xGWBu6z+Fnegr/1N7X2+1M
         Hzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b2YyWOge0M5kIT2ntqlrnr8NQs2OgZVVCHIbAnzaaKE=;
        b=2w0FMucrvTrv4jqKU1baSivB18VuHpqbeHTWwRSaU+cC1KOK3R3dDbx0OK3KmHBKi4
         nVX7+84FT/g8WAl4yt4tzHuOlsF660kXYQ0Z6mv/tBAkNGPpVHU59uFDUlvQyIiPrmV1
         FWSFP8iL26AyNZ9WFSgLS5QFjez9vTaoF6wcw+pjJhZZQiduqSVsxezbiRRQXu0kkEeK
         Q1mSurh371ox4Y4rk5/1aysTy2aRMGeloo4eWZaPpb416d4jibHUSX8cQdDJAPWT6esq
         W2+J88hFLBdAI/mdNJNXdLMMOM6iLcrhN+sXU/ePKQdKPh8PoWvH0dMmMRygq6zFSc+7
         zMWA==
X-Gm-Message-State: AOAM530d/Z1Q07DcJQlsZG4si7dxvZZJmvw1DN24T3V7D+TyFSRHHbV0
        yULLGtRNUJcggcwhxeTzFL8LRA==
X-Google-Smtp-Source: ABdhPJyzaxql9iVXuLykTnyDGM1rb4BxxzxCMBfHaQkTumc+35DPn7h/HgwDnFeQSyGT+oLQfq6hHQ==
X-Received: by 2002:a63:6f07:: with SMTP id k7mr18454510pgc.574.1643197558636;
        Wed, 26 Jan 2022 03:45:58 -0800 (PST)
Received: from sunil-ThinkPad-T490 ([49.206.3.187])
        by smtp.gmail.com with ESMTPSA id na7sm3055210pjb.23.2022.01.26.03.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:45:58 -0800 (PST)
Date:   Wed, 26 Jan 2022 17:15:49 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [RFC PATCH 1/1] riscv/efi_stub: Add support for
 RISCV_EFI_BOOT_PROTOCOL
Message-ID: <20220126114549.GA35654@sunil-ThinkPad-T490>
References: <20220126110615.33371-1-sunilvl@ventanamicro.com>
 <20220126110615.33371-2-sunilvl@ventanamicro.com>
 <CAMj1kXGaBJX9qVXQXiFHPySfDz7SWYQ6+cbHvV5v3sw3tEv0Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGaBJX9qVXQXiFHPySfDz7SWYQ6+cbHvV5v3sw3tEv0Ow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 26, 2022 at 12:13:42PM +0100, Ard Biesheuvel wrote:
> Hello Sunil,
> 
> On Wed, 26 Jan 2022 at 12:06, Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > This patch adds the support for getting the boot hart ID in
> > Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL.
> >
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  drivers/firmware/efi/libstub/efistub.h    | 15 ++++++++++++
> >  drivers/firmware/efi/libstub/riscv-stub.c | 28 ++++++++++++++++++++---
> >  include/linux/efi.h                       |  1 +
> >  3 files changed, 41 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > index edb77b0621ea..0428f8816942 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -720,6 +720,21 @@ union efi_tcg2_protocol {
> >         } mixed_mode;
> >  };
> >
> > +typedef union riscv_efi_boot_protocol riscv_efi_boot_protocol_t;
> > +
> > +union riscv_efi_boot_protocol {
> > +       struct {
> > +               u64 revision;
> > +               efi_status_t (__efiapi *get_boot_hartid)(
> > +                                                        riscv_efi_boot_protocol_t *,
> > +                                                        size_t *);
> > +       };
> > +       struct {
> > +               u32 revision;
> > +               u32 get_boot_hartid;
> > +       } mixed_mode;
> > +};
> > +
> 
> You don't the mixed mode member here - this is for X64 kernels on IA32
> firmware only.

Ah OK. Thanks for the feedback, Ard. Will remove it in next version.

Thanks
Sunil
> 
> >  typedef union efi_load_file_protocol efi_load_file_protocol_t;
> >  typedef union efi_load_file_protocol efi_load_file2_protocol_t;
> >
> > diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> > index 380e4e251399..c7add4eb5453 100644
> > --- a/drivers/firmware/efi/libstub/riscv-stub.c
> > +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> > @@ -46,12 +46,34 @@ static u32 get_boot_hartid_from_fdt(void)
> >         return fdt32_to_cpu(*prop);
> >  }
> >
> > +static u32 get_boot_hartid_from_efi(void)
> > +{
> > +       efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
> > +       efi_status_t status;
> > +       riscv_efi_boot_protocol_t *boot_protocol;
> > +       size_t boot_hart_id;
> > +
> > +       status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
> > +                            (void **)&boot_protocol);
> > +       if (status == EFI_SUCCESS) {
> > +               status = efi_call_proto(boot_protocol,
> > +                                       get_boot_hartid, &boot_hart_id);
> > +               if (status == EFI_SUCCESS) {
> > +                       return (u32)boot_hart_id;
> > +               }
> > +       }
> > +       return U32_MAX;
> > +}
> > +
> >  efi_status_t check_platform_features(void)
> >  {
> > -       hartid = get_boot_hartid_from_fdt();
> > +       hartid = get_boot_hartid_from_efi();
> >         if (hartid == U32_MAX) {
> > -               efi_err("/chosen/boot-hartid missing or invalid!\n");
> > -               return EFI_UNSUPPORTED;
> > +               hartid = get_boot_hartid_from_fdt();
> > +               if (hartid == U32_MAX) {
> > +                       efi_err("/chosen/boot-hartid missing or invalid!\n");
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
