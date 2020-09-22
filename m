Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FD9273D36
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 10:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIVIXf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgIVIXf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Sep 2020 04:23:35 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D17C061755
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 01:23:35 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 77so9737872lfj.0
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 01:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5REaWMFKHTuR35dTVuAEQg9tj6ynopK8vbPkfdOFwks=;
        b=tq9hjototVaRslfXax8qPyR/Z3gJPxAFudoyRKv1lA5Q19Y8Vu5J1qaFy18ow7ZNn5
         gJe+RzmSHgZI7vEut4EFkRDYdRjBUXOhbDkn3rz1UeoGgQ9Uw5oq9OMey2uwQncetSkC
         rgMmjeWD/uMDkFVJT6ZS2OJ6Wtkhn62pmwSQX7DbnvUcNZSiU/avrUPjZUwXCcjYg2yY
         azSlV2jqpGcYbeX51qAf++2qfwqHDaoAgyW4Z8KPssP4Rt6eamm1+x7kd06ATEXON88d
         155IoSz4NA4QsS87dQ/xvzbDCLCfyNJWb6LaxVH/Ffh/WYiLqTHF0/uV2Adz4ZbzAURE
         WIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5REaWMFKHTuR35dTVuAEQg9tj6ynopK8vbPkfdOFwks=;
        b=mJIH6RSjmAh67VUhYeiUhpGS2ki2ed5AGT5Vp/NFUAbojxHXYbA6GI5qYwJS4VlTSg
         Ih7GVNqdjwiRb9W7buiGJE4bX4J6qg+BLpAFeDY8vQUpaRZZ2tfp1Iv8P6QTQpf873Vy
         WfdEU30/kXzE2sx1vvwlQKmTVPu4M4ltjdHkROY0UMlq0s9xBtHHSLgG3MPqMEwe/Kkf
         ICADAfjIxUFPyCLIFgQZg5nxv2t436u1U4ycwwXY/FouRZ2uG5JvnD2aGhWtP1eJrSvn
         G5uLiLnfXTB4vwZJAjSqoUcSc3OuGlfFACKLhmOlDKo9SEtIIS7kqSpiUk6hW7GOdt64
         Y61A==
X-Gm-Message-State: AOAM532BOazP4A1+FMCzE1R1KuRkuKwoKAcK/c4VUqQeTqhFpuF4+Bt1
        U68cKLfAHu3HwHfoLPVaREIycemKgupdJQKWnZvSgg==
X-Google-Smtp-Source: ABdhPJwzEQcsamNCJkfg1YXgfRhyZg3hu3HGL6ymrcFuim3TOI3LOkmznhWxnE3RwgFEFijiDPniHzJKeQ5DinXAQ5I=
X-Received: by 2002:a05:6512:370b:: with SMTP id z11mr1168887lfr.571.1600763013593;
 Tue, 22 Sep 2020 01:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-2-ardb@kernel.org>
In-Reply-To: <20200921154117.757-2-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Sep 2020 10:23:22 +0200
Message-ID: <CACRpkdZJzwyK5zqa7i6ST9U1NrVfZ8Mun9YyDV3Fms97mT9Stg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] ARM: p2v: fix handling of LPAE translation in BE mode
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

> When running in BE mode on LPAE hardware with a PA-to-VA translation
> that exceeds 4 GB, we patch bits 39:32 of the offset into the wrong
> byte of the opcode. So fix that, by rotating the offset in r0 to the
> right by 8 bits, which will put the 8-bit immediate in bits 31:24.
>
> Note that this will also move bit #22 in its correct place when
> applying the rotation to the constant #0x400000.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

That's a good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
