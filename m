Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AC0273DEF
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 11:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgIVJCU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 05:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIVJCU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Sep 2020 05:02:20 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D537AC061755
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:02:19 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z19so17198848lfr.4
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oku/MtBl+8dGavsrtnGOsbfV42oh0TYBB3i/iZs9/0g=;
        b=rbr3hlZeQFeKP2JE0Bbt+eIxOxg2XQ0JutrKvbuontMpLLLlmjtOXfl7cMWi01oLHJ
         tDDCn6IdARn5+e2mwlymIb9hbAIZiQEDDkd5jm7zN+NExSfPdQdQh8EUoHqrmIh1+7Bm
         M2sD6QSbcY5g9ooNLmBOH5ABQvbd2emxThpTfoJqkFyteth7+WXm1lBfxrOlbSgw4Bph
         YA3olHrotaoawJLjzjL8TMjBEQqMD944avoX4+cvtlUmVl9zfqcmkwTaMUpmDTLMnxag
         0JFeiWKVWEgQ5Lf2OUwFGpie1Rvyb98n6Q0LJwxd56aXmx3hOyulXuOgtfn29eepopnB
         KunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oku/MtBl+8dGavsrtnGOsbfV42oh0TYBB3i/iZs9/0g=;
        b=iz6Tj4MK4ilFVWTdYAQV5KZyW8jwjzFjexvJL7IPBdGRza/Vco9zaDUDCQBRcTWHK1
         Lq7k71k5f/A9NuU9GmQo/23NVlcGOKblbM7pVPWIyciZgUDRgojVDiu/ERo08ylG2Cng
         Ko4miZRcWdHsy6Bd+XVoZuwUzmruUs9evw6WDmjL8PCq+/Js1w0Xq65nouMlvShjSIxw
         TY84s67aEGvPXDM7cig4OYJI7mJxEIRbM89/gRp7saDo6/LJD+5lj7JmKURLPP++7Ui2
         Fx3zCQKXJaZnx1NtDslriSUQkNLaxxCL6sv2YNB9/XewRiNJs6SkXlDp254eWIv4+j+l
         VFoQ==
X-Gm-Message-State: AOAM53112o+rPc+U5qCpm9TmQFIZtcPFvK05+aCxE1fHG0ZDhVnbADv+
        Qr0KrLx2ZuNON2vmdauAuziYO3HGplRkIPXCrkyZ01J0WgKWdA==
X-Google-Smtp-Source: ABdhPJw8WS+6RA2TqRrqmZCoFGVn4IhOIQaTlFCO9SZ4B4PQLAJ0UydtKNQv7l6mGmHFskZFz8P4Rb5daWLwAncrhxs=
X-Received: by 2002:a05:6512:370b:: with SMTP id z11mr1217160lfr.571.1600765338340;
 Tue, 22 Sep 2020 02:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-7-ardb@kernel.org>
In-Reply-To: <20200921154117.757-7-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Sep 2020 11:02:07 +0200
Message-ID: <CACRpkdbAi+HFKwDM2he3s18LwvSb6F8nB_nSUOPrAyJbayfF_g@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] ARM: p2v: drop redundant 'type' argument from __pv_stub
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

> We always pass the same value for 'type' so pull it into the __pv_stub
> macro itself.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
