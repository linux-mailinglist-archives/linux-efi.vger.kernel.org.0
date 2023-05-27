Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091447135FC
	for <lists+linux-efi@lfdr.de>; Sat, 27 May 2023 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjE0SEJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 May 2023 14:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjE0SEI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 May 2023 14:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7FFD8;
        Sat, 27 May 2023 11:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D99B611DF;
        Sat, 27 May 2023 18:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63CEC433EF;
        Sat, 27 May 2023 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685210646;
        bh=+2DbhJhzR6mabBBjwgNw5rSlRJnUbBZQeef15wiBopk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KnIH/6iU5kII/kEi9oJ2yNbjTux0io/0dOabQH7bxSWUDCQ/43I79+L/uQmWKzHFw
         B+Zy6nsl/biVr6mGuJRtUiUgEUvIObjF7s2wkHVepOOS7rmS7+tbaECaWe7EKAdas8
         2eNxkC0rvKI5FKvqK2Tk860u4csWFATn4t/IId3GFdpUkAiuvKg0eo4TFDr7gxt0C1
         OBWzC9l8wlXcwt5l2guw9ZNygNwUBLPx79smWL/KlOs5n92wbI26X96g51c1BgGk0m
         ua3zRGzTK7LAqNuT21GHZv9PWj4ywbsQO8BXEkmIcc8lk2E3edho7KG1Gm3u9saA2j
         jwRuCoemDa3PA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2af2f4e719eso19655791fa.2;
        Sat, 27 May 2023 11:04:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDyYJz13HQAzdPaUGCQqTvRm6Oq3UXWXzraEPVNBqvQCwxzbYDSh
        gA0HJtO0EL8agetKhWwLMKWQmA+XDqT3Wa8FOsQ=
X-Google-Smtp-Source: ACHHUZ62gtGyVvIL18p9bdIMl4rfAggAX1oGiuWv0zEoKosgsTxXBGc6Z9d2SNfEvQBXlLkSso7H31J6LCQDa8Uc8ro=
X-Received: by 2002:a2e:9ed9:0:b0:2ac:7d3b:6312 with SMTP id
 h25-20020a2e9ed9000000b002ac7d3b6312mr2273060ljk.22.1685210644828; Sat, 27
 May 2023 11:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
 <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com> <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
In-Reply-To: <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 27 May 2023 20:03:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
Message-ID: <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
Subject: Re: mix of ACPICA regression and EFISTUB regression (Was: kernel >=
 v6.2 no longer boots on Apple's Virtualization.framework (x86_64); likely to
 be related to ACPICA)
To:     Akihiro Suda <suda.kyoto@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux x86 <x86@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux ACPICA <acpica-devel@lists.linuxfoundation.org>,
        Linux Stable <stable@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 27 May 2023 at 20:00, Akihiro Suda <suda.kyoto@gmail.com> wrote:
>
> [Resending as a plain text email]
>
> Turned out that this is a mixture of an ACPICA issue and an EFISTUB issue.
>
> Kernel v6.2 can boot by reverting the *both* of the following two commits:
> - 5c62d5aab8752e5ee7bfbe75ed6060db1c787f98 "ACPICA: Events: Support
> fixed PCIe wake event"
> - e346bebbd36b1576a3335331fed61bb48c6d8823 "efi: libstub: Always
> enable initrd command line loader and bump version"
>
> Kernel v6.3 can boot by just reverting e346bebb, as 5c62d5a has been
> already reverted in 8e41e0a575664d26bb87e012c39435c4c3914ed9.
> The situation is the same for v6.4-rc3 too.
>
> Note that in my test I let Virtualization.framework directly load
> bzImage without GRUB (akin to `qemu-system-x86_64 -kernel bzImage`).
> Apparently, reverting e346bebb is not necessary for loading bzImage via GRUB.
>

Are you using OVMF? Which versions of qemu and OVMF are you using?
