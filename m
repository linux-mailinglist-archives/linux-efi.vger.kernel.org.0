Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E37424E01
	for <lists+linux-efi@lfdr.de>; Thu,  7 Oct 2021 09:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbhJGHWq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Oct 2021 03:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232530AbhJGHWn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 7 Oct 2021 03:22:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E4F76120D;
        Thu,  7 Oct 2021 07:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633591250;
        bh=/Hf+4ElDDdwMZ8Ef3ERAZt27nGhCN0OKNqevJQr7QRk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jO+3RwoN5OnuGS8jZgl8yqOoqyy0LWRewvksi/TPXoaa0XSuyopE+zZvh2rRwGhfj
         zTkrURgjOU5RL1+0tlC1QrcS7Fn9kv0LHwD1phCqnRNmNEHbsM8l06Vvr3ffrdCzTK
         C6lWekd3tF3KEXYMvacI+D0UZSLaR3rXX1OpTVq5iBPqVftWcm7l7XwS6am17JBghH
         XEe0YCVOWFxNy4c4ljSKx2bZC7dflNOr8fDUbleQ2wUNCpcwHIoGIO8XfOHV6FXc4k
         7uI85nc03uFnkEAm1h3qxfv1GoQcBWHqh7hsQIwOsE9ofFXa6pi55rDQ8DcGnISxTf
         jxTncCX97PQdw==
Received: by mail-oi1-f179.google.com with SMTP id z11so7765138oih.1;
        Thu, 07 Oct 2021 00:20:50 -0700 (PDT)
X-Gm-Message-State: AOAM530CvZ1fSq8zv6oxfbd7+oinzqYkmVNrq2OKfIBWLKZ4202sV8dW
        7Q77LsRhsciVXcAfaA91OpswZg35tz8eoM28zao=
X-Google-Smtp-Source: ABdhPJy12E4C7MyMbF8TE2wSml5gM6HJ0FGnpAWaP0/im2yMn2/yW60RMoHH+PeWHNLkZlcH6qnyBqHUEB2qW12gzuQ=
X-Received: by 2002:a05:6808:1148:: with SMTP id u8mr1915535oiu.33.1633591250046;
 Thu, 07 Oct 2021 00:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com> <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
 <YL5U/zSb50SnbLgW@smile.fi.intel.com> <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com>
 <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
 <YMCsSqzmG4jb1Ojo@dhcp-128-65.nay.redhat.com> <YMQ62d1EFFjRcv6w@dhcp-128-65.nay.redhat.com>
 <YMd39tIPercgljll@smile.fi.intel.com> <YMeM1Xee9Yg3j21D@smile.fi.intel.com>
 <YMeRiDMet2JyOV4P@smile.fi.intel.com> <YV3Oonc5s3UpzRq0@smile.fi.intel.com>
In-Reply-To: <YV3Oonc5s3UpzRq0@smile.fi.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 Oct 2021 09:20:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHjXcFePeRWDtxZnC6eHEeELA6kZXOU=sA9oDZ1HzW_Vg@mail.gmail.com>
Message-ID: <CAMj1kXHjXcFePeRWDtxZnC6eHEeELA6kZXOU=sA9oDZ1HzW_Vg@mail.gmail.com>
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

On Wed, 6 Oct 2021 at 18:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 14, 2021 at 08:27:36PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 14, 2021 at 08:07:33PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jun 14, 2021 at 06:38:30PM +0300, Andy Shevchenko wrote:
> > > > On Sat, Jun 12, 2021 at 12:40:57PM +0800, Dave Young wrote:
> > > > > > Probably it is doable to have kexec on 32bit efi working
> > > > > > without runtime service support, that means no need the trick of fixed
> > > > > > mapping.
> > > > > >
> > > > > > If I can restore my vm to boot 32bit efi on this weekend then I may provide some draft
> > > > > > patches for test.
> > > > >
> > > > > Unfortunately I failed to setup a 32bit efi guest,  here are some
> > > > > untested draft patches, please have a try.
> > > >
> > > > Thanks for the patches.
> > > >
> > > > As previously, I have reverted my hacks and applied your patches (also I
> > > > dropped patches from previous mail against kernel and kexec-tools) for both
> > > > kernel and user space on first and second environments.
> > > >
> > > > It does NOT solve the issue.
> > > >
> > > > If there is no idea pops up soon, I'm going to resend my series that
> > > > workarounds the issue.
> > >
> > > Hold on, I may have made a mistake during testing. Let me retest this.
> >
> > Double checked, confirmed that it's NOT working.
>
> Any news here?
>
> Shall I resend my series?
>

As I said before:

"""
I would still prefer to get to the bottom of this before papering over
it with command line options. If the memory gets corrupted by the
first kernel, maybe we are not preserving it correctly in the first
kernel.
"""
