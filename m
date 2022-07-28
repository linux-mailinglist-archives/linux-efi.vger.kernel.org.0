Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6A584220
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 16:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiG1Osz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 10:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiG1Osz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 10:48:55 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD06F4B4AE;
        Thu, 28 Jul 2022 07:48:53 -0700 (PDT)
Received: from mail-ej1-f47.google.com ([209.85.218.47]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N33V5-1nKxnV0UEH-013PME; Thu, 28 Jul 2022 16:48:52 +0200
Received: by mail-ej1-f47.google.com with SMTP id sz17so3548469ejc.9;
        Thu, 28 Jul 2022 07:48:51 -0700 (PDT)
X-Gm-Message-State: AJIora8jmfx8KxPh9mJxdCE4Xl+HQuwEt1QFv1Jauo3yLGE1Vd8gKZ4Y
        fG/tLP1E3k0OZJ2wKgXRTe5oEibG5By+QLE/zbA=
X-Google-Smtp-Source: AGRyM1voWFsned5bc+ZOEVWI6Tk3nmMi4UyCDiV3OuIb+yKzChXoAAi57A5zk3bEc9tox3U8iz+5WVxVjrqfdY0QZtc=
X-Received: by 2002:a17:907:d0f:b0:72e:db1f:9b91 with SMTP id
 gn15-20020a1709070d0f00b0072edb1f9b91mr21730608ejc.470.1659019731647; Thu, 28
 Jul 2022 07:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220728142824.3836-1-markuss.broks@gmail.com> <20220728142824.3836-3-markuss.broks@gmail.com>
In-Reply-To: <20220728142824.3836-3-markuss.broks@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Jul 2022 16:48:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2fZ9O6vSEyxY1KW71pG_Oyvwxp3zTbW2GuaSD6aj+Qfw@mail.gmail.com>
Message-ID: <CAK8P3a2fZ9O6vSEyxY1KW71pG_Oyvwxp3zTbW2GuaSD6aj+Qfw@mail.gmail.com>
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Zf90xitQQ1Gka8NoneHkD8inuSBCM/3y6EK/lEwKYV8CUrERMZL
 QJFVB4Q9N59jDb4DyrlP7AMjitr941ffyLSBPOYxEOEmtBKJSwg8Lzb5I4V7zytUtqoABTF
 7VU3wZvsAiPsd8F2vfrusHu5lum0CbuRQajFjKYsSknjMV2xGnOedJ3SFqCpxqvB0wDVVdE
 y69IB0YDRO4OzI0OE/J5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:32Cxq2ctUw4=:3EGbkZ21TOvU1qiHYgz/aV
 VdGqY/jn0X9t4iThTSRyyOEQcPfRD/+F3hWdIegJwJ61GrFVOh7Dk1uOUofHAt5uLK2ryj1QQ
 3nFpJt52yX/28snx6yHlBPy1elZ1caXcrBOVA78Mbc9GVfv7NlM6X2dVgjlkrfpJ+guRjIJKO
 iXOKtH/opnq97+ZkNlJrnPn/sYeem6BgUjIIKFe6Xt1uFi4JphXmifVYu/AHhBZoNLVSBka+V
 YdK97Mx0voQuNn8/BiCn+IgRxF9/BTjYAhMv+WftbmeC/hyM84zy8/7E3Kv1ClwP70j4uyOFg
 f/FpSe0Rkcm6rLjVCsV86DLaSWBQm+/KgmH6t7v2Kk6Y1H99Z9e/wtrjr/zSFiFMyhdh1+NX7
 KFJ9hSysKMo03vAvy3S8i9SlznpcLwkMap0KPxXaiLiXoNU+Ck3rDj7PruazyrRv6MAM4BRlv
 92boKnuBYkRVtl9Cb4JXLNZXV8auz60JvX0gA/hv6yEZA2KQu0qfCs/9GCLZYG0qbM5mYe0Ml
 rXxtqXGkbYvaelPHJ3RbfhTm8eA1AxomwxfoHWMnS9XGN3Wiu76IgRDT/0NDDxzFcLUY6IX/Q
 w1Dv6bpouxMeKgki7weTWrSQTU6nO/J7QNRwuLmBLsfIxG15ODdSCHHKPc/j1+HCsRQwBo3UX
 dfwxcSNLzmOjql+ZyHH+Kv0Acf17WHdoKO9UhUFuxDypzbmTrvaAMk7RQm8V4jHHiuM7IMXaR
 0sbU8PEodDznxgxYCPuA3nA25e8BhNVryIPbyWiUp1D8HjrK+atO1mYpyz8RzXgScKgOB0Ovc
 JjtA1yp8MJFsZQKCeXQPq4JdADXaY/m37zjkotOtQ3f1mvjXVvPqy+TF7xZtV6qdqRjrDzPjR
 cTeSLqIy9R7Fkxibbbkw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 28, 2022 at 4:28 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> Add early console support for generic linear framebuffer devices.
> This driver supports probing from cmdline early parameters
> or from the device-tree using information in simple-framebuffer node.
> The EFI functionality should be retained in whole.
> The driver was disabled on ARM because of a bug in early_ioremap
> implementation on ARM.
>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  12 +-
>  MAINTAINERS                                   |   5 +
>  drivers/firmware/efi/Kconfig                  |   6 +-
>  drivers/firmware/efi/Makefile                 |   1 -
>  drivers/firmware/efi/earlycon.c               | 246 --------------
>  drivers/video/fbdev/Kconfig                   |  11 +
>  drivers/video/fbdev/Makefile                  |   1 +
>  drivers/video/fbdev/earlycon.c                | 301 ++++++++++++++++++

It looks like this is not actually related to fbdev, and since drivers are
moving from fbdev/simplefb towards drm/simpledrm, maybe it would be
better to put this into either drivers/gpu/drm/tiny/ or possibly
drivers/video/console to let this be used without enabling fbdev?

        Arnd
