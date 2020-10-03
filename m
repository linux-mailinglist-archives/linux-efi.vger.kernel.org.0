Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BA8282277
	for <lists+linux-efi@lfdr.de>; Sat,  3 Oct 2020 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgJCI3h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 3 Oct 2020 04:29:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:48985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgJCI3g (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 3 Oct 2020 04:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601713760;
        bh=lvJ74/HMZn1UeZuLZsdlbA4t7dcnm4RjOEdqUPWQPuw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=atlaDx8aB3Quu5lV6QnFyDXkQ+G0p8tc8dM1FQGJcGb6dWg/yJK4visN/7cK+gHQg
         d3sYOr78PZHG8qv2v+AolNUoxV4N6f66cLynX9FDZbuCdzSGlwjo8MZeDpjR65AtdM
         6LblEgsCQ+U3uL8W6h8uLKEzMcoyhtlaGld8h5h8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([178.202.41.107]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1k5BI911YH-00K97J; Sat, 03
 Oct 2020 10:29:20 +0200
Subject: Re: [PATCH v2 1/2] docs: admin-guide: fdt and initrd load in EFI stub
To:     Atish Patra <atishp@atishpatra.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <20201003063725.8698-1-xypron.glpk@gmx.de>
 <20201003063725.8698-2-xypron.glpk@gmx.de>
 <CAOnJCU+kit2dHihTad9UPYUmN0+EAdVN9m97ibs=Jnu44Qe_LQ@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <0c654506-9bb9-9aee-876e-8c1b8619eb67@gmx.de>
Date:   Sat, 3 Oct 2020 10:28:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAOnJCU+kit2dHihTad9UPYUmN0+EAdVN9m97ibs=Jnu44Qe_LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cafLk/FbnxoXjl7NcLX3IIkuN5mQUOns+Y/HSpKP5T1y4yhaOfp
 mzxQMjXOXnxBLRShSke7dK1DcBfGQNABTYOTxzTZnoqg2ojV36RRGVeZvOE6DNWIlKeYrBA
 GDmjl2GuKXzzOIQMCRGtl/fv77q6RzKDwFShSTeLOgrjY6AYPC6MV7XS5p3IsVwCumW0q3J
 65O/6pCM7DNhGr8Uv6uBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wsuXkB2/sA4=:LwuBHHE3dlDXPKjCWWaFhv
 qUI2ZfO4LKmDcIKaikG5NTYaY2hRgfXU4kP/k8n58baRO5E76Sbd8YRCeKoSs8z+nUcxxX/Yw
 rh91ez+hTy0z5hZMHtaeqvvpNJ6j9aVjmNyFkCbHMtDl0XGeL3rk0rgXbw4D0NK2geJGVfSPc
 654bfCcRjIR644RpoISlkqn+AAugRX3dtDVy+6A8CgjpmZPxTMYQ+iFzbVpvE4n2Vj5+wE+ax
 dYErhhQ+0CgihQX6D6NDJnYBHsbi3gnJbMTZFpK1/LmhlaHWZgFh2+anDQA5ZmP3xaSsiKKdh
 IeliFitgfb2QoqUlSLT9AyMxTDf3CNTJOZXpA54Z5zcqqK+m0kVvV4jo5L05eFYxztJtZ0HOl
 OEswR2c4e/V28cO98Wtd2txDvS8c6C1vRXAnbm77gvDBINZrgAJUrWu3DP2ONU1Rp4CKmIKUw
 wgjXVAdwuF+pTxX8BkF4lx4d1kfMCqnvSwtn8j6GXiia573+mY5b5XQa0hvyJjWEs1KUJn39Q
 qBvG/CotB0GmNsLcC4UEN4DzLdmh4LSQvQxaHTEv3kFT/3Q/aaL5o4/MQKFWWr+UX6/7Qw1Go
 /6+LEtUBmYN2ieQk8IX6almq3Nwb15BEcJB4eVuEjSJ1o5dzG8F0Q/sI5cZ6MMahOiPjiNSeN
 C2X1XBak3ULx7/rPxKT03apABdPtsY/CVZ+yPfoU4qqDtU85oppmzzMv4m9SvtC4+jc0lAKWM
 wk8/0ZsMc3YUIFPZ9fNnkCduzD3lM0asn73h29KpPZgHCvyu5JGB+8ZmA6YiS/Z5yPbv18RzE
 1fpRM4+aL47Ph46u65ca6G88aB1pcJQ+JjaRCchnvK1kAKbDYVnwLbZd/i78HPbRWhMhxtDHD
 dayio6jOlvVSx2t3ZSRiN6Pldc6l6b0+92ZGuUVsbLimicJT7f9+gYdBSf/DrpokdRxnXHyK6
 IJrXe703i2QFUXcznxlPb20nKbmnNgYaXuP3Qr72J+xEkVhE2+SIO+zejjsQpdVGdgt+7w7R+
 YGR3XF1eQnqZUtEcMSyxfxTBRmn2ICN1RUQEjJwXq5sDAUEzag+5bcxKszOestzqT/x/AfmwV
 QF45vlyoRyHtH83kyffTCmYBXypvqT17Zp6Fz5snI5cucdgvoHUin8BQr7v7hGA6Fijywq1iG
 Lb2GFg1SD7qDPe5J7x1hRQv1uxMvO8UwSYHII7GeNPgkRcwKpjNFXKfBUsHrAysiPExveJnya
 6L62NRznZMJVyS7hAs4yIRfurUWJ3sWg1LJni2Q24EovLGz2LLW3dfd8LTZTfdZCwvYgOoZgQ
 58SpWFvXaBGkGWjNmejYLO9ckuTQN2OP3hCaaJM3D4xggD0PALuZ067V2GNg9CSXyow2FrDFL
 7+pxAMgD8OdGpZ2Fu/a1g==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 03.10.20 09:34, Atish Patra wrote:
> On Fri, Oct 2, 2020 at 11:38 PM Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
>>
>> Describe how a device tree and an initial RAM disk can be passed to the=
 EFI
>> Boot Stub.
>>
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>> v2:
>>         mention EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER (thx Atish)
>> ---
>>  Documentation/admin-guide/efi-stub.rst | 35 ++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/adm=
in-guide/efi-stub.rst
>> index 833edb0d0bc4..4965dec48af4 100644
>> --- a/Documentation/admin-guide/efi-stub.rst
>> +++ b/Documentation/admin-guide/efi-stub.rst
>> @@ -38,6 +38,34 @@ arch/arm/boot/zImage should be copied to the system =
partition, and it
>>  may not need to be renamed. Similarly for arm64, arch/arm64/boot/Image
>>  should be copied but not necessarily renamed.
>>
>> +Passing an initial RAM disk to the EFI Boot Stub
>> +------------------------------------------------
>> +
>> +The following means sorted by decreasing priority can be used to provi=
de an
>> +initial RAM disk to the EFI Boot Stub:
>> +
>> +* The firmware may provide a UEFI Load File 2 Protocol. The stub will =
try to
>> +  load the RAM disk by calling the LoadFile() service of the protocol =
using
>> +  a vendor device path with the vendor GUID
>> +  5568e427-0x68fc-4f3d-ac74-ca555231cc68.
>> +* Next the EFI stub will try to load the file indicated by the "initrd=
=3D" command
>> +  line parameter if CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER is e=
nabled.
>> +* The prior boot stage may pass the location of the initial RAM disk v=
ia the
>> +  "linux,initrd-start" and "linux,initrd-end" properties of the "/chos=
en" node
>> +  of the device-tree.
>> +
>
> Should we also specify which method is enabled by default for which
> ARCH and recommended methods?

The user relevant configuration is not the Linux' defconfig but what the
distribution maintainer has baked. I doubt mentioning Linux' defaults is
meaningful here.

>
> For example, It's recommended to use the LoadFile method for RISC-V
> and new ARM systems.

GRUB does not implement the LoadFile2 protocol yet. In U-Boot it is only
good for testing. I am not aware of usability with unmodified EDK II.
Why should we recommend anything before building the ecosystem that
makes it useful?

What is best may depend on the use case. There is nothing insecure in
passing the initrd via "linux,initrd-start" and "linux,initrd-end" if
you control the load options.

The EBBR (https://github.com/arm-software/ebbr) might be a better place
for a recommendation.

> Existing ARM ones will continue to use the initrd argument as that's
> the method enabled by default.

Only if if the LoadFile2 protocol is not available because that has a
higher priority for ARM, x86, and RISC-V.

Should I consider my i.mx6 Wandboard Quad bought in 2013 "old" while it
is running the U-Boot v2020.10-rc5, Linux v5.9-rc7, and Debian testing?
A distinction between "old" and "new" systems seems irrelevant here. All
are treated equal by the EFI stub.

>
>> +The first two items are inhibited by the "noinitrd" command line param=
eter.
>> +
>> +Passing a device-tree to the EFI Boot Stub
>> +------------------------------------------
>> +
>> +A device-tree can be passed to the EFI Boot Stub in decreasing priorit=
y using
>> +
>> +* command line option dtb=3D
>> +* a UEFI configuration table with GUID b1b621d5-f19c-41a5-830b-d9152c6=
9aae0.
>> +
>
> I am just curious. Is there any specific reason why efistub tries to
> load the dtb from the command line first
> and loads from the config table only if it fails from the first approach=
 ?

As we disable dtb=3D in secure boot it would make sense to turn the
priorities around for non-secure boot too.

But this is beyond the scope of a documentation patch.

Best regards

Heinrich

>
>> +The command line option is only available if CONFIG_EFI_ARMSTUB_DTB_LO=
ADER=3Dy
>> +and secure boot is disabled.
>>
>>  Passing kernel parameters from the EFI shell
>>  --------------------------------------------
>> @@ -46,6 +74,10 @@ Arguments to the kernel can be passed after bzImage.=
efi, e.g.::
>>
>>         fs0:> bzImage.efi console=3DttyS0 root=3D/dev/sda4
>>
>> +The "noinitrd" option
>> +---------------------
>> +
>> +The "noinitrd" option stops the EFI stub from loading an initial RAM d=
isk.
>>
>>  The "initrd=3D" option
>>  --------------------
>> @@ -98,3 +130,6 @@ CONFIGURATION TABLE.
>>
>>  "dtb=3D" is processed in the same manner as the "initrd=3D" option tha=
t is
>>  described above.
>> +
>> +This option is only available if CONFIG_EFI_ARMSTUB_DTB_LOADER=3Dy and=
 secure
>> +boot is disabled.
>> --
>> 2.28.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>

