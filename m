Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F803CCEED
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 09:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhGSH4W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 03:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234778AbhGSH4V (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Jul 2021 03:56:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D033F611B0;
        Mon, 19 Jul 2021 07:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626681201;
        bh=xiP3w8WpsWKPUtCCWunp0nP5etaDOOBzPlAC6e3dtis=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hyxTyfs2Xbc5QrhmU11PpDL0UBkKqdlfAY5GNLqsvaCTSufq5Bq8qkuoCcyVqPHT7
         KpBMAuhrU7bqrynUfECtesdBbopecog2BPUaQWA6v2Tlmv8Z1IB/9AsJs0/+0Me8Tk
         cn4R5LYSRK5aEPGtWksq7WQhb2drFmCwV3cV+uiUUdewknCMraSEP72ghoMFMJj0XJ
         VeO3unrbiW3gZucH10cPO4joedvBtvVt8CAg1bE05KgP4ob4Ozm52dxlFKKV4IHPuD
         X5UmCvhkmf3Q06s3UXieDcdFXwxQuKXhy1ebKIar6+rgufr3i+7101UrlaGlvUdwZe
         SFV+SRb05ORJg==
Received: by mail-oi1-f175.google.com with SMTP id s23so4089343oiw.12;
        Mon, 19 Jul 2021 00:53:21 -0700 (PDT)
X-Gm-Message-State: AOAM532+PUAnFwI6tMGR3RPJh46GTPCPclp5T5qzJ08QxFNxETwU8ycs
        rA0BcPJgKCkq0kmBLhQkobV6OqtnxZ9t5Za0iyY=
X-Google-Smtp-Source: ABdhPJxHc/9CNFUIVR773RmH2qEBIWuP3KzXPVIa9827d19jPnOtdHY7H7FuX3vOUun1llJ/MUHCRHQDxz+2jzlTbIw=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr16671836oib.33.1626681201119;
 Mon, 19 Jul 2021 00:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <YLdG91qspr19heDS@smile.fi.intel.com> <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
 <YL5HvUqtsDXx5CzM@smile.fi.intel.com> <YL5U/zSb50SnbLgW@smile.fi.intel.com>
 <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com> <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
 <YMCsSqzmG4jb1Ojo@dhcp-128-65.nay.redhat.com> <YMQ62d1EFFjRcv6w@dhcp-128-65.nay.redhat.com>
 <YMd39tIPercgljll@smile.fi.intel.com> <YMeM1Xee9Yg3j21D@smile.fi.intel.com> <YMeRiDMet2JyOV4P@smile.fi.intel.com>
In-Reply-To: <YMeRiDMet2JyOV4P@smile.fi.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 19 Jul 2021 09:53:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGnVX7JHM6BGRM6t=NSfDfpYnMp7tyTtWzxP+jha7dexQ@mail.gmail.com>
Message-ID: <CAMj1kXGnVX7JHM6BGRM6t=NSfDfpYnMp7tyTtWzxP+jha7dexQ@mail.gmail.com>
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

On Mon, 14 Jun 2021 at 19:27, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 14, 2021 at 08:07:33PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 14, 2021 at 06:38:30PM +0300, Andy Shevchenko wrote:
> > > On Sat, Jun 12, 2021 at 12:40:57PM +0800, Dave Young wrote:
> > > > > Probably it is doable to have kexec on 32bit efi working
> > > > > without runtime service support, that means no need the trick of fixed
> > > > > mapping.
> > > > >
> > > > > If I can restore my vm to boot 32bit efi on this weekend then I may provide some draft
> > > > > patches for test.
> > > >
> > > > Unfortunately I failed to setup a 32bit efi guest,  here are some
> > > > untested draft patches, please have a try.
> > >
> > > Thanks for the patches.
> > >
> > > As previously, I have reverted my hacks and applied your patches (also I
> > > dropped patches from previous mail against kernel and kexec-tools) for both
> > > kernel and user space on first and second environments.
> > >
> > > It does NOT solve the issue.
> > >
> > > If there is no idea pops up soon, I'm going to resend my series that
> > > workarounds the issue.
> >
> > Hold on, I may have made a mistake during testing. Let me retest this.
>
> Double checked, confirmed that it's NOT working.
>

Apologies for chiming in so late - in my defence, I was on vacation :-)

So if I understand the thread correctly, the Surface 3 provides a
SMBIOS entry point (not SMBIOS3), and it does not get picked up by the
second kernel, right?

I would still prefer to get to the bottom of this before papering over
it with command line options. If the memory gets corrupted by the
first kernel, maybe we are not preserving it correctly in the first
kernel.
