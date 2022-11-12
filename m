Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F9A626BFC
	for <lists+linux-efi@lfdr.de>; Sat, 12 Nov 2022 22:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiKLVdJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Nov 2022 16:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiKLVdG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Nov 2022 16:33:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6761E1277D
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 13:33:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E33DC60917
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 21:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49669C433C1
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 21:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668288784;
        bh=/423Ulup3IHDUKHi+s1GFZ60+coEQ1XwSt0h55FPeSY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XGCXktijtxzyjq8xSSJ/3w7mp2Ql9hAdpSzRM+7y0dbTbU/5JXWtXudTzOcJcyyAg
         RXchAX0vuae1JmjYTkGp8LCZwyeOBdjwVuxZRmlilekyz/KDWcIRthDZ/Qg9tdqSHg
         QcDZDI6m135OWq8zSGFwuv0mMGdMwMAkt1UejMbtAz+zOGHMBN7AIma/oiV0Nz5koM
         bFO+PPui+kFuIKy/IO94HqxmwbtuOPd3wbRhB+i548H0OmnjAlt1v7/aOqcQirGKiY
         0gZ0L1KeyCPtGkfYIVliMTCZ1htasIWL4n13gdndfvdvDCRpM0YymOlXRo/cWN2XQb
         Gsht8UI09PBoQ==
Received: by mail-lf1-f42.google.com with SMTP id be13so13425492lfb.4
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 13:33:04 -0800 (PST)
X-Gm-Message-State: ANoB5pkczO6QR+nSKFU7XWanRYjXZe57yNoBE5l4cajrnNx6NBXvDMud
        gbYV5wc/L43LApDDWS4mlZZhQtFBEGLWjkOAf8g=
X-Google-Smtp-Source: AA0mqf5LGN2lehJ1LqoKqdNmM7IxXT4BZEURfzibFbV1qjOB3DT4OWpWZznouKzBa+FtRe2443yMADGhPVumQtpu0M0=
X-Received: by 2002:ac2:46cc:0:b0:4a6:3ed2:3717 with SMTP id
 p12-20020ac246cc000000b004a63ed23717mr2615271lfo.637.1668288782301; Sat, 12
 Nov 2022 13:33:02 -0800 (PST)
MIME-Version: 1.0
References: <202211121437.39938.ulrich.gemkow@ikr.uni-stuttgart.de>
 <202211121755.13372.ulrich.gemkow@ikr.uni-stuttgart.de> <CAMj1kXGJGW9Bt3MWcxQVsPnWWm2HQRo_T=atjwvt8zoaQfp5fQ@mail.gmail.com>
 <202211122209.54371.ulrich.gemkow@ikr.uni-stuttgart.de>
In-Reply-To: <202211122209.54371.ulrich.gemkow@ikr.uni-stuttgart.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 12 Nov 2022 22:32:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHFs8b9C5P4G1JPKhAaWksEtu9qfLtVFerJM8bDerrr5A@mail.gmail.com>
Message-ID: <CAMj1kXHFs8b9C5P4G1JPKhAaWksEtu9qfLtVFerJM8bDerrr5A@mail.gmail.com>
Subject: Re: Regression in Linux 6.0.8 in Lenovo T14 Gen 3 when adding EFI
 boot entries
To:     Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 12 Nov 2022 at 22:10, Ulrich Gemkow
<ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
>
> Hallo Ard,
>
> On Saturday 12 November 2022, you wrote:
> > On Sat, 12 Nov 2022 at 17:55, Ulrich Gemkow
> > <ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
> > >
> > > Hello Ard,
> > >
> > > On Saturday 12 November 2022, you wrote:
> > > > On Sat, 12 Nov 2022 at 16:26, Ulrich Gemkow
> > > > <ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
> > > > >
> > > > > Hello Ard,
> > > > >
> > > > > thanks for looking into this!
> > > > >
> > > > > On Saturday 12 November 2022, you wrote:
> > > > > > On Sat, 12 Nov 2022 at 14:42, Ulrich Gemkow
> > > > > > <ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > calling efibootmgr for adding EFI boot entries with Linux 6.0.8 does
> > > > > > > not work on our Lenovo T14 Gen 3 (intel). The error is "EFI variables
> > > > > > > are not supported on this system". The directory /sys/firmware/efi/efivars/
> > > > > > > exists but is empty.
> > > > > > >
> > > > > > > This worked fine with the latest 5.19 kernel. The config was transferred
> > > > > > > from 5.19 to 6.0 with "make oldconfig". All kernels are self-compiled
> > > > > > > and without changes from the kernel.org downloads.
> > > > > > >
> > > > > > > I saw earlier messages about bugs in this area, the fixes applied
> > > > > > > seem to be not complete.
> > > > > > >
> > > > > > > Please let me know when additional information would help to debug.
> > > > > > >
> > > > > >
> > > > > > Hello Ulrich,
> > > > > >
> > > > > > Can you please share the complete kernel boot log when booting with
> > > > > > efi=debug, and the .config used to build the kernel? Thanks.
> > > > > >
> > > > >
> > > > > please find attached the two files. Please do not get confused about
> > > > > the kernel uname, the used kernel is 6.0.8. I use my own automated
> > > > > setup and build environment which requires a different naming.
> > > > >
> > > >
> > > > Does it work if you enable CONFIG_EFI_STUB?
> > > >
> > >
> > > Enabling CONFIG_EFI_STUB does not help, the problem remains.
> > >
> > > I digged around and found that mounting the efivarfs solves the
> > > problem. This was not required with 5.19. Is this an expected
> > > or wanted change of behavior?
> > >
> >
> > That is surprising. It is entirely up to user space whether and when
> > efivarfs gets mounted - the kernel just provides the facilities but
> > does not decide if they get used.
> >
> > Which distro are you using?
>
> In principle this is Debian 11 but the whole base (init, kernel, ...)
> is self-made. So the distro is maybe not really relevant.
>
> I understand the problem as follows: With 5.19 mounting the efivarfs was
> not required to change EFI boot entries. In 6.0 it seems to be required
> for efibootmgr to change boot entries.
>
> I created a standard Debian 11 install and efivarfs is mounted. So maybe
> in current distros the efivarfs is normally mounted.
>
> So while the changed behavior is formally a regression it may not be relevant
> because most users of todays distros may not notice the change because of
> the always mounted efivarfs. I cannot judge whether this is relevant.
>

I figured out what is happening.

6.0 removes the ancient efivar sysfs interface for accessing EFI
variables. This has been replaced by efivarfs ~10 years ago, but has
only been removed recently. The old sysfs based interface exposes the
EFI variables under /sys/firmware/efi/vars [not /efivars] and requires
no explicit mount.

efibootmgr will fall back to this legacy method if it cannot find the
EFI variables under /sys/firmware/efi/efivars, which is the case for
you because efivarfs is not mounted.

So the answer is really to add efivarfs to the list of pseudo
filesystems like proc and sysfs that get mounted automatically at
boot.
