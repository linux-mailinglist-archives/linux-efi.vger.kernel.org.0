Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F81147DB
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 20:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfLETx7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 14:53:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39783 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfLETx7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Dec 2019 14:53:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so5085869wrt.6
        for <linux-efi@vger.kernel.org>; Thu, 05 Dec 2019 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlIgXX8S79c9hYr1npgrhRfrHzdktnd1MvAjrt7OyqY=;
        b=Dv29NPqHgD/veGFhD2SXu9LXbjXrMQcFdCIDvCOWQjom91Hqpe7Voj5ds4DefVXI7+
         eIsVbnS0Arnj8EvsYW6IL3jEKv7SoCZavq+fnx848p1SCYfjDCCpscAJMDQU+bp0ltSn
         Km6wQ7gmj4vNK6xCgNlg/GSsnz9YsYyiXmVfQ2PkA+RaIpkAWEDnX89gOs/MQJDrVK9u
         aVDqljMdoL1iUhDQttmGbZ8K13KU9+A0XdPwUqDVJGQp4CY+I+tpRVLLZ97X2D6bhLm7
         QjtRivErH5QnKpDHDGf+ZzwKI4nGYmrjLsspR6+loyZuEe9QwSBJnxyHouJij3INBp5/
         pF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlIgXX8S79c9hYr1npgrhRfrHzdktnd1MvAjrt7OyqY=;
        b=pV61WV/+NINqqif/l/6i3y4x3C/iA/wGHou7DMDzmHJd37ttR3bNJcFyUO31QnJ4V6
         Wrx3W3rqfmzU6siWG4EfO6GMpBRvdF12eBK1QQCBQ3UWuzpYBuA8lAEUcGyRHEh75I2a
         3UJpik7YMdB7dAY1NgZh+UseSfrbljRYBifl9mANlRK4F1j0M4qr8ldCd4WWDQFVqjmA
         hyShd1rjMKjttzE6V0fAVLyGZ6C63M1T+mPJvXNoShL61fuK4qwYJwqcnet4cDyOabbk
         Q0QPCPz3JAS2yoGym8Y4MDjPjkY5afKs+Vnh8mbDpGIG4aQmHYIMqJa5PuZNWES+pML2
         7bEQ==
X-Gm-Message-State: APjAAAVutlA630KFl+qaLtSCuuHZGrHQ9hPIX7LQOfZRYNJP6d4UZZ1W
        htbzXID4TVKziwW81OA17XTOqbvdyT9lz5mud8gJgg==
X-Google-Smtp-Source: APXvYqw0FCbkLkCck499t/iKb7aLeti9KSgf9rCr9+XB1p7H6Ew7/gipPhnmDo2UyGaMfoxwwyWRokue+5TMYvEpI9c=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr11335413wrj.325.1575575636837;
 Thu, 05 Dec 2019 11:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20191205164248.14511-1-ardb@kernel.org> <20191205185632.GA32742@smile.fi.intel.com>
 <CAKv+Gu8iRfNVAywXvXxEOvV=OTwbCZ62rBDWDV2JdDZpXSRkrA@mail.gmail.com> <20191205194931.GB32742@smile.fi.intel.com>
In-Reply-To: <20191205194931.GB32742@smile.fi.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 5 Dec 2019 19:53:53 +0000
Message-ID: <CAKv+Gu_ORKyTkjW3KFAmxAn_f9dTjhueEmbuDeoyJLyXORYahA@mail.gmail.com>
Subject: Re: [PATCH v4] efi/earlycon: Remap entire framebuffer after page initialization
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 5 Dec 2019 at 19:49, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 05, 2019 at 07:02:56PM +0000, Ard Biesheuvel wrote:
> > On Thu, 5 Dec 2019 at 18:56, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Dec 05, 2019 at 04:42:48PM +0000, Ard Biesheuvel wrote:
>
> > > > +static int __init efi_earlycon_unmap_fb(void)
> > > > +{
> > > > +     /* unmap the bootconsole fb unless keep_bootcon has left it enabled */
> > >
> > > > +     if (efi_fb && !(earlycon_console->flags & CON_ENABLED))
> > >
> > > Isn't efi_fb test superfluous here?
> > >
> >
> > Well, it could be NULL so it is not superfluous. The initcall() is
> > always executed, even if you are not using earlycon=efifb at all.
>
> My point is that memunmap() is no-op for NULL pointer, isn't it?
>

Right. So I could check for earlycon_console != NULL instead, since
that is implied by efi_fb != NULL, but it could be NULL otherwise, in
which case I should not dereference it to get at the flags. But I need
two checks in any case, so I think this is OK.

> > > > +             memunmap(efi_fb);
> > >
> > > > +     return 0;
> > > > +}
> > > > +late_initcall(efi_earlycon_unmap_fb);
>
> > > I still think we need __exitcall() to clean up the stuff in any case.
> > >
> >
> > Why? As far as I can tell, exitcalls go straight into a /DISCARD/
> > section, and I really don't see the point of carrying dead code in
> > this file.
>
> Okay.
>

Thanks,
