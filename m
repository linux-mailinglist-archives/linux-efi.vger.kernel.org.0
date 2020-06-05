Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933261EFBE6
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgFEOyF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 10:54:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:48507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgFEOyF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Jun 2020 10:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591368832;
        bh=au9l4A+GILO7URfMyWcD4sMoed3gZ0S5z4pof8YKdcc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cxo83xJ9P8AT4GVqMzmTRvwwz2AH7H6Fh2QtnuUB9y3wZK27whdOpgePFFIU5wLZp
         Jh1Mt5M1EopAmTXFLT0CDO344Lnwh6hjGiVu9rAR9+BND4MAZvS/g6Dnxi/DugAJUL
         p68+yCBbT/CtxOwJzsQkwHNASzfyfp63s4M6SwmE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([88.152.145.75]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1jIvXb38Q4-00OCds; Fri, 05
 Jun 2020 16:53:51 +0200
Subject: Re: [PATCH] efi/arm: decompressor: deal with HYP mode boot gracefully
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>
References: <20200605115200.413921-1-ardb@kernel.org>
 <4498d910-f5cb-8559-afba-34710e9ca730@gmx.de>
 <CAMj1kXHS8AVczRPzySgzkkztD0yT1MXnCyMwmOt=ihZ9Bvo0vQ@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <589478fe-14a6-a921-3fdf-ae527e14b945@gmx.de>
Date:   Fri, 5 Jun 2020 16:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHS8AVczRPzySgzkkztD0yT1MXnCyMwmOt=ihZ9Bvo0vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MOm+QmocF/alkn+zj8OkqG8YMkqvUb6dKM23/rogV7EJaxxY0Kp
 6AToKWc3Q4FJXi2TxiibrSu+6yZW7hWP+VZkrsNNie7h6rc394DdIgB0l3Y1aEwyoKGeAEb
 kG3tpotabEDKuCe7N4Kfj8X46lYFH65MkHX5Kr7qEmBGcUnOBYlYvtYSr00v6Pb2/DyqMaK
 54KWSd+H6bF59R5k1lg7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RXfoXId0eR8=:XweCwvb/TIUA+A3GPVARAG
 SY3ILY/B2BS6hM7O9dizvNASjNzATrpcRwEdA/yFk0/SyJA2M5su0KWSbSapfPOUlQXwaTQOS
 Im9STZ2XrkMt/0qVd6+COn9topY3nWkSPKfZs7uO3OI2GBbtv3q9TzVFAKwilgRyOz50OKgYi
 V3Nh8+Gjg0cpC9KPdDi2gw87js+o4TbwJaFGmzxs55GjfZiqgiVC9fQvoCtJlX0VVFlencmGm
 JigJUu2+WiCE3ATtQ7Thowe6ARGJ9w8KW0AjjCCZfqvfzAOKbg3gGk5ERETRIUPkH73FKM6YQ
 TjR1xtfAPTPkxlWiuv9Rr3qV2FMJE5XwjTGw4GO/plGl5SLSsgiIUbUFeLvA0qLOvgNN3I/82
 saVmnijKHhHqk5+Q1MOwvMOaCR/uMidycMGUzujbKEijMfjH2HB8FtZMFNpygnwi55aGM+k5U
 n46niEy3wrMVbp+/OcWHhf8eRuOPZ9G3Y23h19+ca74Dp3B35/FOgswtcYdqPuITCjA9hwy6v
 fXUlMDvzTOLRsWCKICUcYMyfKbyizdIro0h2vqNvwyTmIjUFak/p6ZnezWyyn3uFrSrHXQWgt
 6avWe56RaPG5hoKWK/7iFLhbWqy8wLdtapuHSgZN6AKD4T7EXd5EuEQ9vG0kcDQjCTL27Fzr5
 K7OV/sPfdqnN7A9Qjnk14r0V7ctnIR4hc61gf1FrGg9fbQVGbDdTCAtJBfUUzkpo5uCv9MEYX
 qQujLhhYbimipqdEiSpQ4VazzVh+MpoTtjO/PsajkG9vU3FH78+2/VkxgKtfQ3L1lSl7Am6WR
 0Hm9a0LV7VQ85g2IDxj7T3FMoyiyhamRF+TdGldRJfR1c8aW1DgF0D+8J3UieqZ1N9bu+tebz
 KMtUJjPFPxB9kb0f5lJ7pdMpD7qnYq8rpsiva2gurca1AHsUtcvhevpx7begH517WUqEdOwdI
 4ocMVJh6nHCSMU7ger2CmuEKIIdlE/0e6pcvQe7Jhzm316qbC+WmFXi9yCVYXixGhq4Y/H97r
 iLRYntTaJ9lDX/Jt9R0KAF2nfFZD2LjL07folIXRYatAHjZfzoMCsHv6NpDYg805n6xtctivZ
 9xLUuhpFPPQwkZ+xyud5G6z9vYk8wuyXumgtq13SEKRtmS70gEhLjFqMmvRPrQcKw5xp4LDHq
 jTfe2UVUxoqiF1FD6r4XP6NDAzLW/Lu2vVKpuEuDPhoPS5sdUjoT0yIfAh8DVKrMUrQUL8F0o
 bsl/q9ZlA84nqECah
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 05.06.20 14:39, Ard Biesheuvel wrote:
> On Fri, 5 Jun 2020 at 14:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> On 05.06.20 13:52, Ard Biesheuvel wrote:
>>> EFI on ARM only supports short descriptors, and given that it mandates
>>> that the MMU and caches are on, it is implied that booting in HYP mode
>>> is not supported.
>>>
>>> However, implementations of EFI exist (i.e., U-Boot) that ignore this
>>> requirement, which is not entirely unreasonable, given that it does
>>> not make a lot of sense to begin with.
>>
>> Hello Ard,
>>
>> thanks for investigating the differences between EDK2 and U-Boot.
>>
>> What I still do not understand is if there is a bug in U-Boot where
>> U-Boot does not conform to the UEFI specification? In this case I would
>> expect a fix in U-Boot.
>>
>
> U-Boot violates the EFI spec, yes. The spec is very clear on how the
> MMU is configured, and this rules out booting with the caches off, or
> booting in HYP mode.
>
> However, given that this is the situation today, we still need to deal
> with it on the Linux side.
> In parallel, fixing it in U-boot may be appropriate. However, I think
> the EFI spec is too detailed here - instead of 'booting at the highest
> non-secure privilege mode', it tells you which exact bits to set in
> SCTLR, which seems overzealous to me. In other words, even though it
> violates the letter of the spec, I don't mind dealing with this
> exception in the Linux side, since the requirement is somewhat
> unreasonable to begin with.
>
>> Or is it simply a deficiency of Linux that it does not properly support
>> HYP/EL2 mode on 32-bit ARM?
>>
>
> No, this is definitely not the fault of Linux.
>
>> Up to now I never experience a problem booting a 32bit board via U-Boot
>> -> GRUB-EFI -> Linux. Where did you have a problem when booting via
>> U-Boot's UEFI implementation and the current Linux kernel?
>>
>
> I haven't managed to make it fail, but my only 32-bit HYP capable
> platform is QEMU. I am not 100% convinced that the EFI+HYP+U-Boot case
> is rock solid, and I may have gotten lucky with QEMU (which uses
> emulation not virtualization when running at HYP)
>
> Do you have any A7/A15 based boards that don't print 'WARNING: Caches
> not enabled' at boot?

Hello Ard,

I have no board that prints this. Where did you actually see this output?

The string "Caches not enabled" does not exist in Linux next-20200505
according to "git grep -n 'ache not enabled'".

Here is some sample output for an Orange Pi PC with a quad core
Allwinner H3 Soc. "ARMv7 Processor rev 5 (v7l)" according to
/proc/cpuinfo, compatible to "arm,cortex-a7" according to the device tree.

$ uname -m
Linux orangepi-pc 5.6.0-2-armmp-lpae #1 SMP Debian 5.6.14-1 (2020-05-23)
armv7l GNU/Linux


*Booted via GRUB EFI*

load mmc 0:2 $fdt_addr_r /dtb
# dtb -> dtbs/5.6.0-2-armmp-lpae/./sun8i-h3-orangepi-pc.dtb
load mmc 0:1 $kernel_addr_r /EFI/debian/grubarm.efi
bootefi $kernel_addr_r $fdt_addr_r

EFI stub: Booting Linux Kernel...


EFI stub: ERROR: Could not determine UEFI Secure Boot status.


EFI stub: Using DTB from configuration table


EFI stub: Exiting boot services and installing virtual address map...


EFI stub: ERROR: Could not determine UEFI Secure Boot status

$ sudo dmesg -H | grep ache
[  +0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[  +0.000000] Memory policy: Data cache writealloc
[  +0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes, linear)
[  +0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes, linear)
[  +0.000000] random: get_random_u32 called from
__kmem_cache_create+0x48/0x518 with crng_init=3D0
[  +0.000111] Mount-cache hash table entries: 2048 (order: 1, 8192
bytes, linear)
[  +0.000031] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
bytes, linear)
[  +0.000126] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096
bytes)
[  +0.027188] systemd[1]: Reached target Local Encrypted Volumes.
[  +0.023909] systemd[1]: Reached target Paths.
[  +0.019948] systemd[1]: Reached target Remote File Systems.
[  +0.019927] systemd[1]: Reached target Slices.
[  +0.020008] systemd[1]: Reached target Swap.
[  +0.005853] lima 1c40000.gpu: l2 cache 64K, 4-way, 64byte cache line,
64bit external bus


*Booted via Linux EFI stub*

setenv bootargs root=3DUUID=3D... ro initrd=3Dinitrd.img-5.6.0-2-armmp-lpa=
e
load mmc 0:2 $fdt_addr_r dtb
# dtb -> dtbs/5.6.0-2-armmp-lpae/./sun8i-h3-orangepi-pc.dtb
load mmc 0:2 $kernel_addr_r vmlinuz-5.6.0-2-armmp-lpae
bootefi $kernel_addr_r $fdt_addr_r

EFI stub: Booting Linux Kernel...


EFI stub: ERROR: Could not determine UEFI Secure Boot status.


EFI stub: Using DTB from configuration table


EFI stub: Exiting boot services and installing virtual address map...


EFI stub: ERROR: Could not determine UEFI Secure Boot status.

$ sudo dmesg -H | grep ache
[  +0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[  +0.000000] Memory policy: Data cache writealloc
[  +0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes, linear)
[  +0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes, linear)
[  +0.000000] random: get_random_u32 called from
__kmem_cache_create+0x48/0x518 with crng_init=3D0
[  +0.000114] Mount-cache hash table entries: 2048 (order: 1, 8192
bytes, linear)
[  +0.000033] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
bytes, linear)
[  +0.000128] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096
bytes)
[  +0.027122] systemd[1]: Reached target Local Encrypted Volumes.
[  +0.023916] systemd[1]: Reached target Paths.
[  +0.019869] systemd[1]: Reached target Remote File Systems.
[  +0.019974] systemd[1]: Reached target Slices.
[  +0.020017] systemd[1]: Reached target Swap.
[  +0.017564] lima 1c40000.gpu: l2 cache 64K, 4-way, 64byte cache line,
64bit external bus

Best regards

Heinrich


>
>> Does this patch relate to the retirement of KVM on 32 ARM in Linux 5.7
>> 541ad0150ca4 ("arm: Remove 32bit KVM host support")? Without that patch
>> I would have expected Linux to work fine in HYP mode.
>>
>
> Not really. The code still has to deal with booting at HYP mode,
> regardless of whether it is used in a useful way.
>
> I suppose simply dropping to SVC in the decompressor might make sense
> as well, given that booting the kernel at HYP doesn't buy you anything
> anymore in the first place. Marc may have some thoughts on that, but
> it is really a separate discussion.
>
>
>>
>>>
>>> So let's make sure that we can deal with this condition gracefully.
>>> We already tolerate booting the EFI stub with the caches off (even
>>> though this violates the EFI spec as well), and so we should deal
>>> with HYP mode boot with MMU and caches either on or off.
>>>
>>> - When the MMU and caches are on, we can ignore the HYP stub altogethe=
r,
>>>   since we can just use the existing mappings, and just branch into
>>>   the decompressed kernel as usual after disabling MMU and caches.
>>>
>>> - When the MMU and caches are off, we have to drop to SVC mode so that
>>>   we can set up the page tables using short descriptors. In this case,
>>>   we need to install the HYP stub so that we can return to HYP mode
>>>   when handing over to the kernel proper.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>  arch/arm/boot/compressed/head.S | 29 +++++++++++++++++++++++++++++
>>>  1 file changed, 29 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compresse=
d/head.S
>>> index c79db44ba128..986db86ba334 100644
>>> --- a/arch/arm/boot/compressed/head.S
>>> +++ b/arch/arm/boot/compressed/head.S
>>> @@ -1436,6 +1436,35 @@ ENTRY(efi_enter_kernel)
>>>               mrc     p15, 0, r0, c1, c0, 0   @ read SCTLR
>>>               tst     r0, #0x1                @ MMU enabled?
>>>               orreq   r4, r4, #1              @ set LSB if not
>>> +#ifdef CONFIG_ARM_VIRT_EXT
>>> +             @
>>> +             @ The EFI spec does not support booting on ARM in HYP mo=
de,
>>> +             @ since it mandates that the MMU and caches are on, with=
 all
>>> +             @ 32-bit addressable DRAM mapped 1:1 using short descrip=
tors.
>>> +             @ While the EDK2 reference implementation adheres to thi=
s,
>>> +             @ U-Boot might decide to enter the EFI stub in HYP mode =
anyway,
>>> +             @ with the MMU and caches either on or off.
>>> +             @ In the former case, we're better off just carrying on =
using
>>> +             @ the cached 1:1 mapping that the firmware provided, and=
 pretend
>>> +             @ that we are in SVC mode as far as the decompressor is
>>> +             @ concerned. However, if the caches are off, we need to =
drop
>>> +             @ into SVC mode now, and let the decompressor set up its=
 cached
>>> +             @ 1:1 mapping as usual.
>>> +             @
>>> +             mov     r0, #SVC_MODE
>>> +             msr     spsr_cxsf, r0           @ record that we are in =
SVC mode
>>> +             bne     1f                      @ skip HYP stub install =
if MMU is on
>>> +
>>> +             mov     r9, r4                  @ preserve image base
>>> +             bl      __hyp_stub_install      @ returns boot mode in r=
4
>>> +             cmp     r4, #HYP_MODE           @ did we boot in HYP?
>>> +             bne     1f                      @ skip drop to SVC if we=
 did not
>>> +
>>> +             safe_svcmode_maskall    r0
>>> +             msr     spsr_cxsf, r4           @ record boot mode
>>> +             mov     r4, r9                  @ restore image base
>>> +1:
>>> +#endif
>>>
>>>               mov     r0, r8                  @ DT start
>>>               add     r1, r8, r2              @ DT end
>>>
>>

