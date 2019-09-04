Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7601CA9212
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2019 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbfIDSvZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Sep 2019 14:51:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51125 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732885AbfIDSvY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Sep 2019 14:51:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id c10so4426733wmc.0
        for <linux-efi@vger.kernel.org>; Wed, 04 Sep 2019 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8L+u1Pw1Ok9owTUUl/w9+l+mNO5l0VD9Q7I50HKZSs=;
        b=Sj61qyuIQS+PwL0w5LgUMIdIV9DySMivWc+R53dVvE9/kc0BuT33sDi/KyzzVQqImi
         Y3HvFFT0fdcuKcdv2Riiwt8dH3cv6/7JrTh+jZD5liL8gHVmq+xMqtng8zbGjixMl7qB
         xx789n8Gs897X+MD3fm0rp1/0IRTXFX1takjptSPCQsXsqM3BjfsV84ZQwYCYLuwxqoK
         /ebGnwo5izVwawtXQC4sKqhTKAPvkILVWEXh0CQWYEFQsqsq3MqwUR8GTRjQ9PPLpd/a
         TLXi1LQxHrQuNTfFPrp8PeXwB6fr7FZrNTgNCuLGShWqdYjiKcYa0lSZdZCvJ7+uOrtP
         H22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8L+u1Pw1Ok9owTUUl/w9+l+mNO5l0VD9Q7I50HKZSs=;
        b=NcMhov3fteNDA3IfoR40T7GT+btx7qfk28Bdf4pe4DLHEPcpPDeRK4VjAJ90BWtaqJ
         X1jgfePJHzKbZNgicsG6fgQA0u8pxdPEP4k+6X72jOa2tifDQdZKK08g2xJ4uUSlEc3a
         EySnE4161U4B8kks9i46FzxlNUtaKx/xsL8VptfQaQtOOuutFsJRLOtBJ2yBwYfvl6Z+
         dXDntmLVxDM//fz5o+Ycu8P7db3pVFc7gvURF8YYUzLO1R39qS9Mhdu7By6ontHSV0/w
         qejoStQXsnbIK2pvhV8JMM3ulZIop1OfpiGUJD7tTYZEB1Mfaxi7+rJS9s7thnkeK18Y
         6NWw==
X-Gm-Message-State: APjAAAVQVSD0NxqJEtVuyG1w7TVo9Y9bTahtJQqm3pRegWqBgw37q+Gr
        Nt85OywY8H3cvJ/VKmUy0h3AZVsFPSDDJ243Tql7Dw==
X-Google-Smtp-Source: APXvYqwwndUlZCIWvOOJNC+8jAaESt0oRJqguIaa5gMVTg2B5/LLWH3GUJZjZ9pofhawfKAZaUaPQi5DPHFly3EwdAs=
X-Received: by 2002:a05:600c:491:: with SMTP id d17mr5099270wme.61.1567623080749;
 Wed, 04 Sep 2019 11:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJrUJt_HV+8MCGxv4=bq97JFiKqPtgN4ntfei0TmxGhDT-bCQg@mail.gmail.com>
 <20190815110308.GA22153@lakrids.cambridge.arm.com> <CAKv+Gu-OoFZRy_fv1z3GmTH3rp=TKviO7rEeFXwqqiWzbgJf3A@mail.gmail.com>
 <CAJrUJt_hJJChKviBG5jvkUhv=OJrGPWpxF9aBB=S8-mL4URFOA@mail.gmail.com> <CAJrUJt-_B2DD3+538Ubq6s_3dyW3+EgFDY=RoLHBM8DUzJh_Fw@mail.gmail.com>
In-Reply-To: <CAJrUJt-_B2DD3+538Ubq6s_3dyW3+EgFDY=RoLHBM8DUzJh_Fw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Sep 2019 11:51:09 -0700
Message-ID: <CAKv+Gu9i+pBA91J-r1Pj9VK_s8oAsrOd8dAN=C_2K1S=VRqDYQ@mail.gmail.com>
Subject: Re: arm64/efistub boot error with CONFIG_GCC_PLUGIN_STACKLEAK
To:     skodde <skodde@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 31 Aug 2019 at 10:20, skodde <skodde@gmail.com> wrote:
>
> On Thu, Aug 15, 2019 at 8:17 AM skodde <skodde@gmail.com> wrote:
> > On Thu, Aug 15, 2019 at 7:21 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > > On Thu, 15 Aug 2019 at 14:03, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > On Thu, Aug 15, 2019 at 05:56:27AM -0400, skodde wrote:
> > > > > The kernel boots fine with that option disabled, but strangely
> > > > > presents the same error when disabling only CONFIG_RANDOMIZE_BASE.
> > > >
> > > > That shouldn't be possible, given the IS_ENABLED(CONFIG_RANDOMIZE_BASE)
> > > > guard around the efi_get_random_bytes() call, so something sounds wrong.
> > > >
> > > > Maybe there's a problem with stale objects. If you're not doing so
> > > > already, could you try a clean build with CONFIG_RANDOMIZE_BASE
> > > > deselected?
> > > >
> > > Also, can you try booting with the nokaslr command line option added?
> >
> > You were right, I haven't tried with nokaslr, but it worked fine by
> > rebuilding the kernel after a distclean with CONFIG_RANDOMIZE_BASE
> > disabled and CONFIG_GCC_PLUGIN_STACKLEAK enabled. That's what I was
> > expecting the first time and this is the reason why I mentioned it.
> > I've been recompiling too many times, sorry about that.
> >
> > Anyhow, the main issue is the efi_get_random_bytes() fail with
> > CONFIG_GCC_PLUGIN_STACKLEAK enabled, and that's still valid.
>
> Now the configuration that was working on 5.8 fails on 5.11 (haven't
> tried 5.9 or 5.10):
>

What do these version numbers mean? v5.8 vs v5.11??

>  - CONFIG_GCC_PLUGIN_STACKLEAK=n && CONFIG_RANDOMIZE_BASE=y (working on 5.8)
>
> Loading Linux 5.2.11-00015-g0cc3335a89ac ...
> Loading initial ramdisk ...
> EFI stub: Booting Linux Kernel...
> EFI stub: ERROR: efi_get_random_bytes() failed
> EFI stub: ERROR: Failed to relocate kernel

To be honest, this looks like a firmware issue. Its implementation of
EFI_RNG_PROTOCOL is throwing an error.

I guess we could choose to handle this error more gracefully, but the
result above is the expected behavior when EFI_RNG_PROTOCOL throws an
error.

> Error: Image at 00079560000 start failed: Load Error
> Unloading driver at 0x00079560000
>
>
>  - CONFIG_GCC_PLUGIN_STACKLEAK=n && CONFIG_RANDOMIZE_BASE=y && nokaslr
>
> Loading Linux 5.2.11-00015-g0cc3335a89ac ...
> Loading initial ramdisk ...
> EFI stub: Booting Linux Kernel...
> EFI stub: KASLR disabled on kernel command line
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> EFI stub: ERROR: Unable to construct new device tree.
> EFI stub: ERROR: Failed to update FDT and exit boot services
> Error: Image at 00079561000 start failed: Load Error
> Unloading driver at 0x00079561000
>

This looks unrelated. update_fdt() is faling, but we don't know why.
Could you add some debug prints at the various return sites to figure
out why it is failing?

>
> After getting back to the bootloader, loading a known working kernel
> fails (but it works fine after a reboot):
>
> Loading Linux 5.2.8-00016-ga0d5f389a536 ...
>
> Synchronous Exception at 0x00000000B652157C
> PC 0x0000B652157C
> PC 0x0000B65226B4
> PC 0x0000B6522EE0
> PC 0x0000B646BB10
> PC 0x0000B6468580
> PC 0x0000B6524600
> PC 0x0000B6420078
> PC 0x0000B6485CFC
> PC 0x0000B64849B4
> PC 0x0000B648586C
> PC 0x0000B64849B4
> PC 0x0000B6485E68
> PC 0x0000B6485EC0
> PC 0x0000B647C5C8
> PC 0x0000B647C2C8
> PC 0x0000B647C658
> PC 0x0000B647C2C8
> PC 0x0000B64784A8
> PC 0x0000B646F1FC
> PC 0x0000B6485CFC
> PC 0x0000B64849B4
> PC 0x0000B648586C
> PC 0x0000B64849B4
> PC 0x0000B6483C94
> PC 0x0000B64785A4
> PC 0x0000B6478794
> PC 0x0000B647880C
> PC 0x0000B652532C
> PC 0x00003F95B714 (0x00003F952000+0x00009714) [ 1] DxeCore.dll
> PC 0x0000B66CC440 (0x0000B66B9000+0x00013440) [ 2] UiApp.dll
> PC 0x0000B66CCD8C (0x0000B66B9000+0x00013D8C) [ 2] UiApp.dll
> PC 0x0000BF73D880 (0x0000BF729000+0x00014880) [ 3] SetupBrowser.dll
> PC 0x0000BF737BFC (0x0000BF729000+0x0000EBFC) [ 3] SetupBrowser.dll
> PC 0x0000B66C2700 (0x0000B66B9000+0x00009700) [ 4] UiApp.dll
> PC 0x00003F95B714 (0x00003F952000+0x00009714) [ 5] DxeCore.dll
> PC 0x0000BF71AEBC (0x0000BF711000+0x00009EBC) [ 6] BdsDxe.dll
> PC 0x0000BF721C8C (0x0000BF711000+0x00010C8C) [ 6] BdsDxe.dll
> PC 0x00003F95F470 (0x00003F952000+0x0000D470) [ 7] DxeCore.dll
> [ 1] /home/skodde/macchiatobin/edk/uefi-marvell/Build/Armada80x0McBin-AARCH64/RELEASE_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
> [ 2] /home/skodde/macchiatobin/edk/uefi-marvell/Build/Armada80x0McBin-AARCH64/RELEASE_GCC5/AARCH64/MdeModulePkg/Application/UiApp/UiApp/DEBUG/UiApp.dll
> [ 3] /home/skodde/macchiatobin/edk/uefi-marvell/Build/Armada80x0McBin-AARCH64/RELEASE_GCC5/AARCH64/MdeModulePkg/Universal/SetupBrowserDxe/SetupBrowserDxe/DEBUG/SetupBrowser.dll
> [ 4] /home/skodde/macchiatobin/edk/uefi-marvell/Build/Armada80x0McBin-AARCH64/RELEASE_GCC5/AARCH64/MdeModulePkg/Application/UiApp/UiApp/DEBUG/UiApp.dll
> [ 5] /home/skodde/macchiatobin/edk/uefi-marvell/Build/Armada80x0McBin-AARCH64/RELEASE_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
> [ 6] /home/skodde/macchiatobin/edk/uefi-marvell/Build/Armada80x0McBin-AARCH64/RELEASE_GCC5/AARCH64/MdeModulePkg/Universal/BdsDxe/BdsDxe/DEBUG/BdsDxe.dll
> [ 7] /home/skodde/macchiatobin/edk/uefi-marvell/Build/Armada80x0McBin-AARCH64/RELEASE_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
>
>   X0 0xAFAFAFAFAFAFAFAF   X1 0x0000000000008000   X2
> 0xFFFFFFFFFFEFFFFF   X3 0x0000000000008000
>   X4 0x00000000B6530000   X5 0x00000000B652CAE0   X6
> 0x000000007B4FE000   X7 0x00000000B6468258
>   X8 0x0000000000001000   X9 0x0000000000000002  X10
> 0xFFFFFFFFFFFFFFFF  X11 0x00000000B648A182
>  X12 0x00000000B6489FAC  X13 0x00000000B648A15C  X14
> 0x0000000000000014  X15 0x00000000000000FF
>  X16 0x0000000000001510  X17 0x00000000B5A3AA40  X18
> 0x000000000000005C  X19 0x0000000000000401
>  X20 0x0000000000000001  X21 0x000000002D3C2808  X22
> 0x00000000B652CAB0  X23 0x000000006DB08FA4
>  X24 0x0000000000000000  X25 0x000000007A96E000  X26
> 0x000000000000000F  X27 0x0000000000000FFF
>  X28 0x00000000B646B000   FP 0x000000003F950BD0   LR 0x00000000B65226B4
>
>   V0 0x0000000000000000 4049C00000000000   V1 0x0000000000000000
> 3FE0000000000000
>   V2 0x0000000000000000 40D1AD0000000000   V3 0xFFBFDFDF6FEFFFDF
> FFFFFFFFFFEFFED5
>   V4 0xF7FFF5EF41FBEFFF FFFFBFFFFFFFFFBC   V5 0xFFFFFFFFAFB8FFFB
> FFBFFFFFD7FFDDF6
>   V6 0x8BFFB1B7FFFB7FFE F7EFFFFFFFFFFFFF   V7 0x7BFFFFBF55FFD7D7
> FFFFFFFFDB7FFFFF
>   V8 0x0000000000000000 FFFFFFFFFFDDFF9F   V9 0x0000000000000000
> FFFEFBF3976793FF
>  V10 0x0000000000000000 FFFFFFFFFF7FFFDF  V11 0x0000000000000000
> F77FFEFDFFFFF3FF
>  V12 0x0000000000000000 FFFFFFFF3D554FFF  V13 0x0000000000000000
> FFFFFFFFBDE0EABF
>  V14 0x0000000000000000 FFFFFFFFE7EEFFAD  V15 0x0000000000000000
> FFDFFFFF7DFEFFFB
>  V16 0xEEA8FDDFFFFFDFFF FFFFFFFFB7FE56FF  V17 0xBF3B955BDBFFFFFF
> FFF7F9EFFFFFBFFF
>  V18 0x7FBFFDEF7FEBFFAF FFFFFFBF8FEFFFDF  V19 0xFEBFFF7FFFFDFFFF
> FFFFFFFFF5FF7DF5
>  V20 0xFFFFFFFFFFFFFFFF FFFFFFFFC7ED54FF  V21 0xF7FFFEEEFFFFFF7F
> DAFEFFDFFFF7FBF5
>  V22 0xFBE6FFFFFFFFFFFF FFFFFFFFFFFFFFFF  V23 0xFFF5FFFFFF7FFFFF
> FFFFFFFFFFFFFF7F
>  V24 0xFFFFFFFF7FFEFFFF FFFFEF7FFFFFFFFF  V25 0xEB8EFFF7FFFFF7FE
> FFFFFFFFFD7FFFFD
>  V26 0x3FFFFDFFFFFF5FFF FFCF7EFFFFFFFFFF  V27 0xAFBFFEF9FFFFFFFF
> DDFBBFFBBDC4BE5F
>  V28 0xFFFFFFDFFFF7EFDF 9DCD7CF3FFFFFFCF  V29 0xDFFFFFFFFFFFFFFF
> BAF7D6FE7FFFDFFF
>  V30 0xDFF7FFFFFFBFFFFD FFFFDFFFFFFFFFFF  V31 0xCA4F7F47DAF7DBFB
> FFFFFFFFFFF76E77
>
>   SP 0x000000003F950BD0  ELR 0x00000000B652157C  SPSR 0x60000209  FPSR
> 0x00000010
>  ESR 0x96000004          FAR 0xAFAFAFAFAFAFAFBF
>
>  ESR : EC 0x25  IL 0x1  ISS 0x00000004
>
> Data abort: Translation fault, zeroth level
>
> Stack dump:
>   000003F950AD0: 000000003F950C70 000000003F96454C FFFFFFFFFF7FFFDF
> 0000000000000000
>   000003F950AF0: 000000003F950C90 000000003F96454C 000000003F950B60
> 00000000BF6F9EAC
>   000003F950B10: 00000000B91B4398 00000000BE909498 000000003F950B30
> 000000003F95F5D4
>   000003F950B30: 000000003F950B60 000000003F960758 000000003F97407C
> 000000003F95F5D4
>   000003F950B50: 000000003F950B80 D7AB00003F960910 000000003F950B80
> 000000003F9612DC
>   000003F950B70: 000000004201DB9E 000000003F974078 000000003F950BA0
> 000000003F961364
>   000003F950B90: 000000003F974070 0000000000000000 000000003F950BD0
> 000000003F96323C
>   000003F950BB0: 000000003F950BD0 000000003F960B14 000000003F976618
> 000000007B50DFFF
> > 000003F950BD0: 000000003F950C10 00000000B65226B4 00000000B5A3E8A0 00000000B5A3E8A0
>   000003F950BF0: 0000000000000000 00000000000CEC80 0000000000000000
> 0000000000001000
>   000003F950C10: 000000003F950C70 00000000B6522EE0 00000000000CEC80
> 00000000B5A3E8A0
>   000003F950C30: 0000000000000000 0000000000001000 000000007A96E000
> 0000000000000000
>   000003F950C50: 0000000000007FFF 000000000000000F 0000000000001000
> 00000000B646B000
>   000003F950C70: 000000003F950CD0 00000000B646BB10 0000000000000000
> 0000000000000BA1
>   000003F950C90: 0000000000000000 00000000B5A3E8A0 000000007A96E000
> 0000000000000FFF
>   000003F950CB0: 0000000000BA0A00 0000000000000001 0000000000001000
> 000000003F95F5D4
> ASSERT [ArmCpuDxe]
> /home/skodde/macchiatobin/edk/uefi-marvell/ArmPkg/Library/DefaultExceptionHandlerLib/AArch64/DefaultExceptionHandler.c(271):
> ((BOOLEAN)(0==1))
>
>
>  - CONFIG_GCC_PLUGIN_STACKLEAK=y && CONFIG_RANDOMIZE_BASE=n
>
> Loading Linux 5.2.11-00015-g0cc3335a89ac ...
> Loading initial ramdisk ...
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd081]
> [...]
>
> All good here.
>
> This time I did a distclean before each build.
>
>
> Thanks
