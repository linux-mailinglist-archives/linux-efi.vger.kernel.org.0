Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E477282575
	for <lists+linux-efi@lfdr.de>; Sat,  3 Oct 2020 19:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgJCRQ5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 3 Oct 2020 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgJCRQ5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 3 Oct 2020 13:16:57 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C91CC0613E7
        for <linux-efi@vger.kernel.org>; Sat,  3 Oct 2020 10:16:56 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u19so4890560ion.3
        for <linux-efi@vger.kernel.org>; Sat, 03 Oct 2020 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XrZQLqnNMpD94S1G4sNZjRBettAl+4T8HbFLiItGrM=;
        b=eIQ2T+P6x2QPcxs1/JG3GsHnHMYI/bX1FzFRKyAKsYiwwbsyWTEZkpzIEiO4+6gL2y
         WAJlRooHf26F3JF2p9IYXC9Cs7nt5COQRcBYhJJRBHIW7Ap6QDsjGm7aFjkXzfmk6jp3
         0yftHf4IDDNCqkPXtgxTYjWX5S6bSvzH5SXgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XrZQLqnNMpD94S1G4sNZjRBettAl+4T8HbFLiItGrM=;
        b=YVF4D/5L/PLs9h70W1jlOJvEfu9oJyvsbULvnma2OElqOgasft5HovILPKKn3PpIsr
         lKMx99jgfIwQmaupYNOPS9JUi1Nd/qwEK+klCg8yNM46CTYkv2fd3rhRZ29HDfJcnk0d
         z9KPG5D946Eva6yPcnVJe9LASxQjnlqVGA4px2cojaFWS4Toz0InHkKG3gYW9DZjeenH
         ht2+Fr8srKmmI1rElSuvJ1j/VLuEbS8cv867UOPh/MTpFcHYZmtpAs0bGaiqQlCkCLBA
         n3PVGE0ZFaBUs5PXPlgNEOcpTEqt/UmQwOF08+UO2d2VijtrbFmQdRLkFBUHLJ0jvATB
         AxOw==
X-Gm-Message-State: AOAM531Zmu/POUxtdz3vnYt1+gDajtMOL2gtNUPjGvhzVIDJgBZSkl4x
        6BLFUtJRcI5IJLx3WHPE2uo0f11mRrXnCSdVgmJi
X-Google-Smtp-Source: ABdhPJw08RqpDULJ2XMeNRLoZk91UBhQgs+FPEYURdxrpoIj5OTTH9GFtO38kLkwuVFd5mZ+O05/5mnyG4xmbEqI/k0=
X-Received: by 2002:a05:6602:18a:: with SMTP id m10mr5793676ioo.174.1601745415299;
 Sat, 03 Oct 2020 10:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201003063725.8698-1-xypron.glpk@gmx.de> <20201003063725.8698-2-xypron.glpk@gmx.de>
 <CAOnJCU+kit2dHihTad9UPYUmN0+EAdVN9m97ibs=Jnu44Qe_LQ@mail.gmail.com> <0c654506-9bb9-9aee-876e-8c1b8619eb67@gmx.de>
In-Reply-To: <0c654506-9bb9-9aee-876e-8c1b8619eb67@gmx.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sat, 3 Oct 2020 10:16:44 -0700
Message-ID: <CAOnJCU+1vOk3AkGPBah8gPzwf1V1PXUfdxq9+Y17P=F_rOp9hg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: admin-guide: fdt and initrd load in EFI stub
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Oct 3, 2020 at 1:29 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 03.10.20 09:34, Atish Patra wrote:
> > On Fri, Oct 2, 2020 at 11:38 PM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> Describe how a device tree and an initial RAM disk can be passed to the EFI
> >> Boot Stub.
> >>
> >> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> ---
> >> v2:
> >>         mention EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER (thx Atish)
> >> ---
> >>  Documentation/admin-guide/efi-stub.rst | 35 ++++++++++++++++++++++++++
> >>  1 file changed, 35 insertions(+)
> >>
> >> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
> >> index 833edb0d0bc4..4965dec48af4 100644
> >> --- a/Documentation/admin-guide/efi-stub.rst
> >> +++ b/Documentation/admin-guide/efi-stub.rst
> >> @@ -38,6 +38,34 @@ arch/arm/boot/zImage should be copied to the system partition, and it
> >>  may not need to be renamed. Similarly for arm64, arch/arm64/boot/Image
> >>  should be copied but not necessarily renamed.
> >>
> >> +Passing an initial RAM disk to the EFI Boot Stub
> >> +------------------------------------------------
> >> +
> >> +The following means sorted by decreasing priority can be used to provide an
> >> +initial RAM disk to the EFI Boot Stub:
> >> +
> >> +* The firmware may provide a UEFI Load File 2 Protocol. The stub will try to
> >> +  load the RAM disk by calling the LoadFile() service of the protocol using
> >> +  a vendor device path with the vendor GUID
> >> +  5568e427-0x68fc-4f3d-ac74-ca555231cc68.
> >> +* Next the EFI stub will try to load the file indicated by the "initrd=" command
> >> +  line parameter if CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER is enabled.
> >> +* The prior boot stage may pass the location of the initial RAM disk via the
> >> +  "linux,initrd-start" and "linux,initrd-end" properties of the "/chosen" node
> >> +  of the device-tree.
> >> +
> >
> > Should we also specify which method is enabled by default for which
> > ARCH and recommended methods?
>
> The user relevant configuration is not the Linux' defconfig but what the
> distribution maintainer has baked. I doubt mentioning Linux' defaults is
> meaningful here.
>

Yes. But some distribution admin may think that one of these two configs
(initrd or dtb) are not enabled for RISC-V by mistake and enable it in
the distro config.
Ard had suggested that it is best if RISC-V doesn't inherit the legacy options.

> >
> > For example, It's recommended to use the LoadFile method for RISC-V
> > and new ARM systems.
>
> GRUB does not implement the LoadFile2 protocol yet. In U-Boot it is only
> good for testing. I am not aware of usability with unmodified EDK II.
> Why should we recommend anything before building the ecosystem that
> makes it useful?
>
> What is best may depend on the use case. There is nothing insecure in
> passing the initrd via "linux,initrd-start" and "linux,initrd-end" if
> you control the load options.
>
> The EBBR (https://github.com/arm-software/ebbr) might be a better place
> for a recommendation.
>

Agreed.

> > Existing ARM ones will continue to use the initrd argument as that's
> > the method enabled by default.
>
> Only if if the LoadFile2 protocol is not available because that has a
> higher priority for ARM, x86, and RISC-V.
>
> Should I consider my i.mx6 Wandboard Quad bought in 2013 "old" while it
> is running the U-Boot v2020.10-rc5, Linux v5.9-rc7, and Debian testing?
> A distinction between "old" and "new" systems seems irrelevant here. All
> are treated equal by the EFI stub.
>
> >
> >> +The first two items are inhibited by the "noinitrd" command line parameter.
> >> +
> >> +Passing a device-tree to the EFI Boot Stub
> >> +------------------------------------------
> >> +
> >> +A device-tree can be passed to the EFI Boot Stub in decreasing priority using
> >> +
> >> +* command line option dtb=
> >> +* a UEFI configuration table with GUID b1b621d5-f19c-41a5-830b-d9152c69aae0.
> >> +
> >
> > I am just curious. Is there any specific reason why efistub tries to
> > load the dtb from the command line first
> > and loads from the config table only if it fails from the first approach ?
>
> As we disable dtb= in secure boot it would make sense to turn the
> priorities around for non-secure boot too.
>
> But this is beyond the scope of a documentation patch.
>

Yes. I was just using the context to ask the question. I will send a
separate patch
for that.

> Best regards
>
> Heinrich
>
> >
> >> +The command line option is only available if CONFIG_EFI_ARMSTUB_DTB_LOADER=y
> >> +and secure boot is disabled.
> >>
> >>  Passing kernel parameters from the EFI shell
> >>  --------------------------------------------
> >> @@ -46,6 +74,10 @@ Arguments to the kernel can be passed after bzImage.efi, e.g.::
> >>
> >>         fs0:> bzImage.efi console=ttyS0 root=/dev/sda4
> >>
> >> +The "noinitrd" option
> >> +---------------------
> >> +
> >> +The "noinitrd" option stops the EFI stub from loading an initial RAM disk.
> >>
> >>  The "initrd=" option
> >>  --------------------
> >> @@ -98,3 +130,6 @@ CONFIGURATION TABLE.
> >>
> >>  "dtb=" is processed in the same manner as the "initrd=" option that is
> >>  described above.
> >> +
> >> +This option is only available if CONFIG_EFI_ARMSTUB_DTB_LOADER=y and secure
> >> +boot is disabled.
> >> --
> >> 2.28.0
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
>


-- 
Regards,
Atish
