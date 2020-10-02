Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F27281A3E
	for <lists+linux-efi@lfdr.de>; Fri,  2 Oct 2020 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388237AbgJBRzu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Oct 2020 13:55:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:56939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgJBRzu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 2 Oct 2020 13:55:50 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 13:55:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601661347;
        bh=eL7JBhoz2JAsNQSLXLYFbl1LIBlnoiLRV7VFXGdcSh8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V41u6yxajc7EQVyp3OOC23a8iT6HOGkTlqv0uIIc/0KpTuwpcdO+H/QaGsmXSZVHW
         DjeZCJ3RLjSLNVIq+Mnk2tp9tYoDKyzarOT8ybdG1Qb4jGYtJ6/kmhi7ubuOocDhzJ
         YIQPGpuMkp/UFlb6dnqCp5MB6Ta3yM3L554Qztbc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([178.202.41.107]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1kdskl2AJc-00xcR4; Fri, 02
 Oct 2020 19:50:35 +0200
Subject: Re: [PATCH 1/1] docs: admin-guide: fdt and initrd load in EFI stub
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Fran=c3=a7ois_Ozog?= <francois.ozog@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20201002171112.22738-1-xypron.glpk@gmx.de>
 <CAMj1kXHsGcAX-DqfcpgxzZY3M+JzY-Ef9OdJ+JdysNnx1fK6zg@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <e272840e-d097-0476-1827-ea948cdfad63@gmx.de>
Date:   Fri, 2 Oct 2020 19:50:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHsGcAX-DqfcpgxzZY3M+JzY-Ef9OdJ+JdysNnx1fK6zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rMYBeFJ6gKllVZl69fPnc4RDZH7lOvdbzwihXS6AWamAWUvSMEh
 A5o0rltp/6TNN0K3RdOA/C8iMzJImCxlMmyABNlcuL5gGfMhYQTaOtW6VyLrbaJj1L0k8lg
 8qcEToKi8fBROiRk6+3N3CgzwEjrx/LCORVVDel/ZEaKlmmKX9vaIu9wy15Intbpvco7NzJ
 Cti/79uBsIzn8OrqvucvA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:APT0gqF5AtA=:94YK69IYJi901UJOjz1721
 Dn6BDFNUr8okpeojJOBL4ymdoDNLOkfFJiEFCC2MPWHrMta28iTMOnBxpC8q8rKsj1TAAJ6F+
 8ZVi6yIZYAMgBDfDFst8rqRjL0OpuSu4BG3XQ9+rC21mQ5nbRwsJvk7oSuF6G+V1tgwaiKIgj
 6pps7qp88T/IbOSyNhs+W7YDV/M2UCdEl8l5ND5eut/WnXBWMXM9cSn9K9ZlGm3ZNqQ9W2zSf
 N7Vx10nmk7GygEn3XUpfDrulJ/XQuodNTZvxlBiL4sIo/J854GeUwqeBWHxEUBKSWIW76x8ZW
 H5z6djIDVJ0/dKvQmX4MKXNA/EqB/KEDPgW+wiXHnEZQMy2ht+ECR3DXjNjpfLrI4M/m8WXN0
 ywyKm+GoaqQjJm7FhRLUNo0/Rgy6jK82kgc+vO3QYmlbGKPb5Lb6XY1uiDWjDVvzGRRlsMslF
 Erj45UQT5C/i3Kb6t+RHrJKGzuA1bNUBy+umnJ6N7S71/502gxrG1V6RqW0ikFmwPDG71r/JM
 XcGMgpHD3dijxEc+yDXLyP44GKe4EoeBmKpAhnlKQ+gt/MHTuCUUu4TqBhXurMQpHnrr+jpB4
 Ntf6BQXKRJaLU3cGlFaOP+FHKxsSKkjHbYdnnQNsjggjlZsbTPr6jlm3BXTYNTiWkui6EBmR5
 o/79x2TLZETLvSbhQBWl+LV26Yz4MOkA+fuEM1/AD3Ma0HmAGxd8/roonmCtRfWZq/MBh4D4D
 zMsLCwhFLILOfGcIRDC0yaSHxAhuI42wTqMWbRFKaUCJgYfzyNrQGtqW504J+io0/k03SfvpT
 EgU5thtp6lVJJk/hYHx2XYaWy5O5ux/dMJ0OuA9xMqu4gwFZwZcOxbU4syZzzP9KPubRWiEV4
 jnQqTsCjDOv5jzngNEE2VXWGW4EawR2M+3DmzDptxr3D3SaqzIUE4RQE2ZsM8XhUrmxiv3/Xn
 HuWW3LjXaDyDYAihYhBLf5Od4TGxzMEIB0HXkE36LCndunTDUi4k1a7OCRIXOS+W//L4jEKVz
 i4qEA6a96YY/UftjlBMkE5jQOUToV/8xsWnH2CWbGjIs7rDEpP0r244yb1b5+r97f8jrDj3H6
 Asqc29nrpZOLRwC/KifWUxOy2CSkmtYpriBeyGBjgXjVXrwiNo5kElcZ1WLXmILLcUNz1Zzpa
 Ttd0rAawRWqteEqAACK5aD/DX5i8fxw8h8jZwKYp8MxETgDJBE3gfsv29Y90/JoLKgs8xO1h5
 kp9qkxzTA6cmXbwzT8PGxfB+8teDW7TYdMezAag==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 02.10.20 19:21, Ard Biesheuvel wrote:
> Hi Heinrich,
>
> Thanks for documenting this.
>
>
> On Fri, 2 Oct 2020 at 19:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> Describe how a device tree and an initial RAM disk can be passed to the=
 EFI
>> Boot Stub.
>>
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>  Documentation/admin-guide/efi-stub.rst | 35 ++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/adm=
in-guide/efi-stub.rst
>> index 833edb0d0bc4..86f50a33884c 100644
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
>> +  line parameter.
>> +* The prior boot stage may pass the location of the initial RAM disk v=
ia the
>> +  "linux,initrd-start" and "linux,initrd-end" properties of the "/chos=
en" node
>> +  of the device-tree.
>> +
>
> On x86, the boot_params struct is used to pass the address and size of
> the initrd in memory. Maybe include that for completeness?

Sure we should add it. But I will just wait for more review comments.

>
>> +The first two items are inhibited by the "noinitrd" command line param=
eter.
>> +
>
> Interesting. Are you saying noinitrd is ignored by the kernel itself?
>
> Looking at the code, it might only work for preventing the load of old
> style initrd ramdisks, whereas initramfs images are handled
> separately.
>
> This is something that we should probably fix one way or the other.
>

initrd_load() seems to depend on the value and will not create /dev/ram
if "noinitrd" is set.
init/do_mounts_initrd.o is compiled for ARMv8.

But my ARMv8 Odroid C2 boots fine via U-Boot->GRUB->EFI stub->Linux with:

[  +0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-5.9.0-rc6-arm64+
root=3DUUID=3D.. ro earlycon=3Dmeson,0xc81004c0,115200n8 noinitrd

So I assume initrd_load() is either not called or at least not needed
for the FDT case.

Best regards

Heinrich

>
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

