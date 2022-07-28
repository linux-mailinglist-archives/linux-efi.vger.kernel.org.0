Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923A3584777
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 23:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiG1VFH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 17:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiG1VFF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 17:05:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA706246;
        Thu, 28 Jul 2022 14:05:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j22so5209472ejs.2;
        Thu, 28 Jul 2022 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MGd+LwdnoFiDkdx9krfKLdtj5Dt+fVCB4Sh2nY5wr3c=;
        b=XF5dl8tQGdES7zL4V8n959l0CmDhfnXFccMVTbYlBUZLfCjQCW2qPMmfbke3Yd/FlX
         9fABsmDUHF7O04RUphiNEmVpnNa0o23+ZIp6qz2Az2maaFB95cUS2ePsseQJdQ3OSfP2
         DThFEvF+SzgTIl3wbZG0rnpOug+EUOHtBqSFTlOlcuBSXE6F8myfgnBWOZOVb8hoCvRn
         8p7q8CTOwd6agOrclnY9O5I0Se3vNDlRCzTK7hrjbwu0o0sJN6ID6fRP9CHGgWB+HAAs
         Xnv1Czpa6LOkvjKxnkvJ9XZjINUpRvoqhTQCCbHWn+wKOjPVhKAQyOeKNsajyvA2Tl0o
         /GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MGd+LwdnoFiDkdx9krfKLdtj5Dt+fVCB4Sh2nY5wr3c=;
        b=Uug6i2tfZ03Hlh9SFk2zAHtDZwCS6JWrhQNFoo7vdXqvbFhmDjO9G4U1u0E8T3fqHZ
         PFQF8lJzzPqGIQxuQBAbdqQJPXANtzHypvPy4CQGy18ntT0Rz/2kX9voFB16SdzDV2HF
         eFDPeiMxMEKOTgI4iOlvfFEJzKlbddVw2H5gJ0zePX3wJtbPZB2M7gtEuMMwqUdQLz1d
         qB9RTon9rD84AQ+t4uSUCtCRErUP5+M78pJbMOPrM4YCPwXe5OmodZTnBwixkiskSg+2
         21ZUeH97Da58eeuPZIZvphN6ZYbp5pdMky6sntxiXTtzFXQs2//lDm/KsgeXDbFSGAEd
         H55A==
X-Gm-Message-State: AJIora/ZF89RFcqf8JtHEwd/NuaiySMZf9sVCmZjUSgtNFtHzcTNiEpN
        mmFMJ1/XXTHafzrwcVbAyrSTCv+9yZt3B3zVJEAQzEF6
X-Google-Smtp-Source: AGRyM1vIJyFbUCmOiimEZBEdct0ZkX1TyGOZoJ6hXXMz38/QWz/mBQddZF4BdD7EfWT5LvGdGdK4c7G8zYJPWMb/alg=
X-Received: by 2002:a17:907:28d6:b0:72b:7497:76b with SMTP id
 en22-20020a17090728d600b0072b7497076bmr523196ejc.365.1659042302373; Thu, 28
 Jul 2022 14:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-2-markuss.broks@gmail.com> <YuKfaVG/ZbYtFjS/@kroah.com>
In-Reply-To: <YuKfaVG/ZbYtFjS/@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jul 2022 23:04:24 +0200
Message-ID: <CAHp75Vfz8e1j4qZ6XY6WqMR4E9fKFxrTxj7P6KraXzSLk_NhxQ@mail.gmail.com>
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

On Thu, Jul 28, 2022 at 4:41 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jul 28, 2022 at 05:28:18PM +0300, Markuss Broks wrote:
> > Pass a pointer to device-tree node in case the driver probed from
> > OF. This makes early console drivers able to fetch options from
> > device-tree node properties.

...

> > +     unsigned long node;
>
> That should not be an unsigned long, but rather an 'int'.  Something got
> messed up, of_setup_earlycon() should be changed to reflect this before
> propagating the error to other places in the kernel.

It's a pointer, but what puzzles me, why it can't be declared as a such:

 struct device_node *node;

?

> And it's not really a "node" but an "offset", right?

Seems no.

-- 
With Best Regards,
Andy Shevchenko
