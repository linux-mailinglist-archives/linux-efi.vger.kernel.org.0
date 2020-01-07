Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963021328B9
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 15:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAGOV3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 09:21:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42283 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgAGOV3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 09:21:29 -0500
Received: by mail-qt1-f193.google.com with SMTP id j5so45373573qtq.9
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 06:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=80kkBKlJ9feV1DHtgwYewELKrHJqIdE6PKXcmabHy/g=;
        b=q6us97leMvSSRsTEti6oEhONKCgexrUVJdTNzwnEjGMY9135Dvqz6GYrpgb+9EkO3j
         oj0gOzGC02I1TtmJkFBQsGwMQMU5t2uk61BY4Uv2iO8DZxWUZQ7AG9dQ3zT0McaIepP0
         1zW4zkzC9wioHsTysaXwpAul7PvcedLJF9P0JSAtmgAn7zVf3Rob/DobtCAxrQcfmQfx
         rbWYlm0jglQb+XGUMsL8H6v5Oxt9K5XKn3ItZz2H+6yzjQq5TDEU1/phyN/V0GYXM5xw
         4mrUsiWTONazheSw6fzpBUedaEAY0CDf4JnpWIr/dZth+uFVilKKxHiCoa6U4u7SLUNi
         vbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=80kkBKlJ9feV1DHtgwYewELKrHJqIdE6PKXcmabHy/g=;
        b=aLvu493boOlnCEsy5ZCnXvnFSPi9MMJEAb7j+qvYHonUsLpbcAcfehMCHA1zGLuZIV
         zhpBgQTIjn7HzaUCwW7XYlw6HewEI2fPC0jg+d1ZMon72//Q12w7HrBgiYDmCvNDt6Mz
         Hq31DPjUMP8Yh/PCDsPs+/F6wQjPl4WB1xJO2btD+WDlnQUa0d4VMlIuLlIPurvk/O8E
         quWgCCcY8gokxJGh4SKM8S6l8UWyHdqqcQkmMqRu16lYw5qRBx9mqleWwdZb6RsRgPUF
         L1jiIhrkv4k28ztk2Q4FDvZ19ReETirZVJC4zlbPkShdZUy5RvweinYk45VNKf1rLpSN
         uMxA==
X-Gm-Message-State: APjAAAWN4ExB0QdJINSJT/2sYlX3GbaJbpAXpXrWtuED/1tWcZMOrkzQ
        DntFVaDNGFi/F7XG6+Kt07Q=
X-Google-Smtp-Source: APXvYqx2mfwx3f0vQgiUGpBH0AW2QMot9xap2Ssr3OZ/zxlI2VDOkx2kgm3VdfK1kMS8l+MpvxF/zA==
X-Received: by 2002:ac8:32c6:: with SMTP id a6mr78624345qtb.11.1578406888297;
        Tue, 07 Jan 2020 06:21:28 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 13sm22413635qke.85.2020.01.07.06.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:21:27 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 7 Jan 2020 09:21:26 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
Message-ID: <20200107142125.GA652888@rani.riverdale.lan>
References: <20200107135500.644618-1-nivedita@alum.mit.edu>
 <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
 <CAKv+Gu_+a4igmTHhMgg17B2oH5f=KRM2g2CBGy+LnF5wYsarng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_+a4igmTHhMgg17B2oH5f=KRM2g2CBGy+LnF5wYsarng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 07, 2020 at 03:13:46PM +0100, Ard Biesheuvel wrote:
> On Tue, 7 Jan 2020 at 15:01, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Tue, 7 Jan 2020 at 14:55, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > This series performs GOT relocation before calling into C code for the
> > > EFI stub. While the stub does not currently require GOT relocation, it's
> > > quite easy to introduce code that will use the GOT on old toolchains,
> > > but not recent ones, which can lead to unexpected issues.
> > >
> > > This is based on
> > > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
> > >
> > > with commit 4169bb99cd70 ("efi/libstub/x86: use mandatory 16-byte stack
> > > alignment in mixed mode") reverted, as it caused a crash in mixed mode.
> > >
> >
> > Hi Arvind,
> >
> > I appreciate the effort, but I really don't think this is a good idea.
> >
> > A GOT is completely pointless in bare metal code, and fortunately,
> > modern toolchains make it easier to suppress GOT entries from being
> > emitted. So instead of adding back asm code that I just removed, I
> > think it would be better to investigate whether we can get rid of the
> > GOT entirely.
> >
> 
> With the following added to arch/x86/boot/compressed/vmlinux.lds.S,
> the 64-bit kernel already links without error.
> 
> ASSERT (_got == _egot, "GOT entries detected");
> 
> The 32-bit kernel produces a GOT with 3 entries: I'm trying to narrow
> down where they come from.
> 
> 

With modern toolchain, 32-bit compressed kernel doesn't actually use the
GOT, however unlike 64-bit, the linker still emits a GOT with the three
reserved entries.

The rest of the early boot code (after EFI stub) does generate
R_386_GOT32(X) relocations, so we need to use a GOT anyway to cater for
older linkers. Having a build-time check that the EFI stub code does not
have any such relocations might be possible, but it seems easier to just
do the GOT processing for it as well.
