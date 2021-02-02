Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC44930CF9C
	for <lists+linux-efi@lfdr.de>; Wed,  3 Feb 2021 00:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhBBXF5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Feb 2021 18:05:57 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:22160 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhBBXF4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Feb 2021 18:05:56 -0500
X-Greylist: delayed 57464 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 18:05:53 EST
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 112N4khF003133;
        Wed, 3 Feb 2021 08:04:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 112N4khF003133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612307086;
        bh=UGA0Rplim8ZfC6e4whP20xTht9RzqhbWWxLaXhzWRUA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tOBe0hEHHf9tvmT3rHNnjBL9ugZuudIECWVtYvCik/AC2pP1I4bqBET4RIJ/vBKSB
         0aRw/i7F91TD/PzkclnU2rVRXFMEw6JAzCx93I17/rKXeFG7l0py1WRGJG2fQCZQLj
         q99jD6spPDWOLAzyv0+yHJdvetuJ0mv8N9l2T+24C2KTXwMzAOnAFXBCq1xn8EfdZh
         EqvYL29bZ/OMZE6jEBXdHTulk62/GRSs0uLVCRks7bcTqFsH9kUUbnniWFdepR5nay
         nVRHIn7crbFdyzki6dQc69GxxIU1dobMhHCeavZav8fqc5flWT+QiFEmuYa9o3WH3Q
         4bzZRX2Ms/k9g==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id u11so13344353plg.13;
        Tue, 02 Feb 2021 15:04:46 -0800 (PST)
X-Gm-Message-State: AOAM532yuR3F6Vl6z+NNFjFuGpuWcQl1WLAEmHtTkrLsMp8b4+WdKjrw
        hQrJrSp9A9DIdg9f51DuZe3ED7EZv7t5beQT7aU=
X-Google-Smtp-Source: ABdhPJxvtHfeu+crGL+CyXAo0FUYVHkXnleiaiv+dMA4n8+oso6WU2K79gP3aD12VFT56j8XRv47GWHWmTyr4FAXNxk=
X-Received: by 2002:a17:90b:1b50:: with SMTP id nv16mr88481pjb.153.1612307085830;
 Tue, 02 Feb 2021 15:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20210202070218.856847-1-masahiroy@kernel.org> <YBkk0cZXdwYdXIcD@jagdpanzerIV.localdomain>
In-Reply-To: <YBkk0cZXdwYdXIcD@jagdpanzerIV.localdomain>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 3 Feb 2021 08:04:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQh=bMuyEinKzr6t28E2TuSWAhYU=M+jeJ+HiNhjQN=3A@mail.gmail.com>
Message-ID: <CAK7LNAQh=bMuyEinKzr6t28E2TuSWAhYU=M+jeJ+HiNhjQN=3A@mail.gmail.com>
Subject: Re: [PATCH 1/3] printk: use CONFIG_CONSOLE_LOGLEVEL_* directly
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 2, 2021 at 7:09 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (21/02/02 16:02), Masahiro Yamada wrote:
> >
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
>
> Do you change CONFIG_CONSOLE_LOGLEVEL_DEFAULT so often that it becomes a
> problem?
>
>         -ss



<linux/printk.h> is one of most included headers,
so it is worth downsizing.

CONSOLE_LOGLEVEL_DEFAULT is not such a parameter
that printk() users need to know.

Changing CONFIG_CONSOLE_LOGLEVEL_DEFAULT results in
the rebuilds of the entire tree, which is a flag of
bad code structure.

So, this is not only CONSOLE_LOGLEVEL_DEFAULT.
<linux/printk.h> contains parameters
and func declarations that printk() users
do not need to know.

Examples:
CONSOLE_LOGLEVEL_DEFAULT
log_buf_addr_get()
log_buf_len_get()
oops_in_progress
...


They are only needed for those who want
to more closely get access to
the printk internals.


Ideally, such parameters and func
declarations can go to the subsystems'
local header (kernel/printk/internal.h)
but when it is not possible,
they can be separated out to
a different header.


I can see a similar idea in the consumer/provider
model in several subsystems.

Consumers and providers are often orthogonal,
and de-coupling them clarifies
who needs what.

See other subsystems, for example,

<linux/clk.h>           -  clk consumer
<linux/clk-provider.h>  -  clk provider













--
Best Regards
Masahiro Yamada
