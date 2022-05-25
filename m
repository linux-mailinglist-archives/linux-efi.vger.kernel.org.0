Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF28E53470D
	for <lists+linux-efi@lfdr.de>; Thu, 26 May 2022 01:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiEYXt7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 May 2022 19:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344701AbiEYXt6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 May 2022 19:49:58 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DAE6BFE2
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 16:49:57 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id t26so359164ybt.3
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 16:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2b8MlsVgy0PXNmTV8dy+TKz5ObSmm8PiUnaznemS1Kk=;
        b=RnE0k5m41tRreeyjV9rIBQp9IS8n51q9BWAAP9GOOssrHJTyMFtm4+pWqy0RYQfjxn
         yKed2IVryFnIF5xIWCU9MAdGEa/N9nXMxd6lVgHwZeq/y89d3yGfxFLVc3P7CG36Zp4Z
         KjivNcINMRfMiq3+Hz52iMRYUSqaAgCxB5S/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2b8MlsVgy0PXNmTV8dy+TKz5ObSmm8PiUnaznemS1Kk=;
        b=F+4EdmgSqkLDTd3ktvfWv+MnSC2c1OpV/Ivwi3sF8IhoCqUM3SYNQwLJU1tG+ja4p5
         lhOXQYLeFJDgJ65OmMXqrE1wVcgWPoj26G/txVdfPw4ZXXqRhOr+expm150vX5uqIKMg
         VKSr2HdiqJ+lsr3jhgtvbBDqJu7PUEHMuh+iao32TcnOKIaw6rsVxXiLmcRiqAdq47Eh
         N0zhf3pVW2NEzws8PVoUJ3M89ascXGg1sHu/mosvkRHpNbYgN27D66XgGeObH8gREIMD
         7n3La9cxLslsYIK5zQaRNRoWOPn+VaDR/a6WBvPLd9UJ3UYsaqHSP8hPoaDJNWPh4O5b
         x9Sg==
X-Gm-Message-State: AOAM532LjuELqzBz/EumZzuLiwHT9C3fqC3YVREbRVVSWmKu1hYzjxKk
        KjMFFbpauNa01ql96797WDmGvyQplP+dgRRb+sgy
X-Google-Smtp-Source: ABdhPJx01HOcesLXja2nXoz3VGaZoBMY86NiLV8f653GkRtUx7ztDYWr3KTWHpdFIcaTk74gwDVwL9zVZHwKKB5bmIk=
X-Received: by 2002:a25:a287:0:b0:656:29f4:b0c1 with SMTP id
 c7-20020a25a287000000b0065629f4b0c1mr3996630ybi.598.1653522597025; Wed, 25
 May 2022 16:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
 <20220525151106.2176147-6-sunilvl@ventanamicro.com> <CAMj1kXFhEBv7MVCKZuXdx9=hZx3qWbkATdLDwXAe_Zn9Xyx=dg@mail.gmail.com>
 <1e90b15b-8c73-0de8-2885-1292923b7575@canonical.com> <CAOnJCU+r6KgR7bd2dx5QLmmVLjJX8GhETHb6rG65wq0e_m6FVA@mail.gmail.com>
 <5829932A-6E45-46CA-AADA-14EDD903C4AD@jrtc27.com>
In-Reply-To: <5829932A-6E45-46CA-AADA-14EDD903C4AD@jrtc27.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 25 May 2022 16:49:46 -0700
Message-ID: <CAOnJCUKbT88c+_PzEuchEtzjEtiHcMFvRH_G98z1AmpSdRH+BA@mail.gmail.com>
Subject: Re: [PATCH 5/5] riscv/efi_stub: Support for 64bit boot-hartid
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Sunil V L <sunil.vl@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 25, 2022 at 4:36 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 26 May 2022, at 00:11, Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Wed, May 25, 2022 at 9:09 AM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 5/25/22 17:48, Ard Biesheuvel wrote:
> >>> On Wed, 25 May 2022 at 17:11, Sunil V L <sunilvl@ventanamicro.com> wrote:
> >>>>
> >>>> The boot-hartid can be a 64bit value on RV64 platforms. Currently,
> >>>> the "boot-hartid" in DT is assumed to be 32bit only. This patch
> >>>> detects the size of the "boot-hartid" and uses 32bit or 64bit
> >>>> FDT reads appropriately.
> >>>>
> >>>> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> >>>> ---
> >>>> drivers/firmware/efi/libstub/riscv-stub.c | 12 +++++++++---
> >>>> 1 file changed, 9 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> >>>> index 9e85e58d1f27..d748533f1329 100644
> >>>> --- a/drivers/firmware/efi/libstub/riscv-stub.c
> >>>> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> >>>> @@ -29,7 +29,7 @@ static int get_boot_hartid_from_fdt(void)
> >>>> {
> >>>> const void *fdt;
> >>>> int chosen_node, len;
> >>>> - const fdt32_t *prop;
> >>>> + const void *prop;
> >>>>
> >>>> fdt = get_efi_config_table(DEVICE_TREE_GUID);
> >>>> if (!fdt)
> >>>> @@ -40,10 +40,16 @@ static int get_boot_hartid_from_fdt(void)
> >>>> return -EINVAL;
> >>>>
> >>>> prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
> >>>> - if (!prop || len != sizeof(u32))
> >>>> + if (!prop)
> >>>> + return -EINVAL;
> >>>> +
> >>>> + if (len == sizeof(u32))
> >>>> + hartid = (unsigned long) fdt32_to_cpu(*(fdt32_t *)prop);
> >>>> + else if (len == sizeof(u64))
> >>>> + hartid = (unsigned long) fdt64_to_cpu(*(fdt64_t *)prop);
> >>>
> >>> Does RISC-V care about alignment? A 64-bit quantity is not guaranteed
> >>> to appear 64-bit aligned in the DT, and the cast violates C alignment
> >>> rules, so this should probably used get_unaligned_be64() or something
> >>> like that.
> >>
> >> When running in S-mode the SBI handles unaligned access but this has a
> >> performance penalty.
> >>
> >> We could use fdt64_to_cpu(__get_unaligned_t(fdt64_t, prop)) here.
> >>
> >
> > It is better to avoid unaligned access in the kernel. There are some
> > plans to disable
> > misaligned load/store emulation in the firmware if user space requests
> > it via prctl.
>
> Why?
>
To support prctl call with PR_SET_UNALIGN

> Jess
>
> > We need another SBI extension to do that. The idea is to keep it
> > enabled by default in the firmware but
> > userspace should have an option to disable it via prctl. If we make
> > sure that the kernel doesn't invoke any
> > unaligned access, this feature can be implemented easily.
> >
> >> Best regards
> >>
> >> Heinrich
> >>
> >>>
> >>>
> >>>> + else
> >>>> return -EINVAL;
> >>>>
> >>>> - hartid = fdt32_to_cpu(*prop);
> >>>> return 0;
> >>>> }
> >>>>
> >>>> --
> >>>> 2.25.1
> >>>>
> >>
> >
> >
> > --
> > Regards,
> > Atish
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>


-- 
Regards,
Atish
