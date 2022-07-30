Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C36D585A16
	for <lists+linux-efi@lfdr.de>; Sat, 30 Jul 2022 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiG3K0Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Jul 2022 06:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiG3K0P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Jul 2022 06:26:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0871A387;
        Sat, 30 Jul 2022 03:26:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b16so930437edd.4;
        Sat, 30 Jul 2022 03:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=l0Q/7yx9FyNBDJt9oRASfJ20HzyIqt7jep5RdGQdu90=;
        b=kdqdPdfXhJMF2w1UJLc87Kqy9nPsRpmxfI7UKx53cigvdJ8cyHSe54qVTNrI6YQ0Tn
         40e+x/LcCMjU1pxuJWC+nZ8aRHGqVld5kwZ1Kf0w2Wgur79tXLwBh8rSq7YTbVMzMqbk
         1DVwsy130N3THSReljll0MNEFs1HbZd5Yc7XZhC6J8NFJyPr9KtVAq/ofE+uV3mQFAqm
         YcSjWpwVAZ6pSrKIGOB2GVK7ucXlONSqQZGGXgFnYb6gbJ2qbeujZjYkqMyYIUmYZt9l
         pXeFF3PVa+MNUjpPgdY/w8jcldeydqpOp1/z9Z+4B9V1O/PWa0bQ/CIPZBtROnIJTDNo
         EzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=l0Q/7yx9FyNBDJt9oRASfJ20HzyIqt7jep5RdGQdu90=;
        b=DlYZFmDD62xjawkHSLI3Uc3PyBz2wNLDPuIl1mOYK9VV7/h91GerICRFvEsXAY6Uwp
         niT838OU8ofu7hNCUUWhEDsLGscZVfNH+Ja+Spp8L4L/7+6lFjPz7OqD5l+uXUVWT+HI
         M5AN0N6KnxlTcIXGd/mBgsJ/BQGDN+EuLlxIOzne3T1f6GpnoyuqN+CLTtxj7l0etTMV
         oLkJIR0gentzF6sDeJW+57gryLTXa921YV6NW/SazwTdcNw+KDs/xfsgzKJMrW95DMZi
         Jb7kAKcGz3WUhci0l68QHEJpnQLLgm3zgbEnD019XB7ZRs3e6LTiWbvKF9x6apNAX9SM
         YLQA==
X-Gm-Message-State: AJIora93ugdPyKob0ENkZa1IH3heP/No4y3ZE0XuMPHFqcqWaXxeQYyY
        Omv4I5yALPWaePmQ7X+i6vNO+HS8M7JhO9JtiF0=
X-Google-Smtp-Source: AGRyM1uzdkY14o0hN5mVxeuk86vh5sIURGkQFnGzfLTCYvW7dVNz/f6Do420hxAyaoLNy5TcoYGS9EXPlPGIYYkEMTM=
X-Received: by 2002:a05:6402:2714:b0:43c:1c1:717e with SMTP id
 y20-20020a056402271400b0043c01c1717emr7419196edd.67.1659176771666; Sat, 30
 Jul 2022 03:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-3-markuss.broks@gmail.com> <CAHp75VdaDyyqRw9fAkUOhNjsyifeozVx6JuYXSU1HpoO+VHDNA@mail.gmail.com>
 <3c55e119-5b6f-25ab-99c9-2c99b1dfd9e9@gmail.com>
In-Reply-To: <3c55e119-5b6f-25ab-99c9-2c99b1dfd9e9@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jul 2022 12:25:34 +0200
Message-ID: <CAHp75Vcu2C-+XyVtLrX8Awxb18uNx6_n3CCCVUyekL4yP755Xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: earlycon: Add support for generic framebuffers
 and move to fbdev subsystem
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jul 30, 2022 at 10:55 AM Markuss Broks <markuss.broks@gmail.com> wrote:
> On 7/29/22 00:19, Andy Shevchenko wrote:
> > On Thu, Jul 28, 2022 at 4:32 PM Markuss Broks <markuss.broks@gmail.com> wrote:

...

> I suppose we could use something like:
>
> if (region_intersects() == REGION_INTERSECTS)

Yes.

...

> >> +       ret = sscanf(device->options, "%u,%u,%u", &info.x, &info.y, &info.depth);
> >> +       if (ret != 3)
> >> +               return -ENODEV;
> >
> > Don't we have some standard template of this, something like XxYxD,
> > where X, Y, and D are respective decimal numbers?
>
> I'm not aware of this.

I believe we won't introduce more chaos in already existing formats of
one or another thing, so I prefer to be stuck with in practice use
(e.g. "1024x768x16" without quotes for x=1024, y=768, depth=16).

-- 
With Best Regards,
Andy Shevchenko
