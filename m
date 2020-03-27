Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB77F1957F0
	for <lists+linux-efi@lfdr.de>; Fri, 27 Mar 2020 14:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgC0NX6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Mar 2020 09:23:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35242 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NX5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Mar 2020 09:23:57 -0400
Received: by mail-oi1-f193.google.com with SMTP id t25so8751754oij.2
        for <linux-efi@vger.kernel.org>; Fri, 27 Mar 2020 06:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+WEAAjpFVGS5XNVSI7hGlF53hkZ5JzPMh1exX/nd7A=;
        b=Qxe32cfBp+f1mC3FLRCW7pF+zLsPsCkYkInpXG1HiVvZWcBAD0hOETPvqQHqDkQt1+
         I8yxFAN8QRw0EzK9cR+wfYQSMkpRVj+Zv9OFepYSDf2bDHhhoEHM8EhVl506liReYSGe
         2lhe2BVOxna9ruxh70vI60c4en9wagvAhKiJO7Qr9jaLG9EB8i7shuW3c2kg6y7Y2/e3
         Qvzy2Uc/PwxNAIVBt/PgB1jpBHb1vwjMkes2cqKJ5q666jIyzv7IOz04UGBZQiEmSx7W
         vlPlX2eXt+rCTXvE5IgD0A5f1WMmqJ1iGagn+EJG+k0pnAO5REcQqrWxxkmaPyndkG6m
         7H6A==
X-Gm-Message-State: ANhLgQ1CF49Qd+uGgKr5GeWGBzhcYCiNTSxZQTtsmctfdoVyabE9LDoN
        HbDRfNlEyDBJaUr+PyHEyGA3pJwm4rdT0sqsJgE=
X-Google-Smtp-Source: ADFU+vveUylW7NUdtNIS6kGStAP/O+DSrZAqcOLTdjptfRqhLxllGNxMNINXKMIMb12Qh8NWKXA4jI04joDgV7yQ8mQ=
X-Received: by 2002:aca:cdd1:: with SMTP id d200mr3706401oig.153.1585315437038;
 Fri, 27 Mar 2020 06:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200327105906.2665-1-ardb@kernel.org> <20200327105906.2665-3-ardb@kernel.org>
In-Reply-To: <20200327105906.2665-3-ardb@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Mar 2020 14:23:46 +0100
Message-ID: <CAMuHMdWm-Q=B6JZz5VumdFfRcZOTRwT0niugEYrGHbv-id8dZw@mail.gmail.com>
Subject: Re: [PATCH 2/5] ARM: decompressor: split off _edata and stack base
 into separate object
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
> In preparation of moving the handling of the LC0 object to a later stage
> in the decompressor startup code, move out _edata and the initial value
> of the stack pointer, which are now used in two places, and are needed
> earlier than the remaining contents of LC0.
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
