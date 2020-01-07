Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027161328DB
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 15:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgAGO1g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 09:27:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41057 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGO1g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 09:27:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id k40so45400053qtk.8
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 06:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TRrCHbb8ngaiDk057KUcygXbfXuDhuOmwotGUt9uER0=;
        b=ZTcjtzxd7f6xn3UigEkaozWv1WRw/ikF+rVI9I24DRKqr7U3Vr1N0TRdPo/KfbaPZN
         SUZm7uaq5dHoRBega9jr6VTSs/E9lnCkGBthwktH8U1JnKEoyu4i+C1ABzTlaEU/bZSz
         mSDCRX6Z7ZT4BdB8OxOOmbkOeIcvCQ6M9UShB5LrSaqSpTXL1kmPycghOHQrnQAB/ezD
         MovnxiD1O+mmRR+1GxUtc7M267PJc4tfzOZLiJW+f8Bvf6WldUawyIx7Ub7mQAU5TNqk
         LjdAnKr9BInZxN/mYLH2zx4p0EU5YM9sqXA6Tc3kSr0KVnDj+8BwECuq8A4Wm0qUcWVq
         BC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TRrCHbb8ngaiDk057KUcygXbfXuDhuOmwotGUt9uER0=;
        b=WoNN6rIc+bzUL/EH04v1WeY+WTEHW/Mxg5uK6m9AYHWSVfEIrtRCfuAAfbfxVaSNEL
         xrV/zB0MklTK+b0sqEhQK/NPUgqm4Gk+Z4byUgtAQVd4q6WOjSG9Vw1p8xmav4N4LtTE
         /D9Kk0NGpXiK35GbU1wx3BSyCNTI9tzAEw1hf3CNOoZS+Wx0cZmO0KwjvjXn01VUJGgi
         6Ex5DLcFJ+tEDtWeal8YTL0ry9ksW2fQgGajhH9k9I7mAj/XyVp49ogM7q/Kku7lW6+Z
         hpaVrRXxP/83DYs40hHRKJ4UMXi/hl/EGOQajHpbbOBgkIQ0BAKnIg/y1CUg3MftiQvW
         dDRg==
X-Gm-Message-State: APjAAAV/j/pgcLOYLyznljL4sLmLCTkrSGFxsVOtpaMvZQm4VetTBacv
        ISQCjq9WbyI/L3RMRl1cnJc=
X-Google-Smtp-Source: APXvYqycoX/vH9maWesy1F5ujj0veXkawVjn/YY+HJ6lit+jJ+qY8D7xmYSWFBseK3ugEDf2gs/JKQ==
X-Received: by 2002:ac8:604b:: with SMTP id k11mr79849202qtm.372.1578407255182;
        Tue, 07 Jan 2020 06:27:35 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d9sm24810467qth.34.2020.01.07.06.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:27:34 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 7 Jan 2020 09:27:33 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
Message-ID: <20200107142732.GB652888@rani.riverdale.lan>
References: <20200107135500.644618-1-nivedita@alum.mit.edu>
 <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
 <CAKv+Gu_+a4igmTHhMgg17B2oH5f=KRM2g2CBGy+LnF5wYsarng@mail.gmail.com>
 <20200107142125.GA652888@rani.riverdale.lan>
 <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 07, 2020 at 03:24:18PM +0100, Ard Biesheuvel wrote:
> On Tue, 7 Jan 2020 at 15:21, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Jan 07, 2020 at 03:13:46PM +0100, Ard Biesheuvel wrote:
> > > On Tue, 7 Jan 2020 at 15:01, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Tue, 7 Jan 2020 at 14:55, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > This series performs GOT relocation before calling into C code for the
> > > > > EFI stub. While the stub does not currently require GOT relocation, it's
> > > > > quite easy to introduce code that will use the GOT on old toolchains,
> > > > > but not recent ones, which can lead to unexpected issues.
> > > > >
> > > > > This is based on
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
> > > > >
> > > > > with commit 4169bb99cd70 ("efi/libstub/x86: use mandatory 16-byte stack
> > > > > alignment in mixed mode") reverted, as it caused a crash in mixed mode.
> > > > >
> > > >
> > > > Hi Arvind,
> > > >
> > > > I appreciate the effort, but I really don't think this is a good idea.
> > > >
> > > > A GOT is completely pointless in bare metal code, and fortunately,
> > > > modern toolchains make it easier to suppress GOT entries from being
> > > > emitted. So instead of adding back asm code that I just removed, I
> > > > think it would be better to investigate whether we can get rid of the
> > > > GOT entirely.
> > > >
> > >
> > > With the following added to arch/x86/boot/compressed/vmlinux.lds.S,
> > > the 64-bit kernel already links without error.
> > >
> > > ASSERT (_got == _egot, "GOT entries detected");
> > >
> > > The 32-bit kernel produces a GOT with 3 entries: I'm trying to narrow
> > > down where they come from.
> > >
> > >
> >
> > With modern toolchain, 32-bit compressed kernel doesn't actually use the
> > GOT, however unlike 64-bit, the linker still emits a GOT with the three
> > reserved entries.
> >
> > The rest of the early boot code (after EFI stub) does generate
> > R_386_GOT32(X) relocations, so we need to use a GOT anyway to cater for
> > older linkers. Having a build-time check that the EFI stub code does not
> > have any such relocations might be possible, but it seems easier to just
> > do the GOT processing for it as well.
> 
> Not necessarily. My tests with binutils 2.24 building 32-bit suggest
> that using 'hidden' visibility is often sufficient to get rid of them.

Ah. Could we just add -fvisibility=hidden to the boot/compressed cflags?
If that works with old toolchain, we could just get rid of the whole
adjust_got thing.
