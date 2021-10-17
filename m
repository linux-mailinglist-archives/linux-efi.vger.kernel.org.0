Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C4543095F
	for <lists+linux-efi@lfdr.de>; Sun, 17 Oct 2021 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhJQNdj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 Oct 2021 09:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236809AbhJQNdi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 17 Oct 2021 09:33:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D34EA61266;
        Sun, 17 Oct 2021 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634477488;
        bh=u1XYLs8DDwxN3/FCsIgwCHksZ0bYQZv6HnXSBDhzDfc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NzsGzuYj3uswx80Ap1YJbBsMYjQ82DXhR1gfL8SrZekVD58dCFi7mkPIfHHC2xuCq
         GowMw0pYAoVa7ACJ/QEJUPOrsHCtJX2VinnLFrjaZ+RlL1lLasgJto1W5zldUSOs7q
         09UbB/Yy1/ZT1vUURudbtGpuuMagT+Ha4YCaGNCwZ9SsqFEGrBRL6jh/wQIH1ZCF1A
         ZVjx3/YC/3P4k13X4mS99ZwNEomhJpcUBnz0U04gq+zf9jYAyIGotKvu8wMoxEYL68
         vBZIk+B+qa+5M03QjdNF6ksNzSfRFxpLxGuSyhdS0WYRHi/n1M9B/O4JPEJepv986a
         l1Z2KOtlv9z6g==
Received: by mail-oi1-f173.google.com with SMTP id g125so20617062oif.9;
        Sun, 17 Oct 2021 06:31:28 -0700 (PDT)
X-Gm-Message-State: AOAM532r4GwbUuY1fLvGNKSkCLuwzmoBEhPJXmhBo4bcXq8tiK3AB2/d
        y0bnUXVrYOkEwdUdoJTx5BbDMm6ILo/vmK7gRbA=
X-Google-Smtp-Source: ABdhPJwLY3AD3ztimj/lJV5pJFYgq5YTJpEFIk/GnGfwMCw0BiTRGVIBW8tUVAbSraA0DjktE6/pz5y7DaqYuZT5vFk=
X-Received: by 2002:a05:6808:1805:: with SMTP id bh5mr9709124oib.47.1634477488180;
 Sun, 17 Oct 2021 06:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com> <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
 <YL5U/zSb50SnbLgW@smile.fi.intel.com> <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com>
 <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
 <YMCsSqzmG4jb1Ojo@dhcp-128-65.nay.redhat.com> <YMQ62d1EFFjRcv6w@dhcp-128-65.nay.redhat.com>
 <YMd39tIPercgljll@smile.fi.intel.com> <YMeM1Xee9Yg3j21D@smile.fi.intel.com>
 <YMeRiDMet2JyOV4P@smile.fi.intel.com> <YV3Oonc5s3UpzRq0@smile.fi.intel.com>
 <CAMj1kXHjXcFePeRWDtxZnC6eHEeELA6kZXOU=sA9oDZ1HzW_Vg@mail.gmail.com> <CAHp75VdLLZsJnektx+n=BGvGeaogN0r=viNJpbR-au5RUURi9Q@mail.gmail.com>
In-Reply-To: <CAHp75VdLLZsJnektx+n=BGvGeaogN0r=viNJpbR-au5RUURi9Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 17 Oct 2021 15:31:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFn+6AfVEksrEhPtPTHx-DmfTPwq=F7xpgs6D7EmKHMmA@mail.gmail.com>
Message-ID: <CAMj1kXFn+6AfVEksrEhPtPTHx-DmfTPwq=F7xpgs6D7EmKHMmA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed kernel
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dave Young <dyoung@redhat.com>, Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Javier_Ti=C3=A1?= <javier.tia@gmail.com>,
        kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 7 Oct 2021 at 09:23, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Thu, Oct 7, 2021 at 10:20 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Wed, 6 Oct 2021 at 18:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Jun 14, 2021 at 08:27:36PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Jun 14, 2021 at 08:07:33PM +0300, Andy Shevchenko wrote:
>
> ...
>
> > > > Double checked, confirmed that it's NOT working.
> > >
> > > Any news here?
> > >
> > > Shall I resend my series?
> >
> > As I said before:
> >
> > """
> > I would still prefer to get to the bottom of this before papering over
> > it with command line options. If the memory gets corrupted by the
> > first kernel, maybe we are not preserving it correctly in the first
> > kernel.
> > """
>
> And I can't agree more, but above I asked about news, implying if
> there is anything to test?
> The issue is still there and it becomes a bit annoying to see my hack
> patches in every tree I have been using.
>

If nobody can be bothered to properly diagnose this, how important is
it, really?
