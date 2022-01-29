Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698A34A3080
	for <lists+linux-efi@lfdr.de>; Sat, 29 Jan 2022 17:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352111AbiA2QT6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Jan 2022 11:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242424AbiA2QT6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Jan 2022 11:19:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C769C061714;
        Sat, 29 Jan 2022 08:19:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17EAEB8120C;
        Sat, 29 Jan 2022 16:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08C2C340E5;
        Sat, 29 Jan 2022 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643473195;
        bh=ozMiiYFbCOSr6At7dNUhU0RKoDLf1poblUCMXrvrUTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jNezTp5EJyW5hRYPxZP22DprMQ+MrUgs6k5X7wVUcnRrvkbBcapZl4jD9it8Es7L0
         f+14aV7kNknvtHqL7kJfFSAyiOGNcvGeCKry5iXFLyM4pvwnKbsapLiaaIyJm5k6G9
         2brdDg9Hxney+o74sQhxEU4yumnIfDJZ/73MOlYklxKGktGH5MrGsjDBAar7EpQNwi
         gUFvxHh9iJhLH1JqIwmUFzaOa7J/jdgnsSSKu6VspbeQURN7s0gam2EbgF9r37KD5D
         kztO+8/gB+D8xOQ29G5s1muQ93wxfF4VJyeLdEP3Ho0VofibiZ3LcE7qspR0E338DG
         9MFWwOsCHb0IA==
Received: by mail-wm1-f43.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so7864562wmd.5;
        Sat, 29 Jan 2022 08:19:55 -0800 (PST)
X-Gm-Message-State: AOAM531D9SMn/eknOR7ugPhOZPk1JFG1UC2k81WzJuNRgc3k0h+DY9Sg
        4lbxL20gEzkkVhIBsPFyu+vNqd8WAGHW/gVTcSk=
X-Google-Smtp-Source: ABdhPJzEFC2YpKEZ1hgsY28YircroF5snPOgYrizVAYq4zDTywcro2JwThKl6Oxj03ZEup5kdtiQrwZtqqLM9U47B6c=
X-Received: by 2002:a05:600c:4f84:: with SMTP id n4mr11799956wmq.106.1643473194017;
 Sat, 29 Jan 2022 08:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20220110210809.3528-1-fllinden@amazon.com> <20220110210809.3528-2-fllinden@amazon.com>
 <Yd1cnquQFZoNE7FP@kernel.org> <20220124210538.GA15943@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
In-Reply-To: <20220124210538.GA15943@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 29 Jan 2022 17:19:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHSGGUhmAdOFzpHJrMjfts-AgdpVJ6LJRkmm9_xLL0guw@mail.gmail.com>
Message-ID: <CAMj1kXHSGGUhmAdOFzpHJrMjfts-AgdpVJ6LJRkmm9_xLL0guw@mail.gmail.com>
Subject: Re: [PATCH 1/3] memblock: define functions to set the usable memory range
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 24 Jan 2022 at 22:05, Frank van der Linden <fllinden@amazon.com> wrote:
>
> Meanwhile, it seems that this issue was already addressed in:
>
> https://lore.kernel.org/all/20211215021348.8766-1-kernelfans@gmail.com/
>
> ..which has now been pulled in, and sent to stable@ for 5.15. I
> somehow missed that message, and sent my change in a few weeks
> later.
>
> The fix to just reserve the ranges does seem a bit cleaner overall,
> but this will do fine.
>

Works for me.
