Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51211957F3
	for <lists+linux-efi@lfdr.de>; Fri, 27 Mar 2020 14:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgC0NY1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Mar 2020 09:24:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43617 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NY0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Mar 2020 09:24:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id p125so8690834oif.10
        for <linux-efi@vger.kernel.org>; Fri, 27 Mar 2020 06:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKthXtFlNti0LSi4OUZW/5dQsmpNf9se60/riHk1XAk=;
        b=gjroWUnPUrMQf40xV5RMOqow/wkHQ7X0p5H7GML69HnvTkGISIQsGjXB9q7FgGzmQM
         QtJmMUFGFLaAtdGJyCVBEhzPYmtvTlM8z+QdNuRv3geCViBnU5w5O9k0GdJxWPiFBbcu
         bYlGiO5Rv2wEFiqWX73pAb7APNozT95YbFKL0iQtbD5ThCGTOHBfUhLLfhkICgvTyy1Z
         nS54hlpp/rYr4F8mkmEPZ3idqrXCAPlC1P8xesO1oGzcg5ZDLTMB8nHQH/rhk//L4WFb
         TZbl5UlAzZCVmrvAULDd9JbFV6sr26ZK8r9g3F40t3zsuXrfEHg1BpXp77yGfW6j6YfR
         JvwQ==
X-Gm-Message-State: ANhLgQ3UUZVYEHJ4mvH30YqovwdKxW25zqoO1bdcBQOYFE4Jkgplbyam
        TG0r+WxIwPlfLTJTLzadCXWYasNOdk5FVFA8Cjs=
X-Google-Smtp-Source: ADFU+vswoFq/dDr3qtbsUGZVp2CzdOz0pAn3X10jnaCb7tmV/fihHKD+GJxSWHt9DZGsDGJs3HUQaf2OBy+b5vhI32o=
X-Received: by 2002:aca:ad93:: with SMTP id w141mr4042623oie.54.1585315465084;
 Fri, 27 Mar 2020 06:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200327105906.2665-1-ardb@kernel.org> <20200327105906.2665-4-ardb@kernel.org>
In-Reply-To: <20200327105906.2665-4-ardb@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Mar 2020 14:24:14 +0100
Message-ID: <CAMuHMdW35FXXvCFY6euA2p5YqN36-Q4M-5kbAvhhypr1K20uLQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] ARM: decompressor: defer loading of the contents of
 the LC0 structure
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Mar 27, 2020 at 11:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> The remaining contents of LC0 are only used after the point in the
> decompressor startup code where we enter via 'wont_overwrite'. So
> move the loading of the LC0 structure after it. This will allow us
> to jump to wont_overwrite directly from the EFI stub, and execute
> the decompressor in place at the offset it was loaded by the UEFI
> firmware.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
