Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AD530F04C
	for <lists+linux-efi@lfdr.de>; Thu,  4 Feb 2021 11:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbhBDKQt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Feb 2021 05:16:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:45166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235298AbhBDKQs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 4 Feb 2021 05:16:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612433761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YQZOldqCtjkPupLVxZdZt2KMNRlzizKTv66MNg9zXPI=;
        b=eG3gMKWPwUW01tBEcoF29Eq8Y2qgWWLBNZ4+YaIbBZueMMVpDTfz8dCp+gPebXm6bb9Uyr
        5KShIQZ5qKE24SnDt53w84yolfaTNcLWCnwArKLdZ6BnyxhVhsi0OUrlmnGKLhqto6NEKb
        y18uDsei/XZXTChu+NYikcxbz/ke1mQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 478AFAC97;
        Thu,  4 Feb 2021 10:16:01 +0000 (UTC)
Date:   Thu, 4 Feb 2021 11:16:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mike Travis <mike.travis@hpe.com>,
        Peter Jones <pjones@redhat.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, X86 ML <x86@kernel.org>
Subject: Re: [PATCH 1/3] printk: use CONFIG_CONSOLE_LOGLEVEL_* directly
Message-ID: <YBvJYHW7iVhtlJfh@alley>
References: <20210202070218.856847-1-masahiroy@kernel.org>
 <87eehy27b5.fsf@jogness.linutronix.de>
 <YBq/2ojccc4ZZp9y@alley>
 <CAK7LNAQyV-asWNY6CK6MWze9sFZS3CgXxtH2LEht5e=kjrLu7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQyV-asWNY6CK6MWze9sFZS3CgXxtH2LEht5e=kjrLu7w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu 2021-02-04 06:51:09, Masahiro Yamada wrote:
> On Thu, Feb 4, 2021 at 12:23 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Tue 2021-02-02 09:44:22, John Ogness wrote:
> > > On 2021-02-02, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > CONSOLE_LOGLEVEL_DEFAULT is nothing more than a shorthand of
> > > > CONFIG_CONSOLE_LOGLEVEL_DEFAULT.
> > > >
> > > > When you change CONFIG_CONSOLE_LOGLEVEL_DEFAULT from Kconfig, almost
> > > > all objects are rebuilt because CONFIG_CONSOLE_LOGLEVEL_DEFAULT is
> > > > used in <linux/printk.h>, which is included from most of source files.
> > > >
> > > > In fact, there are only 4 users of CONSOLE_LOGLEVEL_DEFAULT:
> > > >
> > > >   arch/x86/platform/uv/uv_nmi.c
> > > >   drivers/firmware/efi/libstub/efi-stub-helper.c
> > > >   drivers/tty/sysrq.c
> > > >   kernel/printk/printk.c
> > > >
> > > > So, when you change CONFIG_CONSOLE_LOGLEVEL_DEFAULT and rebuild the
> > > > kernel, it is enough to recompile those 4 files.
> > > >
> > > > Remove the CONSOLE_LOGLEVEL_DEFAULT definition from <linux/printk.h>,
> > > > and use CONFIG_CONSOLE_LOGLEVEL_DEFAULT directly.
> > >
> > > With commit a8fe19ebfbfd ("kernel/printk: use symbolic defines for
> > > console loglevels") it can be seen that various drivers used to
> > > hard-code their own values. The introduction of the macros in an
> > > intuitive location (include/linux/printk.h) made it easier for authors
> > > to find/use the various available printk settings and thresholds.
> > >
> > > Technically there is no problem using Kconfig macros directly. But will
> > > authors bother to hunt down available Kconfig settings? Or will they
> > > only look in printk.h to see what is available?
> > >
> > > IMHO if code wants to use settings from a foreign subsystem, it should
> > > be taking those from headers of that subsystem, rather than using some
> > > Kconfig settings from that subsystem. Headers exist to make information
> > > available to external code. Kconfig (particularly for a subsystem) exist
> > > to configure that subsystem.
> >
> > I agree with this this view.
> 
> 
> I have never seen a policy to restrict
> the use of CONFIG options in relevant
> subsystem headers.

I would say that it is a common sense. But I admit that I did not look
at the code in detail. See below.

> > What about using default_console_loglevel() in the external code?
> > It reads the value from an array. This value is initialized to
> > CONSOLE_LOGLEVEL_DEFAULT and never modified later.
> 
> I do not think default_console_loglevel()
> is a perfect constant
> because it can be modified via
> /proc/sys/kernel/printk

And that is the problem. I somehow expected that the external code
wanted to have the currently valid value and not the prebuilt one.

When I look closely:

  + arch/x86/platform/uv/uv_nmi.c
  + drivers/firmware/efi/libstub/efi-stub-helper.c

    These use the value to statically initialize global variables that
    might later be modified by subsystem-specific kernel parameters.

    CONFIG_CONSOLE_LOGLEVEL_DEFAULT is acceptable here from my POV.
    The build dependency sucks. And it is not worth any too complicated
    solution.


  + drivers/tty/sysrq.c

    The intention here is to use the highest console loglevel so that
    people really see them. It used to be hardcoded "7". sysrq is
    typically the last chance to get some information from the system.

    We actually want to use the hardcoded "7" here. But we should
    define it via a macro in printk.h, e.g.

     #define CONSOLE_LOGLEVEL_ALL_NORMAL 7 /* all non-debugging messages */

     or

     #define CONSOLE_LOGLEVEL_NO_DEBUG 7  /* all non-debugging messages */

Best Regards,
Petr
