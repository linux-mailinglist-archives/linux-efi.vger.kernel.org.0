Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE13258CBAA
	for <lists+linux-efi@lfdr.de>; Mon,  8 Aug 2022 17:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbiHHP4L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Aug 2022 11:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbiHHP4K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Aug 2022 11:56:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24086A47B;
        Mon,  8 Aug 2022 08:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEF8EB80FCD;
        Mon,  8 Aug 2022 15:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E36DC43149;
        Mon,  8 Aug 2022 15:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659974167;
        bh=v2lgBXjNZtsYzCboM1GnlUy05vvC9EjJee5FKw0cYsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mIHwvx+tj2BxsPEjBZ0vinsl4KXkSc+hUHjGOo+mlAFTJmKRMbMY/LMLgKCe1QNv4
         nWVNNWJGt7Id3daVXh9gG0kGjCNCY90Ec8lpHmpiS1DGviiH1Ye9GbbRrGb+16XcTk
         luRIciiAM6aSFU/64rT51FuMNb4ojhjb2dLoLIYZ+W9kTOL0L7kKvRP7p2k9OZgB3Z
         GtVeNG5fVpg6X/jx4l8owP7xHWDcjmfsPc734Gi4Kp9fRvQ5uBJr6nArf2AwQYpBwM
         SN13eiIZoUhJYu5L0DT1feKn/7/6/FgwtFdgCYbKqZXXmX4XC/KvDmagMFJjHVaUCk
         W3BZthQ+6i1fg==
Received: by mail-vk1-f179.google.com with SMTP id x128so1554356vke.3;
        Mon, 08 Aug 2022 08:56:07 -0700 (PDT)
X-Gm-Message-State: ACgBeo0LKoPn+86gdnjt8QxyNSMi8FgwachBS1wcPtvnAN2QD9BgOtHz
        zZ3EmJYhrO/f1C0WUxy9g+VwzkqwBcXFCasTCg==
X-Google-Smtp-Source: AA6agR6IlSvPTzHVkYtc/Dl9eo8Po13k4nQJVZL4SY2rHsdelBv+y2wXVK/2+5kYFhsWJQqicxm/4R8FPkDt1nisypg=
X-Received: by 2002:a1f:2dc2:0:b0:377:84fa:dbe5 with SMTP id
 t185-20020a1f2dc2000000b0037784fadbe5mr8008232vkt.15.1659974166257; Mon, 08
 Aug 2022 08:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220806163255.10404-1-markuss.broks@gmail.com> <20220806163255.10404-2-markuss.broks@gmail.com>
In-Reply-To: <20220806163255.10404-2-markuss.broks@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Aug 2022 09:55:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJE7VzqdcoDDNw2QkDHyKr4WgOrgLwsHWJa+BwPTb=A8w@mail.gmail.com>
Message-ID: <CAL_JsqJE7VzqdcoDDNw2QkDHyKr4WgOrgLwsHWJa+BwPTb=A8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drivers: serial: earlycon: Correct argument name
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        phone-devel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Aug 6, 2022 at 10:34 AM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> The "node" argument is actually an offset,

It's an offset to a node in the FDT. The fact that it is an offset is
an internal implementation detail of the FDT format. So really, it's a
handle to a node. 'node' is more descriptive to its purpose.

> and it's also an "int", and not "unsigned long".

Uh, no it's not. of_flat_dt_*() functions all take an unsigned long.

Rob
