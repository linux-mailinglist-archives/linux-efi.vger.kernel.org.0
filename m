Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7556058427D
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 17:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiG1PBc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 11:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiG1PB3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 11:01:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F212F663;
        Thu, 28 Jul 2022 08:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64805619A0;
        Thu, 28 Jul 2022 15:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0B4C433C1;
        Thu, 28 Jul 2022 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659020487;
        bh=AnGfT+ICsOyh5alSICQ2W481AGcoHD5Y+3Yjrk8MoK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWDZDXIRbUZ/IoBQeMzzoHOc5I2XHIwsTCKOeb2aQomZWw6DzieJDUzQEbGaqLe+0
         GuKlglVyhlolxfqdliF2m8KVh6DVDom4+rgyjGJ2nPulYrYgxdsVOFP7ZsA6/8nN09
         7rHvsufLcp53MTiIJcJGydPBj/k+wfMofQWXFGSo=
Date:   Thu, 28 Jul 2022 17:01:25 +0200
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
Message-ID: <YuKkxb7u3piHytJ8@kroah.com>
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-3-markuss.broks@gmail.com>
 <YuKfnAjB4gV0ki4A@kroah.com>
 <30ce6f21-0a91-81cb-8b03-5acff17c59ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ce6f21-0a91-81cb-8b03-5acff17c59ee@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 28, 2022 at 05:52:04PM +0300, Markuss Broks wrote:
> Hi Greg,
> 
> On 7/28/22 17:39, Greg Kroah-Hartman wrote:
> > On Thu, Jul 28, 2022 at 05:28:19PM +0300, Markuss Broks wrote:
> > > Add early console support for generic linear framebuffer devices.
> > > This driver supports probing from cmdline early parameters
> > > or from the device-tree using information in simple-framebuffer node.
> > > The EFI functionality should be retained in whole.
> > > The driver was disabled on ARM because of a bug in early_ioremap
> > > implementation on ARM.
> > > 
> > > Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> > > ---
> > >   .../admin-guide/kernel-parameters.txt         |  12 +-
> > >   MAINTAINERS                                   |   5 +
> > >   drivers/firmware/efi/Kconfig                  |   6 +-
> > >   drivers/firmware/efi/Makefile                 |   1 -
> > >   drivers/firmware/efi/earlycon.c               | 246 --------------
> > >   drivers/video/fbdev/Kconfig                   |  11 +
> > >   drivers/video/fbdev/Makefile                  |   1 +
> > >   drivers/video/fbdev/earlycon.c                | 301 ++++++++++++++++++
> > >   8 files changed, 327 insertions(+), 256 deletions(-)
> > >   delete mode 100644 drivers/firmware/efi/earlycon.c
> > >   create mode 100644 drivers/video/fbdev/earlycon.c
> > 
> > That should be a rename, not a delete/create, right?
> 
> Should this change be split into two separate commits,
> one for moving the file and the second for making changes?

Git will show a rename and modification properly, if you use -M to git
format-patch, so it should be fine.
