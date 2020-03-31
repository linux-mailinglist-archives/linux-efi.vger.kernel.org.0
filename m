Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF7198DA9
	for <lists+linux-efi@lfdr.de>; Tue, 31 Mar 2020 09:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgCaH4e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Mar 2020 03:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbgCaH4d (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Mar 2020 03:56:33 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97192083E
        for <linux-efi@vger.kernel.org>; Tue, 31 Mar 2020 07:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585641392;
        bh=3ercSEYHSsTKpm07uaUkl1Ke9Bk5D1FbsI6WPyK1fow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZkXx1xdhzTOSUctGRLRbHp84UKY6td5WIlGgD7yY7aQb1K2BpJ73R1V/ER/E4DMYp
         mvLp8rIChBc35deAFL2XsWRaZvK+fVS+ee6JaHJIC90w541Cv9ebguI4+mvjYSinWk
         SSfnPCbMy8yw22aW3J0SqWFH8shqd9rVQID5/t0U=
Received: by mail-il1-f181.google.com with SMTP id f16so18504683ilj.9
        for <linux-efi@vger.kernel.org>; Tue, 31 Mar 2020 00:56:32 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0Y1yFJUzXLCGB2ZGoBb8JwcUqdGuCfByYa2p+zcidp1YNLh1RR
        GRsO/TsvgvfxcDq/n+4kWTqUgmNqVnz+NTjf1II=
X-Google-Smtp-Source: ADFU+vvYWMQ/amzvYwYMfsiNFRIesCFTg8eWMXBJuJX6OG9NPd1JuT33mGJHPRlh0m8xSgu4AzVxlZgn7oaDWDlV9Ss=
X-Received: by 2002:a05:6e02:551:: with SMTP id i17mr13821185ils.218.1585641392036;
 Tue, 31 Mar 2020 00:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200328205809.23825-1-ardb@kernel.org> <20200330074721.GV22097@bivouac.eciton.net>
 <CAMj1kXFPtY20afbAZgXT3As4TUuAqi3=pG8u19hjMjFxgN6HWA@mail.gmail.com>
 <CAMj1kXEf5rT1pmDNQoOd5Tx9xQ=fUMT0xo4JXZNfz=VDY9268Q@mail.gmail.com>
 <DM5PR2101MB104760D03E632DD4DBE99AE1D7CB0@DM5PR2101MB1047.namprd21.prod.outlook.com>
 <CAMj1kXF+2O5cDC9zuNp9Lx9Oe6WyxRghPqSi63CnF+KCcGUZyw@mail.gmail.com>
In-Reply-To: <CAMj1kXF+2O5cDC9zuNp9Lx9Oe6WyxRghPqSi63CnF+KCcGUZyw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 31 Mar 2020 09:56:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFJB9ciJ41V2tpQNX_mN7S8BweV9_ME3sDxKjwnR2Jwbg@mail.gmail.com>
Message-ID: <CAMj1kXFJB9ciJ41V2tpQNX_mN7S8BweV9_ME3sDxKjwnR2Jwbg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/arm64: avoid image_base value from efi_loaded_image
To:     Michael Kelley <mikelley@microsoft.com>, lersek@redhat.com
Cc:     Leif Lindholm <leif@nuviainc.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 30 Mar 2020 at 20:24, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 30 Mar 2020 at 20:12, Michael Kelley <mikelley@microsoft.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>  Sent: Monday, March 30, 2020 12:51 AM
> > >
> > > On Mon, 30 Mar 2020 at 09:50, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Mon, 30 Mar 2020 at 09:47, Leif Lindholm <leif@nuviainc.com> wrote:
> > > > >
> > > > > On Sat, Mar 28, 2020 at 21:58:09 +0100, Ard Biesheuvel wrote:
> > > > > > Commit 9f9223778ef3 ("efi/libstub/arm: Make efi_entry() an ordinary
> > > > > > PE/COFF entrypoint") did some code refactoring to get rid of the
> > > > > > EFI entry point assembler code, and in the process, it got rid of the
> > > > > > assignment of image_addr to the value of _text. Instead, it switched
> > > > > > to using the image_base field of the efi_loaded_image struct provided
> > > > > > by UEFI, which should contain the same value.
> > > > > >
> > > > > > However, Michael reports that this is not the case: older GRUB builds
> > > > > > corrupt this value in some way, and since we can easily switch back to
> > > > > > referring to _text to discover this value, let's simply do that.
> > > > >
> > > > > It is not clear to me how "older GRUB builds" would differ here.
> > > > > I think more investigation is needed before making that claim.
> > > > > My suspicion is that some (old) version of non-upstream, shim-enabled
> > > > > distro-specific build is playing a part.
> > > > >
> > > > > So, do we have the option for more detailed investigations, or can we
> > > > > vague the claim up to say "some GRUB builds seen in the wild, based
> > > > > on an upstream 2.02" or suchlike?
> > > > >
> > > >
> > > > I've queued a fix that prints a nastygram if the value deviates from
> > > > the expected one. Let's see if this triggers any reports.
> > >
> > > (/me looks at context)
> > >
> > > *This* is the fix that prints a nastygram.
> >
> > FWIW, I pulled the BOOTAA64.EFI and grubaa64.efi files from CentOS 7.6
> > and CentOS 8.0 binary packages and tested both in my Hyper-V VM.
> > Using strings | grep '2\.' to get version info, the CentOS 7.6 grubaa64.efi
> > shows:
> >
> >         User-Agent: GRUB 2.02~beta2
> >
> > The CentOS 8.0 grubaa64.efi shows:
> >
> >         User-Agent: GRUB 2.03
> >
> > Both versions produce the FIRMWARE BUG warning when using Ard's
> > latest patch.  I'll assume the equivalent RHEL versions are the same.
> > So we've got official distro releases that show the problem.
> >
> > As reported earlier, the BOOTAA64.EFI and grubaa64.efi from a
> > Debian release (not exactly sure which one) do not produce the
> > FIRMWARE BUG warning.  The grubaa64.efi reports as 2.04-4.
> >
>
> Thanks a lot Michael, that is really helpful.

I could not reproduce the issue with Debian Stretch's
2.02~beta3-5+deb9u2, so it does appear to be RedHat's value add that
is to blame here.

@Laszlo: TL;DR RedHat's GRUB for arm64 appears to clobber the
image_base field of the efi_loaded_image struct passed to the kernel.
Could you please recommend a way to report this?
