Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605A919A730
	for <lists+linux-efi@lfdr.de>; Wed,  1 Apr 2020 10:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgDAIYa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Apr 2020 04:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgDAIYa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 1 Apr 2020 04:24:30 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D562078B
        for <linux-efi@vger.kernel.org>; Wed,  1 Apr 2020 08:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585729468;
        bh=V5x/x4MbVefuY6wx9HFlrk7OXqOTT4JyHZcqRaFiDz4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cw3kE7u1veX+S9VUtSsu2rV+MFziVC5RRl4AF3OiwENqpq/Es9etfopNPePx5zyyK
         bTUp9zcsFiT33cHJCygaMny7XTpGXGHueeXWIpKqnAskXhjK57JAVZXWpVqLEzjola
         4Ip+biwM1Cb2E94/OkB7MTdjpl418zOTZjUjg+MM=
Received: by mail-il1-f174.google.com with SMTP id a6so22199951ilr.4
        for <linux-efi@vger.kernel.org>; Wed, 01 Apr 2020 01:24:28 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1hDX1KQQcPsnzQFVOQR7R8Z/MoISuWGkwuNbxNheSXQjTcMH+x
        T60URCCsqxgF5uCJQHBNakiNoWar1aQFhlNhKT4=
X-Google-Smtp-Source: ADFU+vuu19pu3DkAKvKxS9a0XFO+W0wk/Cfi6foPKgJepI6csCSn0IK81sSqPV/b7DE+x18bq8/hSiQroW/4BtLI0OI=
X-Received: by 2002:a92:4849:: with SMTP id v70mr19780446ila.279.1585729468128;
 Wed, 01 Apr 2020 01:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200328205809.23825-1-ardb@kernel.org> <20200330074721.GV22097@bivouac.eciton.net>
 <CAMj1kXFPtY20afbAZgXT3As4TUuAqi3=pG8u19hjMjFxgN6HWA@mail.gmail.com>
 <CAMj1kXEf5rT1pmDNQoOd5Tx9xQ=fUMT0xo4JXZNfz=VDY9268Q@mail.gmail.com>
 <DM5PR2101MB104760D03E632DD4DBE99AE1D7CB0@DM5PR2101MB1047.namprd21.prod.outlook.com>
 <CAMj1kXF+2O5cDC9zuNp9Lx9Oe6WyxRghPqSi63CnF+KCcGUZyw@mail.gmail.com>
 <CAMj1kXFJB9ciJ41V2tpQNX_mN7S8BweV9_ME3sDxKjwnR2Jwbg@mail.gmail.com> <91ce0460-ae47-8092-0dfa-4b7ff6edc283@redhat.com>
In-Reply-To: <91ce0460-ae47-8092-0dfa-4b7ff6edc283@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 1 Apr 2020 10:24:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFkZLCHD+35_FL-fZWH=y9HfCCUAKE357WF5i9De0x_7w@mail.gmail.com>
Message-ID: <CAMj1kXFkZLCHD+35_FL-fZWH=y9HfCCUAKE357WF5i9De0x_7w@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/arm64: avoid image_base value from efi_loaded_image
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 31 Mar 2020 at 21:20, Laszlo Ersek <lersek@redhat.com> wrote:
>
> On 03/31/20 09:56, Ard Biesheuvel wrote:
> > On Mon, 30 Mar 2020 at 20:24, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> On Mon, 30 Mar 2020 at 20:12, Michael Kelley <mikelley@microsoft.com> wrote:
> >>>
> >>> From: Ard Biesheuvel <ardb@kernel.org>  Sent: Monday, March 30, 2020 12:51 AM
> >>>>
> >>>> On Mon, 30 Mar 2020 at 09:50, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>>>
> >>>>> On Mon, 30 Mar 2020 at 09:47, Leif Lindholm <leif@nuviainc.com> wrote:
> >>>>>>
> >>>>>> On Sat, Mar 28, 2020 at 21:58:09 +0100, Ard Biesheuvel wrote:
> >>>>>>> Commit 9f9223778ef3 ("efi/libstub/arm: Make efi_entry() an ordinary
> >>>>>>> PE/COFF entrypoint") did some code refactoring to get rid of the
> >>>>>>> EFI entry point assembler code, and in the process, it got rid of the
> >>>>>>> assignment of image_addr to the value of _text. Instead, it switched
> >>>>>>> to using the image_base field of the efi_loaded_image struct provided
> >>>>>>> by UEFI, which should contain the same value.
> >>>>>>>
> >>>>>>> However, Michael reports that this is not the case: older GRUB builds
> >>>>>>> corrupt this value in some way, and since we can easily switch back to
> >>>>>>> referring to _text to discover this value, let's simply do that.
> >>>>>>
> >>>>>> It is not clear to me how "older GRUB builds" would differ here.
> >>>>>> I think more investigation is needed before making that claim.
> >>>>>> My suspicion is that some (old) version of non-upstream, shim-enabled
> >>>>>> distro-specific build is playing a part.
> >>>>>>
> >>>>>> So, do we have the option for more detailed investigations, or can we
> >>>>>> vague the claim up to say "some GRUB builds seen in the wild, based
> >>>>>> on an upstream 2.02" or suchlike?
> >>>>>>
> >>>>>
> >>>>> I've queued a fix that prints a nastygram if the value deviates from
> >>>>> the expected one. Let's see if this triggers any reports.
> >>>>
> >>>> (/me looks at context)
> >>>>
> >>>> *This* is the fix that prints a nastygram.
> >>>
> >>> FWIW, I pulled the BOOTAA64.EFI and grubaa64.efi files from CentOS 7.6
> >>> and CentOS 8.0 binary packages and tested both in my Hyper-V VM.
> >>> Using strings | grep '2\.' to get version info, the CentOS 7.6 grubaa64.efi
> >>> shows:
> >>>
> >>>         User-Agent: GRUB 2.02~beta2
> >>>
> >>> The CentOS 8.0 grubaa64.efi shows:
> >>>
> >>>         User-Agent: GRUB 2.03
> >>>
> >>> Both versions produce the FIRMWARE BUG warning when using Ard's
> >>> latest patch.  I'll assume the equivalent RHEL versions are the same.
> >>> So we've got official distro releases that show the problem.
> >>>
> >>> As reported earlier, the BOOTAA64.EFI and grubaa64.efi from a
> >>> Debian release (not exactly sure which one) do not produce the
> >>> FIRMWARE BUG warning.  The grubaa64.efi reports as 2.04-4.
> >>>
> >>
> >> Thanks a lot Michael, that is really helpful.
> >
> > I could not reproduce the issue with Debian Stretch's
> > 2.02~beta3-5+deb9u2, so it does appear to be RedHat's value add that
> > is to blame here.
> >
> > @Laszlo: TL;DR RedHat's GRUB for arm64 appears to clobber the
> > image_base field of the efi_loaded_image struct passed to the kernel.
> > Could you please recommend a way to report this?
>
> Yes. I seem to recall that you already have an account at
> <https://bugzilla.redhat.com/>. Please log in, then go to the following
> link:
>
> https://bugzilla.redhat.com/enter_bug.cgi?product=Red%20Hat%20Enterprise%20Linux%208
>
> In the "Component" field, please enter "grub2", then fill in Summary /
> Description / etc.
>
> Please be thorough, as if you wanted me to reproduce the issue :)
>
> After filing the bug, please send the BZ link to me (or add me to the
> bug's CC list), so I can ping some RH bootloader folks directly.
>

https://bugzilla.redhat.com/show_bug.cgi?id=1819624

Thanks.
