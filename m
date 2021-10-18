Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4494326D7
	for <lists+linux-efi@lfdr.de>; Mon, 18 Oct 2021 20:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhJRSvT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Oct 2021 14:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhJRSvS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Oct 2021 14:51:18 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40026C06161C
        for <linux-efi@vger.kernel.org>; Mon, 18 Oct 2021 11:49:07 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id u32so7592763ybd.9
        for <linux-efi@vger.kernel.org>; Mon, 18 Oct 2021 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sLVCD0rExduyTXmZdt0ez2+ozlFNyBz7kwhtChEvjZU=;
        b=IcD9m8jiQ76DfmyDzmJPWdgw/5uTQVy8lAi4SUkPpeJP1cAk3AO1/5hh2XGEYMcsdD
         6hWgOotl8/XI+o05XuQrrlrTb4CYErZ9Ts5ocJLkYRDTrEjmP5P6KaQDFC58kT1IiWEG
         sKhFdD2reGIPAIXA99JeRkni4MKWsa/POw6Y+wrJor78sQ0+fEPkCvIAJ+3A+Ub5a9jK
         bdFSvl8CbnTIwQHYisJZIzHTJljVCqtM6rZuecjq1oyXP80+uU23jOFAbRP0LsWQVNWG
         zV1TKFkOsXE6llEZvthC+aBlCICkJnDKO+Ezaor1y0953NO1EREFaKqd7ECth3OmjcH1
         lJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sLVCD0rExduyTXmZdt0ez2+ozlFNyBz7kwhtChEvjZU=;
        b=sq+4SYAmIKus0E0rYCLfXKcrTTO2lqfQPSG1gAQbJYnMTgWMOrcK/ywGtqUb3I0EIu
         gPdAy4WpH/oURB4eBG8o4pNHoj9zhvxn/HmDmYQYNcf+7SlwBM8jQeqFBGp1Y/wmXZrt
         CUUAuRMxFSZWwVH6Q8yJpvEUaKVwYfMvokIO6prGTpoB7Q4TYIHpDSaT7X+EJRW6wYzu
         uFa3vCgaTaMo8uTRt1/K5i0QMLwUe07vmXebmLjvp1GKRbhbGIZh24XoFjWstUudhJWe
         jAoqqkxhaA+z7ybts9LW4qVB3Z3vdcJjmWQzKrKiuJOiIcb+F9wIRwWOGZQ73ifvvQfY
         rFYw==
X-Gm-Message-State: AOAM5304XdDGLbae+J06cH8s85wiSHB6MkaKuKPBzFGc9QBoM58tkL/M
        Q7gpVDDbOR5tjD/nI0m5/ML6ZwNBd62rG7WbLIbu4v+53AAx/Q==
X-Google-Smtp-Source: ABdhPJxmwO9MAvH6Q6BCCFVNzICN9bE1l9LGKVAmleoXDaDpqpyFm6UCpZYUBRjgUbIT4IlCrXzv8BjrsYQWYeQ8xZo=
X-Received: by 2002:a25:cc4a:: with SMTP id l71mr30820867ybf.41.1634582946111;
 Mon, 18 Oct 2021 11:49:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:1f09:0:0:0:0:0 with HTTP; Mon, 18 Oct 2021 11:49:05
 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Mon, 18 Oct 2021 15:49:05 -0300
Message-ID: <CAKgze5ZZoqOjWrLap4gHPKMgAqeW5YYd=g25GKUiEQx6rjB7SQ@mail.gmail.com>
Subject: Can EFI memory descriptors overlap? [PING v1]
To:     linux-efi <linux-efi@vger.kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>
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
