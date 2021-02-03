Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8830DE0B
	for <lists+linux-efi@lfdr.de>; Wed,  3 Feb 2021 16:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhBCPYN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Feb 2021 10:24:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:45120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234095AbhBCPXy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Feb 2021 10:23:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612365787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v5tD1P3GbXfYcO2FuGCpuZb4rnW2teCslHj/hQe3lGs=;
        b=rdZk0jcdjjKRvFrQGiajPlzLmPJM6hW7+HYHGXxd21KVeaifUuqZKh5B8+YDOd5rG/VHNx
        K6UStUoIZI943Dj37YcjQ7hvx/HTjszR6fq+v4bPw/0EHsi1X24UEdACN4/U1LExMJFYc5
        +dnswT0SuF/EyPD8eQRsmYS3+D5QUEI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3DFA8AC55;
        Wed,  3 Feb 2021 15:23:07 +0000 (UTC)
Date:   Wed, 3 Feb 2021 16:23:06 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org,
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
        dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/3] printk: use CONFIG_CONSOLE_LOGLEVEL_* directly
Message-ID: <YBq/2ojccc4ZZp9y@alley>
References: <20210202070218.856847-1-masahiroy@kernel.org>
 <87eehy27b5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eehy27b5.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue 2021-02-02 09:44:22, John Ogness wrote:
> On 2021-02-02, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > CONSOLE_LOGLEVEL_DEFAULT is nothing more than a shorthand of
> > CONFIG_CONSOLE_LOGLEVEL_DEFAULT.
> >
> > When you change CONFIG_CONSOLE_LOGLEVEL_DEFAULT from Kconfig, almost
> > all objects are rebuilt because CONFIG_CONSOLE_LOGLEVEL_DEFAULT is
> > used in <linux/printk.h>, which is included from most of source files.
> >
> > In fact, there are only 4 users of CONSOLE_LOGLEVEL_DEFAULT:
> >
> >   arch/x86/platform/uv/uv_nmi.c
> >   drivers/firmware/efi/libstub/efi-stub-helper.c
> >   drivers/tty/sysrq.c
> >   kernel/printk/printk.c
> >
> > So, when you change CONFIG_CONSOLE_LOGLEVEL_DEFAULT and rebuild the
> > kernel, it is enough to recompile those 4 files.
> >
> > Remove the CONSOLE_LOGLEVEL_DEFAULT definition from <linux/printk.h>,
> > and use CONFIG_CONSOLE_LOGLEVEL_DEFAULT directly.
> 
> With commit a8fe19ebfbfd ("kernel/printk: use symbolic defines for
> console loglevels") it can be seen that various drivers used to
> hard-code their own values. The introduction of the macros in an
> intuitive location (include/linux/printk.h) made it easier for authors
> to find/use the various available printk settings and thresholds.
> 
> Technically there is no problem using Kconfig macros directly. But will
> authors bother to hunt down available Kconfig settings? Or will they
> only look in printk.h to see what is available?
> 
> IMHO if code wants to use settings from a foreign subsystem, it should
> be taking those from headers of that subsystem, rather than using some
> Kconfig settings from that subsystem. Headers exist to make information
> available to external code. Kconfig (particularly for a subsystem) exist
> to configure that subsystem.

I agree with this this view.

What about using default_console_loglevel() in the external code?
It reads the value from an array. This value is initialized to
CONSOLE_LOGLEVEL_DEFAULT and never modified later.

Best Regards,
Petr
