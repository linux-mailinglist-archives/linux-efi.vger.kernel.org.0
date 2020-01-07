Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 330341328D2
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgAGOYb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 09:24:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35142 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgAGOYb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 09:24:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so54122524wro.2
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6xFi4vR+XaaPXtHFje7XmEW1aEMz02Dz7B09swL07g=;
        b=q05BVGBmgebM0Dapp+vCe89WZzQc7m+3D+oz3mEYIl4gnApu9V8wpwO8zt+owL1UKL
         vM74iwhl4Z9PU4MKGeAdlFM34pbgJtFl/TKuZE96WbEri3nWLYROD+0DbhaNiEfXy9WI
         QQo9uW1sWjikGNncjP8jujK3PMz9dRii6mzzrbwpY5FFciX9t07Tse1HxKY/SO8JA0ZQ
         JziWxDnhT7gMVFs4bCv8urXAu2vFk5JcGXHrcW+maXXyIC9Cj/B/o5pcFNNeUpyD50Mw
         imWmzfUV2aZ+dlNI55sL3wC/EaUYDWIrAPn4beWJQ5Xu/xefvBWu88htM0IzaS0x6VVH
         w7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6xFi4vR+XaaPXtHFje7XmEW1aEMz02Dz7B09swL07g=;
        b=CQSRZBw96zTJdFNAvUnKH3VFk5c0bshHgCt5WxHgAGZ/HzjtgFmBllEe8fWlqs/HSU
         WpF6b0rJMTtXbo+UeHG0tBTPCmNsH5aaUFmZuoUW6oRw5TASjwCyGb2j9Kj67aBGNxH0
         MONBeFgQmbAunK8HQZY/Vh12rz5yVtiQBXUm2LPzT+9GAgtX5hhuPHZg8Iv2Yz576Ub0
         yoKgOKeE5xwmhJREHsiBslHZtwHKIq8vKbUZOFJBkxygkZjjv+vyQjyoTlYOcj5APcTX
         4/10QsI6zeLarq6ilKAG8TMqGIDkMh6aTf/hxd1KprEjZIDID1MxFNZ5XpEqsbHdfY5z
         w8/A==
X-Gm-Message-State: APjAAAUbAuzEKMOYCOP1j3MbYIhRaLlYx7MVkBdV+rIkhZi/Hv+F35u4
        yleWj4e2zfZXJgZs6cU6rIhRmpILHLxTQxYKegDseQ==
X-Google-Smtp-Source: APXvYqxScCLCZmjdijdWCmwxwyGRt9HZPRV7z80tAl5NH1sIWq1NPPF+KPS9aTPbH4t7PcYtPjsdrjLCFgwB23pwsvE=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr102950454wrr.32.1578407068818;
 Tue, 07 Jan 2020 06:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20200107135500.644618-1-nivedita@alum.mit.edu>
 <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
 <CAKv+Gu_+a4igmTHhMgg17B2oH5f=KRM2g2CBGy+LnF5wYsarng@mail.gmail.com> <20200107142125.GA652888@rani.riverdale.lan>
In-Reply-To: <20200107142125.GA652888@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Jan 2020 15:24:18 +0100
Message-ID: <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Jan 2020 at 15:21, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Jan 07, 2020 at 03:13:46PM +0100, Ard Biesheuvel wrote:
> > On Tue, 7 Jan 2020 at 15:01, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Tue, 7 Jan 2020 at 14:55, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > This series performs GOT relocation before calling into C code for the
> > > > EFI stub. While the stub does not currently require GOT relocation, it's
> > > > quite easy to introduce code that will use the GOT on old toolchains,
> > > > but not recent ones, which can lead to unexpected issues.
> > > >
> > > > This is based on
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
> > > >
> > > > with commit 4169bb99cd70 ("efi/libstub/x86: use mandatory 16-byte stack
> > > > alignment in mixed mode") reverted, as it caused a crash in mixed mode.
> > > >
> > >
> > > Hi Arvind,
> > >
> > > I appreciate the effort, but I really don't think this is a good idea.
> > >
> > > A GOT is completely pointless in bare metal code, and fortunately,
> > > modern toolchains make it easier to suppress GOT entries from being
> > > emitted. So instead of adding back asm code that I just removed, I
> > > think it would be better to investigate whether we can get rid of the
> > > GOT entirely.
> > >
> >
> > With the following added to arch/x86/boot/compressed/vmlinux.lds.S,
> > the 64-bit kernel already links without error.
> >
> > ASSERT (_got == _egot, "GOT entries detected");
> >
> > The 32-bit kernel produces a GOT with 3 entries: I'm trying to narrow
> > down where they come from.
> >
> >
>
> With modern toolchain, 32-bit compressed kernel doesn't actually use the
> GOT, however unlike 64-bit, the linker still emits a GOT with the three
> reserved entries.
>
> The rest of the early boot code (after EFI stub) does generate
> R_386_GOT32(X) relocations, so we need to use a GOT anyway to cater for
> older linkers. Having a build-time check that the EFI stub code does not
> have any such relocations might be possible, but it seems easier to just
> do the GOT processing for it as well.

Not necessarily. My tests with binutils 2.24 building 32-bit suggest
that using 'hidden' visibility is often sufficient to get rid of them.
