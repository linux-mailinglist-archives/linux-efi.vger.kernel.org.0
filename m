Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90A163543
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 22:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgBRVnH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Feb 2020 16:43:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgBRVnG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Feb 2020 16:43:06 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A36624654
        for <linux-efi@vger.kernel.org>; Tue, 18 Feb 2020 21:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582062186;
        bh=rnCNNwfwhhUByAEoWNGt0qucm6qUiZuNAQwPm+qSMtM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aicildmJ7rBxWL7JzzdwvmvR9g9L8JkOfUpk+3g8xitwe8LZhGDavlRVGXFzvIb4F
         b4LDzq/aP/RrVNhXbcYbtdg3dA8L7bJdi5jeRiSCN0TfrDV/NpRPJMaJ1E/LKB1Xcl
         6BvCRpQ6lZOA5Ryvr8bQEUY+dDjqqLIg/gU55h98=
Received: by mail-wr1-f41.google.com with SMTP id t3so25773762wru.7
        for <linux-efi@vger.kernel.org>; Tue, 18 Feb 2020 13:43:06 -0800 (PST)
X-Gm-Message-State: APjAAAUrmMI+upPx5plRS07LCuqPRM2q6mkQSyoT3ELMqHFj8GhelVE4
        Mz135KCJ54jtEy+GcLbhFVMOZ4TScif4luBp1eZbnA==
X-Google-Smtp-Source: APXvYqzLREAcofk3M298MDaI+8CWYJZx5SlL6vMrAkXQhof8olULKyvV0eELk98DkPzLqW5H2eTQ23f8/Fz6jJu3GmI=
X-Received: by 2002:adf:8564:: with SMTP id 91mr32101320wrh.252.1582062184607;
 Tue, 18 Feb 2020 13:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20200218063038.3436-1-xypron.glpk@gmx.de> <212145f2-5b00-fe82-82a8-360d3f608b35@infradead.org>
In-Reply-To: <212145f2-5b00-fe82-82a8-360d3f608b35@infradead.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 18 Feb 2020 22:42:53 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8ggxtYehOc++E+NxiaRuDigieUQauz-xbCPXU1vW6sEQ@mail.gmail.com>
Message-ID: <CAKv+Gu8ggxtYehOc++E+NxiaRuDigieUQauz-xbCPXU1vW6sEQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] efi/libstub: describe memory functions
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 18 Feb 2020 at 07:33, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/17/20 10:30 PM, Heinrich Schuchardt wrote:
> > Provide descriptions of:
> >
> > * efi_get_memory_map()
> > * efi_low_alloc_above()
> > * efi_free()
> >
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> > v3:
> >       add missing colons for parameter descriptions
> > v2:
> >       point out how efi_free() is rounding up the memory size
> > ---
> >  drivers/firmware/efi/libstub/mem.c | 36 ++++++++++++++++++++++++++++--
> >  1 file changed, 34 insertions(+), 2 deletions(-)
>
> Looks good. Thanks.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>

Queued, thanks.
