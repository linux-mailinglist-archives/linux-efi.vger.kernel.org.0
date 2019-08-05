Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A2F82105
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2019 18:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfHEQBe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Aug 2019 12:01:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37341 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHEQBc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Aug 2019 12:01:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so59876337wrr.4
        for <linux-efi@vger.kernel.org>; Mon, 05 Aug 2019 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6j4ZxMaWGS3ScQ5dYywCZhv8aZuc2y/2ZEwdEBFjM0=;
        b=PMxbfiSMRVb2CVi78S7JPr4kqNeAtYQt4QEY6FnGOvc/Y9c8iJhcL1bzUGgTScNz9Z
         4Iz7Ay6J+hDVaWZc7sclhnUOzWo9QvkJj26mj39rToOdpSyYK6Marij2v4EmUrvQ81z6
         XzFvCFAX70+HYi1F4I3AXJF+/9WLydPCtMmiIn2pzmeLqA5DAtvCO1q10rtHRZyyFa4V
         lQgtvFRVTAG4aMgIeRLk5jKdg4xj1A9Mthd6V4RJn8U2SI6U/WqVaB3DafYYp4GA2Pj3
         sT+oPkdvPkl1RLTV6Dux5uvcH/THfNfwFpZ7G5XUGJLaEj8O9Deqgt3ZMAhoyrICv/O3
         p4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6j4ZxMaWGS3ScQ5dYywCZhv8aZuc2y/2ZEwdEBFjM0=;
        b=oRh6Cz7WHEeGZINT4P1tHpZM+W1QtNDuXDJCkc5AVdQHtrd3eV2t0Nq/N8ac6KBGlO
         7QOcn+dYo4DDKmrejm8kT9v0i9E/qC4UqSOhaKiGHpLRzi6CaIG9kGiM0oY+HHiXtYoj
         90txKX/pueT5YGmpwsqmKrqGVHOvfweGDbufrSN/tkVlwLHnyi2hjHQ4qGGGFhu+l6dr
         wGsr9NLMhg1PahQWiUnrlvtWOI3cSuSM6ZKUiqjxE2/TVfkiwf1GS7piV7Oz3qpdO3Vc
         3xqFszTVdrQuVKc94PhqZOdkUwDHTgeSjjXW+6LcDQLNFd42w1CidBiDokUvN2S/eV7t
         Xv5Q==
X-Gm-Message-State: APjAAAX9MEp3JRL6Va9GUB1H8ZQf/X+tTOKrY6DbCi6RlNUCovrriQ9C
        cRdgUBEya7J2FPo/Pp+T8DNF/uNkFAsKsERNBZA63w==
X-Google-Smtp-Source: APXvYqzzl2uBb2K29t8VL4rEak+IjBCH2cxdGjkA0Y/AUt/aWR4t/c7z3oqdAHgJrbelidfqtath+dA0ugEzYW8v6GA=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr26783408wrs.93.1565020889861;
 Mon, 05 Aug 2019 09:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <b20dd437-790a-aad9-0515-061751d46e53@redhat.com>
 <CAKv+Gu8p47SHEtTHQu_3agQJDH2yYjQJ5xUvE+oTiLaY=sZdUA@mail.gmail.com> <ff73efc3-1951-2982-3ddf-e77005c5fddb@redhat.com>
In-Reply-To: <ff73efc3-1951-2982-3ddf-e77005c5fddb@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Aug 2019 19:01:20 +0300
Message-ID: <CAKv+Gu9nEM5D877YD+N8tSN0sON6rR3f+Tc-9bg5u==+9Q2meA@mail.gmail.com>
Subject: Re: 5.3 boot regression caused by 5.3 TPM changes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 4 Aug 2019 at 19:12, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 04-08-19 17:33, Ard Biesheuvel wrote:
> > Hi Hans,
> >
> > On Sun, 4 Aug 2019 at 13:00, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi All,
> >>
> >> While testing 5.3-rc2 on an Irbis TW90 Intel Cherry Trail based
> >> tablet I noticed that it does not boot on this device.
> >>
> >> A git bisect points to commit 166a2809d65b ("tpm: Don't duplicate
> >> events from the final event log in the TCG2 log")
> >>
> >> And I can confirm that reverting just that single commit makes
> >> the TW90 boot again.
> >>
> >> This machine uses AptIO firmware with base component versions
> >> of: UEFI 2.4 PI 1.3. I've tried to reproduce the problem on
> >> a Teclast X80 Pro which is also CHT based and also uses AptIO
> >> firmware with the same base components. But it does not reproduce
> >> there. Neither does the problem reproduce on a CHT tablet using
> >> InsideH20 based firmware.
> >>
> >> Note that these devices have a software/firmware TPM-2.0
> >> implementation, they do not have an actual TPM chip.
> >>
> >> Comparing TPM firmware setting between the 2 AptIO based
> >> tablets the settings are identical, but the troublesome
> >> TW90 does have some more setting then the X80, it has
> >> the following settings which are not shown on the X80:
> >>
> >> Active PCR banks:           SHA-1         (read only)
> >> Available PCR banks:        SHA-1,SHA256  (read only)
> >> TPM2.0 UEFI SPEC version:   TCG_2         (other possible setting: TCG_1_2
> >> Physical Presence SPEC ver: 1.2           (other possible setting: 1.3)
> >>
> >> I have the feeling that at least the first 2 indicate that
> >> the previous win10 installation has actually used the
> >> TPM, where as on the X80 the TPM is uninitialized.
> >> Note this is just a hunch I could be completely wrong.
> >>
> >> I would be happy to run any commands to try and debug this
> >> or to build a kernel with some patches to gather more info.
> >>
> >> Note any kernel patches to printk some debug stuff need
> >> to be based on 5.3 with 166a2809d65b reverted, without that
> >> reverted the device will not boot, and thus I cannot collect
> >> logs without it reverted.
> >>
> >
> > Are you booting a 64-bit kernel on 32-bit firmware?
>
> Yes you are right, I must say that this is somewhat surprising
> most Cherry Trail devices do use 64 bit firmware (where as Bay Trail
> typically uses 32 bit). But I just checked efibootmgr output and it
> says it is booting: \EFI\FEDORA\SHIMIA32.EFI so yeah 32 bit firmware.
>
> Recent Fedora releases take care of this so seamlessly I did not
> even realize...
>

OK, so we'll have to find out how this patch affects 64-bit code
running on 32-bit firmware. The only EFI call in that patch is
get_config_table(), which is not actually a EFI boot service call but
a EFI stub helper that parses the config table array in the EFI system
table.
