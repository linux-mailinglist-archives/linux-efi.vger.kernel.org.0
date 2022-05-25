Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0645346ED
	for <lists+linux-efi@lfdr.de>; Thu, 26 May 2022 01:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbiEYXLy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 May 2022 19:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiEYXLx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 May 2022 19:11:53 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB90A5AA5
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 16:11:51 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ec42eae76bso230131407b3.10
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 16:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mm1aY/BdEGgm5C/qzynm8Cyr6ViPrOaHpTh3MCfMy4=;
        b=RyvnfDJs0Rseco3iLXTZ+iPwdihRyFfVKRrDTwspg4Qc3DIVeyzY+dHix2zI4nSgHn
         D8VGUZY6SG3XLMpJMLvsRxqaow/KD3Q905Gxx2t9oItcjYyMWz554n7MBnDqjhXq8zB0
         EAbgqyX8qFiN6NI545xyN0PB9sgEr5xtDCb08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mm1aY/BdEGgm5C/qzynm8Cyr6ViPrOaHpTh3MCfMy4=;
        b=jzj6QQQn/x6CLoDQzHZ9nvUSSp+OMq9ZVAKYbqfr7MuQ+RIiX9jv6IGgy9co/3sLsI
         XBQ+K/qg89Hc/0r3L5mwsV4ciVcBEMKKL56PgHE9JVVdrO7H13dtPWzF6/6jvton6eIe
         0NPR2Jh64YJPs3OJF6n489MTp7gJakZHeopZr2hbUcNwdyfGNCKwdyubSiClzL0Xryms
         j56LoRsmPj1eYh2FHHJPN7Wjsu4M5AlsqX9LuTLvL7ljeLmX+mZ2F0pUSo0p5NacDhdF
         BMiGUkAOeA9cHUNdCeBL0S1jdByL+/+n3hth6VDdEQb0CZcp52YBWSCM8sWBIRvCBfVz
         Odhg==
X-Gm-Message-State: AOAM531CQ5zm/RLZWQCDyWez5OfUBVHOSqL494S7nn7Ifw0U96Qyz7Ql
        MC/tpRnQoz/xeN0wweJh1hV2hpIlOjkvly/IVc8D
X-Google-Smtp-Source: ABdhPJx3ULvZXcVEBtgdS0E5XoYo/4N3FYTfZ2i5Gw2cvII72BCF9nS2480KdMribBkprxpRJSb7p87PCzEiQIU3yFI=
X-Received: by 2002:a0d:e88c:0:b0:2fe:da96:1b77 with SMTP id
 r134-20020a0de88c000000b002feda961b77mr35598083ywe.262.1653520311153; Wed, 25
 May 2022 16:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
 <20220525151106.2176147-6-sunilvl@ventanamicro.com> <CAMj1kXFhEBv7MVCKZuXdx9=hZx3qWbkATdLDwXAe_Zn9Xyx=dg@mail.gmail.com>
 <1e90b15b-8c73-0de8-2885-1292923b7575@canonical.com>
In-Reply-To: <1e90b15b-8c73-0de8-2885-1292923b7575@canonical.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 25 May 2022 16:11:40 -0700
Message-ID: <CAOnJCU+r6KgR7bd2dx5QLmmVLjJX8GhETHb6rG65wq0e_m6FVA@mail.gmail.com>
Subject: Re: [PATCH 5/5] riscv/efi_stub: Support for 64bit boot-hartid
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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

On Wed, May 25, 2022 at 9:09 AM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 5/25/22 17:48, Ard Biesheuvel wrote:
> > On Wed, 25 May 2022 at 17:11, Sunil V L <sunilvl@ventanamicro.com> wrote:
> >>
> >> The boot-hartid can be a 64bit value on RV64 platforms. Currently,
> >> the "boot-hartid" in DT is assumed to be 32bit only. This patch
> >> detects the size of the "boot-hartid" and uses 32bit or 64bit
> >> FDT reads appropriately.
> >>
> >> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> >> ---
> >>   drivers/firmware/efi/libstub/riscv-stub.c | 12 +++++++++---
> >>   1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> >> index 9e85e58d1f27..d748533f1329 100644
> >> --- a/drivers/firmware/efi/libstub/riscv-stub.c
> >> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> >> @@ -29,7 +29,7 @@ static int get_boot_hartid_from_fdt(void)
> >>   {
> >>          const void *fdt;
> >>          int chosen_node, len;
> >> -       const fdt32_t *prop;
> >> +       const void *prop;
> >>
> >>          fdt = get_efi_config_table(DEVICE_TREE_GUID);
> >>          if (!fdt)
> >> @@ -40,10 +40,16 @@ static int get_boot_hartid_from_fdt(void)
> >>                  return -EINVAL;
> >>
> >>          prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
> >> -       if (!prop || len != sizeof(u32))
> >> +       if (!prop)
> >> +               return -EINVAL;
> >> +
> >> +       if (len == sizeof(u32))
> >> +               hartid = (unsigned long) fdt32_to_cpu(*(fdt32_t *)prop);
> >> +       else if (len == sizeof(u64))
> >> +               hartid = (unsigned long) fdt64_to_cpu(*(fdt64_t *)prop);
> >
> > Does RISC-V care about alignment? A 64-bit quantity is not guaranteed
> > to appear 64-bit aligned in the DT, and the cast violates C alignment
> > rules, so this should probably used get_unaligned_be64() or something
> > like that.
>
> When running in S-mode the SBI handles unaligned access but this has a
> performance penalty.
>
> We could use fdt64_to_cpu(__get_unaligned_t(fdt64_t, prop)) here.
>

It is better to avoid unaligned access in the kernel. There are some
plans to disable
misaligned load/store emulation in the firmware if user space requests
it via prctl.

We need another SBI extension to do that. The idea is to keep it
enabled by default in the firmware but
userspace should have an option to disable it via prctl. If we make
sure that the kernel doesn't invoke any
unaligned access, this feature can be implemented easily.

> Best regards
>
> Heinrich
>
> >
> >
> >> +       else
> >>                  return -EINVAL;
> >>
> >> -       hartid = fdt32_to_cpu(*prop);
> >>          return 0;
> >>   }
> >>
> >> --
> >> 2.25.1
> >>
>


-- 
Regards,
Atish
