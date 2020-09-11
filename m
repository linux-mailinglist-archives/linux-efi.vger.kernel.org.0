Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6002658F7
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 07:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgIKFyL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 01:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgIKFyJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Sep 2020 01:54:09 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95CFC061573
        for <linux-efi@vger.kernel.org>; Thu, 10 Sep 2020 22:54:08 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so11135323ljg.9
        for <linux-efi@vger.kernel.org>; Thu, 10 Sep 2020 22:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/u/E67lFQ/DRW8U14sqwm3fdUVJhfpCM8MC4WHkqngc=;
        b=VRzd63RIk2KzCwGb6SJFKM8u1pn/we9cUOFTPjLXD25+QnaCPqNZ9N7zkcvwO1RMDs
         p5On/vvc1epy0Ya6XAICLlWMtsuoMJHnLygppcjGZsuBztvgFwrrHXdwqhBS9ewZdGJB
         eVGzCE4avdd2OVsEfIz2Hqb98Geg+5V/2xa3p7BHZoHp00wVfMb9ltSSY8oOGwlTCirx
         nPezCOc+r0/rT1z86p6rgWjzWTGU6vBAogX/7uSiQWPsZRUlxtOoszaUqJoigzAqdScJ
         Nz2HFojc6yFs/K/j0nUzbYq0VGP/lHcoXJ4wsI9ryMt6D2RYBX+dNQQ7m3DGOkv5YFu5
         DpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/u/E67lFQ/DRW8U14sqwm3fdUVJhfpCM8MC4WHkqngc=;
        b=IE21W7kRqmn4pzQVeK88v6kH5nJf6qOMo8m5/NMKmLYBtfWhtGiQRppZJE306k3nKX
         nK/WhJG8Pth7lkECVaarImB1C24VW4lQdDYBZItvvUCVaByqNoSm6PiO7pA8TN9IgJyQ
         34/RNe7zplY8xY2sCI28x4vewW9TwVENsYqLYBamQr5sx73iYYXDHoALREIuLzIvheGC
         2ZroXMQ3OgWUFok5+qyeWeGOWNNBuAXDnORz4hTp7M/7DQFIvhw1WpdcLrYLTSbg/KFP
         yYV24uVtEF1pv1nIMLh619EIo5ztytGgX3+8kvbBAxNb++jqg2N87ysDiyREx31vU/DO
         8vWQ==
X-Gm-Message-State: AOAM530MTYYSzDRbEz15Oi1XIxvFIc3WvIFGpBaoPiu8wKpHxzduEljw
        vdMXFF8cBBIgAR5sIYQEM/3Rfo6p/yZBxHXQ+mE=
X-Google-Smtp-Source: ABdhPJzB7P4hVIsZODE3GP3z4XE1IenGGaYSt/Gp/uvbDgrLe/eHSSQRjMuyM/12SK7lL9aM5an2ARw81VaGRM/XydM=
X-Received: by 2002:a2e:b615:: with SMTP id r21mr105446ljn.341.1599803647065;
 Thu, 10 Sep 2020 22:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
 <20200907170021.GA2284449@rani.riverdale.lan> <CAO18KQg9wLFF8KxZdP4fVv-vk_CpfV+_v38WnCJ-uqEAJ3FNwA@mail.gmail.com>
 <20200908223255.GA276578@rani.riverdale.lan> <CAO18KQgPJu2uZzBuCTsKOJydnbgsNM+EMvcJRDBE3UhSKHtpfw@mail.gmail.com>
 <20200909190038.GA474185@rani.riverdale.lan> <CAO18KQjGdcZD8bts36GuicJO8_iprbryXdh5vM+-GfAbcKV==Q@mail.gmail.com>
 <20200909203830.GA490605@rani.riverdale.lan> <CAMj1kXEAkR9_tN_o0m30e+HY_F_xf3wY_uSDUiWYOkaugcvoNw@mail.gmail.com>
 <DM6PR19MB2636BAC48CDC12B08BF611D3FA270@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20200911000401.GA877093@rani.riverdale.lan>
In-Reply-To: <20200911000401.GA877093@rani.riverdale.lan>
From:   Jacobo Pantoja <jacobopantoja@gmail.com>
Date:   Fri, 11 Sep 2020 07:53:53 +0200
Message-ID: <CAO18KQhucsmzxTXqq9jW53PhaSYmvdE3FmO_Og278XeawBeQTQ@mail.gmail.com>
Subject: Re: EFISTUB arguments in Dell BIOS
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 11 Sep 2020 at 02:04, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Sep 10, 2020 at 08:40:06PM +0000, Limonciello, Mario wrote:
> > > >
> > > > Ok, this is laid out in section 3.1 of the spec which defines the f=
ormat
> > > > of the EFI_LOAD_OPTION descriptor. Dell's BIOS is passing the entir=
e
> > > > descriptor instead of just the OptionalData part.
> > > >
> > > > OptionalData    The remaining bytes in the load option descriptor a=
re a
> > > >                 binary data buffer that is passed to the loaded ima=
ge.
> > > >                 If the field is zero bytes long, a Null pointer is
> > > >                 passed to the loaded image. The number of bytes in
> > > >                 OptionalData can be computed by subtracting the sta=
rting
> > > >                 offset of OptionalData from total size in bytes of =
the
> > > >                 EFI_LOAD_OPTION.
> > > >
> > > > https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.=
pdf
> > > >
> > >
> > > This vaguely rings a bell so I have cc'ed some folks who may have run
> > > into this in the past. Complete thread can be found at [0]
> > >
> >
> > Thanks for sharing the context.  This rings a bell for me with the last=
 time
> > I recall worrying about the Load Options and this commit in shim comes =
to
> > mind:
> >
> > https://github.com/rhboot/shim/commit/3322257e611e2000f79726d295bb4845b=
be449e7
> >
> > It seems to me the shim approach to the problem isn't too big of a deal=
:
> > count the number of strings and if it's greater or equal to 2, then thr=
ow
> > out the first one.  It's also already been used in production code acro=
ss a
> > ton of platforms for several years, so if there was major breakages I w=
ould
> > expect they're covered in that code too by now.
>
> AFAICT, the >=3D 2 check is for seeing if it was invoked by the shell, an=
d
> if so, skipping the first word (which would be the name of the
> executable). For handling the case we're running into here, it's
> checking if loadoptions is valid UCS-2, though its idea of valid seems
> to be that it must consist of characters < 0x100; and if not, trying to
> parse it as a complete EFI_LOAD_OPTION.
>
> >
> > > The firmware is obviously passing the wrong data, and I am reluctant
> > > to quirk this out, since we'd have to interpret the contents of these
> > > UEFI variables, and given the amount of 'value add' by the BIOS
> > > vendors in this area, we may end up breaking things on other
> > > platforms.
> > >
> > > [0] https://lore.kernel.org/linux-
> > > efi/20200909203830.GA490605@rani.riverdale.lan/
> >
> > In the defense of others who have interpreted the spec, as I'm reading =
it I'm
> > not convinced that it explicitly calls out what data should be passed. =
In
> > section 7.4 which explains how LoadImage() behaves.
> >
> > ```
> > Once the image is loaded, firmware creates and returns an EFI_HANDLE th=
at identifies the image and
> > supports EFI_LOADED_IMAGE_PROTOCOL and the EFI_LOADED_IMAGE_DEVICE_PATH=
_PROTOCOL.
> > The caller may fill in the image=E2=80=99s =E2=80=9Cload options=E2=80=
=9D data
> > ```
> >
> > In this context the caller is most likely BDS, and it's "optional" to l=
oad
> > content in.  Within section 9.1 which describes the loaded image protoc=
ol the exact
> > format of the content of "LoadOptions" is not described.  I can see an =
interpretation
> > it should be the full descriptor or that it can be the OptionalData.
>
> LoadImage() is a general library function, it can be called by the
> firmware boot manager, but also by any other EFI application during boot
> services. In this context, LoadOptions is arbitrary data to be filled in
> by the caller of LoadImage() if it wants to.
>
> Section 3.1 is what describes how the Boot#### variables are to be
> handled by the boot manager, and that is explicit about what gets
> passed by the boot manager to the loaded image.
>
> >
> > And actually if you looks in history from EDK code, you can see that it=
's been done that way there too at least at one time:
> > https://github.com/tianocore/edk2/blob/b8d06293caa122f9c3bd2ae32a6c3f79=
0a054e03/IntelFrameworkModulePkg/Library/GenericBdsLib/BdsBoot.c#L2433
> >
>
> I don't think that's passing the whole Boot#### variable. "Option" there
> is a BDS_COMMON_OPTION, and that is created from the Boot#### variable
> using BdsLibVariableToOption, which copies just the OptionalData into
> BDS_COMMON_OPTION.LoadOptions.
>
> https://github.com/tianocore/edk2/blob/b8d06293caa122f9c3bd2ae32a6c3f790a=
054e03/IntelFrameworkModulePkg/Library/GenericBdsLib/BdsMisc.c#L598
>
> >
> > Jacobo,
> >
> > Can you provide some more details on your system that is reproducing
> > this?  Model number, FW version would be useful.
> > The links provided earlier on are on pretty old stuff, so knowing that =
this
> > is a problem on something more current would be good.

Hi Mario, thanks for joining the conversation.
The system in which I'm testing is a Precision T3620 with the very last
firmware 2.15.0 (published in mid 2020). It seems that this is affecting a =
lot
of Dell's BIOSes:
[1]: https://www.dell.com/community/Linux-Developer-Systems/Linux-EFISTUB/t=
d-p/4586378
[2]: https://www.dell.com/community/Laptops-General-Read-Only/Dell-UEFI-imp=
lementation-does-not-support-Linux-Kernel-EFISTUB/td-p/5185272
[3]: https://bbs.archlinux.org/viewtopic.php?pid=3D1753169#p1753169
[4]: https://github.com/xdever/arch-efiboot

> >
> > I guess the other option if Ard chooses not to adopt a quirk for this
> > described behavior is to use shim to load the kernel efistub, and let
> > it do the split for you.

We can circumvent this bug in several ways (using GRUB, packing
kernel plus initrd into a single EFI file, etc.) but honestly, I'd like to =
have
the same loading scheme in all my machines. As Arvin stated, and I share
his statement, section 3.1.3 of the UEFI standard is clear:
"The remaining bytes in the load option descriptor are a binary data buffer
that is passed to the loaded image. If the field is zero bytes long, a NULL
pointer is passed to the loaded image. The number of bytes in OptionalData
can be computed by subtracting the starting offset of OptionalData from tot=
al
size in bytes of the EFI_LOAD_OPTION".
