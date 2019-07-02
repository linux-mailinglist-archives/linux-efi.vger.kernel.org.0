Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A975DB2E
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jul 2019 03:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGCBxr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Jul 2019 21:53:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41473 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfGCBxr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Jul 2019 21:53:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so781914wrm.8
        for <linux-efi@vger.kernel.org>; Tue, 02 Jul 2019 18:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiKm32fbrJXvadhbbH8R2AC30oRr6R/vtBXdk9UU6tg=;
        b=rouFNaQrAD+LVzdQfwSGl8KyN3XCFATAsscS1nSiY3nqrVKn88L+2X9hpP8G0LkkWC
         NbXBVmKrNM2i/FYXzVyY65owea83CsnsL2EYq3GhtYm+wIktVkTqWtRAWOulqc+2Eijb
         tNZhEVAQRLz89yF0sk+uF/rQSzJNULI8c49x9De777zT65pYsUUSurWdrSNR9lmy2NEt
         9eY0VkqUb2j+lxdkUSL9dhgUIzql3NanYjEhvjtxJVfIfVj1EIEm0MIgXIiUzfQXV33O
         rHDGqg4EVcvtwueBiup5u0kebQrjrGClyg1D+nX2fPJPU7N/NtWIDb7JpF1b7OEh92lu
         QbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiKm32fbrJXvadhbbH8R2AC30oRr6R/vtBXdk9UU6tg=;
        b=S1RV3owqwzhQ3DeZwiQswdWRTKrQRzcTLYN4zOMRLGE9mA+7eK6bA1g/rezwcuZrSv
         oJJ8c/Map+WZc3l3wq1CeTjBZFTm4pyAppV+TKDBsZxvjIiKsvtaEN6mIcXClXPqRPPi
         zOb7iYOR34cdQON8ilUrmGwSuffu5/nSfF3rU9ent9lQn65MOqa3/+wy7vK7t79UQceS
         8jlG5yWBAqe5IXPvesvAFaZhxNueQANLmDUbaOtWAser7oxHbAIVQs/ZnqQnXtRWdYo8
         yF0SbothnEr5R6AFwEOr2hs3EO3EpTDPIi1hhP4smGtVMw/Yft8KDZEYfs086rPorzJD
         dbyA==
X-Gm-Message-State: APjAAAVBXZNWVtFEJjC1PQkpHpJU7OLRUt+bamjHOQAq3zsP+P4ZuxM8
        0YGMDtvg0bgfGlTFW2O+soMhWSeBrMsCHemoxeKSARJ7Xyc=
X-Google-Smtp-Source: APXvYqyzF5MuwoPkI10B4TbfC/rzEV0YiPHBluGmH1/zHhhFfHwqiAfVyxlK7Fj4GY/VFsoeVVgftVQDaSC75isjmzg=
X-Received: by 2002:adf:b69a:: with SMTP id j26mr17416154wre.93.1562099731858;
 Tue, 02 Jul 2019 13:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190630203614.5290-1-robdclark@gmail.com> <20190630203614.5290-3-robdclark@gmail.com>
 <CAKv+Gu_8BOt+f8RTspHo+se-=igZba1zL0+jWLV2HuuUXCKYpA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_8BOt+f8RTspHo+se-=igZba1zL0+jWLV2HuuUXCKYpA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Jul 2019 22:35:16 +0200
Message-ID: <CAKv+Gu-KhPJxxJA3+J813OPcnoAD4nHq6MhiRTJSd_5y1dPNnw@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi/libstub: detect panel-id
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Julien Thierry <julien.thierry@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2 Jul 2019 at 22:26, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Sun, 30 Jun 2019 at 22:36, Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > On snapdragon aarch64 laptops, a 'UEFIDisplayInfo' variable is provided
> > to communicate some information about the display.  Crutially it has the
> > panel-id, so the appropriate panel driver can be selected.  Read this
> > out and stash in /chosen/panel-id so that display driver can use it to
> > pick the appropriate panel.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Hi Rob,
>
> I understand why you are doing this, but this *really* belongs elsewhere.
>
> So we are dealing with a platform that violates the UEFI spec, since
> it does not bother to implement variable services at runtime (because
> MS let the vendor get away with this).
>

To clarify, the above remark applies to populating the DT from the OS
rather than from the firmware.

> First of all, to pass data between the EFI stub and the OS proper, we
> should use a configuration table rather than a DT property, since the
> former is ACPI/DT agnostic. Also, I'd like the consumer of the data to
> actually interpret it, i.e., just dump the whole opaque thing into a
> config table in the stub, and do the parsing in the OS proper.
>
> However, I am not thrilled at adding code to the stub that
> unconditionally looks for some variable with some magic name on all
> ARM/arm64 EFI systems, so this will need to live under a Kconfig
> option that depends on ARM64 (and does not default to y)
>

... but saving variables at boot time for consumption at runtime is
something that we will likely see more of in the future.
