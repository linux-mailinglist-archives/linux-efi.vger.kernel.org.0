Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A97273E13
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 11:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIVJGy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 05:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIVJGy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Sep 2020 05:06:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4972AC061755
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:06:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u21so13472153ljl.6
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMyHGdJM49aioMW3pu8O25BW/Y0DrIOoBt7UWn+i/n8=;
        b=oJ7xhSxz1GSRdt7YdLdZvzzhEhXRyeQLIKXdrQnPT+AZigpguvDUOkhXvqz+2OCAZM
         ftmz3rwIoepRJsPfyGO6oW1ZEXwmedYVEEejm4GoF8G+2LFAI04yjnKqFTmfvGh13ftB
         GBXMmFn/QvM5GHwPK9yXSNU5XQuWTYkfnOv2K+TR/64T2LD+kDy9v13DqrwOjjFaAybe
         C7wjuY1TgGy5+nXIADOTZfWdxyZ+o7Jr5NGSOhJsiHB0907vwVWDtjyfX8XvbDcHUtwg
         BEkV7+Fyla2tlzjoPsNza/V4g0DJ2UrTMQYoSJpC3aLHZSgalOa/uO2B8wTIBmlQhq3u
         3Hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMyHGdJM49aioMW3pu8O25BW/Y0DrIOoBt7UWn+i/n8=;
        b=nlG2vd0as4/W/ww2AoU34oqqPaYCtJ5AB7fzDmv8kaM1OpY7Uozr/0WylHaha3J5o6
         PqKFxXb63D0XnlAwX6DJKtm0z9GFwF2XCQQGvE5T3+MEU7ITH9f5IGCcjbExRnnOkYnA
         7QDsYOBzWdQ+ynDvT7kcLIfdo1WDOjtPLHhV8WwqV5y+pPKjYxs3JeFWAu1jgcvV++2z
         0whThNftQS6fuTg+WSZh2iYHTSW7Nu1s8hfKhnwnrf7phY0NzPbudTKQA7hkzc62ochB
         093LC67sqg2bacs0ZrElRhrzDSX4N/QJzKITkkqlnlPJFgYx2TA8OdHyAkEwbNZl1yCD
         8mGg==
X-Gm-Message-State: AOAM5300rTCCTwgeD8+seIeecMz6+oZHBq6xgy0JZk94KWSUh0I362Fr
        8tskNKKdTIBGXZSHzTIxNJaRZzDjBVcdYdAhamonZA==
X-Google-Smtp-Source: ABdhPJx/F6bvkvoYifwygTTUbaui5ANc12Yg3LnkGrgP5hNmC2ldjNuWX20m5vV2FqzJxAOQdVDNIoVZF+Hm5VxdGuM=
X-Received: by 2002:a2e:810e:: with SMTP id d14mr1283697ljg.100.1600765612760;
 Tue, 22 Sep 2020 02:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-9-ardb@kernel.org>
In-Reply-To: <20200921154117.757-9-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Sep 2020 11:06:42 +0200
Message-ID: <CACRpkdbKoJeit7Y6zr__46qNfSxUgixqGdXRYWE19WFVJiFxrg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] ARM: p2v: simplify __fixup_pv_table()
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

> Declutter the code in __fixup_pv_table() by using the new adr_l/str_l
> macros to take PC relative references to external symbols, and by
> using the value of PHYS_OFFSET passed in r8 to calculate the p2v
> offset.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
