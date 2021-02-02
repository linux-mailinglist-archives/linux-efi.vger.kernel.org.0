Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3130BA16
	for <lists+linux-efi@lfdr.de>; Tue,  2 Feb 2021 09:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhBBIjI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Feb 2021 03:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhBBIjG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Feb 2021 03:39:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9595C061573;
        Tue,  2 Feb 2021 00:38:25 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612255104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XSvnQS472UFc97/OveAYELQREPOxJl2PjuSTa4E+Q7A=;
        b=fOwUz6oMsJL1OT+8YKgVu8YLiGerlC6aoRGuk2gj3WQtUgU8QXSFpJ09U58JpJZXEehe+m
        Qvm+Z3XThUOMXKRyBZB7+bDjUhB+oW1k9PjhHBvhXxRvpDI/pEj0dFjalO7cXIZ6/LmAmw
        AkIet2SuXwlUKmVKo6LYhbu3DnbqfcXWFnkeq13yZS8SZs/yNjBFd+tbOJ43wrJQMUIO4V
        V5ZdDZeEV1oaO/ZC+FkkcD5CvM9I9f9RZUMxvlOWWq7jLpmML8ghyP0xcXUniwX4RVQVj4
        j9+Q4MQbZrSxNHrqAt2SHlSB53aNx+8ux1oL3D+TPkMNegsaWy31lKKV3ki2GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612255104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XSvnQS472UFc97/OveAYELQREPOxJl2PjuSTa4E+Q7A=;
        b=OPu2XNNKWOUcpfxtFJWAMYFL7d6qcjsZokIJEMUiNGj0vWq2dCutTDGvIHWGet1UOF9hx3
        9T+b4TtHpCZ3cXDw==
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
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
In-Reply-To: <20210202070218.856847-1-masahiroy@kernel.org>
References: <20210202070218.856847-1-masahiroy@kernel.org>
Date:   Tue, 02 Feb 2021 09:44:22 +0106
Message-ID: <87eehy27b5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-02-02, Masahiro Yamada <masahiroy@kernel.org> wrote:
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

With commit a8fe19ebfbfd ("kernel/printk: use symbolic defines for
console loglevels") it can be seen that various drivers used to
hard-code their own values. The introduction of the macros in an
intuitive location (include/linux/printk.h) made it easier for authors
to find/use the various available printk settings and thresholds.

Technically there is no problem using Kconfig macros directly. But will
authors bother to hunt down available Kconfig settings? Or will they
only look in printk.h to see what is available?

IMHO if code wants to use settings from a foreign subsystem, it should
be taking those from headers of that subsystem, rather than using some
Kconfig settings from that subsystem. Headers exist to make information
available to external code. Kconfig (particularly for a subsystem) exist
to configure that subsystem.

But my feeling on this may be misguided. Is it generally accepted in the
kernel that any code can use Kconfig settings of any other code?

John Ogness
