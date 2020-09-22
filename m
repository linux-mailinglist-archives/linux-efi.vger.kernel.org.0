Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA731273D6A
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 10:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIVIji (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 04:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgIVIji (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Sep 2020 04:39:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59959C061755
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 01:39:38 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a15so13436941ljk.2
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNUoKuOTd/hrSonBCLcZWUQuwhiP/mhLkL9sSv+Y07I=;
        b=ckRQa6P9pQaIgk9c+qzNK+RjjTyNzAfedMVT+SUD8ETy9L6cdJZmBOXAGrWYHvvllX
         8NEJ7985d1U0wXIXqn0+Y3ZQrK2cWhCmgrcZkUAYkk9YUxAa5wI1jknS+0m4mFEIUas+
         wr8LXOms24tHGBUnSWZfEJdMJTUspIojXzfvWpMPOTLkR9MMU1oF+TfRzgmvGC2w2nJP
         RMFIX43JtWpXq2dsFbr0qlul59wX8aCQuvPlkKINrrQzQuuv9M0eeu1cJoeNLHzpm0C9
         /5Xe1QKEfUUzc7lduO/JBiNxQW8bdEazh00w3ksd8iMTKxWRObmeS2aKW9SL7Ue6Zkat
         ngAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNUoKuOTd/hrSonBCLcZWUQuwhiP/mhLkL9sSv+Y07I=;
        b=SCq6f/0/PX9GJaUzNOq2u4AR2wu4B6U4LsWLVWY31UecdDzRsOE2Y7rLzq5OP0P8A5
         UdlfbX8qgZZUV/JY1BFmPNSTIcmpWaYRsQTaEbWzpIVOOd29KMO1ep9h6n3Xrm8B1qLD
         zHIowzOsO5iT1sE03QdH9B2XaMVnxpyRU4d8H11AmbRjXVs6MceJZOUg64PfvFam0Nw3
         Gzs+K/O2Hw6HdDI3iyKVBV70+GPm9bUn3HYJPX5BqE7PpSzQHZBbh45AwAu9D0iOTTqA
         GJfO12pj7DXj63V0dpSf1FA0m6xAi7VSim89bC/dYpxqDkK5mZ43BD9w9d1yKo/RjfXn
         IAeA==
X-Gm-Message-State: AOAM531lqJ8f0QmBBVabBeZPf9q+Wr0kFLcJRHLEECpFa+H8jT+d5HQp
        7tT9h9cKfTu2TZtUflAwqW/TBDmxB4AtUeYecTOQWQ==
X-Google-Smtp-Source: ABdhPJwz3VjcsDtP4p4LMZe1x4GAYiBDdtGeh8DRMY5Ox9ofM9CIBUYEbofykZvyzuysuZnQ26CPgKH0vbnd0A8mr3Q=
X-Received: by 2002:a2e:a177:: with SMTP id u23mr1098747ljl.104.1600763976841;
 Tue, 22 Sep 2020 01:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-5-ardb@kernel.org>
In-Reply-To: <20200921154117.757-5-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Sep 2020 10:39:26 +0200
Message-ID: <CACRpkdZETueMXpH-x=n=SUWSLZ_AVu1MKbx202K6WhyrmQAE-w@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ARM: p2v: factor out shared loop processing
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

> The ARM and Thumb2 versions of the p2v patching loop have some overlap
> at the end of the loop, so factor that out.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Would add to commit message: "changes numeric labels to
symbolic labels while we're at it".
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
