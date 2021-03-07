Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80CF33032E
	for <lists+linux-efi@lfdr.de>; Sun,  7 Mar 2021 18:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhCGRJZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Mar 2021 12:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhCGRJE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 7 Mar 2021 12:09:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7747C6503E;
        Sun,  7 Mar 2021 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615136944;
        bh=nlD2LHI/3PWGrlpTYwTaMZVGa1MrBYm3Lg/lYOU2mVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pJ3bogdquSGlNatEqyFNjMHkcX1hhxB0sf8agvaO3H1aGjcoZ3IEC5rXpLuEbgbge
         3bYL8DaMHpEvw9KZ6bGAECWrRxmH0XB810VddSn6ZJhX8avT5OBzQgVQcObjPmzsyN
         Day6Cy8b/6cxC7hMq91kUd5h8hP4ck50fTO36XjsqQTVOs+b3hf8/MXjqW2vBIq910
         O0y3w4eRwUNIhaRwm1GvsQUu8s3NSjUs1yWscCjHlh14CrX5FXFMngS53A5LSYN8mJ
         x4WSTPCWWtYSHLy8nRzkw3nJPbWELYZfnukvwV8I+ugBnJXxkk2A7RyTGt4aimz4zk
         9zVmdOQP+iX7w==
Received: by mail-oo1-f52.google.com with SMTP id l5so1665712ooj.7;
        Sun, 07 Mar 2021 09:09:04 -0800 (PST)
X-Gm-Message-State: AOAM531tjP7mdexSVa64UKXgX/un3CqFwzJ+OrQLuU8BN62WuMM/epHM
        DR30Tw3UzHX4DAEhmrwvyvOUUAOjZXj94gAAMvI=
X-Google-Smtp-Source: ABdhPJze4qVJaipYIBnKjCumOc0NRg2rmqBgWPDIp9oBWmUN/9Gpsxrmi99m+8cUbc13j50JlIIHU8R8hkWe9ykebZI=
X-Received: by 2002:a4a:94a7:: with SMTP id k36mr15571558ooi.45.1615136943864;
 Sun, 07 Mar 2021 09:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20210304082837.22262-1-heikki.krogerus@linux.intel.com> <20210304094420.GA25266@wunner.de>
In-Reply-To: <20210304094420.GA25266@wunner.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 7 Mar 2021 18:08:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGDX58Ek93yoBR0pp5G6h0q6PoVDURuOWxqV-gy8eshQQ@mail.gmail.com>
Message-ID: <CAMj1kXGDX58Ek93yoBR0pp5G6h0q6PoVDURuOWxqV-gy8eshQQ@mail.gmail.com>
Subject: Re: [PATCH] efi/apple-properties: Handle device properties with
 software node API
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 4 Mar 2021 at 10:46, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Thu, Mar 04, 2021 at 11:28:37AM +0300, Heikki Krogerus wrote:
> > The old device property API is going to be removed.
> > Replacing the device_add_properties() call with the software
> > node API equivalent, device_create_managed_software_node().
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> Acked-by: Lukas Wunner <lukas@wunner.de>

Queued in efi/next

Thanks all.
