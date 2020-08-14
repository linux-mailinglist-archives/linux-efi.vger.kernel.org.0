Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BAB244503
	for <lists+linux-efi@lfdr.de>; Fri, 14 Aug 2020 08:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgHNG3E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Aug 2020 02:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgHNG3E (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 14 Aug 2020 02:29:04 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F8520791;
        Fri, 14 Aug 2020 06:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597386544;
        bh=fc91yarCTH69Zspbg59v1kAG6yeSpGx3fAOjqMTPChg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V18J4pcBcdCcPtSyF0uEXxRQtdLTKmx7pEOZrJ/23cW/niZUEps9Dw7gYVjwGZ9Ax
         GAUYT6LP2nKMm6EDQUsEkS7YZj3DpKiJVWEs4ghiSVLKY4VkifNbq2mbmEkpylbejW
         CIabmmSklawld1ymXmOXpVtQ9r0EdgBG74MA+GCg=
Received: by mail-oo1-f46.google.com with SMTP id g1so1715269oop.11;
        Thu, 13 Aug 2020 23:29:04 -0700 (PDT)
X-Gm-Message-State: AOAM530E7VRYiD+elXr+aMmN8p7V9QFxrIEQBlH9vWkxZf787p8YP24b
        V4MyNJKQEZ9MxvnSix7MzWABoSWVDzLiLlTti9Q=
X-Google-Smtp-Source: ABdhPJws8LyTKFi25MNWfpNV7vUpa0UMsbjSu95Uhsc10Q3iQ02/+cjRY0CrMDG+0ew42fMo8w9tjkkR89gq9jOAAVo=
X-Received: by 2002:a4a:da4c:: with SMTP id f12mr681160oou.41.1597386543479;
 Thu, 13 Aug 2020 23:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200813185811.554051-1-nivedita@alum.mit.edu>
In-Reply-To: <20200813185811.554051-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Aug 2020 08:28:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFm8xZ2Sk9r5XZQuRN2BoCGcysOaEq14MChS1T7zqj1PA@mail.gmail.com>
Message-ID: <CAMj1kXFm8xZ2Sk9r5XZQuRN2BoCGcysOaEq14MChS1T7zqj1PA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Three small fixes to cmdline parsing
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 13 Aug 2020 at 20:58, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> First 2 are resends:
> https://lore.kernel.org/linux-efi/20200725155916.1376773-1-nivedita@alum.mit.edu/
> https://lore.kernel.org/linux-efi/20200729193300.598448-1-nivedita@alum.mit.edu/
>
> Arvind Sankar (3):
>   efi/libstub: Stop parsing arguments at "--"
>   efi/libstub: Handle NULL cmdline
>   efi/libstub: Handle unterminated cmdline
>

Thanks Arvind. I already applied #1 and #2 locally, so I will just
pick up the last one.


>  drivers/firmware/efi/libstub/efi-stub-helper.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> --
> 2.26.2
>
