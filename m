Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56714273D5D
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 10:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgIVIeu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 04:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIVIet (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Sep 2020 04:34:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800DDC061755
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 01:34:49 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so17053593lfi.12
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zR5AY8zGEZ0VbltaNHdBQ/w+c7vUvu3m8fvvx3qk9jA=;
        b=PjD1doSfJ8z/dXMb71WJplwhQnqpJaKJupqpgGXbpPvcbfsVZ4+hhmbP2ldeyw53aU
         k9asnl+4B9Tu+FPs0PBki1Kf9JUEX9IsZeWiURzZyJgPHZsAU24Ie5N+snhksi4OzNCW
         ONXj0xR9e7UsVlcJ+6I/a38lfxDQfp2Uj8rgbz3RvsDjINzUTKbt8ocNuyMrhxxv92IA
         AU+TIeyXqbzcQAPcGXiYo8MDaPYpGdJyiCJyygA4HNDVEFOQEVyLhivdAkxqOM0NqetU
         38DwRZNIuFUvWLfIMrk/04YdPKnovlAzbs0BkUF4KNIzgpicNBriKJ8YZWZm7x9ZCLI7
         azRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zR5AY8zGEZ0VbltaNHdBQ/w+c7vUvu3m8fvvx3qk9jA=;
        b=EIAJAJbfzrJohFA6WIddqNqfccoeGTUYFTfVgIYx1IvGCRg2I/pSbyjjvMr2yiHVVz
         4AlmtMfsqfS0930NOdqSGbf1uONQU8BZ47GMol5CJF2RLINAglWf2DjDPHPDadex9i1e
         dLsKOviFGQ9t0BARri4uUwWcuqf0lvUW9yH+9Vx7Ug84k6U2QYlGcHOM/OlL45HT2M0F
         MUTmMxwlVXL7u6K8LGIDMqJvA/iHRM+kIOtONwGYkNxGIZgsQry8cfzyqRJbsfUtPxng
         gs940/nhGHhpUG7M+VWc7+PnobWEs9o4gO1loz11wUks3MmM2pAMBTrJ76efRR33Hezs
         gruQ==
X-Gm-Message-State: AOAM533web9BkxR0BUmwPkHm4A8OO7lpTMwga9SoXQYPceV8lcmilBFU
        UqSOlFmS54IJzDnAPfRR6juGjvIXmYa7pBkSLYKSVw==
X-Google-Smtp-Source: ABdhPJwA1Vjl44dmNt8Jux6HsqxDKKl8Rm3oHffXrMZ0yqQeVYg+e0xqRa2RpPDilisAdUGETuICr2ICltzKlgVQsNI=
X-Received: by 2002:a19:6419:: with SMTP id y25mr1206725lfb.333.1600763687963;
 Tue, 22 Sep 2020 01:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-4-ardb@kernel.org>
In-Reply-To: <20200921154117.757-4-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Sep 2020 10:34:37 +0200
Message-ID: <CACRpkdavQg4-BajpoJDdktJ7dsvGvDr7pDpWy-_uJKc5HqfiiQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] ARM: p2v: move patching code to separate
 assembler source file
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 21, 2020 at 5:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:

> Move the phys2virt patching code into a separate .S file before doing
> some work on it.
>
> Suggested-by: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

This is a really neat patch. Removes ifdeffery and
modularize some really complex code.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
