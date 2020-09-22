Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BDB273DCA
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgIVIvy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 04:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIVIvy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Sep 2020 04:51:54 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A56C061755
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 01:51:53 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y2so17120577lfy.10
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcEIHiqTgU0mk1hPqpYU0Ly04YPiHVSHBMYpVUxmioU=;
        b=BxVKZ8dG9OOJfvAUnngMKEoyIUjlFmPR21gvYF2JUlO6kBK/PUg+7nxiRKSD8H729L
         bW25IaGeHrrke16Kg+5UF8jXwqUFxGdtDZG8XPjf2GLm6dHkzP7L+5bVjOLK/dHZphbE
         v1q0QBz0oNhF233s9McPSueq/6hiH0AiL3Ot9+GiGIDCrfPuOcJr32A9WLxJPw/Y0ulE
         rUWqMSnfBohJwaV02Zo3Uxcz0Pqey1nB7HhN9m0BGR/gY0XfLk/9IcL3E0/3PPI4XGdO
         U7DhfGrQB03XHip377lFhzR62rmp9t9lrhkcBJOKd8DdgaJJwzn93oWXBnRqqiVVON0k
         fgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcEIHiqTgU0mk1hPqpYU0Ly04YPiHVSHBMYpVUxmioU=;
        b=pf6gPTS/bHkvwO7eto/rAUZ8Vlks/eGFG+Bpx9pa/WCmphlnU6TfjTE55p3QWAFjmp
         DPXU5AaN/iUsulnO0+rwo7eLbgFB3+AfRxw5rPFSoJPkRqUjgSEDsytmJwPgQVU66MFY
         F/6+xIpaeZ4ezCv1/ZCV2nVyjjmJQ6qzd7Q6Wfm0GG19JwGkoWL8JAvDWRiQAoiWWlsw
         iz0ZTAdXoEnhvOj6AkKlXmQmehsjCc8EilNvW7SL4qFVHfuu6sKgqJQ+igDQRQdFfkOI
         FB+pCRQ+IZJXeyqVc9XPPuOTratCZXksE2qf5qqjL1bB+olkk1Qj6J1mWzJX4c0q63fx
         hiNA==
X-Gm-Message-State: AOAM530eCsjgm+O0t9xQOWGPeqYElkfjYWE2ScnX7iRaujvhidNRA/Wr
        Nm0gPNUuFE2/pQ9nBR8cA/APV9Gsp+ovlWDIxY5ukA==
X-Google-Smtp-Source: ABdhPJz/fPNH6x7WkeU4Gvq5gztV3X66C2CLQQzBXMin3Fu5/g3Hl4yTJgHatGkSTjsgMtLt231tjVKCANdnVKTxAD4=
X-Received: by 2002:a19:6c2:: with SMTP id 185mr1188339lfg.441.1600764712239;
 Tue, 22 Sep 2020 01:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-6-ardb@kernel.org>
In-Reply-To: <20200921154117.757-6-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Sep 2020 10:51:41 +0200
Message-ID: <CACRpkdactgVcSsm8wpqSDg=JkSM102GkeS4EM2YRr7y_hDDRFg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] ARM: p2v: factor out BE8 handling
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

> The big and little endian versions of the ARM p2v patching routine only
> differ in the values of the constants, so factor those out into macros
> so that we only have one version of the logic sequence to maintain.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Since you had patch 1 fixing up BE on LPAE I suppose
it is implicit in the commit that this was tested with BE
on classic MMU and LPAE. Very nice patch!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
