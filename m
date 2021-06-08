Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E581F39F6EF
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhFHMlZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 08:41:25 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:50979 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhFHMlY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Jun 2021 08:41:24 -0400
Received: by mail-pj1-f53.google.com with SMTP id g4so2367383pjk.0;
        Tue, 08 Jun 2021 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUd1RibEbr1RO189mP0vlG8rvokpv2jTYP6Mg5w05yE=;
        b=CNj30DcfMTzBEBr4KJSDOjX/d56RDil/08XD+UwSnd2sBDrZiLghYvMjKEf6RuN4J4
         UsPz5WUoxwLV3VtQMA8qLpIm2Y72zlmlwMnoHyT+3C+svNZ+aamDrrxvwjiFGt+Tm4B0
         TSyhiyGnV/I6VSXj1kbjYqQmJByc1WN9grqCK9RrWTWrtbC/VXublTJwNqcOZl6YZEoZ
         tysfh7ROWoc5pmHIC/czHYJzHCt/KR2J1iEoSGx5D2KchRm8pbZ4kXpgXMJ5vupWlA02
         3FzuyqXkQwQ/LoUjaWVvXDR5Li4N/fQ/dO6XDU7k+qEs1uvXdOX4BaZW3UmySjYcEMdK
         SkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUd1RibEbr1RO189mP0vlG8rvokpv2jTYP6Mg5w05yE=;
        b=QTYjWCgvvAPiqta5/GxPjri4OSvWfvHltBVAOzB4lXylmcurxKSI6Jqd8tp2BWKXwu
         CT3+dUXuYcJynsJ/gDiYSWb3ZdcZj9X+tlMtK7Wj/cIhsqg+/u3NDbUZEXu7qt//K4zs
         lJy6NevTZ6yA1XzUZQXQMFLUPeTbUOpTWdoKQTZTkDuJ0bZz3esYYaZYMS95qNnu2puc
         j11bHp3IYPIENq3l6o28n0s13nAYPFTGCQxe4AZjnR0aGagWurtkOFFfPEoo64H7zmt8
         rYTE9nk/KKKr87AeJZvXrOd2lviLTrM5S8PDtaivzm2vjDxbMPm5v996EfLjSrhkjtXd
         Y8kQ==
X-Gm-Message-State: AOAM530pJfxZzghIMBtbgkORc171nm/HoFkHtr2cF22jfoSlOndC6OzW
        ignEbUCWqyxRC8+AOwx//sWM5lAboRgBJpVme8cevmJDyqg=
X-Google-Smtp-Source: ABdhPJwhSijydSHoyTNvnLyUWjc9x1RknZ3UIDRnGT16hzVQPS/Abx06TeX1mTIRvUTbH/3R9dJvLzBltB0zddzcG6M=
X-Received: by 2002:a17:90a:80c5:: with SMTP id k5mr4741288pjw.129.1623155898187;
 Tue, 08 Jun 2021 05:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <YLdEZoSWI41fcTB1@smile.fi.intel.com> <YLdG91qspr19heDS@smile.fi.intel.com>
 <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com> <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
 <YL5U/zSb50SnbLgW@smile.fi.intel.com> <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com>
In-Reply-To: <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Jun 2021 15:38:01 +0300
Message-ID: <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed kernel
To:     Dave Young <dyoung@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Javier_Ti=C3=A1?= <javier.tia@gmail.com>,
        kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 8, 2021 at 3:29 PM Dave Young <dyoung@redhat.com> wrote:
> On 06/07/21 at 08:18pm, Andy Shevchenko wrote:
> > On Mon, Jun 07, 2021 at 07:22:21PM +0300, Andy Shevchenko wrote:
> > > On Sat, Jun 05, 2021 at 03:51:05PM +0800, Dave Young wrote:
> > > > On 06/02/21 at 11:53am, Andy Shevchenko wrote:
> > > > > On Wed, Jun 02, 2021 at 11:42:14AM +0300, Andy Shevchenko wrote:
> > > > > > On Fri, Dec 02, 2016 at 09:54:14PM +0200, Andy Shevchenko wrote:
> > > > > > > Until now DMI information is lost when kexec'ing. Fix this in the same way as
> > > > > > > it has been done for ACPI RSDP.
> > > > > > >
> > > > > > > Series has been tested on Galileo Gen2 where DMI is used by drivers, in
> > > > > > > particular the default I2C host speed is choosen based on DMI system
> > > > > > > information and now gets it correct.
> > > > > >
> > > > > > Still nothing happens for a while and problem still exists.
> > > > > > Can we do something about it, please?
> > > >
> > > > Seems I totally missed this thread. Old emails lost.
> > >
> > > You can always access to it via lore :-)
> > > https://lore.kernel.org/linux-efi/20161217105721.GB6922@dhcp-128-65.nay.redhat.com/T/#u
>
> Thanks.  Hmm, this is for 32bit efi.  kexec efi boot support was only
> added for 64bit. So if 32bit dmidecode does not work I'm not surprise.
>
> > >
> > > (Okay, it's not full, but contains main parts anyway)
> > >
> > >
> > > > The question Ard asked is to confirm if the firmware converted the
> > > > SMBIOS3 addr to a virtual address after exit boot service. I do not
> > > > remember some easy way to check it due to lost the context of the code.
> > > > But you can try to check it via dmesg|grep SMBIOS both in normal boot
> > > > and kexeced boot log.  And then compare if those addresses are
> > > > identical.
> > > >
> > > > If the SMBIOS3 addr in kexec kernel is different then it should have
> > > > been modified by firmware. Then we need patch kernel and kexec-tools to
> > > > support it.
> > > >
> > > > You can try below patch to see if it works:
> > >
> > > So, AFAIU I have to apply patch to kexec tools for the fist kernel + userspace
> > > and apply kernel patch for the second kernel? Or it's all for the first one?
> > >
> > > > apply a kexec-tools patch to kexec-tools if you do not use kexec -s
> > > > (kexec_file_load):
> > >
> > > Here is how we are using it:
> > > https://github.com/andy-shev/buildroot/blob/intel/board/intel/common/netboot/udhcpc-script.sh#L54
> >
> > Okay, thanks for the patches. I have applied them to both kernels, so the first
> > one and second one are the same and kexec tools have a patch provided in the
> > user space of the both kernels (only first one in use though).
> >
> > Before applying your patch, I have reverted my hacks (as per this series).
> >
> > Result is:
> >
> > # uname -a
> > Linux buildroot 5.13.0-rc5+ #1 SMP Mon Jun 7 19:49:40 EEST 2021 i586 GNU/Linux
> > # dmidecode
> > # dmidecode 3.3
> > Scanning /dev/mem for entry point.
> > # No SMBIOS nor DMI entry point found, sorry.
> >
> > I.o.w. it does NOT fix the issue. My patches do (with a hint from user space).
>
> As I said, since it is 32bit efi, so your test results are expected,
> also no need to check the kernel log about SMBIOS3 address changed or
> not.

So, what shall I do? It's already 5 years passed without any progress
while my patches definitely help here.
Should I rebase and resubmit?

-- 
With Best Regards,
Andy Shevchenko
