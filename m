Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87BB23BB1B
	for <lists+linux-efi@lfdr.de>; Tue,  4 Aug 2020 15:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgHDNYt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Aug 2020 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgHDNYr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Aug 2020 09:24:47 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A213C061756
        for <linux-efi@vger.kernel.org>; Tue,  4 Aug 2020 06:24:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so22132219pgf.0
        for <linux-efi@vger.kernel.org>; Tue, 04 Aug 2020 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LL7CVx3M+GnKSSe8eUQMx8d9kBXew/bFtxjaZTrFB4I=;
        b=HNLlroBUqWnzQ0xGT6GTr/Id4TzheIch2ECQb//1Mh+eL1JbUWj7mgeq13LfdccS98
         IS3DGtZa2HgV/RhIJuVePSKzqD3uwjzCS1qPt4Fito6mIqPvXraCYBmdo3L34332gOIm
         WmfyL0evZGWgvDbKbmphDaCTUSc2DQbsN3FZIG1S/LRGxUsEGkoRmRKe10PFG0piz92M
         AhSuxdBD/UQqupXICBkPfCSJFZTywgv3NvO04VK0i+G1rFdbd3XmQteUx1vj4/C5GbfW
         pWOV7qnFTZRWi05TIryxjWTQNA2vc3vyZdMkk8iDFMuFXYFCkua4Y53lmW6gg4sBAf/7
         0SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LL7CVx3M+GnKSSe8eUQMx8d9kBXew/bFtxjaZTrFB4I=;
        b=Y04H9AzKwDqo9OU2IawPCArqWLx9JuhqE8kTRxqOvUNn8mplnWeKpSbs/rYdhZyVAl
         0D1aGVoTr9OYIDOGBM7S49PzXtWqvSSsAWa1spbTKjh3DKzC0VEdYBbzAJrZcO25FACH
         6dOf25P1wm8BPNFRTjFLsrmPdXT/Z/YpO8NIZ2ySJcNQ1Qu23w39DsnzP3AVp/vwTvgH
         0Fc6lLUb2DqOZEAP//sBohpQQYDGmoPARw6AG4geFZpfcI//fIYn8oCPEcDVxYhXVFlE
         yLDjSnAY/upNw31o/A0zPbGWfsyiv4hy/dpTBeZuQQi0kBDf6dQ3kKlf0xYIo/umAjJl
         owig==
X-Gm-Message-State: AOAM5307Eh710far/H2RKYQLCXZlMeBBgQ21XN9/2ASMq90BMbsPIc5n
        ovESGX05YrTQtCSJsd0nDMcC96HaBK+pAA7zw4NNWA==
X-Google-Smtp-Source: ABdhPJx3jQKW6ryn3Y7C/EY3oYgP1FKFpU1S+iDkIFMexVg3zCcBg4JLu/mb7S7DJX/i24rr6RUB20iZPZdJ3KDAP60=
X-Received: by 2002:a65:4bc7:: with SMTP id p7mr3313300pgr.440.1596547484618;
 Tue, 04 Aug 2020 06:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596544734.git.andreyknvl@google.com> <26fb6165a17abcf61222eda5184c030fb6b133d1.1596544734.git.andreyknvl@google.com>
 <20200804131939.GC31076@gaia>
In-Reply-To: <20200804131939.GC31076@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 4 Aug 2020 15:24:33 +0200
Message-ID: <CAAeHK+wVpLvjcwGzD=0FyXiC0+tf6CU0uwh_vfzBXfaCpDyKPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] kasan, arm64: don't instrument functions that
 enable kasan
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 4, 2020 at 3:19 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Aug 04, 2020 at 02:41:26PM +0200, Andrey Konovalov wrote:
> > This patch prepares Software Tag-Based KASAN for stack tagging support.
> >
> > With stack tagging enabled, KASAN tags stack variable in each function
> > in its prologue. In start_kernel() stack variables get tagged before KASAN
> > is enabled via setup_arch()->kasan_init(). As the result the tags for
> > start_kernel()'s stack variables end up in the temporary shadow memory.
> > Later when KASAN gets enabled, switched to normal shadow, and starts
> > checking tags, this leads to false-positive reports, as proper tags are
> > missing in normal shadow.
> >
> > Disable KASAN instrumentation for start_kernel(). Also disable it for
> > arm64's setup_arch() as a precaution (it doesn't have any stack variables
> > right now).
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> I thought I acked this already. Either way:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Sorry, I forgot to include that into v2. Thanks!
