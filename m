Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B033FCBF5
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 18:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbhHaRAq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 13:00:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:43031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239443AbhHaRAq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Aug 2021 13:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630429186;
        bh=DIIldGPF3Wsc0XP7OE/tqp36owk8Av7jTsNyJrldVEE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DSAcRpDZ5twE9orPsAnP0KDyW+8fB0qwnjNq6frohPQhxBWCozumbpM/AyKaz63S6
         MctXZFp5ERhFLDco2T2TmfwF4+UD5aM7kNXj6TLTxqrsqk5X6OpzXMAjqqxkA629tz
         77/4uGThYPx0rG0YA+Y9/q1I1qVr23a6Tufvv4Hk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.55] ([88.152.144.157]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRQq-1mQWWU10Yu-00Tp4Q; Tue, 31
 Aug 2021 18:59:46 +0200
Subject: Re: Fwd: Re: [PATCH] efi_loader: Omit memory with "no-map" when
 returning memory map.
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-efi@vger.kernel.org,
        Kristian Amlie <kristian.amlie@northern.tech>
References: <CAMj1kXFAniHs=a8d1t-3KxH8uGYmeCDKm8DOAb_HiRQNeehw6g@mail.gmail.com>
 <FD131CA7-415E-48D5-8BBD-F236AC6D4055@gmx.de>
 <5fafbb62-b93d-1f08-0e52-54b892f2ad30@northern.tech>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <341cc376-540b-0c96-a2db-728cc276d983@gmx.de>
Date:   Tue, 31 Aug 2021 18:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5fafbb62-b93d-1f08-0e52-54b892f2ad30@northern.tech>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hk1yZCcABne5jIrQOa0+frnRI6KNs7Ka28uTNTAmvZvH/GkqJbT
 As63CtbhljBUUr5/NF9yPXxeOiI8di7zTV1kfHlPh8Sxc+km5PrMpcptddPbRx59HJUjmk4
 SkBCRXffhgiw0lTrrr8l+7/r5wrzkx5X7Q06x3eN8y3AkPKU8kDjqP90fTwWM3wQRPp7mDz
 ErDsbW9uIogVt+NhDOjAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6GOAsg4cuXY=:BWqNRv4wdgMrHNpPkncRmZ
 sDfl3JEQVsUjI8L6nwaTcw7JMoo9PSvyO66EDG1i6Vy3zssR/M4XeYBALItCIjpwIRCIkazys
 7BUGqWNEjhxw+sEtCDa9wOSG9ZWEz2W1xhsrYnjhV/IHeClPvNHzPARrk5uwkntV2g2Y4FvSt
 S+GBPXVfjGg9i6LX35BouPMwq+seyFf/Jde1HvBq5FGcMubfqx0J5IHTUBTwWAPx+Ynx33E7m
 +VEMk4SRFqIl9dfTGmuUWzX85WA3KOM/ie/bDVQWYj+88eIpWJ6LnrDpnqa0ySk4JVx8kUUgO
 xZssAWoJPnapBkvMiLWMmtp9AxuBAabdWgfG16Yv5EBSvHADta4iHPJMFnulL8Yyq9Z0KEkob
 yMwD8sZGisuc0lhcao6JosSIEkzPyj/SpRNam/tdmAwAgWfDV1MCeqPVF4d7LADY/cckIuBTA
 j1x1zbDUECK+5GhJZKAXuOtWpwcKYugrzjYwt3nTCJ4vTLbSPuDCh1yEDnUzVfhRujSfqylF+
 wpX6revoIIaYeWZwMf2pZMAQgZeho/0BV7aJGp1Bfb6BRLLNWON5hhBePt6kAWqDgO3/E1jgH
 AQ938LH3OM9u1JgToY1wGEoHtW0tRw9JOoSP1IeMzzJmzNqv4mus1gvBMFQzFQ5EU4twUalyD
 w4Y9qDlCT9oN+iH7b+nHk6R7ysfnDHYmM16Lvlgj1VjKqnNm6h2RacqUyF7FY5XEm87zKBcnk
 dpL2ceSbtN0inNoD5n5S0QfH2OqdmgeGyeCiOdH4EXGrXCImZfzBb/UUCUIe5ncI5fYNO1Fti
 vsMBlHOz9Yp8meN97+Uv+PfnSDdUQOkGUjCusuaMSwIlX/8gRQDEUE8sLGy8Oxn1DFHZsTYuJ
 2WJYZIuPY7wATW++HLxfgcmCD8MO0a6R1XCRIKO861MTF6As4m9G+0LPUymnkUasTbmKl4dJy
 YgsSplxQT8bd6oCUL3uBkN7v+mrbB+jzRqzDiyroXWGp96WxEMNiXP8Ey2Cg+jyEIn9qL8qt6
 UDF+JKgewUSDdqbW3GrblTnfXk9v6IbQ1/nze6pSesOTwyNFZyaZI7YjG50g5Z7j5/K7/Bt2V
 iU84uoqIg8x/x/rUOYEGfd/D4E4Go/KPdPwIjARc+XFkeYyKToVKT4u5A==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/31/21 1:12 PM, Kristian Amlie wrote:
> On 31/08/2021 12:46, Heinrich Schuchardt wrote:
>>
>>
>> -----------------------------------------------------------------------=
-
>> *Von:* Ard Biesheuvel <ardb@kernel.org>
>> *Gesendet:* 31. August 2021 12:33:56 MESZ
>> *An:* Heinrich Schuchardt <xypron.glpk@gmx.de>
>> *CC:* Kristian Amlie <kristian.amlie@northern.tech>
>> *Betreff:* Re: [PATCH] efi_loader: Omit memory with "no-map" when
>> returning memory map.
>>
>> On Tue, 31 Aug 2021 at 08:41, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
>>
>>
>>      On 8/27/21 9:55 AM, Kristian Amlie wrote:
>>
>>      You can use scripts/get_maintainer.pl to find the right addressees=
 for
>>      your patches.
>>
>>          efi_reserve_memory() states that memory marked with "no-map"
>>          shall not
>>          be accessed by the UEFI payload. Make sure efi_get_memory_map(=
)
>>          honors
>>          this.
>>
>>
>> Accessing memory and describing memory are two different things.
>> Describing reserved memory in the memory map is important, because it
>> helps us distinguish it from MMIO regions.
>
> Ok, my mistake, I thought the kernel would deduce this separately
> through the DTB.
>
>>
>>          This helps the case when booting vexpress_ca9x4 under QEMU. Be=
cause
>>          the kernel wants to use an address in the lowest 128MiB of the
>>          range,
>>          but this range is reserved with "no-map", the kernel complains
>>          that it
>>          can not allocate the low memory it needs. In reality the actua=
l
>>          usable
>>          memory starts much higher, which is reflected correctly in the
>>          memory
>>          map after this fix.
>>
>>
>>
>> This is a u-boot patch right? (I cannot tell from the context, as
>> there are no mailing lists on cc)
>>
>> It is u-boot's job to describe all the memory, no matter how it is
>> used. Even if the kernel itself may not use it as system memory, there
>> are cases where kernel infrastructure is used to map these regions:
>> for instance, the ACPI core may need to map a SystemMemory OpRegion,
>> and we need the EFI memory map to tell us whether to use memory or I/O
>> semantics.
>>
>> As for the 128 MB issue: can you reproduce this with a recent kernel?
>> We made some changes recently to the EFI stub as well as the
>> decompressor code to prevent the decompressor code from relocating
>> itself to the base of DRAM, and to allow the decompressed kernel to
>> reside at any 2 MB aligned offset in memory.

This would allow putting the kernel at the very top of memory. But
consider this function that misbehaves:

arch/arm/include/asm/efi.h:

76 /* on ARM, the initrd should be loaded in a lowmem region */
77 static inline unsigned long efi_get_max_initrd_addr(unsigned long
image_addr)
78 {
79         return round_down(image_addr, SZ_4M) + SZ_512M;
80 }

0x1F000000 =3D efi_get_max_initrd_addr(0xff000000);

And below 0x1f000000 there may be no RAM at all.

Best regards

Heinrich

>
> I'll try this and get back to you!
>
> --
> Kristian
>
>>
>>
>>      The 'no-map' requirement needs to be fulfilled by the kernel.
>>
>>      The GetMemoryMap() boot time service must comply to the UEFI
>>      specification.
>>
>>      The Devicetree Specification has this clarification:
>>
>>      "Reserved regions with the no-map property must be listed in the m=
emory
>>      map with type EfiReservedMemoryType. All other reserved regions mu=
st be
>>      listed with type EfiBootServicesData."
>>      https://devicetree-specification.readthedocs.io/en/latest/chapter3=
-devicenodes.html
>>      <https://devicetree-specification.readthedocs.io/en/latest/chapter=
3-devicenodes.html>
>>
>>      Should the kernel calculate its internal 128 MiB requirement incor=
rectly
>>      this needs be fixed in the kernel EFI stub. Does the problem exist=
 with
>>      kernel 5.14?
>>
>>      I wonder if the 128 MiB requirement of the kernel can be lifted fo=
r
>>      32bit ARM as we already did for RISC-V. Cf.
>>
>>
>> As mentioned above, this should already be fixed, in v5.11 or later
>>
>>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/?h=3Dv5.14&id=3Dc79e89ecaa246c880292ba68cbe08c9c30db77e3
>>      <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?h=3Dv5.14&id=3Dc79e89ecaa246c880292ba68cbe08c9c30db77e3>
>>
>>      Cc Ard, maintainer of the kernel EFI stub.
>>
>>      Best regards
>>
>>      Heinrich
>>
>>
>>          Signed-off-by: Kristian Amlie <kristian.amlie@northern.tech>
>>          --------------------------------------------------------------=
----------
>>          lib/efi_loader/efi_memory.c | 14 +++++++++++++-
>>          1 file changed, 13 insertions(+), 1 deletion(-)
>>
>>          diff --git a/lib/efi_loader/efi_memory.c
>>          b/lib/efi_loader/efi_memory.c
>>          index f4acbee4f9..7f8543143a 100644
>>          --- a/lib/efi_loader/efi_memory.c
>>          +++ b/lib/efi_loader/efi_memory.c
>>          @@ -646,8 +646,16 @@ efi_status_t efi_get_memory_map(efi_uintn=
_t
>>          *memory_map_size,
>>
>>          provided_map_size =3D *memory_map_size;
>>
>>          - list_for_each(lhandle, &efi_mem)
>>          + list_for_each(lhandle, &efi_mem) {
>>          + struct efi_mem_list *lmem;
>>          +
>>          + lmem =3D list_entry(lhandle, struct efi_mem_list, link);
>>          +
>>          + if (lmem->desc.type =3D=3D EFI_RESERVED_MEMORY_TYPE)
>>          + continue;
>>          +
>>          map_entries++;
>>          + }
>>
>>          map_size =3D map_entries * sizeof(struct efi_mem_desc);
>>
>>          @@ -672,6 +680,10 @@ efi_status_t efi_get_memory_map(efi_uintn=
_t
>>          *memory_map_size,
>>          struct efi_mem_list *lmem;
>>
>>          lmem =3D list_entry(lhandle, struct efi_mem_list, link);
>>          +
>>          + if (lmem->desc.type =3D=3D EFI_RESERVED_MEMORY_TYPE)
>>          + continue;
>>          +
>>          *memory_map =3D lmem->desc;
>>          memory_map--;
>>          }
>>
>>
>
>
