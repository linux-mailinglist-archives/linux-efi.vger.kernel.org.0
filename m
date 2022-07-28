Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D5A5842CB
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiG1PQx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 11:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiG1PQw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 11:16:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569B846D93;
        Thu, 28 Jul 2022 08:16:50 -0700 (PDT)
Received: from mail-ed1-f48.google.com ([209.85.208.48]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N4R4o-1nHwPf1aDu-011SJ4; Thu, 28 Jul 2022 17:16:49 +0200
Received: by mail-ed1-f48.google.com with SMTP id z15so2575047edc.7;
        Thu, 28 Jul 2022 08:16:49 -0700 (PDT)
X-Gm-Message-State: AJIora89W2UCTWHyw2Opf6RLtXodZIQWv5s1za0N2/J6HrS+owSyITSi
        Y+Pz9FNkPhqKhnJQMwkYp0K9t9nTVaf+sinGkXs=
X-Google-Smtp-Source: AGRyM1vWuOSQ5jkdH83jWj0RrtQb7QqIeQadUBaSrg3Qh2GudbEb/nqWHTWnFuVbZrtnJIU4rYColKF2SYdmGBop/yk=
X-Received: by 2002:a05:6402:1d4c:b0:43b:c85f:5c95 with SMTP id
 dz12-20020a0564021d4c00b0043bc85f5c95mr28453461edb.213.1659021408962; Thu, 28
 Jul 2022 08:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-3-markuss.broks@gmail.com> <CAK8P3a2fZ9O6vSEyxY1KW71pG_Oyvwxp3zTbW2GuaSD6aj+Qfw@mail.gmail.com>
 <8e694cb6-c3dc-74e3-6804-fc532f108523@gmail.com>
In-Reply-To: <8e694cb6-c3dc-74e3-6804-fc532f108523@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Jul 2022 17:16:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2vJFCJmeMj-vuasUhwa2=2P+hAr=ScGhT21TcjQ1Z8Aw@mail.gmail.com>
Message-ID: <CAK8P3a2vJFCJmeMj-vuasUhwa2=2P+hAr=ScGhT21TcjQ1Z8Aw@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: earlycon: Add support for generic framebuffers
 and move to fbdev subsystem
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rCxTKLoMsKF+qy1+w1yA5c+w412i/gDEbQw04N3nxbN3DJdhvUp
 F2gi5G/PFuuJFwleT8TaffAEaAFb/JXhwkaHNVFb6akoax/3d89aZJ26aE0MHLgwFBI/j5F
 7wgq3q7/W71RajaRDc+n/+xAJL6VvIQfawNJUW4TUs1wGdLwpsdPja/20TNIRn1/FL5eP7V
 WdFX/7d9ESsZDDIKECRGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BwAYqLL4sg8=:datghrcUFVSGlpEFX0NyqP
 6Lkk1DQlbdb4iy0idbgVhVJUNXowmZ3GafWicZaGVAy78IIP2CnDpMQBhm5X/fOuGqHvidvST
 O7pKUz4McOuP3bvFtZNACCRw2T6wOK83m/vf/LOogiZpibL4Hw/QyrVg0D7LEuYVGovOqD78K
 clt1e7fBrdsDtrSAvGdUXn1+AWJHJk6uxH31l92hVoBBkZ/lWOKu9nr/eRc6hjaYkuSqenEHi
 mPfHavXfbMbgz8GnCqvd1f4vQyygPsRyPGk1evEPro4ZqzpiaCyZCjG2WKhYMtWrXxmn7SajL
 viV4U7IVFoNu+XwST9qMb5p93S3SeA9xHVxVVkeVG+a8lVWi2hWSdOYJDRVSbTwv7saYDKd1g
 q7RgcV0XB9qgVoHz0E4l8VF88AMvozWRteT9EjLtCPyffziaIupTHxq4M2fXTjTIdp35Sl3ja
 1yWuUnBS4yokT4NOjQH0ni2gTJ17vN7VSQ2/3J3EmqoDsylCGZxwzK0dPYPEDIlULYxrt2EOS
 qo8djFyA3AH7ejW2DK7/8Cx4+P8Vp2f3fyjNAle8U7s3grAybnHM7D4tQbIM9+o9yvKyDZ+uF
 0cyVOq+M5ygEmCIF1AQT/hlxwR+p8pirOR6D2koqZhbd9VXohL1+fIzIPGOMdUCP5o8tcNnUc
 34vYjbSgwTMfBTeyscHSxXlYyEAQyVHeWEpSA9j2VoGiA1gfB1EUZw6+dYyN7P/19sU5j/9JJ
 SjlfVUQEPtdlUZ1GJt9cfc3u8TpkO5o7ZJCa9pa9kBMLwDQITalhR2qVvs+kw84ACEQzjiFv5
 gznkHOw9f0/BhHvzt/qrGCzNgX1zfAXMr5qfhT/Wao4b20KtSUaEYjy1hnr051U/S8XXOYmWf
 J/7hTnlWw1OmgN/OMHfOQaZPoOxknugtub35qgrUA8QZXLYNMvk9coHpYjGNpixKvsL0s5Qu0
 XJckCnYGmwzJ0IsEZs/vNDEUa6L2iiNipIrRmtqrRVRK1J0uf5xzp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 28, 2022 at 4:57 PM Markuss Broks <markuss.broks@gmail.com> wrote:
> On 7/28/22 17:48, Arnd Bergmann wrote:
> > On Thu, Jul 28, 2022 at 4:28 PM Markuss Broks <markuss.broks@gmail.com> wrote:
> >>
> >> Add early console support for generic linear framebuffer devices.
> >> This driver supports probing from cmdline early parameters
> >> or from the device-tree using information in simple-framebuffer node.
> >> The EFI functionality should be retained in whole.
> >> The driver was disabled on ARM because of a bug in early_ioremap
> >> implementation on ARM.
> >>
> >> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> >> ---
> >>   .../admin-guide/kernel-parameters.txt         |  12 +-
> >>   MAINTAINERS                                   |   5 +
> >>   drivers/firmware/efi/Kconfig                  |   6 +-
> >>   drivers/firmware/efi/Makefile                 |   1 -
> >>   drivers/firmware/efi/earlycon.c               | 246 --------------
> >>   drivers/video/fbdev/Kconfig                   |  11 +
> >>   drivers/video/fbdev/Makefile                  |   1 +
> >>   drivers/video/fbdev/earlycon.c                | 301 ++++++++++++++++++
> >
> > It looks like this is not actually related to fbdev, and since drivers are
> > moving from fbdev/simplefb towards drm/simpledrm, maybe it would be
> > better to put this into either drivers/gpu/drm/tiny/ or possibly
> > drivers/video/console to let this be used without enabling fbdev?
>
> Ideally this shouldn't depend on anything, because it isn't utilizing
> any of fbdev code and won't be utilizing any of drm/console code. I
> agree that either of those would be a better place for it, but which one
> do you think would suit more for this driver?

I think ideally this would be integrated with simpledrm in the long run,
but I have no idea what that means in terms of future code changes.

Maybe Thomas Zimmermann has an idea here.

        Arnd
