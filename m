Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8445CD5B8F
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2019 08:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfJNGlY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Oct 2019 02:41:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35692 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfJNGlY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Oct 2019 02:41:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id x3so12875489oig.2;
        Sun, 13 Oct 2019 23:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmHAlPJNVe0RaMoOleYG+ZxdJLOlVMYXDAcLrgl89ew=;
        b=mMjClXjIlgilzv9aeGNBsGfFREt8uBuy3j8ZKIq/wY8sXbYaQTQvxLGnjPDrDocKTD
         wMq0fV7nJTR97D5gFOQc/ji3PG88ob2rB//dwaBiX/gfeuQtjj74mSUu8XDS2xzcIYeV
         +RAnk4lx8sq08f4Iz0P8GqXgxWCxN1yV1knHo7uD7sk9lewDFH9hhgypQAG2xUOmHGnY
         9+Mzywr4uxih/KniumVh48LCK7Lt8CU5M1qHeqqzcuuzM4jZYm0yqyDjBzq94AgAybRI
         je6bTakz4LXDmW+jZc7ZLD9zOUgbYpwhm3ZGyROU+Kv7ou+sxmrQGa7UZEdmewenFS/y
         fstg==
X-Gm-Message-State: APjAAAXUViP67+EHTB+Hr05nv/rSpmQkmeJ8gVS22b8con4vyyqvUGIH
        0rISuZ1laKLyQCdcjLzNYwlNA5EZvJbZ0v/VzaI=
X-Google-Smtp-Source: APXvYqzE0ltBaWgdjMHwdV0pHZ9UuO8beeBBO703E9xjvPug1OfxEJ9ZMzOEEO9Q1xUOr3wRPwgpZKZOEMMMFsr1Hpk=
X-Received: by 2002:aca:cf58:: with SMTP id f85mr22254983oig.153.1571035281478;
 Sun, 13 Oct 2019 23:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191013185643.GA2583@localhost.localdomain>
In-Reply-To: <20191013185643.GA2583@localhost.localdomain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Oct 2019 08:41:10 +0200
Message-ID: <CAMuHMdVa_UaaKEf5sSDs+8AWJL7=X5JVPWuW23qtWqK9fpEecA@mail.gmail.com>
Subject: Re: [PATCH v1] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
To:     Narendra K <Narendra.K@dell.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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

Hi Narendra,

On Sun, Oct 13, 2019 at 8:57 PM <Narendra.K@dell.com> wrote:
> From: Narendra K <Narendra.K@dell.com>
>
> For the EFI_RCI2_TABLE kconfig option, 'make oldconfig' asks the user
> for input on platforms where the option may not be applicable. This patch
> modifies the kconfig option to ask the user for input only when CONFIG_X86
> or CONFIG_COMPILE_TEST is set to y.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fix-suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Suggested-by: ...?

> Signed-off-by: Narendra K <Narendra.K@dell.com>

Thanks for your patch!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
