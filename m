Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375BC534749
	for <lists+linux-efi@lfdr.de>; Thu, 26 May 2022 02:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347370AbiEZAGd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 May 2022 20:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344879AbiEZAGb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 May 2022 20:06:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63891289A6
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 17:06:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso189592wmn.4
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 17:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8Tx5B89wRH0aFtZRAXM3z4Ug2Ls2VMbHaKwqc1lcgtE=;
        b=jX2jVB2PuEO61dP74cOE7eq4vJdkuomI88a4aklp62TGE3bMzTdOq3ZvgrjcGanJ9x
         pfJzN51Dm3OFhODlZ8nHrvaPYURi1/sVlDr7PgEjKj2+voRVEaV8jtqXNVFido/CndB4
         TDCDphpS1W0yIPmkl6Uplc86qK+GsCyD/fpyitHuDEwcEx9PAIvX2AQtdvOT8gAaAh+R
         wdPolM7KIbK+USwDT2vAlnqDKt+md+4KDSduSjtNMf/9L6TbvEAI+aQ+9hUNU/EIM1aN
         hI/EfaJ25j//Oo9dP/A8bzDAbtwt/VvrCBnv+B4uLX5TIqhAy30LRc1OE304PsNFAKl1
         bkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8Tx5B89wRH0aFtZRAXM3z4Ug2Ls2VMbHaKwqc1lcgtE=;
        b=0rp3xNr8QyUQxTRfIpNYCF18W+okYRu9RkX5waXegrX0NUSFLWfX0Z+5I6wRqMLcxP
         NDXp4bzrC/oSR4T/cEX+W8F58asZFR1DyfJf/mNO00Rin+lHfcXx83GXadl/9tdmLT+1
         VRqVhNbl4SRA3m9cij8/BKtgBUAZMlnzvFaL5ikSfEH0MUH2byqJTjrZFR0JcsGZkCRS
         hwBW0y/US28yAj9WzhFFxlhHgqrlbRmyRQd1ylhuPl2T7scy5hy5KLDCpR9YF0yfeLsm
         3dKSerI2Dzdupp0X+VrNFOROCoTP2nu074MMiwKFZpgl6raxBqhXpxSJhOR1OCIiTakE
         EFUw==
X-Gm-Message-State: AOAM533KIabJqL2AUjE1Sa4uZvPahzxZoKu66L6jMME79go7DHAof7c4
        fMS3oicM7O3lTQIlCsBMT+d5SQ==
X-Google-Smtp-Source: ABdhPJyIzFHlmQXXDNNZPf3lpOzfpRz9q68yW2F7qmH0Tb9sXVpEVISc1p9gio7TPnqDSk3AyvYnPg==
X-Received: by 2002:a1c:2184:0:b0:397:7421:7761 with SMTP id h126-20020a1c2184000000b0039774217761mr2902180wmh.14.1653523587899;
        Wed, 25 May 2022 17:06:27 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c4e4900b003942a244f2esm3087161wmq.7.2022.05.25.17.06.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 May 2022 17:06:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 5/5] riscv/efi_stub: Support for 64bit boot-hartid
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAOnJCUKbT88c+_PzEuchEtzjEtiHcMFvRH_G98z1AmpSdRH+BA@mail.gmail.com>
Date:   Thu, 26 May 2022 01:06:26 +0100
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
Message-Id: <898EDFB9-D4AE-45CD-AEEC-FAB4BE7AEBF4@jrtc27.com>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
 <20220525151106.2176147-6-sunilvl@ventanamicro.com>
 <CAMj1kXFhEBv7MVCKZuXdx9=hZx3qWbkATdLDwXAe_Zn9Xyx=dg@mail.gmail.com>
 <1e90b15b-8c73-0de8-2885-1292923b7575@canonical.com>
 <CAOnJCU+r6KgR7bd2dx5QLmmVLjJX8GhETHb6rG65wq0e_m6FVA@mail.gmail.com>
 <5829932A-6E45-46CA-AADA-14EDD903C4AD@jrtc27.com>
 <CAOnJCUKbT88c+_PzEuchEtzjEtiHcMFvRH_G98z1AmpSdRH+BA@mail.gmail.com>
To:     Atish Patra <atishp@atishpatra.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 26 May 2022, at 00:49, Atish Patra <atishp@atishpatra.org> wrote:
>=20
> On Wed, May 25, 2022 at 4:36 PM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>>=20
>> On 26 May 2022, at 00:11, Atish Patra <atishp@atishpatra.org> wrote:
>>>=20
>>> On Wed, May 25, 2022 at 9:09 AM Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>=20
>>>> On 5/25/22 17:48, Ard Biesheuvel wrote:
>>>>> On Wed, 25 May 2022 at 17:11, Sunil V L <sunilvl@ventanamicro.com> =
wrote:
>>>>>>=20
>>>>>> The boot-hartid can be a 64bit value on RV64 platforms. =
Currently,
>>>>>> the "boot-hartid" in DT is assumed to be 32bit only. This patch
>>>>>> detects the size of the "boot-hartid" and uses 32bit or 64bit
>>>>>> FDT reads appropriately.
>>>>>>=20
>>>>>> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
>>>>>> ---
>>>>>> drivers/firmware/efi/libstub/riscv-stub.c | 12 +++++++++---
>>>>>> 1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>>=20
>>>>>> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c =
b/drivers/firmware/efi/libstub/riscv-stub.c
>>>>>> index 9e85e58d1f27..d748533f1329 100644
>>>>>> --- a/drivers/firmware/efi/libstub/riscv-stub.c
>>>>>> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
>>>>>> @@ -29,7 +29,7 @@ static int get_boot_hartid_from_fdt(void)
>>>>>> {
>>>>>> const void *fdt;
>>>>>> int chosen_node, len;
>>>>>> - const fdt32_t *prop;
>>>>>> + const void *prop;
>>>>>>=20
>>>>>> fdt =3D get_efi_config_table(DEVICE_TREE_GUID);
>>>>>> if (!fdt)
>>>>>> @@ -40,10 +40,16 @@ static int get_boot_hartid_from_fdt(void)
>>>>>> return -EINVAL;
>>>>>>=20
>>>>>> prop =3D fdt_getprop((void *)fdt, chosen_node, "boot-hartid", =
&len);
>>>>>> - if (!prop || len !=3D sizeof(u32))
>>>>>> + if (!prop)
>>>>>> + return -EINVAL;
>>>>>> +
>>>>>> + if (len =3D=3D sizeof(u32))
>>>>>> + hartid =3D (unsigned long) fdt32_to_cpu(*(fdt32_t *)prop);
>>>>>> + else if (len =3D=3D sizeof(u64))
>>>>>> + hartid =3D (unsigned long) fdt64_to_cpu(*(fdt64_t *)prop);
>>>>>=20
>>>>> Does RISC-V care about alignment? A 64-bit quantity is not =
guaranteed
>>>>> to appear 64-bit aligned in the DT, and the cast violates C =
alignment
>>>>> rules, so this should probably used get_unaligned_be64() or =
something
>>>>> like that.
>>>>=20
>>>> When running in S-mode the SBI handles unaligned access but this =
has a
>>>> performance penalty.
>>>>=20
>>>> We could use fdt64_to_cpu(__get_unaligned_t(fdt64_t, prop)) here.
>>>>=20
>>>=20
>>> It is better to avoid unaligned access in the kernel. There are some
>>> plans to disable
>>> misaligned load/store emulation in the firmware if user space =
requests
>>> it via prctl.
>>=20
>> Why?
>>=20
> To support prctl call with PR_SET_UNALIGN

Is that needed? It=E2=80=99s almost entirely unused as far as I can =
tell, with
all but one use turning unaligned fixups *on*, and the other use being
IA-64-specific. What is the actual use case other than seeing a thing
that exists on some architectures and wanting to have it do something
on RISC-V?

Jess

