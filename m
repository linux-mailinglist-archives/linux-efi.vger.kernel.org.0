Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119742C5CE1
	for <lists+linux-efi@lfdr.de>; Thu, 26 Nov 2020 21:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgKZUKI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Nov 2020 15:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbgKZUKI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Nov 2020 15:10:08 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2241C0613D4;
        Thu, 26 Nov 2020 12:10:06 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id p12so1870096qtp.7;
        Thu, 26 Nov 2020 12:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pRtBJIFBeqqYV9Z9HF2XyEsAvN+gTbeLybLApfNI+U=;
        b=R/0z0D6D3UiuOb4/PIsTixHSCi4K/YiaGY+k56kbrviirYPgadNCjVjI9F+qrfSIfx
         NGBqCFLxRvN4y/zVd/J59agag6oRKP7hfv2/to1Y2M1Xpg44GCl2uld4HlrpVAKtpyVF
         xoZjq8KiAUt+kUe26JdjmpRZKgNYDRW2nN6ha5ROLkYCWmbDXcNfnA5/PywuVxYsQPlX
         30r8xZt3itRHSM0JsYt0hI/XhdqEDvEfMmf0QGkJWTFYsQR+ATWpb6bG3q5Ma2t7wk7v
         JPLW0PkYMax2rLlPTSd9Rjz29klapWASV2eRpmRHFRP0NybNLmtCF7IM3KZxy9O/WV/w
         bJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pRtBJIFBeqqYV9Z9HF2XyEsAvN+gTbeLybLApfNI+U=;
        b=jNN+yT1s6YRMGv9LAU0ltyQNxPWv0y7WuzckFJ8V2W4zKmmvTebrVv2SBjXKmCJWTv
         r75R6fDyoNLtqgwywafaOE90tyggOkj+agODrrbA3vliRa7tSWK7kJwfvoEIVYGubToD
         SxMer4Sg1IbAx6P/PJsVDl7IXaLISECJvOlfa+HsBpSDdaJ45jdqJVoGa7+FuKNV1BUm
         OZiPB19uKWVBPhxAqYSC2s0Mq2mFrncpege9StGpECf37LjVHoiV6XbceS2ou0eAB9os
         Wk6P/B/1V8KX+pgapjyMII/bI7E32GH+UyIOFhPUSdGF5pQFcj+mg0McInlathmguwyl
         IyJA==
X-Gm-Message-State: AOAM5301mpohmV9TgIJlngxw/8yM1yoZFSs74QCtsa1kixPOvu1W7QdB
        cJ8LlFCRmC2rUJ9mDeM4Uml1X6Jxz4roBPTbzKQ=
X-Google-Smtp-Source: ABdhPJxdaGBvyaxgb9tCpfT7vAQyGjSFutNasmeQkN57K5nb2GD6EuRWzIcJc0w0OK6dlPrNjyW9pmEt+iHM1/AWX38=
X-Received: by 2002:ac8:5345:: with SMTP id d5mr4885330qto.60.1606421406101;
 Thu, 26 Nov 2020 12:10:06 -0800 (PST)
MIME-Version: 1.0
References: <5f31cde519b941308412b3849197ee7c@AcuMS.aculab.com>
 <CAMj1kXHhetomAx4Kd5McnvZQev9j1d-C1Og7h+J7V009WTiwxA@mail.gmail.com>
 <c4c57a4b65d57bb7b2e87870a92558a5@natalenko.name> <X74WuTEjLXzAziwJ@kroah.com>
 <31d944b52416dd3fb82902566bc3b23b@natalenko.name>
In-Reply-To: <31d944b52416dd3fb82902566bc3b23b@natalenko.name>
From:   Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date:   Thu, 26 Nov 2020 12:09:55 -0800
Message-ID: <CAA42JLYqy3Kb8Hrz9jFASwcN6KuC6H9SM3Mk1pFjCkUvBKt-zQ@mail.gmail.com>
Subject: Re: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        matthew.garrett@nebula.com, jk@ozlabs.org,
        Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 25, 2020 at 2:11 AM Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> Hello.
>
> On 25.11.2020 09:32, Greg Kroah-Hartman wrote:
> > On Tue, Nov 24, 2020 at 10:24:27PM +0100, Oleksandr Natalenko wrote:
> >> Hi.
> >>
> >> On 24.11.2020 15:23, Ard Biesheuvel wrote:
> >> > Surely caused by
> >> >
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/efivarfs?id=fe5186cf12e30facfe261e9be6c7904a170bd822
> >>
> >> This also soaked through the stable queue into v5.9.11, and now the
> >> same BUG
> >> is triggered in the latest stable kernel.
> >>
> >> /cc Greg
> >
> >  cc: me for what?
> >
> > /me has no context as to what to do here...
>
> This was a precursor to
> https://lore.kernel.org/stable/X74VBej49SCPVisA@kroah.com/ and you
> already jumped in there.
>
> Thanks.
>
> --
>    Oleksandr Natalenko (post-factum)

FYI, I hit the same issue with v5.10.0-rc5. It looks like the issue
has not been fixed in today's Linus tree.

Thanks,
Dexuan
