Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB8584780
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 23:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiG1VHJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiG1VHI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 17:07:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B83F1D0F3;
        Thu, 28 Jul 2022 14:07:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b11so5152518eju.10;
        Thu, 28 Jul 2022 14:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ab/60a7ap/TF4pOEKknPkIZ19AphsfkpAIUOdyILIjA=;
        b=BFQmBltvDWAyd4EdZYjsfo++kYP1bOdlRa9ZabzH2Q0s39aOYP2Y9NvADlWYjuszT/
         sTTbfR4WsUrQknG5OkKNVhyCz2YsQOcE9D9ycG3InxB3xxFnjWNuAaBCGKkZG8wkajtr
         Rpp0Ou4GkMHSI5QluJniDpEFg8FcoBv+Mlo3lDJPwnQlcSxPqoxWG/+x5BX1rqPDSLBE
         vEbHIgLuYsOWUV80Eb7WOysCdlpoNo2GuSdJhK3dUVp3ETfDy7wn/8SpsbiqL3dGH3pD
         cu3dPlrqBZ+j7I4xlFNAWN7vdVcdt94CO3SHK3O5euZXrxoISXO6IN8cqUKHG+Dfo6N+
         oZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ab/60a7ap/TF4pOEKknPkIZ19AphsfkpAIUOdyILIjA=;
        b=JeP98h9YPfzMzmLlxkCavGcuoQ9i/VnK3mFIQNN293k01XyKC+H6bmsMfyP+x78dH3
         EGDK7zmwnAsvm7cWrT20F9NxVOCz/QtEUcI6LfymVJaGURgiyvlxrBQsTCWSAyLxW9iy
         IAwoyShAmqc9fU3xnDLF6fr1sFYgpyEt5BjFJTcjNELsMGDLWtRu2lY6ehWExZUZzz4l
         u41pW+UIDkaTq7uP9VTY4AnSxjzQw8Bz0NIZjik1Fh7T0+LgYSDbkXH2b3v+d90cyypv
         wkfuhR/Gf1zTYd7oz1+h7DmjUKAyIu8uAF8veQ1TQ/oHyB4YgnQ7pq1HH/glwXoamiws
         E26g==
X-Gm-Message-State: AJIora/DChNoH8Y29SmxOuLJdVU727obb+oGXlwrD3TQtqbRay1IW1+3
        ia8XyaPCGVK1pngy/H0x5mYfvl4PgsoZmu/WdVs=
X-Google-Smtp-Source: AGRyM1tRri2yxGEFn1QQ0Ft0YIQaCW8e+5RgcNCLhZwZ5P2GWyRFBLmCsyKL5A2sFwjM3h12cHNdVratAckuZRN8iZI=
X-Received: by 2002:a17:907:6e02:b0:72b:9f16:1bc5 with SMTP id
 sd2-20020a1709076e0200b0072b9f161bc5mr564451ejc.676.1659042424819; Thu, 28
 Jul 2022 14:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-3-markuss.broks@gmail.com> <YuKfnAjB4gV0ki4A@kroah.com> <30ce6f21-0a91-81cb-8b03-5acff17c59ee@gmail.com>
In-Reply-To: <30ce6f21-0a91-81cb-8b03-5acff17c59ee@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jul 2022 23:06:27 +0200
Message-ID: <CAHp75VeNM5vc58WAOLwHnhpDBwMk_FbzfnNRAEUDdZTBq9L73w@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: earlycon: Add support for generic framebuffers
 and move to fbdev subsystem
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, Jul 28, 2022 at 4:58 PM Markuss Broks <markuss.broks@gmail.com> wrote:
> On 7/28/22 17:39, Greg Kroah-Hartman wrote:
> > On Thu, Jul 28, 2022 at 05:28:19PM +0300, Markuss Broks wrote:

> >>   delete mode 100644 drivers/firmware/efi/earlycon.c
> >>   create mode 100644 drivers/video/fbdev/earlycon.c
> >
> > That should be a rename, not a delete/create, right?
>
> Should this change be split into two separate commits,
> one for moving the file and the second for making changes?

I think it's a pointer to use `git format-patch -M -C ...` when
preparing patches.

-- 
With Best Regards,
Andy Shevchenko
