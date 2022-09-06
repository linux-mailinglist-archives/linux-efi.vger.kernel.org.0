Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C45AF487
	for <lists+linux-efi@lfdr.de>; Tue,  6 Sep 2022 21:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiIFTkV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Sep 2022 15:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIFTkK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Sep 2022 15:40:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DB621E3B
        for <linux-efi@vger.kernel.org>; Tue,  6 Sep 2022 12:39:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c131-20020a1c3589000000b003a84b160addso9552363wma.2
        for <linux-efi@vger.kernel.org>; Tue, 06 Sep 2022 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=Q7k34QMFna+VMCWcVTBpDYwMMQqIocaQ24VXbz0U53E=;
        b=fSlBCXUTu5f+ysIYWkhIOcXEh0jK1dX6We3GoYUzQZD/pi1UP7PLGgh3ddRR5nF4bd
         IXrbHJCXywJEJD1/6lFMXsX2r6MtDTGZWi+ivQLGsdFh0rfWi0HwvRiTFhb2CKJArtDF
         0cOn3TBXU4djET4/KpQEUGdEZGhaaUKc7Vuxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Q7k34QMFna+VMCWcVTBpDYwMMQqIocaQ24VXbz0U53E=;
        b=k/R9g1GY8BWAsRHvjKa54BBhullmWtmBBbBCPdZZ+F6Xf7eEpbom2wGEP2t136ppFB
         K5JlmKeUj2B3FFw8lIp29wOGI5cc6/WFSqZ3DqLxiJKQV8oTWtU9CBywgsUHdgGR8RV/
         +bFknr8kNG0iHbs5fgWLMUs0YeKa649oTS/XmM6rvuVWp9k5Bsn8grVNGLTxoD2YA1lt
         jCsOL1dW1S/R4s1knyz9YZx0KlUCaqG2nTKDT8nDlJOV7PD4va4TwDfcXVxL86qu7TA1
         2W/774hV4wOVFNfhlsM6Cv3mx2Et4kpbuNwLLoJl8WF1+pXK5QyeeaKFErldRS/vA7Q4
         pItQ==
X-Gm-Message-State: ACgBeo0RtkXwvoXW7rgnHhGwIlH0BI3hgpIwYjPx55IzPS/2WZjFXzRx
        TSQcjqWwQ0AHtYHBc9WLFS88RQ==
X-Google-Smtp-Source: AA6agR7dO/5mx+p7Bq5UKEq1+BC5n76RbAm/1S4e5aby/E5HZfLdP8Mmz+/OpcL0OycEbj++i728uQ==
X-Received: by 2002:a05:600c:1554:b0:3a6:23d7:1669 with SMTP id f20-20020a05600c155400b003a623d71669mr14922175wmg.70.1662493188711;
        Tue, 06 Sep 2022 12:39:48 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm8083000wrc.41.2022.09.06.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:39:48 -0700 (PDT)
Date:   Tue, 6 Sep 2022 21:39:45 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org,
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
        Tony Lindgren <tony@atomide.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] efi: earlycon: Add support for generic framebuffers
 and move to fbdev subsystem
Message-ID: <YxeiAbw0OLb7OP7V@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
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
        Tony Lindgren <tony@atomide.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-3-markuss.broks@gmail.com>
 <YuKfnAjB4gV0ki4A@kroah.com>
 <30ce6f21-0a91-81cb-8b03-5acff17c59ee@gmail.com>
 <YuKkxb7u3piHytJ8@kroah.com>
 <27b40940-b8a7-2755-1ef5-e97d6b35dd2a@gmail.com>
 <Yu9hWu8IseJlpCUK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu9hWu8IseJlpCUK@kroah.com>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Aug 07, 2022 at 08:53:14AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Aug 06, 2022 at 07:26:07PM +0300, Markuss Broks wrote:
> > Hi Greg,
> > 
> > On 7/28/22 18:01, Greg Kroah-Hartman wrote:
> > > On Thu, Jul 28, 2022 at 05:52:04PM +0300, Markuss Broks wrote:
> > > > Hi Greg,
> > > > 
> > > > On 7/28/22 17:39, Greg Kroah-Hartman wrote:
> > > > > On Thu, Jul 28, 2022 at 05:28:19PM +0300, Markuss Broks wrote:
> > > > > > Add early console support for generic linear framebuffer devices.
> > > > > > This driver supports probing from cmdline early parameters
> > > > > > or from the device-tree using information in simple-framebuffer node.
> > > > > > The EFI functionality should be retained in whole.
> > > > > > The driver was disabled on ARM because of a bug in early_ioremap
> > > > > > implementation on ARM.
> > > > > > 
> > > > > > Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> > > > > > ---
> > > > > >    .../admin-guide/kernel-parameters.txt         |  12 +-
> > > > > >    MAINTAINERS                                   |   5 +
> > > > > >    drivers/firmware/efi/Kconfig                  |   6 +-
> > > > > >    drivers/firmware/efi/Makefile                 |   1 -
> > > > > >    drivers/firmware/efi/earlycon.c               | 246 --------------
> > > > > >    drivers/video/fbdev/Kconfig                   |  11 +
> > > > > >    drivers/video/fbdev/Makefile                  |   1 +
> > > > > >    drivers/video/fbdev/earlycon.c                | 301 ++++++++++++++++++
> > > > > >    8 files changed, 327 insertions(+), 256 deletions(-)
> > > > > >    delete mode 100644 drivers/firmware/efi/earlycon.c
> > > > > >    create mode 100644 drivers/video/fbdev/earlycon.c
> > > > > 
> > > > > That should be a rename, not a delete/create, right?
> > > > 
> > > > Should this change be split into two separate commits,
> > > > one for moving the file and the second for making changes?
> > > 
> > > Git will show a rename and modification properly, if you use -M to git
> > > format-patch, so it should be fine.
> > 
> > It appears that there are so many changes Git would refuse to make it a
> > "move" no matter what I do. What should be done here: should it be two
> > separate commits for move/change or should it just be kept as delete/create?
> 
> One commit to move the file, and then add your changes on top of it
> might be the easiest to review, right?

+1

I think this should be a least
- commit to move the file, as unchanged as possible
- commit to auto-select the right mapping mode (or maybe that's only in
  v2)
- actual change to add the simplefb support with a clearly readable diff

But also video/console is for Greg to maintain, I'm trying hard to not go
even more stupid :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
