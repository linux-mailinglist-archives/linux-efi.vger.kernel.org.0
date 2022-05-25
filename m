Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37BE534706
	for <lists+linux-efi@lfdr.de>; Thu, 26 May 2022 01:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiEYXga (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 May 2022 19:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiEYXg3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 May 2022 19:36:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3CA4C413
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 16:36:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s28so99983wrb.7
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 16:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=svxp83ully3titClkRHBPwkiGXlXX0awUR+v2+8RPek=;
        b=f/zQ8Wy4CFG4GCNX2VxulQq1o3t6fAR6PyNAk4FrZBvsIT8O3VQqu9ChxjyzHliEGO
         M4ZsmgMf09xPt1JVLQ5l679Q9UuNUmLF0Xw50ZYXWCxrRICWX8miJyzc/JMwQy0eoMdT
         PXbY7JF+xC4+56QiE65CmdZFJs8KSN5/VP2phyNQAs62yy62Of0/C3XVt0znAkCdLR9l
         sBT1r9Egotq10I39MzTrmDQmY7he939U2LPRpkygYfKLrVjk+JcocEclJ8IO5B+osMND
         E6HMhki6q5qdqtK1AElMfbCGQElQUcDlkRIGEI57d/ZGXbnmIqdsaAG8M8fzUbsWMOnN
         YpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=svxp83ully3titClkRHBPwkiGXlXX0awUR+v2+8RPek=;
        b=7/26Wwwqrghhd4fOd7/l9SyPuKfuFpsS5IjYXesgbvyaBbzZT3Bp1fFiaj5rjRE41u
         2T9qo/Ie/35UdBjblMcPc+dPrAyFisSvZ/0vL4vXI3ekD4VR/laXbu4Bbyhr5YXuIVCo
         hHgwL/sIke1mzS6bh36TPesZwVQbL+AE+j4FGrJFsp77rGLW+tJ4Pl5spM576ySaY1KL
         SlmJKzKBv4HgEq0xuo8irFIa6+L1CmamrRDiiO+5IWPCVloZ2jIQX+6MofLNOmsmqwn8
         n2Xk3JAodX+ifDxUKDkLOWMvTiTgnC1qhVqX41ym7YpIp9mfgUDhxBBMCberDd61fyn8
         +L6w==
X-Gm-Message-State: AOAM530bYbp6GFh0D4rnzSRD9J7U3yslwrJUCX9TJ/xQ7k4o+NLl54Kk
        SCXZmhZkHoLt7m/m2aqfkzI8sw==
X-Google-Smtp-Source: ABdhPJz1PA4YaqrTseWXsPt1FNfLnyyPo6Ed0pJ3xL1TVct0XWzjrwCExTmMuvQDCVe7IUW94sBcww==
X-Received: by 2002:adf:d4ce:0:b0:20d:9b4:2bc2 with SMTP id w14-20020adfd4ce000000b0020d09b42bc2mr29114605wrk.151.1653521786002;
        Wed, 25 May 2022 16:36:26 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id d23-20020a1c7317000000b0039736892653sm117725wmb.27.2022.05.25.16.36.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 May 2022 16:36:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 5/5] riscv/efi_stub: Support for 64bit boot-hartid
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAOnJCU+r6KgR7bd2dx5QLmmVLjJX8GhETHb6rG65wq0e_m6FVA@mail.gmail.com>
Date:   Thu, 26 May 2022 00:36:24 +0100
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <5829932A-6E45-46CA-AADA-14EDD903C4AD@jrtc27.com>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
 <20220525151106.2176147-6-sunilvl@ventanamicro.com>
 <CAMj1kXFhEBv7MVCKZuXdx9=hZx3qWbkATdLDwXAe_Zn9Xyx=dg@mail.gmail.com>
 <1e90b15b-8c73-0de8-2885-1292923b7575@canonical.com>
 <CAOnJCU+r6KgR7bd2dx5QLmmVLjJX8GhETHb6rG65wq0e_m6FVA@mail.gmail.com>
To:     Atish Patra <atishp@atishpatra.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 26 May 2022, at 00:11, Atish Patra <atishp@atishpatra.org> wrote:
>=20
> On Wed, May 25, 2022 at 9:09 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>=20
>> On 5/25/22 17:48, Ard Biesheuvel wrote:
>>> On Wed, 25 May 2022 at 17:11, Sunil V L <sunilvl@ventanamicro.com> =
wrote:
>>>>=20
>>>> The boot-hartid can be a 64bit value on RV64 platforms. Currently,
>>>> the "boot-hartid" in DT is assumed to be 32bit only. This patch
>>>> detects the size of the "boot-hartid" and uses 32bit or 64bit
>>>> FDT reads appropriately.
>>>>=20
>>>> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
>>>> ---
>>>> drivers/firmware/efi/libstub/riscv-stub.c | 12 +++++++++---
>>>> 1 file changed, 9 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c =
b/drivers/firmware/efi/libstub/riscv-stub.c
>>>> index 9e85e58d1f27..d748533f1329 100644
>>>> --- a/drivers/firmware/efi/libstub/riscv-stub.c
>>>> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
>>>> @@ -29,7 +29,7 @@ static int get_boot_hartid_from_fdt(void)
>>>> {
>>>> const void *fdt;
>>>> int chosen_node, len;
>>>> - const fdt32_t *prop;
>>>> + const void *prop;
>>>>=20
>>>> fdt =3D get_efi_config_table(DEVICE_TREE_GUID);
>>>> if (!fdt)
>>>> @@ -40,10 +40,16 @@ static int get_boot_hartid_from_fdt(void)
>>>> return -EINVAL;
>>>>=20
>>>> prop =3D fdt_getprop((void *)fdt, chosen_node, "boot-hartid", =
&len);
>>>> - if (!prop || len !=3D sizeof(u32))
>>>> + if (!prop)
>>>> + return -EINVAL;
>>>> +
>>>> + if (len =3D=3D sizeof(u32))
>>>> + hartid =3D (unsigned long) fdt32_to_cpu(*(fdt32_t *)prop);
>>>> + else if (len =3D=3D sizeof(u64))
>>>> + hartid =3D (unsigned long) fdt64_to_cpu(*(fdt64_t *)prop);
>>>=20
>>> Does RISC-V care about alignment? A 64-bit quantity is not =
guaranteed
>>> to appear 64-bit aligned in the DT, and the cast violates C =
alignment
>>> rules, so this should probably used get_unaligned_be64() or =
something
>>> like that.
>>=20
>> When running in S-mode the SBI handles unaligned access but this has =
a
>> performance penalty.
>>=20
>> We could use fdt64_to_cpu(__get_unaligned_t(fdt64_t, prop)) here.
>>=20
>=20
> It is better to avoid unaligned access in the kernel. There are some
> plans to disable
> misaligned load/store emulation in the firmware if user space requests
> it via prctl.

Why?

Jess

> We need another SBI extension to do that. The idea is to keep it
> enabled by default in the firmware but
> userspace should have an option to disable it via prctl. If we make
> sure that the kernel doesn't invoke any
> unaligned access, this feature can be implemented easily.
>=20
>> Best regards
>>=20
>> Heinrich
>>=20
>>>=20
>>>=20
>>>> + else
>>>> return -EINVAL;
>>>>=20
>>>> - hartid =3D fdt32_to_cpu(*prop);
>>>> return 0;
>>>> }
>>>>=20
>>>> --
>>>> 2.25.1
>>>>=20
>>=20
>=20
>=20
> --=20
> Regards,
> Atish
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

