Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66715E5C11
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiIVHOP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 03:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiIVHNx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 03:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6CEB7EFA
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 00:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFA7E61197
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 07:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ADBC43140
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 07:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663830793;
        bh=QzWjkCuNa6rlQWoXFdnIthgW9wv3tP36Fe+JwawE/HU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G9AWFGf78yi3mDSJGL9xFTLCv07UDiiu58y5lC0h1HWxVOiGVfOlArQOK/JbyCUVt
         Vl68sHewBzk2O3/5Bu9W6tqrnPhXWbIEDtNNAyoi81A5vzxz/68iXKS7AyL6PnLTaA
         krm2y5u3jU8Rby62RzwNdTdASu/y0N/1QAz39PQpEbOvOIFzPg0Zgh0JJPRUP9hJT/
         2RCAHNDVeW4l0b4g4uNG3Ut6wTjYlDOIcf/FBNRaNCz0dfWFbzF+yweCyt22uOfJlC
         TRkwvTR2EoaMuRPJGC1uxw3mU5UMn95mfeWskxVzHMZwWRB8gSzRfaJ5OGQYYI7Rvf
         c7qYxBrbzXA3A==
Received: by mail-lf1-f53.google.com with SMTP id x27so13271437lfu.0
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 00:13:13 -0700 (PDT)
X-Gm-Message-State: ACrzQf1qPqSzi2zbw2UbTcq7K4+TXG9bgcHbHoEwvBVCt1wMhCw/ahHL
        ufgH2qAyP9RVhpZvmVpAHOoUlx6nJPMYEI7bOwg=
X-Google-Smtp-Source: AMsMyM76C/hQC5YHSSEA7/TKUcw4X/IWkbrnRCX/vShLJKACUuGOyWqzhklH1rluL8iYiXGYcx+pIYmJ7g3PSQTpmIo=
X-Received: by 2002:a05:6512:ba1:b0:498:9890:1bb4 with SMTP id
 b33-20020a0565120ba100b0049898901bb4mr664716lfv.122.1663830791251; Thu, 22
 Sep 2022 00:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220920183554.3870247-1-ardb@kernel.org> <20220920183554.3870247-9-ardb@kernel.org>
 <CAAhV-H4+Exqu6Z3G_hYmhz=Ccv_4EKLjQ5GVT8h3YsJy0FSpAg@mail.gmail.com>
 <CAMj1kXG9HRn6iV5x-Q94xdOhNhiKMGiO6SkE3LMwzXPkXxen_Q@mail.gmail.com> <CAAhV-H5AjwKd-ydZTA=vKCA+fe_gAVyhCM2s-Wm54AqWqpBF1A@mail.gmail.com>
In-Reply-To: <CAAhV-H5AjwKd-ydZTA=vKCA+fe_gAVyhCM2s-Wm54AqWqpBF1A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Sep 2022 09:12:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFKfwvvidNPumQNzhHXSR4kHpTq-j4ygR=Jow7yySc44Q@mail.gmail.com>
Message-ID: <CAMj1kXFKfwvvidNPumQNzhHXSR4kHpTq-j4ygR=Jow7yySc44Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] efi/loongarch: libstub: remove dependency on
 flattened DT
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, loongarch@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 22 Sept 2022 at 04:15, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 4:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 21 Sept 2022 at 06:02, Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> > >
> >
> > Thank you Huacai
> >
> > I have created a separate tag with these patches applied onto the
> > first loongarch efi enablement patch (see below)
> >
> > I would prefer to keep the loongarch trees separate for the next merge
> > window, but if needed to avoid massive conflicts, you could merge the
> > tag into the loongarch tree and rebase your changes on top. But please
> > take care not to rebase those patches themselves: the commit SHAs need
> > to remain the same.
> >
> > However, if the conflicts are only minor, you can just explain in your
> > PR to Linus what the resolution should look like.
> >
> > The tag can be found here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/tag/?h=efi-loongarch-for-v6.1-2
> >
> > I have merged this into the EFI tree as well and pushed it out; it
> > should appear in -next tomorrow.
> >
> >
> >
> > b093dc55ba9a efi/loongarch: libstub: remove dependency on flattened DT
> > 102faf0747c2 efi: libstub: install boot-time memory map as config table
> > 7318926e7bc9 efi: libstub: remove DT dependency from generic stub
> > 7cb6671e3caa efi: libstub: unify initrd loading between architectures

I will have to respin the initrd patch, unfortunately, as it breaks
x86. So the signed tag will be updated, and the SHAs above will change
as well.

> > 1add08ceb15b efi: libstub: remove pointless goto kludge
> > d2130a9cf0f7 efi: libstub: simplify efi_get_memory_map() and struct
> > efi_boot_memmap
> > bc5853aa56de efi: libstub: avoid efi_get_memory_map() for allocating
> > the virt map
> > d80ca810f096 efi: libstub: drop pointless get_memory_map() call
> > ead384d95634 (tag: efi-loongarch-for-v6.1) efi/loongarch: Add efistub
> > booting support
> > 568035b01cfb (tag: v6.0-rc1) Linux 6.0-rc1
> Hmmm, I want to also merge zboot support in the loongarch-next's base,
> is that possible?
>

No, let's keep that separate. LoongArch boots fine without it, so we
can wait until it arrives via the EFI tree, no?
