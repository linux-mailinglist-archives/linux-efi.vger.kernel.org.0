Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7020158A9F4
	for <lists+linux-efi@lfdr.de>; Fri,  5 Aug 2022 13:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiHELI7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Aug 2022 07:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiHELI6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Aug 2022 07:08:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0423606B4
        for <linux-efi@vger.kernel.org>; Fri,  5 Aug 2022 04:08:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 982CFB827EC
        for <linux-efi@vger.kernel.org>; Fri,  5 Aug 2022 11:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB4EC43470
        for <linux-efi@vger.kernel.org>; Fri,  5 Aug 2022 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659697735;
        bh=ZcuouNC8ZXDndRo7t2WhXz91pYiZg16H4tHcWmF8PS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uMmxwp9koiNzLoat/TKcDdvo3RV5fBgkgMw4st/lxUIckFye1EVhhALH4lbJR2USq
         HpLsw5UyPqEYyluA4/Oq8gwibjA0ilVXWu9J/6raGLnGxMWh4jLrwp4pCy0R8ly88d
         d9doVs7FVtJk3Mm8z6I5yuUtlTGqbU5TYc563Sx7+tDaOu106I5fBj5h/aCUHz4E+N
         e7jkvR+94ywvucdOSinwpzDE+Ooua6V2hdimfSwH5dIefN6B1M2BysiDqQ8kyWNsGW
         rOxM8+5phDT1+TAyKgg5teMHUncgYf3HyADz8C44ZSd7SWOApOT4Kd4yojsJ6+00g9
         SWtd/ZCHN7ltA==
Received: by mail-oi1-f172.google.com with SMTP id l188so2334720oia.4
        for <linux-efi@vger.kernel.org>; Fri, 05 Aug 2022 04:08:55 -0700 (PDT)
X-Gm-Message-State: ACgBeo1PwnOz7OTZPeUAZOGBzve6Y01FHpZw0Md3ihj5Nf7k3Ae5UQ5a
        RVPZ9lNSo2fgBf+Cj2fJdRcqSpuPk1pSKL9XWf0=
X-Google-Smtp-Source: AA6agR4KumACn6M4f/oVL9Nj6o4UHUDiWFXhYhiIosGm28Xoif/hJ249EGNnj+Fn+KFi+xjpgUnZcOG6ZeChWO4HymY=
X-Received: by 2002:a05:6808:16ac:b0:33b:32ce:edd8 with SMTP id
 bb44-20020a05680816ac00b0033b32ceedd8mr2758235oib.126.1659697734529; Fri, 05
 Aug 2022 04:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <YuxOgtykRQb1HU3e@zx2c4.com> <20220804230411.17720-1-Jason@zx2c4.com>
 <40fdfb11-1e40-a36a-d3a4-fcbef546a78a@redhat.com>
In-Reply-To: <40fdfb11-1e40-a36a-d3a4-fcbef546a78a@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Aug 2022 13:08:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFDs8HCCCcVAVwjLcATh6MYcUSAha5yvi0ftMw+Ddy_Xg@mail.gmail.com>
Message-ID: <CAMj1kXFDs8HCCCcVAVwjLcATh6MYcUSAha5yvi0ftMw+Ddy_Xg@mail.gmail.com>
Subject: Re: [PATCH v3] hw/i386: place setup_data at fixed place in memory
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-devel@nongnu.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>, linux-efi@vger.kernel.org
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

On Fri, 5 Aug 2022 at 10:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 8/5/22 01:04, Jason A. Donenfeld wrote:
> > +    /* Nothing else uses this part of the hardware mapped region */
> > +    setup_data_base = 0xfffff - 0x1000;
>
> Isn't this where the BIOS lives?  I don't think this works.
>
> Does it work to place setup_data at the end of the cmdline file instead
> of having it at the end of the kernel file?  This way the first item
> will be at 0x20000 + cmdline_size.
>

Does QEMU always allocate the command line statically like that?
AFAIK, OVMF never accesses that memory to read the command line, it
uses fw_cfg to copy it into a buffer it allocates itself. And I guess
that implies that this region could be clobbered by OVMF unless it is
told to preserve it.
