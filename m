Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAC236F808
	for <lists+linux-efi@lfdr.de>; Fri, 30 Apr 2021 11:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhD3JlK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Apr 2021 05:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhD3JlJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 30 Apr 2021 05:41:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EED661469
        for <linux-efi@vger.kernel.org>; Fri, 30 Apr 2021 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619775621;
        bh=eT6E8MXn4fjkiLE1OWrxIAzbNeZuID1KEV4dI1EVMLg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cCHtvl28QTGySpql1KYc1tu4rCDH4i237LPPRgegbR6kFA/iBjjepptPCrPv6wsgB
         fnJgWQ4P6mibHC1g+HNECsP3uyTlUCIQ172asYPheyJRAc8t//a3STkwaRtugFLQYX
         CDHm2PLRbfNwYiikyRJ9rdA4UuLaIXMI2qQBhL4ocrJhPeEy5As3GNx+vkie9CLGCc
         blJg3E/EFNLWoYFUrqXels1+Qdbw2fwZXfbXKa2CkqUm8UIB1W7vKDmG0BC8uemQ9i
         Ra7gJMtL+7Ky17KMd7qZ4HarMr09ie28kSAJeoI+lD4s6JSpAlZRuQnB6MtaprsCWX
         ic6JJfS5ltVYg==
Received: by mail-ot1-f43.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso41414532otl.0
        for <linux-efi@vger.kernel.org>; Fri, 30 Apr 2021 02:40:21 -0700 (PDT)
X-Gm-Message-State: AOAM532vCw6PzUN4QkpSmw0WS4AX5Dl7FScmlgTwxWg5/31MkyTLcYYa
        7CWBSyS91tqPKoxLvY/8gbUBqT9gfwhnyYqlHLM=
X-Google-Smtp-Source: ABdhPJx35DESktuV3wL1J/IGZdnorl/xbkhJVgNDqkWjqH0uuR9hOgvXVxBzclmS9wpvAYSBnqXfJd0dsOhTiCfeLM0=
X-Received: by 2002:a05:6830:4d1:: with SMTP id s17mr2883098otd.108.1619775620526;
 Fri, 30 Apr 2021 02:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <c32f0994-605c-3770-cda8-335acaa53c66@gmail.com>
In-Reply-To: <c32f0994-605c-3770-cda8-335acaa53c66@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 30 Apr 2021 11:40:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHYxREHi_gUrajioaPAS8miHdpoqxUaqH9wYGpNAkCn0A@mail.gmail.com>
Message-ID: <CAMj1kXHYxREHi_gUrajioaPAS8miHdpoqxUaqH9wYGpNAkCn0A@mail.gmail.com>
Subject: Re: Still required that EFI_MEMORY_XP and EFI_MEMORY_RO must not both
 be cleared?
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 30 Apr 2021 at 10:06, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> I'm one of the people seeing the following warning:
>
> efi: memattr: Entry attributes invalid: RO and XP bits both cleared
> efi: memattr: ! 0x000000090000-0x000000090fff [Runtime Code|RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ]
>
> Out of curiosity I checked UEFI spec 2.9. On p.108 there's table 4.1:
>
>                                                    EFI_MEMORY_RO EFI_MEMORY_XP EFI_MEMORY_RUNTIME
> No memory access protection is possible for Entry  0             0             1
> Write-protected Code                               1             0             1
> Read/Write Data                                    0             1             1
> Read-only Data                                     1             1             1
>
> So it seems to be valid that both attributes are cleared.
> Also in the surrounding text I didn't find a hint mandating
> that at least one the attributes has to be set.

You are right. My assumption at the time was that not having either of
RO or XP in the memory attributes table makes little sense, as it
describes the default case. However, this interpretation may conflict
with the requirement that entries in the memory attributes table cover
an entry in the EFI memory map entirely, or not at all. IOW, if a
memory map entry consists of a code region, a data region and a region
that requires both execute and write permissions, there would be no
way to describe it unless we permit entries that have RO and XP both
cleared.

Patches welcome!

-- 
Ard.
