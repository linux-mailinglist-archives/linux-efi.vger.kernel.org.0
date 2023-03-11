Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CE76B5F43
	for <lists+linux-efi@lfdr.de>; Sat, 11 Mar 2023 18:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCKRk5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Mar 2023 12:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCKRk4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Mar 2023 12:40:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A1272AD;
        Sat, 11 Mar 2023 09:40:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C03360DD7;
        Sat, 11 Mar 2023 17:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4B3C4339B;
        Sat, 11 Mar 2023 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678556362;
        bh=d2twZZt4iEQVL+Jfp+CiaBl6RMLSrb0fiX4DrrOVnsI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LhVJJ5ZW07oZOtliO+RNPBKjCAgzdlkrDeTvy+dwboCXkWE2H+wiqdazsfouwGYy+
         oG9sw7f6zIQSveHJKHMXcd0zJoMDTRgVdR8xYXG/pe2q3/22sGxLc2W6R4O+m0Id0+
         VkxkF6+1R7+5Tt8EfBrO9rLxKHd7L4qSo1zh7C8wRLtY5RHjbqgQPtaptIJOzhpqNq
         /hroaLOAr+pO8BV9Vr6DTP2WsU32KTlaw8ig88O4bjdNQhc5gLFJv28ML6+T7ZAX9Y
         c4BXAwv6Kr2e1IZbc3SPEgozuYvzDsrR5HqrFA37ZkgmSkzbjgSidk/abX7b/5s8F4
         ZlasyQ/6CTSjQ==
Received: by mail-lj1-f178.google.com with SMTP id g18so8607710ljl.3;
        Sat, 11 Mar 2023 09:39:21 -0800 (PST)
X-Gm-Message-State: AO0yUKX+ZuYZPNtMMUnXm8P3E9Faqs/mf7PIPp0rni1a3aNTytqjzsWW
        gttTUKU/VlMRjbS5uZ/tYbs/VEa/hGW9pTQ9RQE=
X-Google-Smtp-Source: AK7set/a81dG4zhFZj0+7Z3uTzo4Ho9LtVgw4JBaootkU0p++pREaHz47EgcHfK/YCdyDqqM6tblmpua3tvPyoTLYjg=
X-Received: by 2002:a2e:aa1c:0:b0:293:4ed3:a404 with SMTP id
 bf28-20020a2eaa1c000000b002934ed3a404mr9076038ljb.2.1678556360060; Sat, 11
 Mar 2023 09:39:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <c38ad7a1b89aff743d4a29882a7022d97d4fea58.1671098103.git.baskov@ispras.ru>
 <CAMj1kXGzXLp20nbg-NoToENbDQhn1b0Gpi2s8f9DgSSM28BbeQ@mail.gmail.com> <f29b8efc018819cbb8202d13795ba89e@ispras.ru>
In-Reply-To: <f29b8efc018819cbb8202d13795ba89e@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 11 Mar 2023 18:39:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHAeddy+6MjwgHLH7J=qAO0SaecB7ZGuHNT+13-r1VcQw@mail.gmail.com>
Message-ID: <CAMj1kXHAeddy+6MjwgHLH7J=qAO0SaecB7ZGuHNT+13-r1VcQw@mail.gmail.com>
Subject: Re: [PATCH v4 21/26] efi/x86: Explicitly set sections memory attributes
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 11 Mar 2023 at 16:09, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2023-03-10 18:20, Ard Biesheuvel wrote:
> > On Thu, 15 Dec 2022 at 13:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
> >>
> >> Explicitly change sections memory attributes in efi_pe_entry in case
> >> of incorrect EFI implementations and to reduce access rights to
> >> compressed kernel blob. By default it is set executable due to
> >> restriction in maximum number of sections that can fit before zero
> >> page.
> >>
> >> Tested-by: Peter Jones <pjones@redhat.com>
> >> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> >
> > I don't think we need this patch. Firmware that cares about W^X will
> > map the PE image with R-X for text/rodata and RW- for data/bss, which
> > is sufficient, and firmware that doesn't is a lost cause anyway.
>
> This patch were here mainly here to make .rodata non-executable and for
> the UEFI handover protocol, for which attributes are usually not getting
> applied.
>
> Since the UEFI handover protocol is deprecated, I'll exclude patches
> from
> v5 and maybe submit it separately modified to apply attributes only when
> booting via this protocol.
>

I think the issue here is that loaders that use the UEFI handover
protocol use their own implementations of LoadImage/StartImage as
well, and some of those tend to do little more than copy the image
into memory and jump to the EFI handover protocol entry point, without
even accounting for the image size in memory or clearing the bss.

To be honest, even though I understand the reason these had to be
implemented, I'm a bit reluctant to cater for the needs of such
loaders, given that these are all downstream distro forks of GRUB
(with shim) with varying levels of adherence to the PE/COFF spec.

I'm happy to revisit this later if others feel this is important, but
for the moment, I'd prefer it if we could focus on making the x86
image work better with compliant loaders, which is what this series is
primarily about.
