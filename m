Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B2E602B03
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 14:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJRMBk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 08:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiJRL7v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 07:59:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC7412771
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:59:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58F5461537
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB437C43470
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094369;
        bh=U2holwK68YbVkjO+EETOVRlLcxvqnGYot6f6caemQ38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mkMd8Ay8k7c7IACh+XhGbSR0cPgVDZQzcwwVY4v+yKBoYJCRNtNfWv6VJ+GVKCbvj
         vdHY2iFByMa4wvYbBjQQltQ7zxGWGShuKBIezv69ufWC203go6sfP1R4WcbjNILeux
         GWU13mt9lfcbWBFbGN4lvekJnj+TTsPNzG3OI5/KptceFSrHRu53xK/HZefN7iYlPh
         sN+LBdzUce2zNyiNY03XFKwOlyWpoWv2+ece0wuNqX4IVZchOb0VFEpRxs3WV/xbba
         Th87WG6rsm5ds2Hifu+NYaxkmsVcI/2ejscqMIwJNmMYwHC0QvozorUKfElVmRkPRj
         gxkpUahpIxLYQ==
Received: by mail-lf1-f44.google.com with SMTP id bu25so22151077lfb.3
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:59:29 -0700 (PDT)
X-Gm-Message-State: ACrzQf0h7lzRqETJ4MGKoiYYy0/183JP/UHUF4dT0WHzMbUYfpwo+73/
        tXNlriZnM5bG1bwTpgZJYmkoBQ/OpC1alIyauXY=
X-Google-Smtp-Source: AMsMyM439hszskCIt0dLBGbDVvBp4azwBGQoOwawPvzmiZ5t7XFTPILCDa931Ti+kooBtEAyNcNmw/sXFCEYZOLbIns=
X-Received: by 2002:a05:6512:104a:b0:4a2:9c7b:c9c with SMTP id
 c10-20020a056512104a00b004a29c7b0c9cmr842547lfb.122.1666094367776; Tue, 18
 Oct 2022 04:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221017171700.3736890-1-ardb@kernel.org> <20221017171700.3736890-3-ardb@kernel.org>
 <Y06UpeYYYm9qSATn@arm.com>
In-Reply-To: <Y06UpeYYYm9qSATn@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 18 Oct 2022 13:59:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEeq4Ssdw=eY+pvBeuXZMR2NBDGd4+HEwRuhPVjaLjdZw@mail.gmail.com>
Message-ID: <CAMj1kXEeq4Ssdw=eY+pvBeuXZMR2NBDGd4+HEwRuhPVjaLjdZw@mail.gmail.com>
Subject: Re: [PATCH 02/21] arm64: efi: Avoid dcache_clean_poc() altogether in efi_enter_kernel()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 18 Oct 2022 at 13:57, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Oct 17, 2022 at 07:16:41PM +0200, Ard Biesheuvel wrote:
> > To allow efi_enter_kernel() to be shared with the EFI zboot decompressor
> > build, drop another reference to dcache_clean_poc() and replace it with
> > a single DC CVAC instruction. To ensure that it covers the remainder of
> > efi_enter_kernel() as intended, reorganize the code a bit so it fits in
> > a 32-byte cacheline, and align it to 32 bytes. (Even though the
> > architecture defines 16 as the minimum D-cache line size, even the
> > chosen value of 32 is highly unlikely to ever be encountered on real
> > hardware, and this works with any line size >= 32)
>
> This should do.
>
> > -0:
> > +     adr     x4, 1f
> > +     dc      civac, x4
>
> s/civac/cvac/ ?
>

Ah yes, I changed that last minute because of
ARM64_WORKAROUND_CLEAN_CACHE - I'll add a note.

> Otherwise,
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks
