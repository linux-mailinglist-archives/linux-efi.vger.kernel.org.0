Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C6C281F04
	for <lists+linux-efi@lfdr.de>; Sat,  3 Oct 2020 01:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgJBX06 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Oct 2020 19:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBX0z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Oct 2020 19:26:55 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30612C0613E2
        for <linux-efi@vger.kernel.org>; Fri,  2 Oct 2020 16:26:54 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id o18so2763816ilg.0
        for <linux-efi@vger.kernel.org>; Fri, 02 Oct 2020 16:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fv3qdMRDaLBfogWRJHhoCXkOBnI4/36vTO6sbBXAcnw=;
        b=eCa/98FCnp4UTR3aXlWZjL/eg4dh+N+ts98vxLiuv2sPK4mJUCce0x/JU5ChW0a/Oy
         mwNP5uFItwXsMvCUwBEjoi4tOhFrA9EqH518+sPZceUxeWmIbqz4/Z792BXmDne4ugT+
         GRHOHscqijBnPBF+TDWQqFJoCCuFsIzAo1E6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fv3qdMRDaLBfogWRJHhoCXkOBnI4/36vTO6sbBXAcnw=;
        b=L5A/NT0OkRZOwh6y5Xzck9BBYJ2c9WPjbxW2MuZRgP11pGLHF/VYRpCeICRfkjRsi9
         6vlNyC5Rv8OhczD0NEq99t5LAeuETFiPDRm14P/uxTVL7vSFj+t+7Xm8kMFh62AwNg1I
         JzeDz0i81oxa569fUKWUjJ9u5xzEPQN8Z7DtBJmBmLpJtPAgHP3bya+fRMHh/TO97ECk
         4D9Zug+OuLcWiiIOXhtp+alpMmxbux7yI8mhG+nbPJqzVp59AeBOAIUGdP5D9qN6F48t
         Oa5yRjd/gSadHHPi4jmGmS3vuqQII8IZY3uBY2NOaNDxLw0zZIZanOYE/VVk7Yl2vjsi
         LgiA==
X-Gm-Message-State: AOAM533uPRpMuNb3nmrotJoNxBtcWvN7UhXcnOluBIkJH2o5fYGoOE3N
        lLvVCFPI67rB6p9c+ytVljrtO+tOEw14c5coJDmM
X-Google-Smtp-Source: ABdhPJyDR2maUdIOnSOJWap/wYHYT+2zF9fyvJxRajeKbF/5ZCkey9h7TlhoaCXDUZOT/jc0S6kNr0TPct4RQVS58ow=
X-Received: by 2002:a92:512:: with SMTP id q18mr3453000ile.147.1601681213180;
 Fri, 02 Oct 2020 16:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201002171112.22738-1-xypron.glpk@gmx.de> <CAMj1kXHsGcAX-DqfcpgxzZY3M+JzY-Ef9OdJ+JdysNnx1fK6zg@mail.gmail.com>
 <9899cc58-c856-38ca-3a89-4b545c973a4f@gmx.de> <CAMj1kXGBGb5yU0XH3oBJfTUDiFzhqa8ihyYo=n_qyj1VcCs5zA@mail.gmail.com>
 <5c9370aa-aaba-bc2b-1924-2c691164ff69@gmx.de>
In-Reply-To: <5c9370aa-aaba-bc2b-1924-2c691164ff69@gmx.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 2 Oct 2020 16:26:42 -0700
Message-ID: <CAOnJCU+Sr2v4po98RrEC2=HyaxnmRzZy9Xka6aYjr1WZtBiCVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs: admin-guide: fdt and initrd load in EFI stub
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 2, 2020 at 1:04 PM Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
>
> On 10/2/20 9:21 PM, Ard Biesheuvel wrote:
> > On Fri, 2 Oct 2020 at 21:14, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
> >>
> >> On 10/2/20 7:21 PM, Ard Biesheuvel wrote:
> >>> Hi Heinrich,
> >>>
> >>> Thanks for documenting this.
> >>>
> >>>
> >>> On Fri, 2 Oct 2020 at 19:11, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
> >>>>
> >>>> Describe how a device tree and an initial RAM disk can be passed to =
the EFI
> >>>> Boot Stub.
> >>>>
> >>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>> ---
> >>>>  Documentation/admin-guide/efi-stub.rst | 35 +++++++++++++++++++++++=
+++
> >>>>  1 file changed, 35 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/=
admin-guide/efi-stub.rst
> >>>> index 833edb0d0bc4..86f50a33884c 100644
> >>>> --- a/Documentation/admin-guide/efi-stub.rst
> >>>> +++ b/Documentation/admin-guide/efi-stub.rst
> >>>> @@ -38,6 +38,34 @@ arch/arm/boot/zImage should be copied to the syst=
em partition, and it
> >>>>  may not need to be renamed. Similarly for arm64, arch/arm64/boot/Im=
age
> >>>>  should be copied but not necessarily renamed.
> >>>>
> >>>> +Passing an initial RAM disk to the EFI Boot Stub
> >>>> +------------------------------------------------
> >>>> +
> >>>> +The following means sorted by decreasing priority can be used to pr=
ovide an
> >>>> +initial RAM disk to the EFI Boot Stub:
> >>>> +
> >>>> +* The firmware may provide a UEFI Load File 2 Protocol. The stub wi=
ll try to
> >>>> +  load the RAM disk by calling the LoadFile() service of the protoc=
ol using
> >>>> +  a vendor device path with the vendor GUID
> >>>> +  5568e427-0x68fc-4f3d-ac74-ca555231cc68.
> >>>> +* Next the EFI stub will try to load the file indicated by the "ini=
trd=3D" command
> >>>> +  line parameter.

This is only applicable if EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER is enable=
d.
Should we specify that as well?

> >>>> +* The prior boot stage may pass the location of the initial RAM dis=
k via the
> >>>> +  "linux,initrd-start" and "linux,initrd-end" properties of the "/c=
hosen" node
> >>>> +  of the device-tree.
> >>>> +
> >>>
> >>> On x86, the boot_params struct is used to pass the address and size o=
f
> >>> the initrd in memory. Maybe include that for completeness?
> >>
> >> On x86 boot_params is set in function efi_pe_entry() after loading the
> >> file indicated by the initrd=3D command line.
> >>
> >> boot_params is not accessible by a caller of the EFI stub but is a
> >> structure used at the interface between EFI stub and main kernel. This
> >> interface is not in the scope of the admin-guide.
> >>
> >
> >  I don't see the difference between dt for arm and boot_params for
> > x86. Both can be provided by the bootloader, and will be created from
> > scratch by the efi stub if not. They both carry the command line and
> > address and size of the initrd, and the efi stub will load  the initrd
> > and update this Information, or pass it on unmodified if the
> > bootloader already loaded the initrd into memory.
>
> "The Linux kernel user=E2=80=99s and administrator=E2=80=99s guide" is no=
t targeted for
> developers.
>
> All I have described in this patch are interfaces between Linux and the
> prior boot stage when using the EFI stub. It does not cover how the EFI
> stub communicates with main Linux.
>
> I may already have put too much technical detail here considering the
> audience.
>
> To my knowledge boot_params is not an inbound interface parameter of the
> EFI stub.
>
> Is it of interests for administrators and users to know that the EFI
> stub calls the legacy entry point of Linux? If yes, we should point to
> the documentation of the legacy entry point for all architectures:
>
> https://www.kernel.org/doc/html/latest/x86/boot.html#bit-boot-protocol
> https://www.kernel.org/doc/html/latest/x86/boot.html#id1
> https://www.kernel.org/doc/html/latest/arm/booting.html
> https://www.kernel.org/doc/html/latest/arm64/booting.html
>
> I could not find an appropriate chapter for RISC-V in
> https://www.kernel.org/doc/html/latest/riscv/index.html.
>

Unfortunately, there is no booting document for RISC-V yet. It has
been discussed many times but no patch yet.
If you want to take a stab at it, that would be great.


> As the interface between the EFI stub and main Linux is not exposed to
> the outside world and may rightfully change without notice I suggest to
> not mention it in the admin guide.
>
> Best regards
>
> Heinrich
>
> >
> >
> >
> >> The main Linux entry point is already described in
> >> Documentation/x86/boot.rst and ./Documentation/x86/zero-page.rst.
> >>
> >> We can add Sphinx style documentation for function efi_pe_entry()
> >> mentioning that it fills in boot_params.
> >> drivers/firmware/efi/libstub/x86-stub.c then can be added to
> >> Documentation/driver-api/firmware/efi/index.rst in an x86 chapter. But
> >> these will be separate patches.
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>>
> >>>> +The first two items are inhibited by the "noinitrd" command line pa=
rameter.
> >>>> +
> >>>
> >>> Interesting. Are you saying noinitrd is ignored by the kernel itself?
> >>>
> >>> Looking at the code, it might only work for preventing the load of ol=
d
> >>> style initrd ramdisks, whereas initramfs images are handled
> >>> separately.
> >>>
> >>> This is something that we should probably fix one way or the other.
> >>>
> >>>
> >>>> +Passing a device-tree to the EFI Boot Stub
> >>>> +------------------------------------------
> >>>> +
> >>>> +A device-tree can be passed to the EFI Boot Stub in decreasing prio=
rity using
> >>>> +
> >>>> +* command line option dtb=3D
> >>>> +* a UEFI configuration table with GUID b1b621d5-f19c-41a5-830b-d915=
2c69aae0.
> >>>> +
> >>>> +The command line option is only available if CONFIG_EFI_ARMSTUB_DTB=
_LOADER=3Dy
> >>>> +and secure boot is disabled.
> >>>>
> >>>>  Passing kernel parameters from the EFI shell
> >>>>  --------------------------------------------
> >>>> @@ -46,6 +74,10 @@ Arguments to the kernel can be passed after bzIma=
ge.efi, e.g.::
> >>>>
> >>>>         fs0:> bzImage.efi console=3DttyS0 root=3D/dev/sda4
> >>>>
> >>>> +The "noinitrd" option
> >>>> +---------------------
> >>>> +
> >>>> +The "noinitrd" option stops the EFI stub from loading an initial RA=
M disk.
> >>>>
> >>>>  The "initrd=3D" option
> >>>>  --------------------
> >>>> @@ -98,3 +130,6 @@ CONFIGURATION TABLE.
> >>>>
> >>>>  "dtb=3D" is processed in the same manner as the "initrd=3D" option =
that is
> >>>>  described above.
> >>>> +
> >>>> +This option is only available if CONFIG_EFI_ARMSTUB_DTB_LOADER=3Dy =
and secure
> >>>> +boot is disabled.
> >>>> --
> >>>> 2.28.0
> >>>>
> >>
>


--
Regards,
Atish
