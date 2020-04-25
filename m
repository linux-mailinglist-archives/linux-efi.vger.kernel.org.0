Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF171B855F
	for <lists+linux-efi@lfdr.de>; Sat, 25 Apr 2020 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgDYJsM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Apr 2020 05:48:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:53759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgDYJsL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 25 Apr 2020 05:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587808072;
        bh=C+CV4CzDRp5fYtYy+pll9aMwyjgfuNADtMtiAgxiIk4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=F5NjarbrKv5sX+pn+FzgaTHfOUHW98dk3ecM9838Y5gckr2bbvvelD9SwjYWS9Q/J
         TjkCOK6ATrsTeGsxTNYl4b10H6VHbmGpnKaLcoMxsNbdo2iDEU4F0VjFWXCWyahm6x
         4ReaIwlkI/5ihHU6Uvw21ZhQ3kYdXSb35X6bsOyk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([84.119.33.226]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ob6-1j5z0r3ubu-015oXo; Sat, 25
 Apr 2020 11:47:52 +0200
Subject: Re: [v2 PATCH 1/5] efi: Move arm-stub to a common file
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <Atish.Patra@wdc.com>, will@kernel.org
Cc:     linux-efi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        catalin.marinas@arm.com, linux@armlinux.org.uk,
        linux-riscv@lists.infradead.org, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <mhng-b521aadc-a209-48d6-886c-957c87f97367@palmerdabbelt-glaptop1>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <8bf726ff-2f25-e8ba-17c7-2abf450b7c72@gmx.de>
Date:   Sat, 25 Apr 2020 11:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <mhng-b521aadc-a209-48d6-886c-957c87f97367@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JuXH4bzxRq5XOwnHZlchTBJ6QK2keBcuLdefY70ek1AUYDYW4lG
 xrIkJTLDncNKnxaUJVIS1v2MuDWyP9AbmD+A6RoA1r1aXNySmXilpmRKVMZ6SsIsEA3s5tI
 VEZae8NrD0ifuxbkl/BYZ4lm1q/GibTBbgduQEq43X+GWkyq0X61qLyWzd4kF9J4YLlZ04r
 br0YcvCGGNssrO6hofQuw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rchas7/xmWE=:cOE2Av5lH45XPnRMt8eXFx
 8SRTtMzdVxnm9L1QCy8n3xS/0ACbLx0vsO0MYFPVCKrgL5xvlj2+tF41OjC0GBIwEdYBV/gh7
 cMFEJYExatMZlDkbvxc9Z/P064Hcn7cpjsY4IBv/lYR3+xUCgM9rkiLBL5h4XgrkQwrT2+P7j
 KCmz0jP1N1TZ7wL0uf0EcJgy/E8ABKOlH03Kf0lHwz41ZLhyoxVXJCKamg0o9uZjhh/8X+7XM
 ZdY1M/zS2feyhiWXsS9XjkZxiGYmk8M4WOZ7F+evvbBHUlZASOPYqi8/i7TpzfeIoK4ePP5qR
 6zkY6A9sEJ2UkHgkCOXE+HIjbYhBvCtYaVBTn+acjiaHXqEhDce1/MWCb988S6Ny5rcw9SMAk
 iPGNgbusxMX6nzdKQ+G80SNbeaM6+3+mWg0fnXYJPww5NkEEoxEYyqMMkKjx/36w4Dr94U+FA
 qcKrT2oV1uDrmbkiBm3H9SQVIBoViDkUT55rE5xpwsoJ/xoshj4rLkTqrJIODShnG6GFAyBeW
 ZS8vaIgkTAal99+0XDp4kWniCGpCCmIrTJR17nC3ZZnfXLcxoe2ZbhsDLTtcc58zrMiiJNh7k
 8hmRHIxFxkdLlCGDRMwv3EKCXkQ8EvfPQkPgtvHc9vo1to/PrxniWnP+ITe6XDfBnpRWI60ix
 YLUOaTPSbeNQjNocj2P2AlCiHChxahKrTSSiKVH6DDc2Om72YW+RjUr52gZsz082vsOJIDZi9
 vFF7sm6anQb57fvBWMJ8krTyuIslgbr9sP8oTBYCRrMfV7vR5tP5TleUB0y/7jQR7u4rhsD8Y
 imOdtA6lktVfNwakvmoKTixd74EkDMGrqSsVfp1awAgFBBv3TKpYAVtRjOKvR1Y7V2vdBg5nN
 0LjOCW6eIDoNn8SqxnAAGQaTgLR2Cty779c+Pjjtb1uqafq68Xflu9vdSt7TtD8BGPzl728kx
 1opsTQaN1+pWEWMfPlbr+OD8GFgmG75IjlrBr/5dGqQkbG/pc4vnrpfZqigGV7RKxb/iJSHLa
 YL6J8AvpRfhweb8kF1QOsz8JuIECch0bAVUhhev1S3atOZzcEQjC7btwPeH3uLI+wAwCEn2ke
 JF3LGWCEZGFPRhX18EWg8kee2nIxYnKNMfqMdVnls2/SiOn4kxa6ikFh8XnA3SyaOv5XcGy4g
 BtrDbEaU27SNOM5yRhzHvGQnXGba8x74bytmgm6uR+SbU+rzCkMJBdoWte9megavuDzn/v0ll
 rkZs3FMT+gEETM0EF
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/21/20 9:19 PM, Palmer Dabbelt wrote:
> On Mon, 13 Apr 2020 14:29:03 PDT (-0700), Atish Patra wrote:
>> Most of the arm-stub code is written in an architecture independent
>> manner.
>> As a result, RISC-V can reuse most of the arm-stub code.
>>
>> Rename the arm-stub.c to efi-stub.c so that ARM, ARM64 and RISC-V can
>> use it.
>> This patch doesn't introduce any functional changes.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>

The code being moved has some problems:

The ARM stub ignores the return value of efi_setup_gop().

drivers/firmware/efi/libstub/arm-stub.c and
drivers/firmware/efi/libstub/x86-stub.c both call LocateHandle() before
calling efi_setup_gop(). I think this should be moved to efi_setup_gop().

I guess the issues can be addressed in some follow up patch.

Best regards

Heinrich

>
> We'll need a bunch of Acked-bys for these, but I'm happy to take this in=
 my
> tree.
>
>> ---
>> =C2=A0arch/arm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0arch/arm64/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0drivers/firmware/efi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>> =C2=A0drivers/firmware/efi/libstub/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +++++=
+------
>> =C2=A0.../firmware/efi/libstub/{arm-stub.c =3D> efi-stub.c}=C2=A0 |=C2=
=A0 0
>> =C2=A05 files changed, 10 insertions(+), 10 deletions(-)
>> =C2=A0rename drivers/firmware/efi/libstub/{arm-stub.c =3D> efi-stub.c} =
(100%)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 66a04f6f4775..165987aa5bcd 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1954,7 +1954,7 @@ config EFI
>> =C2=A0=C2=A0=C2=A0=C2=A0 select UCS2_STRING
>> =C2=A0=C2=A0=C2=A0=C2=A0 select EFI_PARAMS_FROM_FDT
>> =C2=A0=C2=A0=C2=A0=C2=A0 select EFI_STUB
>> -=C2=A0=C2=A0=C2=A0 select EFI_ARMSTUB
>> +=C2=A0=C2=A0=C2=A0 select EFI_GENERIC_STUB
>> =C2=A0=C2=A0=C2=A0=C2=A0 select EFI_RUNTIME_WRAPPERS
>> =C2=A0=C2=A0=C2=A0=C2=A0 ---help---
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This option provides support for r=
untime services provided
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 40fb05d96c60..32d818c5ccda 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1785,7 +1785,7 @@ config EFI
>> =C2=A0=C2=A0=C2=A0=C2=A0 select EFI_PARAMS_FROM_FDT
>> =C2=A0=C2=A0=C2=A0=C2=A0 select EFI_RUNTIME_WRAPPERS
>> =C2=A0=C2=A0=C2=A0=C2=A0 select EFI_STUB
>> -=C2=A0=C2=A0=C2=A0 select EFI_ARMSTUB
>> +=C2=A0=C2=A0=C2=A0 select EFI_GENERIC_STUB
>> =C2=A0=C2=A0=C2=A0=C2=A0 default y
>> =C2=A0=C2=A0=C2=A0=C2=A0 help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This option provides support for r=
untime services provided
>> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfi=
g
>> index 613828d3f106..2a2b2b96a1dc 100644
>> --- a/drivers/firmware/efi/Kconfig
>> +++ b/drivers/firmware/efi/Kconfig
>> @@ -106,12 +106,12 @@ config EFI_PARAMS_FROM_FDT
>> =C2=A0config EFI_RUNTIME_WRAPPERS
>> =C2=A0=C2=A0=C2=A0=C2=A0 bool
>>
>> -config EFI_ARMSTUB
>> +config EFI_GENERIC_STUB
>> =C2=A0=C2=A0=C2=A0=C2=A0 bool
>>
>> =C2=A0config EFI_ARMSTUB_DTB_LOADER
>> =C2=A0=C2=A0=C2=A0=C2=A0 bool "Enable the DTB loader"
>> -=C2=A0=C2=A0=C2=A0 depends on EFI_ARMSTUB
>> +=C2=A0=C2=A0=C2=A0 depends on EFI_GENERIC_STUB
>> =C2=A0=C2=A0=C2=A0=C2=A0 default y
>> =C2=A0=C2=A0=C2=A0=C2=A0 help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select this config option to add s=
upport for the dtb=3D command
>> diff --git a/drivers/firmware/efi/libstub/Makefile
>> b/drivers/firmware/efi/libstub/Makefile
>> index 094eabdecfe6..d590504541f6 100644
>> --- a/drivers/firmware/efi/libstub/Makefile
>> +++ b/drivers/firmware/efi/libstub/Makefile
>> @@ -23,7 +23,7 @@ cflags-$(CONFIG_ARM)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 :=3D $(subst
>> $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -fno-builtin -fpic \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call cc-option,-mno-single=
-pic-base)
>>
>> -cflags-$(CONFIG_EFI_ARMSTUB)=C2=A0=C2=A0=C2=A0 +=3D -I$(srctree)/scrip=
ts/dtc/libfdt
>> +cflags-$(CONFIG_EFI_GENERIC_STUB)=C2=A0=C2=A0=C2=A0 +=3D -I$(srctree)/=
scripts/dtc/libfdt
>>
>> =C2=A0KBUILD_CFLAGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=3D $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -include
>> $(srctree)/drivers/firmware/efi/libstub/hidden.h \
>> @@ -45,13 +45,13 @@ lib-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=3D efi-stub-helper.o gop.o
>> secureboot.o tpm.o \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skip_spaces.o lib-cmdline.o =
lib-ctype.o
>>
>> =C2=A0# include the stub's generic dependencies from lib/ when building=
 for
>> ARM/arm64
>> -arm-deps-y :=3D fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c
>> fdt_sw.c
>> +efi-deps-y :=3D fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c
>> fdt_sw.c
>>
>> =C2=A0$(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
>> =C2=A0=C2=A0=C2=A0=C2=A0 $(call if_changed_rule,cc_o_c)
>>
>> -lib-$(CONFIG_EFI_ARMSTUB)=C2=A0=C2=A0=C2=A0 +=3D arm-stub.o fdt.o stri=
ng.o \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(patsubst %.c,lib-%.o,$(arm-deps-=
y))
>> +lib-$(CONFIG_EFI_GENERIC_STUB)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +=3D efi-stub.o fdt.o string.o \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(patsubst %.c,lib-%.o,$(efi-deps-=
y))
>>
>> =C2=A0lib-$(CONFIG_ARM)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D =
arm32-stub.o
>> =C2=A0lib-$(CONFIG_ARM64)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=
=3D arm64-stub.o
>> @@ -73,8 +73,8 @@ CFLAGS_arm64-stub.o=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 :=3D
>> -DTEXT_OFFSET=3D$(TEXT_OFFSET)
>> =C2=A0# a verification pass to see if any absolute relocations exist in=
 any
>> of the
>> =C2=A0# object files.
>> =C2=A0#
>> -extra-$(CONFIG_EFI_ARMSTUB)=C2=A0=C2=A0=C2=A0 :=3D $(lib-y)
>> -lib-$(CONFIG_EFI_ARMSTUB)=C2=A0=C2=A0=C2=A0 :=3D $(patsubst %.o,%.stub=
.o,$(lib-y))
>> +extra-$(CONFIG_EFI_GENERIC_STUB)=C2=A0=C2=A0=C2=A0 :=3D $(lib-y)
>> +lib-$(CONFIG_EFI_GENERIC_STUB)=C2=A0=C2=A0=C2=A0 :=3D $(patsubst %.o,%=
.stub.o,$(lib-y))
>>
>> =C2=A0STUBCOPY_FLAGS-$(CONFIG_ARM64)=C2=A0=C2=A0=C2=A0 +=3D --prefix-al=
loc-sections=3D.init \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --prefix-symbols=3D__efistub=
_
>> diff --git a/drivers/firmware/efi/libstub/arm-stub.c
>> b/drivers/firmware/efi/libstub/efi-stub.c
>> similarity index 100%
>> rename from drivers/firmware/efi/libstub/arm-stub.c
>> rename to drivers/firmware/efi/libstub/efi-stub.c
>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

