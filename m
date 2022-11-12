Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D406269D7
	for <lists+linux-efi@lfdr.de>; Sat, 12 Nov 2022 15:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiKLOQM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Nov 2022 09:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiKLOQL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Nov 2022 09:16:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28759DEEC
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 06:16:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C09306068A
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 14:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34859C433C1
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668262568;
        bh=GFpZlvI9h0ncfpBlN1DVZ/6hOsBzJh5MmgjMwM/1G84=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GzkyEYkd3fGUbuo2wjgGcSfrNXjFVLqm0lZ0UtMKEMbsh7rDwwWBXJ/pjkn0QqqvD
         g9yn5vXGLU49XCz7nW1tp7Cpmj1zQjt692QzcPP8jmkg2n+ty6QUdTYTrDVR27KExr
         0qmd+bBdsB9MHyUyma7MimbsaPZ9Mj9q6QbQoVizThtSvR0/ChgiAZ3DZpX86+TSUt
         9QAU1ZxLxt+m1DuwuZ7RM2lZmcuzSsDDhnmfhwSujUZIbyQs3ZI3py/B2Jt2HOq3L1
         ITho32hRVsAK5dXYH+SP6U7QVaNQjOD5/V+Bn+KzMvf2aRb+Kr4ih/X7nPrUtiddjH
         X01dO3d6Apz2A==
Received: by mail-lf1-f42.google.com with SMTP id p8so12321705lfu.11
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 06:16:08 -0800 (PST)
X-Gm-Message-State: ANoB5pkNxbY+Zyhd3Uhjo1N8HcClD2OfwTKv9mRa89B4EfjXhDx5IHQO
        +S0uY+xBN/I7yQCIcO0YkzWz15OEXWW7JathrIU=
X-Google-Smtp-Source: AA0mqf78h1j3Uo0xUKgojtdk2McWtv21BULcGLHg/W4oBp+eUXPmb21MpnlfNqDYjWWWEK3MBWjyK+KD2nEIFC7o9Sg=
X-Received: by 2002:a05:6512:1042:b0:4a2:2aad:95c4 with SMTP id
 c2-20020a056512104200b004a22aad95c4mr2492883lfb.110.1668262566186; Sat, 12
 Nov 2022 06:16:06 -0800 (PST)
MIME-Version: 1.0
References: <202211121437.39938.ulrich.gemkow@ikr.uni-stuttgart.de>
In-Reply-To: <202211121437.39938.ulrich.gemkow@ikr.uni-stuttgart.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 12 Nov 2022 15:15:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEgzN2WdnYdNvywG1XMT4uhhn5RU_64-JyVBiMASox5rg@mail.gmail.com>
Message-ID: <CAMj1kXEgzN2WdnYdNvywG1XMT4uhhn5RU_64-JyVBiMASox5rg@mail.gmail.com>
Subject: Re: Regression in Linux 6.0.8 in Lenovo T14 Gen 3 when adding EFI
 boot entries
To:     Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 12 Nov 2022 at 14:42, Ulrich Gemkow
<ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
>
> Hello,
>
> calling efibootmgr for adding EFI boot entries with Linux 6.0.8 does
> not work on our Lenovo T14 Gen 3 (intel). The error is "EFI variables
> are not supported on this system". The directory /sys/firmware/efi/efivars/
> exists but is empty.
>
> This worked fine with the latest 5.19 kernel. The config was transferred
> from 5.19 to 6.0 with "make oldconfig". All kernels are self-compiled
> and without changes from the kernel.org downloads.
>
> I saw earlier messages about bugs in this area, the fixes applied
> seem to be not complete.
>
> Please let me know when additional information would help to debug.
>

Hello Ulrich,

Can you please share the complete kernel boot log when booting with
efi=debug, and the .config used to build the kernel? Thanks.
