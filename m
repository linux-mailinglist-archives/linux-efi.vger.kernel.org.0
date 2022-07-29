Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFFE584F2D
	for <lists+linux-efi@lfdr.de>; Fri, 29 Jul 2022 12:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiG2KsQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Jul 2022 06:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiG2KsO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Jul 2022 06:48:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF52A1AD;
        Fri, 29 Jul 2022 03:48:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z18so5312714edb.10;
        Fri, 29 Jul 2022 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3n/U/FQWga428NP8njwRwJq8YQtOFS7dE4r1PAnkS1w=;
        b=NUwJ6Ia5ztlFAPJRSi//yXxSQSxStivnbYzEDrxWCEUcunK9mPPbSDW9UDDz5jYYTf
         5/3Tv/X7zyoHU/COku0GH9BU+wnuhqnwNFhGBh/oBwLrmzhgi2WmL6r/pQigVKDP+2wN
         r2nnp+tCjUus1cege2Vm5IiCUqgIiTt4/grj8tzAwe+OtUD4H+EwBDhK/GPRq3Lq3Riq
         OU7YrReBurHOIdx3AJ1A2MhkIWr3n3xTalz66sqsFBkMks+QVyqGj8zIaTAQPSbuEfQf
         8cevW1Q80DurxbNMHDhAvDW9cs5zdQWNQyPeZtlVDDib66Jn5ZADWJkEZ//9TVlc5tq5
         Kiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3n/U/FQWga428NP8njwRwJq8YQtOFS7dE4r1PAnkS1w=;
        b=zHm82nlJ9x4xd8lO9Q8TwwhBPELe0WiAZiEc3E+uY71Dnr6RAn8Rk6/ydgPwAxBxrR
         3CRu1godetGM4Q6Ir/pWtNdAVYlF8+317V7SnqSAMKaoS/qJ7ZXR8vZT89+Lr8SFhI00
         BTHeuhWfaC+eLbcOUO2B7c9x/2gb73dSMF2aEBUqxjaasqJGBBrqlG225n5osWaZzZ6D
         xvdRrXYwDw+ckzur6wMOCIoPmR30T8qb3rWsEStLsXsD3z/sRlAVCQOAPCKAzw3gANfe
         QZN/PwjNfQ6+NT50qrCPcAGKNg9riE9SbEZ3hJcpxQQ5P5njeb0QSYABGINyifm4+Dnd
         4TMA==
X-Gm-Message-State: AJIora8w+u/RFNE81Ht6KgBTc15QZ6QhbOjgogmbjsl+h+cNrqoXjZKh
        YtHzpX8xHrEODFVz+QeuCK8l7bW5g9lfqPnOYYY=
X-Google-Smtp-Source: AGRyM1swfkCmQwapy/e5MLB35AJLdgSMfrw8dhx1rZSpZi2iRMETLlJ8/O9gf/GWaYLbPNQzerUI5dsp0GToPimD/Xw=
X-Received: by 2002:a05:6402:2714:b0:43c:1c1:717e with SMTP id
 y20-20020a056402271400b0043c01c1717emr2983928edd.67.1659091692189; Fri, 29
 Jul 2022 03:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-2-markuss.broks@gmail.com> <YuKfaVG/ZbYtFjS/@kroah.com>
 <CAHp75Vfz8e1j4qZ6XY6WqMR4E9fKFxrTxj7P6KraXzSLk_NhxQ@mail.gmail.com> <YuOS5yUfNlTOtI6U@kroah.com>
In-Reply-To: <YuOS5yUfNlTOtI6U@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jul 2022 12:47:35 +0200
Message-ID: <CAHp75VcqtO5E91e5HxM6qN3gcMH5-_h=508chyDiWzvmLiFn6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: serial: earlycon: Pass device-tree node
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        Petr Mladek <pmladek@suse.com>
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

On Fri, Jul 29, 2022 at 9:57 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jul 28, 2022 at 11:04:24PM +0200, Andy Shevchenko wrote:
> > On Thu, Jul 28, 2022 at 4:41 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Thu, Jul 28, 2022 at 05:28:18PM +0300, Markuss Broks wrote:

...

> > > > +     unsigned long node;
> > >
> > > That should not be an unsigned long, but rather an 'int'.  Something got
> > > messed up, of_setup_earlycon() should be changed to reflect this before
> > > propagating the error to other places in the kernel.
> >
> > It's a pointer, but what puzzles me, why it can't be declared as a such:
> >
> >  struct device_node *node;
> >
> > ?
>
> It should not be a pointer, trace things backwards, it comes from a call
> to of_setup_earlycon() from early_init_dt_scan_chosen_stdout() which has
> offset declared as an int, and then does:
>         if (of_setup_earlycon(match, offset, options) == 0)
>
> So why would it be a node?

This is a very good question.

> > > And it's not really a "node" but an "offset", right?
> >
> > Seems no.
>
> Really?  What am I missing here?

It's me who is missing something here, thanks for your elaboration!
After it it becomes clear that your first question should be
addressed.

-- 
With Best Regards,
Andy Shevchenko
