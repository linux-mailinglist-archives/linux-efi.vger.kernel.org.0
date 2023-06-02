Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7F0720C13
	for <lists+linux-efi@lfdr.de>; Sat,  3 Jun 2023 00:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjFBWwu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 18:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjFBWwu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 18:52:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A4E43;
        Fri,  2 Jun 2023 15:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7D7C6123A;
        Fri,  2 Jun 2023 22:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA3AC433EF;
        Fri,  2 Jun 2023 22:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685746367;
        bh=IC0IwOeV5ZGwtS0t1QyQiE7IDxlt6mYpuQxSohJQc+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ui1+xlFdv+gQIhUXah52CbPuoOmiwCIF61/1abY4VSHRVhFG3VQ5+2z2S3C+ZVGiv
         b5fSLksxHEpsqcwfTUV+8HJWtoTe+zsVd+RASVTvOYg1NnvNB3wElvYkYwdasc8ZTi
         kGWR6e0NTbbMAFTIVoW2ozZlAm9Y4jNPQFHyV3NGxxJme1t2vb0tIhdi/LSIPF+kWP
         wCoLEgJXvPybU+XlZEHJwab8w+N7xAO2dRz3DnfHmhRcl4GkIVcbft223ByWqLKflY
         wRKcF1qZPdlxUz7H7lg4ASwmcgFUaKhvdW9osXYDE0UjZbIhIo6tY+LQRFU7PN4vnz
         ysUNdEL1HuN5A==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f6067a9029so3383218e87.1;
        Fri, 02 Jun 2023 15:52:47 -0700 (PDT)
X-Gm-Message-State: AC+VfDzPDqMBlOg/ijbkeHmmSiSerQlTQYX8DoKNs74c7R9kxM+UZjO0
        Vnv9l7N3ZYYDrYmyOQ4n42Q/Jpdx2NKmIyFzJ+E=
X-Google-Smtp-Source: ACHHUZ6THOskysw3k8dEJZvLK6zG7JQXTtrITM2GOvOWAjmAZ5ASGsH1P64dAyWBLNQBkLAPMyUMwBbUeK1alq2b1Zw=
X-Received: by 2002:a05:6512:48b:b0:4e8:4412:1d95 with SMTP id
 v11-20020a056512048b00b004e844121d95mr2750978lfq.29.1685746365219; Fri, 02
 Jun 2023 15:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAG8fp8Te=oT1JJhTpOZvgWJrgcTq2DXan8UOVZ=KYCYNa8cKog@mail.gmail.com>
 <CAMj1kXG0q-pJEnvqJxxpecVqJcB2jk3rj7S4KNp728THM=de3Q@mail.gmail.com>
 <CAG8fp8Tnfb5tt3Eea4+=zznZLxBfqwha_wkQcPDvU4QhcSckEw@mail.gmail.com> <CAG8fp8QbQqDVxEvzeyijbkfU5HoAwbRH0VptMK4-oPnJ7-0Ljg@mail.gmail.com>
In-Reply-To: <CAG8fp8QbQqDVxEvzeyijbkfU5HoAwbRH0VptMK4-oPnJ7-0Ljg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 3 Jun 2023 00:52:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHAt69QqFdZDOTFKNLvAYuY9cwrVFgE+eDNZ8FSQA-45w@mail.gmail.com>
Message-ID: <CAMj1kXHAt69QqFdZDOTFKNLvAYuY9cwrVFgE+eDNZ8FSQA-45w@mail.gmail.com>
Subject: Re: [PATCH] efi: bump efistub version from 1.1 to 3.0 for
 VZLinuxBootLoader compatibility
To:     Akihiro Suda <suda.kyoto@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org, Linux x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2 Jun 2023 at 22:30, Akihiro Suda <suda.kyoto@gmail.com> wrote:
>
> > > I'll queue this as a fix, but I'm going to tweak the comment (and the
> > > commit log) a bit, if you don't mind
>
> Thank you for rewriting my comments, but the new comments seem
> slightly incorrect:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=36e4fc57fc1619f462e669e939209c45763bc8f5
>
> > efi: Bump stub image version for macOS HVF compatibility
>
> The commit is about Virtualization.framework, not about
> Hypervisor.framework (HVF).
>
> Virtualization.framework = high-level VMM, similar to QEMU
> (/usr/bin/qemu-system-*)
> Hypervisor.framework     = low-level  VMM, similar to kvm.ko
>
> > The macOS hypervisor framework includes a host-side VMM called VZLinuxBootLoader
>
> VZLinuxBootLoader is a part of Virtualization.framework, not
> Hypervisor.framework.
> Also, VZLinuxBootLoader is not a VMM; it is just an API for loading
> vmlinuz into Virtualization.framework.
> (similar to the `-kernel` and the `-initrd` flags of QEMU)
>

Apologies for these mistakes. Unfortunately, this patch has been
merged now so there is nothing we can do about it.

> > On x86, it incorporates a BIOS style loader that does not implement or expose EFI to the loaded kernel.
>
> AFAICS, it does not seem to use real mode BIOS.
>

I never mentioned real mode, did I?
