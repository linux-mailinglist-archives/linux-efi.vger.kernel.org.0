Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42FC584D04
	for <lists+linux-efi@lfdr.de>; Fri, 29 Jul 2022 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiG2H5c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Jul 2022 03:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbiG2H5b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Jul 2022 03:57:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DD07E027;
        Fri, 29 Jul 2022 00:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2F5D61BF8;
        Fri, 29 Jul 2022 07:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEAAC433D6;
        Fri, 29 Jul 2022 07:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659081450;
        bh=kGpstCAAwPkGYsBYA0Sv1cWBhpQqBl9cZdq6KbVZpIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5ZbaoWIRXMrNQTc535bsP0zIPJb4o4x7G+72avOewl26tmgUH0fnYcLGAm1TRjkG
         wqEuTzdTP5GGSarwRrwLDIPmR7ZtpH/JQSaxOqnbgevhFJYaZFL/c+mM1lO2blfykq
         e/98jXo2dQ75Q6EsD/pRVQ6C38alFpyauc3p8dHA=
Date:   Fri, 29 Jul 2022 09:57:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH 1/2] drivers: serial: earlycon: Pass device-tree node
Message-ID: <YuOS5yUfNlTOtI6U@kroah.com>
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-2-markuss.broks@gmail.com>
 <YuKfaVG/ZbYtFjS/@kroah.com>
 <CAHp75Vfz8e1j4qZ6XY6WqMR4E9fKFxrTxj7P6KraXzSLk_NhxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vfz8e1j4qZ6XY6WqMR4E9fKFxrTxj7P6KraXzSLk_NhxQ@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 28, 2022 at 11:04:24PM +0200, Andy Shevchenko wrote:
> On Thu, Jul 28, 2022 at 4:41 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Thu, Jul 28, 2022 at 05:28:18PM +0300, Markuss Broks wrote:
> > > Pass a pointer to device-tree node in case the driver probed from
> > > OF. This makes early console drivers able to fetch options from
> > > device-tree node properties.
> 
> ...
> 
> > > +     unsigned long node;
> >
> > That should not be an unsigned long, but rather an 'int'.  Something got
> > messed up, of_setup_earlycon() should be changed to reflect this before
> > propagating the error to other places in the kernel.
> 
> It's a pointer, but what puzzles me, why it can't be declared as a such:
> 
>  struct device_node *node;
> 
> ?

It should not be a pointer, trace things backwards, it comes from a call
to of_setup_earlycon() from early_init_dt_scan_chosen_stdout() which has
offset declared as an int, and then does:
	if (of_setup_earlycon(match, offset, options) == 0)

So why would it be a node?

> > And it's not really a "node" but an "offset", right?
> 
> Seems no.

Really?  What am I missing here?

confused,

greg k-h
