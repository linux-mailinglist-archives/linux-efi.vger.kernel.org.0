Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC8113288B
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 15:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgAGOOB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 09:14:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35970 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGOOB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 09:14:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so54124186wru.3
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 06:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x8VlU2NEbg3UY0tduTeudov8UnqBVPGWfCHW9YzhxsU=;
        b=oVoXT8i+59hpPmg2hhx3V7aLUhwPYxrgMMAAuY7ZJVZkuDO+EDEe/lhEHPORb7osOS
         X/CQdRwDql78SRg/i+822i7sAHk36eD9sfFF7w5C34uZMFK+KmDR+Uh54w92Fb+sZ7PJ
         8/tXlsVFuNmEWpMkkbTsnostKjrwthfhlYdilK1QaFfCu9xBAwQacIJrZFSMsRMpfE5v
         JXkAAh1QyFWwPjNtwmyniArM/BH5e16n7WOy/5BBf/eDk3wezIdwddnifcZ+7p097fO2
         Rgw3UbM0YBzrTxdF3QF8UioF4y/MwetwqIiUCDbnsPhttLjN6uLhqV7Lbq17eokr8X8N
         sPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8VlU2NEbg3UY0tduTeudov8UnqBVPGWfCHW9YzhxsU=;
        b=JCYZOnbtd1y6+Emt+0/59tPMvlZvl7UbgDXuoUWXXPsPWIhl9c3KeuWEThqlweg+T6
         4fMCG0Z2YNODEj+6d7YlRLqUCTBPVvcSuewYO0vmExJcKlBX1z6R2rul8NttWtV839u+
         iiAexFYyR4pS15GX+6P4m3rnFvx4mK1kgdl13D9tQtvRjiVbAqGB7HkuW9vvHE6H4VGi
         FpcV1wFHdAAi1iOLPqjTAmimTytpYJE+RcfLKJ8byIZH+A36Pu+9S+aaIqmvpVSAV4ZE
         QOdmm+9sCk76dS/yZzCi7AmUQdRQb8U613O7/05kfqYCIcdSyNfzayi7+QOO3qel+Kdl
         x+4Q==
X-Gm-Message-State: APjAAAVSgBEH54mV/ROdOSrdB2atCSc9nwL+znPHkweB75Nv2h4MgYC8
        bhbZ90Ifu3UVY5mDgTCD12OmKFahg5eOTlQRasyfrKpcKTLWrg==
X-Google-Smtp-Source: APXvYqwtAxDOCIZWNRekZ010aVDEOegJYCydUFiFNEz+DeskLa2VE/vCi5j1QxxS3lHgIp7VXciebwdjosNOK+5ynGU=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr97113107wrj.325.1578406437849;
 Tue, 07 Jan 2020 06:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20200107135500.644618-1-nivedita@alum.mit.edu> <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
In-Reply-To: <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Jan 2020 15:13:46 +0100
Message-ID: <CAKv+Gu_+a4igmTHhMgg17B2oH5f=KRM2g2CBGy+LnF5wYsarng@mail.gmail.com>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Jan 2020 at 15:01, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 7 Jan 2020 at 14:55, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > This series performs GOT relocation before calling into C code for the
> > EFI stub. While the stub does not currently require GOT relocation, it's
> > quite easy to introduce code that will use the GOT on old toolchains,
> > but not recent ones, which can lead to unexpected issues.
> >
> > This is based on
> > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
> >
> > with commit 4169bb99cd70 ("efi/libstub/x86: use mandatory 16-byte stack
> > alignment in mixed mode") reverted, as it caused a crash in mixed mode.
> >
>
> Hi Arvind,
>
> I appreciate the effort, but I really don't think this is a good idea.
>
> A GOT is completely pointless in bare metal code, and fortunately,
> modern toolchains make it easier to suppress GOT entries from being
> emitted. So instead of adding back asm code that I just removed, I
> think it would be better to investigate whether we can get rid of the
> GOT entirely.
>

With the following added to arch/x86/boot/compressed/vmlinux.lds.S,
the 64-bit kernel already links without error.

ASSERT (_got == _egot, "GOT entries detected");

The 32-bit kernel produces a GOT with 3 entries: I'm trying to narrow
down where they come from.


>
>
>
> > Arvind Sankar (3):
> >   x86/boot/compressed/64: Make adjust_got easier to use repeatedly
> >   x86/boot/compressed/32: Allow adjust_got to be called repeatedly
> >   x86/boot: Perform GOT relocation before calling EFI stub
> >
> >  arch/x86/boot/compressed/eboot.c   |  4 +-
> >  arch/x86/boot/compressed/head_32.S | 65 +++++++++++++++++++++----
> >  arch/x86/boot/compressed/head_64.S | 76 +++++++++++++++++-------------
> >  3 files changed, 99 insertions(+), 46 deletions(-)
> >
> > --
> > 2.24.1
> >
