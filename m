Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA023CD080
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 11:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhGSIkE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 04:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbhGSIkD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Jul 2021 04:40:03 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6299C061574;
        Mon, 19 Jul 2021 01:21:46 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id h9so20029913oih.4;
        Mon, 19 Jul 2021 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KXyDjJQQkhn/DgOWTg+z85gltafvNNtCXv+7D2OsIg=;
        b=ZDxfvu+wdN7IbZzsgzzkA0eLVaS20RaCpTmbhdJxNKZtfgeGGY9GGqiQ6xpjXtco8l
         7gycpo2Ypu+DVGfAWs4l/TJCaZGSX8f73eAJyhW7yx+jcxQdBgQI5uFkTi8YUPImpmgp
         kku/P9QMY+G4bJofoIRGZyQZ5vnhQfTbrZ3j/+uh1Rt0Z/SsTh4/Yd8vgOH6DZ8AJfU6
         bEQjJ7HvNBYx2jMfpJZfmeG/QNi6dW+uKbvuxOK0AU/gnGn06HB6GrW9xIqyVMIWdNDg
         ZXH9LLQT55rzmB4xZG0gG710hKDMCdrsCKHgNWZvuBNsgaoOC3q8wxyLAR3qzld861Sm
         xvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KXyDjJQQkhn/DgOWTg+z85gltafvNNtCXv+7D2OsIg=;
        b=nspUItWMeKJkeZF4j2RtDIGnaR9GAhYYkP/72YuhhEQdkANW9rCabofbJFsjm4j4XQ
         I0g7537DrGFAlWB+QIUipZT0uuiIp4Hgegedo9n1P4b6ZZd8lGbjnL6qsj+xi7alTYFa
         1qEKVPrLAS0c3VDFVC1R2n2dZRvHU+dIquXEq7apNHgug/p+++qQWRFRwHy0snYdR2uY
         LeGZN02YkV5UCixE6z49Z7peH/YHaPTOsp1P7reVxzTPlpiw3poPH006RSn9oNeUXeee
         pu+kqZv4rZ9MVt59ofKnsSrQlQtfa8N8ipVTGhIW5PDEfBTiUnZlU3B2gROkeaXiVmhH
         qgkw==
X-Gm-Message-State: AOAM531Xf6hcLff+wr19incz9mApVK5baGDTCcciZwg22Ge95ya+wYtv
        GSazGIZVEMF9NhJQsuzn3OLOl+0L8kTVjly0/6WlaGk+jKc=
X-Google-Smtp-Source: ABdhPJyppiB1TqP5m/X/ZDV/yqWvjS9uNiu1wf4TfFpj6Sl9uOVqWIOgzkHNdV5OxmpqYNXUzJVrBdpD4wb32txDxY0=
X-Received: by 2002:a17:90b:1194:: with SMTP id gk20mr24728029pjb.181.1626683161566;
 Mon, 19 Jul 2021 01:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <YLdG91qspr19heDS@smile.fi.intel.com> <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
 <YL5HvUqtsDXx5CzM@smile.fi.intel.com> <YL5U/zSb50SnbLgW@smile.fi.intel.com>
 <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com> <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
 <YMCsSqzmG4jb1Ojo@dhcp-128-65.nay.redhat.com> <YMQ62d1EFFjRcv6w@dhcp-128-65.nay.redhat.com>
 <YMd39tIPercgljll@smile.fi.intel.com> <YMeM1Xee9Yg3j21D@smile.fi.intel.com>
 <YMeRiDMet2JyOV4P@smile.fi.intel.com> <CAMj1kXGnVX7JHM6BGRM6t=NSfDfpYnMp7tyTtWzxP+jha7dexQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGnVX7JHM6BGRM6t=NSfDfpYnMp7tyTtWzxP+jha7dexQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Jul 2021 11:25:21 +0300
Message-ID: <CAHp75VdaMCoqe62QT1heoeUbqKG0e5H41YcpcqDH97g5gKYJyg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed kernel
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Mon, Jul 19, 2021 at 10:53 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Mon, 14 Jun 2021 at 19:27, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
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
> Apologies for chiming in so late - in my defence, I was on vacation :-)
>
> So if I understand the thread correctly, the Surface 3 provides a
> SMBIOS entry point (not SMBIOS3), and it does not get picked up by the
> second kernel, right?
>
> I would still prefer to get to the bottom of this before papering over
> it with command line options. If the memory gets corrupted by the
> first kernel, maybe we are not preserving it correctly in the first
> kernel.

There are _at least_ two platforms which are affected by this:
 - Intel Galileo
 - Microsoft Surface 3

For the time being I'm testing this on the former one. If we get
something working there, I will perform similar tests on the latter
one. And who knows how many more platforms are affected, because kexec
is usually not what many people are using every day, however we (my
teammates and I) use such a setup _a lot_.on a number of platforms It
appears that only those two were found in our zoo to behave badly.

-- 
With Best Regards,
Andy Shevchenko
