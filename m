Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE02D25F541
	for <lists+linux-efi@lfdr.de>; Mon,  7 Sep 2020 10:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgIGIbM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Sep 2020 04:31:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:57911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgIGIbK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Sep 2020 04:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599467460;
        bh=7Lzeaf7Rf0Qcq1mD+nNPdol8l4uzCp3SqWANycTe7M8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bahaS/BOW1G+7FZK54OJyRjBMAlJ4AiVNwdCq1CK7oFF8xjrNBliNolkHoaWfgVTK
         1pyvP/5iskO6aq6fP7JPlqXNLgWR6+FI2YW1mhoSV2kbx3OTdAVDpj/FsWTyDP6+5i
         z6R2X6G1xWeM7DciEGGAIXrNHgNGqiLozKrkgYQo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([178.202.41.107]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUrx-1kU7sT2DVp-00xpI1; Mon, 07
 Sep 2020 10:31:00 +0200
Subject: Re: [PATCH 1/1] efi/libstub: DRAM base calculation
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20200904155025.55718-1-xypron.glpk@gmx.de>
 <CAD8XO3ZLqkuajo3GVRdvXiFXMH9P-vp-PX5s6idgA51ouVDpKQ@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <fec7e55e-154c-5348-5181-6d9efdc0245a@gmx.de>
Date:   Mon, 7 Sep 2020 10:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAD8XO3ZLqkuajo3GVRdvXiFXMH9P-vp-PX5s6idgA51ouVDpKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O+t9bTlChZFLirYVif3dS0lMS2SVqgYT2B3k5XZpVtnMlQZhpRh
 A3HGRSpIP+Ms+qeKK725SN/c1/hc+GuH1079IMK20NklP3+JWfEmnD7+KqFtvolqdBHNMHv
 wPqQ3gal8xV/isOpPL2S1PkHC+PjcROKN20/0HHj8ZIwcemksjvgAhYKQfCF++avbfgaB4H
 e0AfyspqzSoRiekBRBJJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rBjhkfylKhw=:x4H/UzsfzFMKIx/jNYgPrG
 DKlqy8cCinXH1xjX4Q4AYu3jMA9wSqy3Tu99pZqyA6RNmyLsN+cXDHv3Ldyx8Tp+DtYfxzVy/
 7rJlIllfiSVhIYmZTdIpPHVzqDQX4ZC30kZBmSlM8xsSxx3AV7wMZ7o2om+p2Qm8vFbC7eXkj
 uiwAMdBb7AJwxCZ7ilTkeaLSDYR7huzQ85pViye7RU0A9gSMfJJFJOiQWoiXAM78gAMwKS82V
 nA11hWQJz57AY85e/8w4ncT66aMy2TkBKDBUr4NIdemPyQcBawIbLms/Lt8FeeMB48OhpNHVn
 gMhwlrojJf34Mk7b19Dc+gx0VxgmK8T+gsLt+Qdeur9G1KtsQ9Yx7S4j2v9/P4MwgUsWRh7r3
 5EXQZ1oVYRLADPot9d0+auz58zXLErpizKzVCQwhF35fpH3Y1aNQnTYkMI9SPn2OU9+s8I9NP
 gKrnScp2YonrWam4KipEh5+8ptnnCN9tVPfkS8NvMVAV6x5dVQFBhE8c7+Ux1G0NXw65fv6wA
 r5LRudyy8u3kyZc3xtJGqHFrJMtNy+1fb34oQuNbrHLTb4sNOoU7u6N8nr8BHTeq5w+kejc+k
 3iylM/0s/nwgE2SSNXjgT8/k1GPTvS0O7a5g07dE/3ML8SYU/zyj73zjmQSweAkpZskHvvuv2
 gOVrF7osVMpQ8g50Qq3i/suh6mS1L5Koi3wHMIMZJdDYpUJFd49lZY5HREiZM/MYtYjpZH/Vt
 NkQWO/H6LIfpRxJ0vdSxmInzQFaQQ5VG3ZUwDLjVLXzM5re0W4LinoRkgTcTx7nQ5OnRuRylM
 g1bgulelpIw/XwWLg+PRBCCxPWUutNPykF1yphdlHxrCwNP6+egV/vAyu19TKjY6Xqck2JRzA
 z+uU0wXJb38Ok8J7vW/4SkplzeTsKlAGmHa1lV8DCDoSDs1S3+naOWwm83KXVBforiSNZw5Ts
 gtzGcwHNnTv6zByZFOnesUVzMrVfByv1RaWNyol90ewhwasKcmzH5FxzLpPBjGXpffadEwV70
 Jy2u79E3kYAdltTL+wPXp3oonw7p+oAyc4ec9LUkBkcMyf2EG2Gpziu8fZlnm0/uKxZzlvn+r
 wWgGyKpXWlQBplCUsoe06PqLbfyfvM4IqykXna8xNibpFK6RsFC+aL2qIgeJevQBGgTtxghGB
 3QP8AbaAznr0ndCBd3s7Ea4bp7xIGsJF2eaWrSNExX+1L51MTnWNcitFhi0myT3DopWQF6pB+
 iHxJGglnPLIWjNcYgAbvAfP5lOOZC2iK1Pwb6gg==
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 07.09.20 09:00, Maxim Uvarov wrote:
> On Fri, 4 Sep 2020 at 18:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> In the memory map the regions with the lowest addresses may be of type
>> EFI_RESERVED_TYPE. The reserved areas may be discontinuous relative to =
the
>> rest of the memory. So for calculating the maximum loading address for =
the
>> device tree and the initial ramdisk image these reserved areas should n=
ot
>> be taken into account.
>>
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>  drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware=
/efi/libstub/efi-stub.c
>> index c2484bf75c5d..13058ac75765 100644
>> --- a/drivers/firmware/efi/libstub/efi-stub.c
>> +++ b/drivers/firmware/efi/libstub/efi-stub.c
>> @@ -106,7 +106,8 @@ static unsigned long get_dram_base(void)
>>         map.map_end =3D map.map + map_size;
>>
>>         for_each_efi_memory_desc_in_map(&map, md) {
>> -               if (md->attribute & EFI_MEMORY_WB) {
>> +               if (md->attribute & EFI_MEMORY_WB &&
>> +                   md->type !=3D EFI_RESERVED_TYPE) {
>
> shouldn't the type here be CONVENTIONAL?

In 32bit ARM reserve_kernel_base() the following are considered:

* EFI_LOADER_CODE
* EFI_LOADER_DATA
* EFI_BOOT_SERVICES_CODE
* EFI_BOOT_SERVICES_DATA
* EFI_CONVENTIONAL_MEMORY

What I have not yet fully understood is why Linux on ARM 32bit tries to
put the kernel into the first 128 MiB. Cf. handle_kernel_image() in
drivers/firmware/efi/libstub/arm32-stub.c.

According to the comments this is due to some implementation detail in
the Linux zImage decompressor and not required by UEFI or the hardware:

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Verify that the DRAM base=
 address is compatible with the ARM
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boot protocol, which dete=
rmines the base of DRAM by masking
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off the low 27 bits of th=
e address at which the zImage is
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loaded. These assumptions=
 are made by the decompressor,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 before any memory map is =
available.

Best regards

Heinrich

>
>>                         if (membase > md->phys_addr)
>>                                 membase =3D md->phys_addr;
>>                 }
>> --
>> 2.28.0
>>

