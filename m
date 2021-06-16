Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978013A9D76
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jun 2021 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhFPOYN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Jun 2021 10:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232694AbhFPOYN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Jun 2021 10:24:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 795866109D
        for <linux-efi@vger.kernel.org>; Wed, 16 Jun 2021 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623853327;
        bh=eEMx0WOnXtmum4oOxdYk1pTMvNHI1H1Xdyiv8+wbZ+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HmK2hSta44PaDpy45emmGYomYdF5aCAlKzsshVYO65vJpua0zX6FnQSiAcUk+1Eku
         5tl6/CeA41v1EhImuELLGXZ6nwk8hBRp/FuYx+bxQ3eVq3bwZ6RlNeqQWCgr/uopsr
         jyIO2Y62p0Xsy71UES81ketz7xkVTTHxNidxNIb401yPf/Mez8xVsroHhOzpVjcVfV
         8RcA3ZarDh5uC6QDyTGBJXtIi3EcCTexFNtg48ADpDeGMbEn/Hl2vJvlTCcH0hb5ad
         t2KUV+TYZKTiiDqL7IylaQ/I4Pyng7pEtBQMjCqiYntqBgtrLt7/9PgsjhBMcKRLJQ
         CEF0adgxN0vrg==
Received: by mail-ot1-f54.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso2633623otj.4
        for <linux-efi@vger.kernel.org>; Wed, 16 Jun 2021 07:22:07 -0700 (PDT)
X-Gm-Message-State: AOAM533XQSySCxzaTPrMwzvN/L8FdxfaJqMlU347B8OoVw/jsJRUrB6G
        9oM+QYz7nfgSeVvBrC1Eud7SrKlA6q5vsuW3Z9s=
X-Google-Smtp-Source: ABdhPJzlSVk+kdVGJIR268KNDaH4aZkHTjsiNZMpd5cE2AB5mUFEYNxx+mdaSMnO3xbmCa4tLIK0iYnwVZxX+4IllaM=
X-Received: by 2002:a9d:4c83:: with SMTP id m3mr119599otf.77.1623853326911;
 Wed, 16 Jun 2021 07:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <dcb66364-d6af-3fc6-05dc-7507acedbb0c@t2data.com>
In-Reply-To: <dcb66364-d6af-3fc6-05dc-7507acedbb0c@t2data.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 16 Jun 2021 16:21:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHb8KZOkVKWNk-YorwoK-_RnwzjhevRWf3-uu55Ox24Hw@mail.gmail.com>
Message-ID: <CAMj1kXHb8KZOkVKWNk-YorwoK-_RnwzjhevRWf3-uu55Ox24Hw@mail.gmail.com>
Subject: Re: x86 UEFI stub builtin cpio rootfs.
To:     Christian Melki <christian.melki@t2data.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Arvind)

On Tue, 15 Jun 2021 at 12:45, Christian Melki
<christian.melki@t2data.com> wrote:
>
> Trying to incorporate a cpio archive but I'm having trouble getting the
> kernel to recognize the builtin archive. No printouts regarding initrd
> at all.
> Does the x86/UEFI stub/arch support builtin cpios? I can't find any
> documentation suggesting otherwise.
> Skimming through the code makes me skeptical however.
>
> What's the state of builin cpio for x86? More spec. for a UEFI stubbed
> kernel?
>

The CPIO rootfs should be independent from the bootloader, UEFI stub,
etc. From the bootloader pov, it is just a part of the image.
