Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D233D16F11B
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 22:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgBYV0L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 16:26:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42205 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBYV0K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Feb 2020 16:26:10 -0500
Received: by mail-lf1-f65.google.com with SMTP id 83so289424lfh.9
        for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2020 13:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aofyHzaDTN0lQyvXH5K7/Dsq6NCi7oRX0/IGVa1FXi4=;
        b=uueMW7BOmqE0QQOS1mbvF7IU74dsu1owWz+9+1VZfJibjcicp9C18dm3HxlrUdZmRs
         dArUgOAdxWfas3S0DJH4qNTUg599vjDAdrSmgJaQnZ8OV9Lc/SoO9RSgXv8zWkx7a/pV
         FdUpI89WhBjGp05ZdUQhAzXKiQQKvHyX46w08laYEQ7lqvELHXtLMp4gkdXwoz6xpHPB
         pjGZvzCG82zwpYToB3DiLPdt+zH3QuXCLMnkDZtvjMqlf4d5u710j6woA2/SReNXj5di
         TlRoNXsWvKfSpn3E/838ngPcl7ddAGAiBs8yp9MyROObOwLrjabqeLdJBuQK6758BZUJ
         tyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aofyHzaDTN0lQyvXH5K7/Dsq6NCi7oRX0/IGVa1FXi4=;
        b=fDDbNOb+bjcvBXUtw9lp8wuT3fQ0+CEdpLEEuKdH8f8JkkRuFUrJg+Mkt+DRSES9Y0
         tMcjurM1m6g++HYSZBLBjY+eHjpfzuNekUz4G8NUW/9LaN5RV7nfbd4VOIuzMUwO3Ilk
         p6JKsV2AQHAGXoJi6oNeBzsq3VGzS4IINCh4Bm2nh+er/EqqMVd5bPIL3amLYctsZVR7
         1FTshRFRXVDzUtzcoKI92NUaqscOrG5B/jF4TNjB6DcVQX/1C05Xj+1TLRJt4sp6Dy/B
         8ZXwgrCeRsn6b9AXdIdC0yrbRviVOfEwvhrc6AgXjOFIQpwoMRLOVgmDW2jHT3SHF/dZ
         /YSQ==
X-Gm-Message-State: APjAAAXW44YVdqV2cuDt82Fuk3niKyFKeiKhaIOEmb4TmDDYbAZMpNIN
        d4vjAw7h3d/MCNzZ6uBpuJ2CwzKAajBnDkIZGQNATA==
X-Google-Smtp-Source: APXvYqz/1gJiL8Y4EWaD1mX1Yw2qmsSfjoZtbQUJRWIbo1atsLY4gyHZEXUZoN8OKlAQW72JOeE9fvGcYJlHD2YWjkQ=
X-Received: by 2002:ac2:44a5:: with SMTP id c5mr424248lfm.4.1582665967222;
 Tue, 25 Feb 2020 13:26:07 -0800 (PST)
MIME-Version: 1.0
References: <20200224121733.2202-1-ardb@kernel.org> <CACRpkda5VFzMHE483MPj86VN7uU7w4bNibY=ZeLUHyED=JD7Cw@mail.gmail.com>
 <CAKv+Gu8MOZHFLw-Of5yK15Q1z9gpOmdQNmYF405XRAkeiCoXDw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8MOZHFLw-Of5yK15Q1z9gpOmdQNmYF405XRAkeiCoXDw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Feb 2020 22:25:55 +0100
Message-ID: <CACRpkda1er-gahEAAFLJHimSKo8YwXXTmJAn=0ff9fGdgA0ciQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] ARM: decompressor: use by-VA cache maintenance for
 v7 cores
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 25, 2020 at 6:18 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Tue, 25 Feb 2020 at 16:48, Linus Walleij <linus.walleij@linaro.org> wrote:

> > I took this v3 patch set for a ride on some ARMv7 and ARMv6
> > (hardware) boards using zImage:s so the compressed path
> > should be exercised:
> >
> > - Ux500 (ARMv7 Cortex A9 x 2) works like a charm
> > - RealView PB11MPCore (ARM1176 x 4 MPCore) works like a charm
> >
> > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > I can do more thorough tests with more boards if needed.
>
> Thanks Linus. Do you happen to have any boards that boot with appended DTB?

Oh, both of these use appended DTB so it's definitely working.

Yours,
Linus Walleij
