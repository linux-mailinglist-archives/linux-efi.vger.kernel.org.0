Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6B6273E06
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 11:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIVJFJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 05:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIVJFI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Sep 2020 05:05:08 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85574C061755
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:05:08 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x69so17185916lff.3
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QQ2P3P+sdUkSEH4MSr9MNEfdpk/hjp1k4VLzfLu7NA=;
        b=Y4ITyekGzUMXHk057uvLO1JI39HnaftfNBL9mpBU+Xkalm6gAAYVRv5vxRl8NYAgBL
         IbEkwdHnoQ0KiMBhXhYalR4Qm08KS82UcVdTZOqz3DdaO86+XYwtHN7VAqdZze0wFfWM
         TyvsR7NUKNbqdh2hHc/V7++wo8cD2azVjHWlrMHVW2+UHEMLL7YPw+lap3I1f+GhJrgb
         WZ/rvLZI8760CBP+EcnaR+1yeYy6RVe8yyCCpIKCthFKwwJ0zS9+mIOpoDCcvPc9Sym5
         swsf/htrLFHCdoidHLCM3Lx4e02cXKYVMGCI2DVRRxy0YYQnujn2Wn7HGulUqI+ZbxJh
         Re5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QQ2P3P+sdUkSEH4MSr9MNEfdpk/hjp1k4VLzfLu7NA=;
        b=Reweqq4Pg7oEqEc91b8gsFI0YTxKBRjsxg10KH0pNh/1m1x1vGqg8GLN+OANNjwoo5
         LOfuo/cRIEKPLxj61GkAEiDTiaCxgjRzpg1N730jSS3FwNK/5plnX7UjpciRi8TndnVE
         FjT4XN+hVBjFMRnXl861ygasPp0eVT0EK1j8f9I61EDcfI3nCviEo8n4c7G8vYPwoTMm
         Uv0yjvS8h3glz8GJoSmeHfT1dP5VReAxxeHMCWZNN9H8j+52G58LA7M1vuvFW4pssAaU
         DIpb1DjY34rXm0EQi17c+xaqZeZHxMFfck0IV/s14Hv8t0q2PdH0aqkqLzn/q4hvbAA5
         8bbw==
X-Gm-Message-State: AOAM533fGXx10rOeoIkIAqbZT/cJ+F3US0VBwpZdGynHZVelwwoLnIIv
        koFUM7zLJ7crHUZAqLFeSfMKxCw3aljNKPPZx75lbQ==
X-Google-Smtp-Source: ABdhPJyJVOf4CpIAPcPavHAMFqa8W1meGE93VB/DL7ncc3u6KmqSh5VZJVYUR0L6h4M+Asl/dOybZ+qgdwufBVC+K3I=
X-Received: by 2002:a19:1c8:: with SMTP id 191mr1229041lfb.585.1600765506999;
 Tue, 22 Sep 2020 02:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-8-ardb@kernel.org>
In-Reply-To: <20200921154117.757-8-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Sep 2020 11:04:56 +0200
Message-ID: <CACRpkda9hF7ScfFF=Utk7yx-Rztpe4Kat3=51jM0cbDT9UoMog@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] ARM: p2v: use relative references in patch site arrays
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

> Free up a register in the p2v patching code by switching to relative
> references, which don't require keeping the phys-to-virt displacement
> live in a register.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Neat!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
