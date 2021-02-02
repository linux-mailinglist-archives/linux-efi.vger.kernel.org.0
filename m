Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17BA30BBDC
	for <lists+linux-efi@lfdr.de>; Tue,  2 Feb 2021 11:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBBKNj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Feb 2021 05:13:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhBBKNh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 2 Feb 2021 05:13:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D1AC64EE2;
        Tue,  2 Feb 2021 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612260775;
        bh=a9JpeLTPXuDOqgu+ithu1Vjt2uPFzg7y0tFXGXpxM34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2G7Sa2W2ilSNpuWlzi5xy2tjO1cPC84KVISQKCBmXkdFncJ0agNWmtpKRNGXthS7M
         rd2RAlsEu/8qmLpx/S4Q9Tb4/zkCloMzc6hNLmvZhgw4B4eBq90pJ8K/CHAPqsTO5q
         /uTrJLoBQx5z3FubOBQqvQ5cnYa4wvWYyC/ml7P8=
Date:   Tue, 2 Feb 2021 11:12:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
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
Message-ID: <YBklpQ1PrVc5iEQl@kroah.com>
References: <20210202070218.856847-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202070218.856847-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 02, 2021 at 04:02:16PM +0900, Masahiro Yamada wrote:
> CONSOLE_LOGLEVEL_DEFAULT is nothing more than a shorthand of
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT.
> 
> When you change CONFIG_CONSOLE_LOGLEVEL_DEFAULT from Kconfig, almost
> all objects are rebuilt because CONFIG_CONSOLE_LOGLEVEL_DEFAULT is
> used in <linux/printk.h>, which is included from most of source files.
> 
> In fact, there are only 4 users of CONSOLE_LOGLEVEL_DEFAULT:
> 
>   arch/x86/platform/uv/uv_nmi.c
>   drivers/firmware/efi/libstub/efi-stub-helper.c
>   drivers/tty/sysrq.c
>   kernel/printk/printk.c
> 
> So, when you change CONFIG_CONSOLE_LOGLEVEL_DEFAULT and rebuild the
> kernel, it is enough to recompile those 4 files.
> 
> Remove the CONSOLE_LOGLEVEL_DEFAULT definition from <linux/printk.h>,
> and use CONFIG_CONSOLE_LOGLEVEL_DEFAULT directly.
> 
> With this, the build system will rebuild the minimal number of objects.
> 
> Steps to confirm it:
> 
>   [1] Do the full build
>   [2] Change CONFIG_CONSOLE_LOGLEVEL_DEFAULT from 'make menuconfig' etc.
>   [3] Rebuild
> 
>   $ make
>     SYNC    include/config/auto.conf
>     CALL    scripts/checksyscalls.sh
>     CALL    scripts/atomic/check-atomics.sh
>     DESCEND  objtool
>     CHK     include/generated/compile.h
>     CC      kernel/printk/printk.o
>     AR      kernel/printk/built-in.a
>     AR      kernel/built-in.a
>     CC      drivers/tty/sysrq.o
>     AR      drivers/tty/built-in.a
>     CC      drivers/firmware/efi/libstub/efi-stub-helper.o
>     STUBCPY drivers/firmware/efi/libstub/efi-stub-helper.stub.o
>     AR      drivers/firmware/efi/libstub/lib.a
>     AR      drivers/built-in.a
>     GEN     .version
>     CHK     include/generated/compile.h
>     UPD     include/generated/compile.h
>     CC      init/version.o
>     AR      init/built-in.a
>     LD      vmlinux.o
>     ...
> 
> For the same reason, do likewise for CONSOLE_LOGLEVEL_QUIET and
> MESSAGE_LOGLEVEL_DEFAULT.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/x86/platform/uv/uv_nmi.c                  |  2 +-
>  drivers/firmware/efi/libstub/efi-stub-helper.c |  6 +++---
>  drivers/tty/sysrq.c                            |  4 ++--
>  drivers/video/fbdev/core/fbcon.c               |  2 +-
>  drivers/video/fbdev/efifb.c                    |  2 +-
>  include/linux/printk.h                         | 10 ----------
>  init/main.c                                    |  2 +-
>  kernel/printk/printk.c                         |  6 +++---
>  8 files changed, 12 insertions(+), 22 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
