Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B411F16E9
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jun 2020 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgFHKqg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Jun 2020 06:46:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:60805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbgFHKqf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Jun 2020 06:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591613177;
        bh=sDbMWhrGcpGuBcouFsdLSeCfDg5Y4fjzTI4hxoNFcIs=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=ThLAreEoSfEQIslURB+/stMJc9q3+2TS6aa31IumK54tudmmeN0mQBdz36ZrnJPsX
         fmzUgXYRdO3d/fu/qOO/i5gNNe8D/tk9QUzLkn9RfqixlRgREcA162dNyd6Z+N4LHC
         /7NENWqBBm+pvtktFytL9w52JXkCfidhTQYU1Uok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([88.152.145.75]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf4c-1jHSyw46RW-00ioYb; Mon, 08
 Jun 2020 12:46:17 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 1/2] efi/arm: decompressor: deal with HYP mode boot
 gracefully
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>
References: <20200607135834.898294-1-ardb@kernel.org>
 <20200607135834.898294-2-ardb@kernel.org>
 <96a36110-68e1-89e3-2d59-b16f01abae21@gmx.de>
 <CAMj1kXG9XTtsyLQ=njM8LPCYCE2tOrrYQtctU_acNAxLfe=5oQ@mail.gmail.com>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <f8a485d2-1e00-1d02-58a4-2e1684bfbfb4@gmx.de>
Date:   Mon, 8 Jun 2020 12:46:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXG9XTtsyLQ=njM8LPCYCE2tOrrYQtctU_acNAxLfe=5oQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bt25R4+MNx4wI45kBVtVpg/zSdFoGPfxGO9eI7kbO+eMcXjXWyj
 4Rj6m71BN6SgNsGs6B0Cgv0GZdrjESgTjhT4EC3v0pujQfGTFO9f1HiiyLAH6Igj/75gnIM
 3BuWBH23plgOih5XIp6ZZbhGRiLYI+xgFpqiMmw9Au2FXaPLXZ0BjabdBW/W39exmg23I6d
 PL0qZVPugx5xgz0d2LMrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HZaebPCbB9U=:YSLYdonT84DoMEEc1Ger5o
 2NbQ5Sy87Sm9GKlwESRzy5ABNeaIQfyajfCppyUBXeFDlRACQMdFYhltN5d3GL+Oux/XNBnF/
 LFPVJopIvcvbG2NjoewgAtcKhdk54QYhYVOZ5xkqs0IZukcFvbfjzh6wGUpaJg4GvdkiT7ahd
 t3PI1o358t3A0Q/nYf2/gs/WUqQ8a5YrhmPIoYAzOx3XlRACjVqkf2ATpWygl9GsLF2gtdGqA
 4ZN4y+tn/7CNtlhk3XgXOpkD3d5BnnY6RB8MtR0dt0ton5DB80yZW5wDyv4HfelLAcyBHo8u1
 6EydpNJNhNCkuRToDsnLyRPPOq70+RUbe1I+vewqJntI4v7xdfXT1JDv3Pqzkth+rB6ZfEL5e
 MmONwP/UaqXJOLJ/qznUsK4q5gn0bt67b5CX8JqzNeg0PNGm+1zGHVKK4QJ94j5CCtuxhILpq
 wA6eaetRaYUJSdP1SUW8Ue0mhlj6ZaUZot6g/YkSOpzhnpZd82RaOjNaD5Z2/XtXA1IohirRw
 Zekw7pKd/P+0XRAONPFe9rupsLH0mP/EWRs7hFCNOdHd+n0r5vd1cgBu5D4ajZxErYk9CAuOY
 7zFYXgY+s3lo0pvQAn8qG0gF52jL9WvSoSJhtFAWLkkGWIUuoO1ve3TseLL5+CtzThwqUxH6c
 x0a99tp/vyIWvPHdUD9Jd4qeSr8eDcvJ6scHfo88b8+AaHOKg9O7Hj/ElB/gy7RH0qYUkofrv
 x/XDsaJO3/xwZbUsKx8YuVOlw9U52H5O6foXkdJMzndSpCqIOQyGDgCK5uq0458JWnEK4wDUY
 r4HBfYZK/tmsk5XYL1Siptrbc6OHx3x3LRuYBlCdQiBvHaFdFGl0pfdejcRE1TJnuUq5Hwjkj
 tWCD7fm5QalyPNadm+Mi9SzPKmsHIMcZ/50KC/Pjucbyw3zF7cGwa4mS0Epv24c9DCD1AX+zA
 QE3DlwbQHXra958NU9C9dPWziX0rfalh+1Qu2EMXik29ZEELjTNs183c1cOcjzhqSqH0UntdC
 xWrJ2UNa5ibfb7g+6xSAmbsWz+sJ/kkfEIdwlGG5wmC/ycz+zNLqnw778FV2NJ+5lurilzMRu
 R03ErQS2ZwY3vR0u0AS/SQDheDt7BtsHnj1XkSUduyChA5wqno33PoZEiiGJov5lwQPT9g1tr
 DOyTjd4sU5h9IVPfZBJOgSM4YvMfhrUPGEYaExr4PBTurdanbI6QSGVO7vqOSvwXtcmsocWKn
 jBJ5rVK9oEu3CmDEA
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/8/20 1:08 AM, Ard Biesheuvel wrote:
> On Sun, 7 Jun 2020 at 19:24, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> On 6/7/20 3:58 PM, Ard Biesheuvel wrote:
>>> EFI on ARM only supports short descriptors, and given that it mandates
>>> that the MMU and caches are on, it is implied that booting in HYP mode
>>> is not supported.
>>>
>>> However, implementations of EFI exist (i.e., U-Boot) that ignore this
>>> requirement, which is not entirely unreasonable, given that it makes
>>> HYP mode inaccessible to the operating system.
>>>
>>> So let's make sure that we can deal with this condition gracefully.
>>> We already tolerate booting the EFI stub with the caches off (even
>>> though this violates the EFI spec as well), and so we should deal
>>> with HYP mode boot with MMU and caches either on or off.
>>>
>>> - When the MMU and caches are on, we can ignore the HYP stub altogethe=
r,
>>>   since we can carry on executing at HYP. We do need to ensure that we
>>>   disable the MMU at HYP before entering the kernel proper.
>>>
>>> - When the MMU and caches are off, we have to drop to SVC mode so that
>>>   we can set up the page tables using short descriptors. In this case,
>>>   we need to install the HYP stub as usual, so that we can return to H=
YP
>>>   mode before handing over to the kernel proper.
>>
>> To me it is still unclear why you need this patch. Please, describe the
>> problem this patch fixes.
>>
>> Is there any device that you cannot boot without the patch?
>>
>
> The code as it is today is broken, and if it works, it only does so by a=
ccident.
>
> (There were some recent changes but the old code is broken in a similar =
way)
>
> When we enter via the stub, we used to call cache_off() to disable the
> caches before calling the decompressor entry point. However, that
> disables the SVC mode caches, not the HYP mode caches, and so if we
> enter via EFI at HYP, we will call __hyp_stub_install() with the HYP
> mod MMU and caches enabled, which is explicitly forbidden (see
> hyp-stub.S)
>
> With the recent change, the EFI entry code doesn't call cache_off()
> anymore, but that does not remove the problem, it just moves it to the
> point where we hand over to the kernel proper.
>
> The problem is really on the u-boot side, and so we either have to
> follow the letter of the EFI spec and ban the practice of booting in
> HYP mode or with the caches off, or we work around this like I do in
> this patch. Doing nothing is not really an option.
>
> If we want EBBR and U-boot as EFI firmware to succeed, we should
> really fix issues such as these, and not pretend everything is fine
> when we know it is broken but happens to work on the few boards that
> we test. This is the reason we have architecture and firmware specs in
> the first place, and it is really quite unfortunate that we did not
> catch these u-boot issues before.
>
> As I said, I think booting at HYP can be tolerated, since the OS loses
> access to it otherwise (and maybe we should even update the EFI spec
> to allow this). But fiddling with the caches like we do should really
> be avoided (and the GRUB hack really needs to go as well)
>
>
>
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>  arch/arm/boot/compressed/head.S | 61 ++++++++++++++++++++
>>>  1 file changed, 61 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compresse=
d/head.S
>>> index c79db44ba128..3476e85c31e7 100644
>>> --- a/arch/arm/boot/compressed/head.S
>>> +++ b/arch/arm/boot/compressed/head.S
>>> @@ -1410,7 +1410,11 @@ memdump:       mov     r12, r0
>>>  __hyp_reentry_vectors:
>>>               W(b)    .                       @ reset
>>>               W(b)    .                       @ undef
>>> +#ifdef CONFIG_EFI_STUB
>>> +             W(b)    __enter_kernel_from_hyp @ hvc from HYP
>>> +#else
>>>               W(b)    .                       @ svc
>>> +#endif
>>>               W(b)    .                       @ pabort
>>>               W(b)    .                       @ dabort
>>>               W(b)    __enter_kernel          @ hyp
>>> @@ -1429,14 +1433,71 @@ __enter_kernel:
>>>  reloc_code_end:
>>>
>>>  #ifdef CONFIG_EFI_STUB
>>> +__enter_kernel_from_hyp:
>>> +             mrc     p15, 4, r0, c1, c0, 0   @ read HSCTLR
>>> +             bic     r0, r0, #0x5            @ disable MMU and caches
>>> +             mcr     p15, 4, r0, c1, c0, 0   @ write HSCTLR
>>> +             isb
>>> +             b       __enter_kernel
>>> +
>>>  ENTRY(efi_enter_kernel)
>>>               mov     r4, r0                  @ preserve image base
>>>               mov     r8, r1                  @ preserve DT pointer
>>>
>>> + ARM(                adrl    r0, call_cache_fn       )
>>> + THUMB(              adr     r0, call_cache_fn       )
>>> +             adr     r1, 0f                  @ clean the region of co=
de we
>>> +             bl      cache_clean_flush       @ may run with the MMU o=
ff
>>> +
>>> +#ifdef CONFIG_ARM_VIRT_EXT
>>> +             @
>>> +             @ The EFI spec does not support booting on ARM in HYP mo=
de,
>>> +             @ since it mandates that the MMU and caches are on, with=
 all
>>> +             @ 32-bit addressable DRAM mapped 1:1 using short descrip=
tors.
>>> +             @
>>> +             @ While the EDK2 reference implementation adheres to thi=
s,
>>> +             @ U-Boot might decide to enter the EFI stub in HYP mode
>>> +             @ anyway, with the MMU and caches either on or off.
>>> +             @
>>> +             mrs     r0, cpsr                @ get the current mode
>>> +             msr     spsr_cxsf, r0           @ record boot mode
>>> +             and     r0, r0, #MODE_MASK      @ are we running in HYP =
mode?
>>> +             cmp     r0, #HYP_MODE
>>> +             bne     .Lefi_svc
>>> +
>>> +             mrc     p15, 4, r1, c1, c0, 0   @ read HSCTLR
>>> +             tst     r1, #0x1                @ MMU enabled at HYP?
>>> +             beq     1f
>>> +
>>> +             @
>>> +             @ When running in HYP mode with the caches on, we're bet=
ter
>>> +             @ off just carrying on using the cached 1:1 mapping that=
 the
>>> +             @ firmware provided. Set up the HYP vectors so HVC instr=
uctions
>>> +             @ issued from HYP mode take us to the correct handler co=
de. We
>>> +             @ will disable the MMU before jumping to the kernel prop=
er.
>>> +             @
>>> +             adr     r0, __hyp_reentry_vectors
>>> +             mcr     p15, 4, r0, c12, c0, 0  @ set HYP vector base (H=
VBAR)
>>> +             isb
>>> +             b       .Lefi_hyp
>>> +
>>> +             @
>>> +             @ When running in HYP mode with the caches off, we need =
to drop
>>> +             @ into SVC mode now, and let the decompressor set up its=
 cached
>>> +             @ 1:1 mapping as usual.
>>> +             @
>>> +1:           mov     r9, r4                  @ preserve image base
>>> +             bl      __hyp_stub_install      @ install HYP stub vecto=
rs
>>> +             safe_svcmode_maskall    r1      @ drop to SVC mode
>>
>> Are you returning to HYP mode somewhere?
>>
>
> Yes.
>
>> What is the effect on PSCI?
>>
>
> If you boot Linux in HYP then you cannot have PSCI in HYP as well.
> Linux will take ownership of HYP mode, and remove whatever was there.
> If you want to run PSCI at HYP, then the OS needs to boot in SVC mode.
>
>> The Allwinner/Sunxi boards must be booted in HYP mode to have PSCI
>> according to https://linux-sunxi.org/PSCI
>>
>
> See above. If PSCI runs in HYP, the OS needs to run at SVC
>
>> Did you test that you still can reboot those boards?
>>
>
> No, I don't have such a board.

Hello Ard,

thanks for supplying a branch for testing:
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=3Def=
i-arm-hyp-mode

The OrangePi PC boots fine with this branch. PSCI is enabled. Rebooting
the system works fine. See log below.

With the patch 2/2 you add an output line for the exceptions level and
the MMU status. Above you state "We already tolerate booting the EFI
stub with the caches off." This relates to a workaround in U-Boot
accomodating old GRUB versions (CONFIG_EFI_GRUB_ARM32_WORKAROUND=3Dy).

Would a further diagnostic line showing if D-cache and I-cache is
enabled make sense?

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Loading Linux 5.7.0-armmp-lpae+ ...
Loading initial ramdisk ...
EFI stub: Running in HYP mode with MMU enabled
EFI stub: Booting Linux Kernel...
EFI stub: ERROR: Could not determine UEFI Secure Boot status.
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
EHCI failed to shut down host controller.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.7.0-armmp-lpae+ (user@node)
(arm-linux-gnueabihf-gcc (Debian 9.3.0-13) 9.3.0, GNU ld (GNU Binutils
for Debian) 2.34) #10 SMP Mon Jun 8 03:44:37 CEST 2020
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7),
cr=3D30c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] OF: fdt: Machine model: Xunlong Orange Pi PC
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: EFI v2.80 by Das U-Boot
[    0.000000] efi: RTPROP=3D0x78f30040 SMBIOS=3D0x78f2a000
MEMRESERVE=3D0x6a1fa040
[    0.000000] cma: Reserved 16 MiB at 0x000000007f000000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x000000006fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000070000000-0x000000007fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x0000000078f07fff]
[    0.000000]   node   0: [mem 0x0000000078f08000-0x0000000078f09fff]
[    0.000000]   node   0: [mem 0x0000000078f0a000-0x0000000078f24fff]
[    0.000000]   node   0: [mem 0x0000000078f25000-0x0000000078f28fff]
[    0.000000]   node   0: [mem 0x0000000078f29000-0x0000000078f29fff]
[    0.000000]   node   0: [mem 0x0000000078f2a000-0x0000000078f2afff]
[    0.000000]   node   0: [mem 0x0000000078f2b000-0x0000000078f2cfff]
[    0.000000]   node   0: [mem 0x0000000078f2d000-0x0000000078f2dfff]
[    0.000000]   node   0: [mem 0x0000000078f2e000-0x0000000078f2ffff]
[    0.000000]   node   0: [mem 0x0000000078f30000-0x0000000078f32fff]
[    0.000000]   node   0: [mem 0x0000000078f33000-0x0000000078f33fff]
[    0.000000]   node   0: [mem 0x0000000078f34000-0x0000000078f34fff]
[    0.000000]   node   0: [mem 0x0000000078f35000-0x0000000078f35fff]
[    0.000000]   node   0: [mem 0x0000000078f36000-0x0000000078f36fff]
[    0.000000]   node   0: [mem 0x0000000078f37000-0x0000000078f38fff]
[    0.000000]   node   0: [mem 0x0000000078f39000-0x0000000078f3efff]
[    0.000000]   node   0: [mem 0x0000000078f3f000-0x000000007df65fff]
[    0.000000]   node   0: [mem 0x000000007df66000-0x000000007df66fff]
[    0.000000]   node   0: [mem 0x000000007df67000-0x000000007dfb9fff]
[    0.000000]   node   0: [mem 0x000000007dfba000-0x000000007dfbcfff]
[    0.000000]   node   0: [mem 0x000000007dfbd000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000040000000-0x000000007fffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: Using PSCI v0.1 Function IDs from DT
