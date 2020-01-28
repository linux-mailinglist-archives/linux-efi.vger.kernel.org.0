Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9838814B077
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jan 2020 08:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgA1Hd7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jan 2020 02:33:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43454 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgA1Hd6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jan 2020 02:33:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so14759092wre.10
        for <linux-efi@vger.kernel.org>; Mon, 27 Jan 2020 23:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8/h2bPEqPWeThJEypD1fDrIV3uZkJ0Spf9SsxFALTw=;
        b=dwotw4KanF7Rr5R8R+2zrC3GotxW2umZNPfukUzk39baBmVods+BoK4dMAq69uYY7g
         w+SGWEGZHNJ117MWwkKscB+LUpFA0VTRNzPK5XqDaJvKe5Qj2nkaCcDoJ37jygI6Qko+
         TrLELDx6JWBc5d4RGGgNhVk054IOYJNs7Gz1W+rYkqSELCoMtxiqUTLaa+Ua/RvykWui
         fB3lw5IUXN6sGkdbULostObMmmUdEVueFtG0ZIY2lKIFB1p2LE2rZw9EW/wnf5Kug4nS
         MGe6fZlyEvhDmlbzuJY2E+FIUkQkEF8t9chSY/c3eX8dC4ULgOQy+d2PN6O42rumfvFZ
         6/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8/h2bPEqPWeThJEypD1fDrIV3uZkJ0Spf9SsxFALTw=;
        b=oEt97SgWqDZEdqaLCGTCsUYVoOZAW8w5rY0EkMZUTajv/TIbi/GqHB5suu8d5ji0Iv
         MihxB5ykuQ38QwdCiMMD0Y9VR000KKfqQdj/UkxBg2Tto471pcbLedDOJWrEltPD0IuE
         nUYBDK9hJcPXWbxMkQ7Mouib9xNdZIYa6rFf/C+Q09vIUaNdpwy5/ak3NGzOXVgK5YDB
         lON9kBhsZcH55wY2e9nG75BZE+sKeROrzisGwBsw5JjnYeQZkGs3hhItycdka93O6Z3b
         HOEFI4x+Hv9xW7E2WxU2Z5NNwlwjbxtETc5xdj2bNsRb1NgUVph9CWqqMR50ctgAg1tk
         imkQ==
X-Gm-Message-State: APjAAAUkzJoAsze9l9G8saXHseDlaggL7jrLM1XS9JI+txlDFGIk1yzj
        5wWYVi/6VDkfYth9u5Ett7G2Kr9qlqxrVvogCEG7oA==
X-Google-Smtp-Source: APXvYqzRsFwG9bEQ85NBunD148AjHa0dxOfEOo4Rm/EgIgpxum6o/BtnVYQzHUFVAAdT5QZodGqW2WChnr5jeU+fLZs=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr26280990wrw.126.1580196836110;
 Mon, 27 Jan 2020 23:33:56 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu8ZcO3jRMuMJL_eTmWtuzJ+=qEA9muuN5DpdpikFLwamg@mail.gmail.com>
 <E600649B-A8CA-48D3-AD86-A2BAAE0BCA25@lca.pw> <CACT4Y+a5q1dWrm+PhWH3uQRfLWZ0HOyHA6Er4V3bn9tk85TKYA@mail.gmail.com>
In-Reply-To: <CACT4Y+a5q1dWrm+PhWH3uQRfLWZ0HOyHA6Er4V3bn9tk85TKYA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 28 Jan 2020 08:33:45 +0100
Message-ID: <CAKv+Gu8ZRjqvQvOJ5JXpAQXyApMQNAFz7cRO9NSjq9u=WnjkTA@mail.gmail.com>
Subject: Re: mmotm 2020-01-23-21-12 uploaded (efi)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Qian Cai <cai@lca.pw>, Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Jan 2020 at 07:26, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Jan 28, 2020 at 7:15 AM Qian Cai <cai@lca.pw> wrote:
> > > Should be fixed by
> > >
> > > https://lore.kernel.org/linux-efi/20200121093912.5246-1-ardb@kernel.org/
> >
> > Cc kasan-devel@
> >
> > If everyone has to disable KASAN for the whole subdirectories like this, I am worried about we are losing testing coverage fairly quickly. Is there a bug in compiler?
>
> My understanding is that this is invalid C code in the first place,
> no? It just happened to compile with some compilers, some options and
> probably only with high optimization level.

No, this is not true. The whole point of favoring IS_ENABLED(...) over
#ifdef ... has always been that the code remains visible to the
compiler, regardless of whether the option is selected or not, but
that it gets optimized away entirely. The linker errors prove that
there is dead code remaining in the object files, which means we can
no longer rely on IS_ENABLED() to work as intended.

> There is a known, simple fix that is used throughout the kernel -
> provide empty static inline stub, or put whole calls under ifdef.

No, sorry, that doesn't work for me. I think it is great that we have
diagnostic features that are as powerful as KASAN, but if they require
code changes beyond enable/disable, I am not going to rely on them.
