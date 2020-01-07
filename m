Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD84D132857
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 15:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgAGOCC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 09:02:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53577 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgAGOCA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 09:02:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so19070316wmc.3
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 06:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZfBt1XnPQmHtcA65JmgHNJdpmVsTg8ZimWizhEKHBU=;
        b=MxmF3bQ6ojh9Q+CMA3LWdl15hXPyq+ReWiqOCLAReNUYnBEzWe8kF7wiMVpJ0B6Y2H
         fK09o7GAaB371NOVF+kc7IqaX8Hc2V1b7dP//vBNPbjV7XBwsjoQ0IHElXUyoglJN0/z
         7O8dwj2+n4JCaesrFtbCf3j9mljMrjc1ZmXwuukURMp4wtij0ZA53WUe/rPPgTLvsVe1
         hvKqnL5j2tIYJqycUdFyvsWg1Hz4d2TymTkGTbh4z1Ze4WyMvWoF4aIN7Y8uJSCYQ7mh
         /a8mk9+saH7igVLr0ExA+KzkTtXWuTOOEytgF0+RYjEiZEB3BHs/3owbI5O1ccYbqrbT
         HZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZfBt1XnPQmHtcA65JmgHNJdpmVsTg8ZimWizhEKHBU=;
        b=ihy2xzRo1abr7i2wIe5JG2o8iO9YwoycQZF8l3yXw2hI6e0X9sHjhivEVxhYm4rqJI
         qzd5oxNt9dpXOnwket3Noul2LdWHj80mb1beERkKssmjTV0W7vLa7hvdkDYzUmIHBDg6
         8UdBXhj3rCgsxMQIAPdjn2mRAUyH+IUuH0fLo3ZeVcmBaEAvsZS8e3D0GbSHDxLFuYWb
         oKd1X4syYQSmRcXMvRlIDeHHmi8IQunZu5vTqr8k6hxRVbIGNYtKlSFmtr8NpzbmBzDk
         jn6fdt1h0hx7fEFmhibPIrb3xwP5DTEd/lhvEIbM/KnoABSzvGVGdh7wsSIjM2yi6tuq
         uvmQ==
X-Gm-Message-State: APjAAAVqFg8dozQMo5xLrp25BmFGxRDLmaBDi9PbqhLO2rJklcJynNLU
        SeMYeVOlk3Q/oA/Qn7R7VxOxV0qHGIPMW35vRh0C+Q==
X-Google-Smtp-Source: APXvYqwFRdzj9kEdRygMPFFeb+MeVUnaYTSqRQfI0W3xZa7LIMDDKLUFk/acXJqHhVZCafz/Y+MmuD1Zpl9ZCj7ZBY0=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr41721058wmc.9.1578405718542;
 Tue, 07 Jan 2020 06:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20200107135500.644618-1-nivedita@alum.mit.edu>
In-Reply-To: <20200107135500.644618-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Jan 2020 15:01:47 +0100
Message-ID: <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Jan 2020 at 14:55, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> This series performs GOT relocation before calling into C code for the
> EFI stub. While the stub does not currently require GOT relocation, it's
> quite easy to introduce code that will use the GOT on old toolchains,
> but not recent ones, which can lead to unexpected issues.
>
> This is based on
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
>
> with commit 4169bb99cd70 ("efi/libstub/x86: use mandatory 16-byte stack
> alignment in mixed mode") reverted, as it caused a crash in mixed mode.
>

Hi Arvind,

I appreciate the effort, but I really don't think this is a good idea.

A GOT is completely pointless in bare metal code, and fortunately,
modern toolchains make it easier to suppress GOT entries from being
emitted. So instead of adding back asm code that I just removed, I
think it would be better to investigate whether we can get rid of the
GOT entirely.




> Arvind Sankar (3):
>   x86/boot/compressed/64: Make adjust_got easier to use repeatedly
>   x86/boot/compressed/32: Allow adjust_got to be called repeatedly
>   x86/boot: Perform GOT relocation before calling EFI stub
>
>  arch/x86/boot/compressed/eboot.c   |  4 +-
>  arch/x86/boot/compressed/head_32.S | 65 +++++++++++++++++++++----
>  arch/x86/boot/compressed/head_64.S | 76 +++++++++++++++++-------------
>  3 files changed, 99 insertions(+), 46 deletions(-)
>
> --
> 2.24.1
>
