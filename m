Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26E41B843
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 22:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242668AbhI1UW4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 16:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhI1UW4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Sep 2021 16:22:56 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4ECC06161C
        for <linux-efi@vger.kernel.org>; Tue, 28 Sep 2021 13:21:16 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r1so288573ybo.10
        for <linux-efi@vger.kernel.org>; Tue, 28 Sep 2021 13:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sLVCD0rExduyTXmZdt0ez2+ozlFNyBz7kwhtChEvjZU=;
        b=INrkyL/3icrs5muSdyE3VDftT6APzNLOiyxbywrdyrboRfo8i/NHOnG8ZNSvzHTDaS
         0BeL+3w9HwAKpPZFCjw7z4Og0djOL2RnDJQYnjwVRSUB4nioLlccMgNKWKdqwnz3Tj4F
         bZuxobXhj4LXK3iKzkSe5HbuuZCZm0m3UHL5P4Q3KQuW+O3eADa8iKDAf7S0R7WNUPsg
         uPBtc32HVVBhQ9tZsbfjhmrF9elPMvxMxGHifMDAQbnn7kIRE0/Ca5EXpRQflzQmd0g9
         0iuDRGH6t7mNElbSaw8jKPlU5tyA7Z4uXXXjRIdQijMoZxvdy73QrxWdogjgrazjQNFH
         /g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sLVCD0rExduyTXmZdt0ez2+ozlFNyBz7kwhtChEvjZU=;
        b=tfx2SgUG4ctyEuDWW6RXrTHMHUG/l+sC0SAPlqzccRi3EZ2ER0zPm6DrxxyZq2MCJ+
         YgkUhlO/ZtVkNurOY05s6pZb2QGLBeCbRDsNs7/e12aoXkMS7K3r7FDR7D/mXp6SZy2A
         w4CLECUJ1Jz1QLVtjxqNK7UOts36a8k0zbWl6l6SkhpwWeNZv/mGaAM+tv5x8xTCUjaE
         LtAdAxh+MdMzWHKviYiCnnMzS1FgXV8Af7bd1tM9FhnCfp5INuadj1MZg1rHWV06jb6d
         nlu3HlJ8UKMM+bh/O9vHXYKQBfBLr1Xm3jXMG99qE1j7wBF1AFiffrAutdFhWnfSfHKG
         oqJA==
X-Gm-Message-State: AOAM532BGYUdVnzMnwKAT4vg4Xa8ll/lsiwDW8pyCo0WWUN5P+PwiVob
        s9pOpm0Dj25HHN3RMrhnkKz58Z17NOgNonK9ZeN3zcfD5NTyBEdx
X-Google-Smtp-Source: ABdhPJyye4vX+N0TjVGhwGJMuu+Mt07kRf5Q/1NVJ1iYUP3ibuGV2MlIF60umrVDJW1sZM5CorBMaXKaFY4xp1W3oN0=
X-Received: by 2002:a25:b3c9:: with SMTP id x9mr10207681ybf.514.1632860474799;
 Tue, 28 Sep 2021 13:21:14 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 28 Sep 2021 17:21:03 -0300
Message-ID: <CAKgze5aPLn-2ZOJsmWMnsSsYoAsxuJRq7rE4X1f0JMKjQeupPA@mail.gmail.com>
Subject: Can EFI memory descriptors overlap?
To:     linux-efi@vger.kernel.org
Cc:     Daniel Gutson <daniel.gutson@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, I'm working on the rework of
https://lore.kernel.org/linux-efi/CAMj1kXEqjHVRNV131=o_aO3TX+58xhYzgfaVDrd0RngAqqtrVg@mail.gmail.com/T/
and I wanted to know if the memory map given by EFI have any guarantee
that the regions don't overlap.

I couldn't find anything in the UEFI spec, but there is a piece of
code in the kernel that seems to "doesn't care" and assumes that the
regions given by EFI are sorted and don't overlap.

https://elixir.bootlin.com/linux/latest/source/arch/x86/platform/efi/efi.c#L502

static void __init efi_merge_regions(void)
{
    efi_memory_desc_t *md, *prev_md = NULL;

    for_each_efi_memory_desc(md) {
        u64 prev_size;

        if (!prev_md) {
            prev_md = md;
            continue;
        }

        if (prev_md->type != md->type ||
            prev_md->attribute != md->attribute) {
            prev_md = md;
            continue;
        }

        prev_size = prev_md->num_pages << EFI_PAGE_SHIFT;

        if (md->phys_addr == (prev_md->phys_addr + prev_size)) {
            prev_md->num_pages += md->num_pages;
            md->type = EFI_RESERVED_TYPE;
            md->attribute = 0;
            continue;
        }
        prev_md = md;
    }
}

Is this a bug or in practice EFI always gives a "nice" memory map? I
think that if there is no overlap then the sorting (EFI doesn't give
me a sorted memory map on my machine) is a kind of easy problem to
solve, but if there is overlap involved then we need to decide for the
type and the attributes of those overlaps, which can be tricky.

I'm working on x86 and with the master branch of the kernel.

Martin.
