Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106745BEB4A
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 18:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiITQo5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 12:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiITQo4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 12:44:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9108213E27;
        Tue, 20 Sep 2022 09:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B56562B4F;
        Tue, 20 Sep 2022 16:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868C8C43470;
        Tue, 20 Sep 2022 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663692294;
        bh=XIsRykKdGIJ+RZITE67y/5dHz3YGRh/z9EWZg+FrivU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FEAo2CYlL6TCfxwNk8R5Lka/RkflGNBbITwbG1b/FazyvOnhLu1xtwrlvPRtmupyh
         ySLDDROfDB0eNBuL+Pls/96mWcf485xPBBQIVMYf1X2W0a+yyGbfepDuy1ymti/uam
         Rph92vC78UZ3C2oTp2sogjDjWr/C+JhZDeUoZDZJiW41MMA3EdWo0edcI9MwvYYmFx
         wQ6NBe7wheZDi+8pcLRSBdkXuGjA3m3C5JyvBEX2GoXNfCEc4iFYpnEmQnGPl83FRQ
         FmooEIsC2pjM8Vw+XqfHe2PPW+UMI/1VOtg6BlI3pF1PgUL9OyS+grLoooXEed6+SU
         uUQZeulUXhdSw==
Received: by mail-lf1-f50.google.com with SMTP id j16so4797303lfg.1;
        Tue, 20 Sep 2022 09:44:54 -0700 (PDT)
X-Gm-Message-State: ACrzQf2/FzE3EUQUxb6PvATgI8F8dRt9Igl2+g/QPc4akmoa1IDckRw7
        B/HEnZXiwSDMcu8AKsGOgNx5GFj3w0ANnZ3OpxE=
X-Google-Smtp-Source: AMsMyM7YfCjjO+1K7sVpyuUbefVF0ofb9t18Bsop16/pHu5lVYZ43kb+0I0nchspS9Agje+mDAu1AP8ShTlA1iUQprQ=
X-Received: by 2002:a05:6512:ba1:b0:498:9890:1bb4 with SMTP id
 b33-20020a0565120ba100b0049898901bb4mr7983242lfv.122.1663692292587; Tue, 20
 Sep 2022 09:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220909194214.186731-1-gpiccoli@igalia.com> <04d65bd7-a6b2-bb14-fd69-632542ae9e86@wanadoo.fr>
 <e8ce8fb4-baac-b3a5-5d6d-418e20c8d2d9@igalia.com>
In-Reply-To: <e8ce8fb4-baac-b3a5-5d6d-418e20c8d2d9@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Sep 2022 18:44:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGze41X9ogZDEbm7=04XnFRPGjV7RMmeJnOveAsTfgDhQ@mail.gmail.com>
Message-ID: <CAMj1kXGze41X9ogZDEbm7=04XnFRPGjV7RMmeJnOveAsTfgDhQ@mail.gmail.com>
Subject: Re: [PATCH V2] efi: efibc: Guard against allocation failure
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        matt@codeblueprint.co.uk, mjg59@srcf.ucam.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 11 Sept 2022 at 16:36, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 10/09/2022 01:56, Christophe JAILLET wrote:
> > [...]
> >>      wdata = kmalloc(MAX_DATA_LEN * sizeof(efi_char16_t), GFP_KERNEL);
> > Hi,
> >
> > even if mostly useless in this case, kmalloc_array()?
> >
> > Or certainly maybe even better, kstrndup()?
> >
> > CJ
> >
>
> Thanks! It's up to Ard, I could rework with this change if makes sense.
> Cheers,
>

kstrndup() does not work on wide strings so I think the code is fine as is.

I've queued it as a fix - thanks.
