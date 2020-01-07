Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105FE1328E2
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 15:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgAGO2o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 09:28:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50388 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgAGO2o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 09:28:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so19193051wmb.0
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 06:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fM0Y99fzoh1sWdNrGSXKq5Ut8HHLPX/Xb2R4iMZIVo=;
        b=onsrFG03OCUWJUquMKAWv/FfZ65pB1yv69irtoceNF+4Ki8cx2YjWwPUojSnbOwmhY
         YQ4aBDeJnlazAteYLaaYw3hLciBjOKjSSiZvoR2zz93EhhCQofPdJy+2O09YYZT4FKxI
         AL40ApowCfK1q5n3DJkwbFziGXyFgyIAMnt+WxISH45IzQZlB+9P9P0m7kWmdAvWaEcn
         RsPbbKsHfY5IXysQHcb89IPypcHXXLK4RBMl7jSg1Za/vqg507nswMHas2nXmEvTdqC/
         zLFgtIzMHIcJHEnsd/DP2ywmg7hQGGnoul8w2gp8tJ40ufPF9/nBrE5UgW1mpx0skwsJ
         m3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fM0Y99fzoh1sWdNrGSXKq5Ut8HHLPX/Xb2R4iMZIVo=;
        b=tx2o9ZTaUZBM2tn3HMHhRCCX5XwXHtq9I02SY0NHUShszexlsV5an+En4D7LuRg+gO
         j3KX9iO98iiKaTzf6cXS4feHBENKvUM83CCImGWBPGgWfI9TsB3M2lPWBo11yI1zqG0y
         w2g8Hf1Zu1dbGjeH0HqZbIfF/qC9bYdJq4k06s6lfNcQ68omVigrpYaXE1h86gtpCLHK
         ka1RMsNl/iunNqZjuvZfAdVI/ZTeLqf9fEooEajrcW4akTUOFTbCaaiQReLDKZY3obMQ
         iuDF/is05nDVUfZLk8NytTavQfWXRkZEhF+7s9BTkjCh5BtwtXVetTUDrcpIIBAaI8Ho
         Rf7Q==
X-Gm-Message-State: APjAAAWX+iKXShSbk6Vgm5qqX1opoe+QKjWSWnX4JThu7MUqAZNyTfKJ
        zSZwE22/m7dJ3iaDjfKjMP+x70lCTx21z00ic5n09g==
X-Google-Smtp-Source: APXvYqxbr/RgNesoMBegxeDY1PHKOsU9CKoyFy97IjNEaa3Ltyjwdib34VmytAPVCbUlg8YyvwRhzFoIOBkA6a/16BA=
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr40901001wme.148.1578407322563;
 Tue, 07 Jan 2020 06:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20200107135500.644618-1-nivedita@alum.mit.edu>
 <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
 <CAKv+Gu_+a4igmTHhMgg17B2oH5f=KRM2g2CBGy+LnF5wYsarng@mail.gmail.com>
 <20200107142125.GA652888@rani.riverdale.lan> <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
 <20200107142732.GB652888@rani.riverdale.lan>
In-Reply-To: <20200107142732.GB652888@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Jan 2020 15:28:31 +0100
Message-ID: <CAKv+Gu8v-5DXWh5ZaY0omrVNh46TEourpcf2Hv3TrsbCUtLFng@mail.gmail.com>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Jan 2020 at 15:27, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Jan 07, 2020 at 03:24:18PM +0100, Ard Biesheuvel wrote:
> > On Tue, 7 Jan 2020 at 15:21, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, Jan 07, 2020 at 03:13:46PM +0100, Ard Biesheuvel wrote:
> > > > On Tue, 7 Jan 2020 at 15:01, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > > >
> > > > > On Tue, 7 Jan 2020 at 14:55, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > >
> > > > > > This series performs GOT relocation before calling into C code for the
> > > > > > EFI stub. While the stub does not currently require GOT relocation, it's
> > > > > > quite easy to introduce code that will use the GOT on old toolchains,
> > > > > > but not recent ones, which can lead to unexpected issues.
> > > > > >
> > > > > > This is based on
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
> > > > > >
> > > > > > with commit 4169bb99cd70 ("efi/libstub/x86: use mandatory 16-byte stack
> > > > > > alignment in mixed mode") reverted, as it caused a crash in mixed mode.
> > > > > >
> > > > >
> > > > > Hi Arvind,
> > > > >
> > > > > I appreciate the effort, but I really don't think this is a good idea.
> > > > >
> > > > > A GOT is completely pointless in bare metal code, and fortunately,
> > > > > modern toolchains make it easier to suppress GOT entries from being
> > > > > emitted. So instead of adding back asm code that I just removed, I
> > > > > think it would be better to investigate whether we can get rid of the
> > > > > GOT entirely.
> > > > >
> > > >
> > > > With the following added to arch/x86/boot/compressed/vmlinux.lds.S,
> > > > the 64-bit kernel already links without error.
> > > >
> > > > ASSERT (_got == _egot, "GOT entries detected");
> > > >
> > > > The 32-bit kernel produces a GOT with 3 entries: I'm trying to narrow
> > > > down where they come from.
> > > >
> > > >
> > >
> > > With modern toolchain, 32-bit compressed kernel doesn't actually use the
> > > GOT, however unlike 64-bit, the linker still emits a GOT with the three
> > > reserved entries.
> > >
> > > The rest of the early boot code (after EFI stub) does generate
> > > R_386_GOT32(X) relocations, so we need to use a GOT anyway to cater for
> > > older linkers. Having a build-time check that the EFI stub code does not
> > > have any such relocations might be possible, but it seems easier to just
> > > do the GOT processing for it as well.
> >
> > Not necessarily. My tests with binutils 2.24 building 32-bit suggest
> > that using 'hidden' visibility is often sufficient to get rid of them.
>
> Ah. Could we just add -fvisibility=hidden to the boot/compressed cflags?
> If that works with old toolchain, we could just get rid of the whole
> adjust_got thing.

Unfortunately, the command line option implements a weaker form of
visibility than the pragma, so it probably comes down to setting the
pragma in a .h file that gets -include'd via the command line so it is
guaranteed to be seen first.
