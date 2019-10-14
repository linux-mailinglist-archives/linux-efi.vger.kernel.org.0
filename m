Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D721BD5B9F
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2019 08:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfJNGuF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Oct 2019 02:50:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53679 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfJNGuF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Oct 2019 02:50:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so15907957wmd.3
        for <linux-efi@vger.kernel.org>; Sun, 13 Oct 2019 23:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i556mFwYf8FJIzRWD0xRPKTAzAbrFIRwLz7tLTyc16I=;
        b=e5tNTV2IqKyLBADnPCHorrsl4DDZ/PyUC/We9ZJ/S4okZ5ea9QHFVwRi+yLk9Lji1W
         rdfo7ojt8NP98ddhlVY0DBUWsa5bGfknaH35L9jjjZOcsJ11Y+MlKc+dPNZfQuozaZyQ
         qRKqgEoXTFFwUovAtdAeqCLq+86rxoFgRU/TOPVzJ67GODjs10OBql/M5KHh94TotTGu
         Eha6u9Y93OjZ0J9i+s16TZiYGhykP5lDDwVOiwOZlKDHlGiqXDuxG4wFteH6nTVJibBq
         b+rvDd+8BVTlsgIUNXCS5TT6W2w/9opNbmiB73+3qXweE9hin9cWNWRfpvjGvnidr9ZH
         Yf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i556mFwYf8FJIzRWD0xRPKTAzAbrFIRwLz7tLTyc16I=;
        b=oV3HRQ71UFFU3jRyi9fBw/BjppOz1PLwko3i3IY+k1icqeEzh+2FNmXkSxSBcLhpcr
         jeYQqesE9BSj10cCVDoQyNw2WfSPsgzdK5Gh5yMqp/F/jXYds/cP9hMKkzMlFZGWeiw7
         3Kqf6b0eeh17loBdbC8bZfq3hKATWs3JE9JvnFXfVAkHI0+/GpYhUnJylgeWsQh4EM3s
         Sbq/gD5wLWaa3bL8YyhqxtqTQKiNKBh7UBtNTgSqWJfnuWyWIrcnw6f15OYjWkYqoJ44
         bCg38nXccYi4eV4SwOid3zbFxi/TSMklFsKXDv7A93rus9RerhIMFENihhqSTD3WhF7a
         hq7w==
X-Gm-Message-State: APjAAAXsEaEIs6lwn24XDfPsnuK7WgxJhMTTlsxco3/7DeGEWfP11Pej
        pCJWfPGD2Am8JTdb57xnH/xbnjRCM2p+PtAmJkaqMg==
X-Google-Smtp-Source: APXvYqwAq+OXNwY9aVo/Lrl690GryVGV8D6ew4C8ONbtihdPTW56ZKMcf1xOPQB/BVzluTNHdcktl0gSdrv92qMa37I=
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr14005321wml.10.1571035803709;
 Sun, 13 Oct 2019 23:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191013185643.GA2583@localhost.localdomain> <CAMuHMdVa_UaaKEf5sSDs+8AWJL7=X5JVPWuW23qtWqK9fpEecA@mail.gmail.com>
In-Reply-To: <CAMuHMdVa_UaaKEf5sSDs+8AWJL7=X5JVPWuW23qtWqK9fpEecA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 14 Oct 2019 08:49:51 +0200
Message-ID: <CAKv+Gu-aOHbdG2T9fPp7S4PvRAVosnsnCdsdHEk5PHnSN4gBrQ@mail.gmail.com>
Subject: Re: [PATCH v1] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Narendra K <Narendra.K@dell.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 14 Oct 2019 at 08:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Narendra,
>
> On Sun, Oct 13, 2019 at 8:57 PM <Narendra.K@dell.com> wrote:
> > From: Narendra K <Narendra.K@dell.com>
> >
> > For the EFI_RCI2_TABLE kconfig option, 'make oldconfig' asks the user
> > for input on platforms where the option may not be applicable. This patch
> > modifies the kconfig option to ask the user for input only when CONFIG_X86
> > or CONFIG_COMPILE_TEST is set to y.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Fix-suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Suggested-by: ...?
>

Indeed

> > Signed-off-by: Narendra K <Narendra.K@dell.com>
>
> Thanks for your patch!
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Thanks all. I'll get this queued as a fix.
