Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97E858B9E3
	for <lists+linux-efi@lfdr.de>; Sun,  7 Aug 2022 08:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiHGGxW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Aug 2022 02:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiHGGxV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 Aug 2022 02:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22CFA18A;
        Sat,  6 Aug 2022 23:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ACCF60DE5;
        Sun,  7 Aug 2022 06:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD489C433C1;
        Sun,  7 Aug 2022 06:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659855199;
        bh=1rYnTrs8I+byhJUYy1LkYsWKoVp5KrJVR6dYtv8Vmns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+CoSJGNVIdkrVFDrhcI5xDcQ26g4ahZYt48v/0JnrfwwtzFxzlvGMlUYbp9lg4l2
         7Cu3gJZ8YISWrf5+pwl4mOEanmykz2H2/MAEnDe1IzYaFHrRRZ4l64u7laKd7dI1cL
         inrk+YcYvwRxXEnrhhsW7slK8v309gDbKzyuqovQ=
Date:   Sun, 7 Aug 2022 08:53:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <Yu9hWu8IseJlpCUK@kroah.com>
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-3-markuss.broks@gmail.com>
 <YuKfnAjB4gV0ki4A@kroah.com>
 <30ce6f21-0a91-81cb-8b03-5acff17c59ee@gmail.com>
 <YuKkxb7u3piHytJ8@kroah.com>
 <27b40940-b8a7-2755-1ef5-e97d6b35dd2a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27b40940-b8a7-2755-1ef5-e97d6b35dd2a@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Aug 06, 2022 at 07:26:07PM +0300, Markuss Broks wrote:
> Hi Greg,
> 
> On 7/28/22 18:01, Greg Kroah-Hartman wrote:
> > On Thu, Jul 28, 2022 at 05:52:04PM +0300, Markuss Broks wrote:
> > > Hi Greg,
> > > 
> > > On 7/28/22 17:39, Greg Kroah-Hartman wrote:
> > > > On Thu, Jul 28, 2022 at 05:28:19PM +0300, Markuss Broks wrote:
> > > > > Add early console support for generic linear framebuffer devices.
> > > > > This driver supports probing from cmdline early parameters
> > > > > or from the device-tree using information in simple-framebuffer node.
> > > > > The EFI functionality should be retained in whole.
> > > > > The driver was disabled on ARM because of a bug in early_ioremap
> > > > > implementation on ARM.
> > > > > 
> > > > > Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> > > > > ---
> > > > >    .../admin-guide/kernel-parameters.txt         |  12 +-
> > > > >    MAINTAINERS                                   |   5 +
> > > > >    drivers/firmware/efi/Kconfig                  |   6 +-
> > > > >    drivers/firmware/efi/Makefile                 |   1 -
> > > > >    drivers/firmware/efi/earlycon.c               | 246 --------------
> > > > >    drivers/video/fbdev/Kconfig                   |  11 +
> > > > >    drivers/video/fbdev/Makefile                  |   1 +
> > > > >    drivers/video/fbdev/earlycon.c                | 301 ++++++++++++++++++
> > > > >    8 files changed, 327 insertions(+), 256 deletions(-)
> > > > >    delete mode 100644 drivers/firmware/efi/earlycon.c
> > > > >    create mode 100644 drivers/video/fbdev/earlycon.c
> > > > 
> > > > That should be a rename, not a delete/create, right?
> > > 
> > > Should this change be split into two separate commits,
> > > one for moving the file and the second for making changes?
> > 
> > Git will show a rename and modification properly, if you use -M to git
> > format-patch, so it should be fine.
> 
> It appears that there are so many changes Git would refuse to make it a
> "move" no matter what I do. What should be done here: should it be two
> separate commits for move/change or should it just be kept as delete/create?

One commit to move the file, and then add your changes on top of it
might be the easiest to review, right?

thanks,

greg k-h
