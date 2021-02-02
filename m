Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F8630BBCD
	for <lists+linux-efi@lfdr.de>; Tue,  2 Feb 2021 11:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBBKKQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Feb 2021 05:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhBBKKF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Feb 2021 05:10:05 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA393C0613D6;
        Tue,  2 Feb 2021 02:09:25 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b8so12181506plh.12;
        Tue, 02 Feb 2021 02:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FYeJLFgukpjjaiX0ohZ3jkdwwwc8rHopLauzuSIyIdw=;
        b=tV+v78ppPBh5j1qozvGytXqYRH3YTJdedkA+I8BKPM/+ZtmYvrTzBWbeVfXbArKUSM
         iN4DyO4rLEKMayZ/QM19bmkFz6e2qX/7WaBp+PIDYEig7nWtknkexxzua6XvFhgpHqne
         lMEJZfTOQk7alc33ttk1hifGy5+zTtIrFKaHTSf6mg9Tfz5AO0tqYi4erZkvNM02mM7F
         34qhUEHyyimt6uvazTjZyHv98SSh3Jyu5L4GyjX35aHc1AQuPb7R2MgE/5cvZaUS1c2/
         oW/pTvabA1T2TAr4fqG1xQ9yyF5eenOs5p6igNbRJQAuRb/uXxQJoOvzreh2AVCzW5ld
         4Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FYeJLFgukpjjaiX0ohZ3jkdwwwc8rHopLauzuSIyIdw=;
        b=bOIzmPHvRpzgmS1MmP9MuyPEs2lHHMSPd5xHbplR/n2Nkuoow4i8P7LrCQQXSCeBS1
         QvNEFeKzRbFhC6uC12aL5DJtv1XUUVGpZ3pvo/aD+YB1GW3KheCp70vakvw2UOeHTMI8
         m8zvpgXyhpfjg2go7ZtNRWUnja84KPvwMWfX/ntL59ar6A4MAFRRmifjg1194UOWYQmZ
         TO48u5iO/2tHoiwEbDQXds+4SPq4RhWUov2Rj9DXUTOGwebtl3a2Xj91Do65PGYJXQRA
         LoThXRCR0PF8rrB4Aqhe2LXlpB/duLiDGceGSBlArcWt9GyXEKNwjokHvvnIeobRMGPY
         mYaA==
X-Gm-Message-State: AOAM530B6XEA5phDOS5fsxDvc4l8ytxSDmE/WxwxWGcs/xP4Q7NFpd1R
        RdRQ8vWY/zKTKkDk7GCE5dqcHAMlQE5jlw==
X-Google-Smtp-Source: ABdhPJzOiwWh5mPPYa1i19XPG4Fp5MvPpEcfOWz0ooMRC2HOki3phGTorM9UmMcRGoRVm4K5OTM51w==
X-Received: by 2002:a17:90a:d02:: with SMTP id t2mr3397288pja.130.1612260565335;
        Tue, 02 Feb 2021 02:09:25 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id l2sm21403893pga.65.2021.02.02.02.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 02:09:24 -0800 (PST)
Date:   Tue, 2 Feb 2021 19:09:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
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
Message-ID: <YBkk0cZXdwYdXIcD@jagdpanzerIV.localdomain>
References: <20210202070218.856847-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202070218.856847-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On (21/02/02 16:02), Masahiro Yamada wrote:
> 
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

Do you change CONFIG_CONSOLE_LOGLEVEL_DEFAULT so often that it becomes a
problem?

	-ss
