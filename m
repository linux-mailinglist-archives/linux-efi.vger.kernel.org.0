Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17C1AFA6E
	for <lists+linux-efi@lfdr.de>; Sun, 19 Apr 2020 15:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDSNSV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 19 Apr 2020 09:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgDSNSU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 19 Apr 2020 09:18:20 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B67E20724
        for <linux-efi@vger.kernel.org>; Sun, 19 Apr 2020 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587302300;
        bh=1AYioC5knc5kevTaajyMgC2WAAQUGKkxBPHp7TSz11M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xussM8gGNDqS0uFUtjAHGOlsI8xekfQQlG8b1xXJIR9MHZOHjBccWZ/Wo3xyaODHB
         H14Q5ZgFD02EMTgOyB4uFwM2zNsL0DFDNh/mMo5rbk2twjOkttFqpIyUofVl/3CISp
         8PV+91IeQZ3ZmnOOP5NiK0TGdreBfmW8FAT1pZfE=
Received: by mail-io1-f48.google.com with SMTP id i3so7712950ioo.13
        for <linux-efi@vger.kernel.org>; Sun, 19 Apr 2020 06:18:20 -0700 (PDT)
X-Gm-Message-State: AGi0Puafye5qBsGXCVql/3QjZrHrgd/3tppMB6Km5gttIRzO/avpHa2I
        xzHSjCmYt/6xBnz/CK8/WBd9/wl4KfHaEfFOqOU=
X-Google-Smtp-Source: APiQypJRW4EvEbkPoNCQeoRuKINiZM0yvhD0XatoH1v03oAg/CTFcs9MGDB5YCLaUl2sqO81u8J3I4ebVGuKLAvHD5M=
X-Received: by 2002:a6b:ef03:: with SMTP id k3mr11601332ioh.203.1587302299527;
 Sun, 19 Apr 2020 06:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <bf17f4c7-f7a8-01c1-f7a9-bf0a499c502c@redhat.com>
 <CAMj1kXEdjqph0d96o6j=avT+Zt41ibegiyTKHK+RCmGaZVeTpA@mail.gmail.com> <caf85ef9-5231-9d2f-356b-375a46c2cb42@redhat.com>
In-Reply-To: <caf85ef9-5231-9d2f-356b-375a46c2cb42@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 19 Apr 2020 15:18:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGzEByRf2qmD=4+N_b8KfSr7PHrpM-rVQmqFU1VhxMJkg@mail.gmail.com>
Message-ID: <CAMj1kXGzEByRf2qmD=4+N_b8KfSr7PHrpM-rVQmqFU1VhxMJkg@mail.gmail.com>
Subject: Re: Starting with kernel 5.6 deleting efibootmgr entries no longer
 works (efivarfs regresson)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>, russianneuromancer@ya.ru
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 19 Apr 2020 at 14:55, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 4/19/20 1:59 PM, Ard Biesheuvel wrote:
> > On Sun, 19 Apr 2020 at 13:41, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Ard,
> >>
> >> I got a bug report by email that "grub-install" was throwing errors
> >> on 32 bit UEFI (64 bit kernel, mixed mode) systems starting with 5.6 .
> >> After that I noticed that the Fedora installer also threw an error about
> >> it being unable to setup the bootloader (which I could luckily skip), this
> >> was also a 32 bit UEFI mixed-mode system.
> >>
> >> So I've been running some tests with efibootmgr from the shell. Adding
> >> new entries works, but removing an entry involves unlinking the EFI var
> >> for the old which fails, here is the relevant part from a strace run:
> >>
> >> unlink("/sys/firmware/efi/efivars/Boot0000-8be4df61-93ca-11d2-aa0d-00e098032b8c") = -1 EINVAL (Invalid argument)
> >>
> >> With kernel 5.5 the same unlink succeeds, I guess this is also the
> >> cause for the grub-install and Fedora 32 installer errors. At least
> >> the Fedora 32 install error was seen on a system which already had
> >> a "Fedora" efibootmgr entry, so likely the installer tried to remove
> >> the old entry first and that caused the failure.
> >>
> >> I've also tried removing efibootmgr entires on a 64 bit UEFI system running
> >> 5.6.4 and that works fine. On 32 bit UEFI mixed-mode systems the problem
> >> persists with 5.7-rc1.
> >>
> >> Ard, any idea where to start with pinpointing the cause of this
> >> regression ?
> >>
> >
> > Can you start by trying this patch please?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=urgent&id=9461aa3b44ac21668100067939d24a6ffa810eae
>
> Cool, I can confirm that this fixes deleting boot entries with
> efibootmgr.
>

Thanks for confirming, and apologies for the breakage.

> Regards,
>
> Hans
>
>
> p.s.
>
> In Torvald's tree this seems to have gotten a different commit-id:
> a4b81ccfd4caba017d2b84720b6de4edd16911a0
>

Yes, as you know, Ingo prefers to re-apply EFI patches piecemeal
rather than merging my branches directly, so the branches in the EFI
tree are not stable, unfortunately.
