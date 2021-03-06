Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4170532F946
	for <lists+linux-efi@lfdr.de>; Sat,  6 Mar 2021 11:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhCFKF3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 Mar 2021 05:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCFKFP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 6 Mar 2021 05:05:15 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E5DC06175F
        for <linux-efi@vger.kernel.org>; Sat,  6 Mar 2021 02:05:14 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q204so3809423pfq.10
        for <linux-efi@vger.kernel.org>; Sat, 06 Mar 2021 02:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IxxG7+/Jf2xeis/L0iB2HVcjDnZPIqtkUD4U9LiGxFA=;
        b=F1ly1E3BLIqrYvco/cS6aH0WiDIbpt7rf2lq6DlhBmIhkxcbOEG8aMACert8PfQ18F
         rpzeXziheyELB8AkpzWs19zKWtSlaojSnPdshF+g5U+wG/IqzV2Q5Qq/34e1LcY38swH
         LPvIHpRk8Z53yRT5HsPmDCXSMkHOfTJ/2NA/XLIM2b1ZBQtEkXZ5MDZ8rkxQb9IQfOTu
         WpJBHwsEwWgDqigpM52DLrXmVvTOmnJsPKU79aoPiU4KElKjxQT+jk2YOYCMPJGdRQu6
         v9kND2nbrn0kkGwoTvjCKwr7c92a91xdLaCItYY7gCMAMgPh9XN06BwJRLTVc+WHU0Qk
         KS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IxxG7+/Jf2xeis/L0iB2HVcjDnZPIqtkUD4U9LiGxFA=;
        b=iOE7q6sRryGWDoD4qGPqF3nIVzder7mjPtX7mAoMdgCf8tUcn2EtL4Ct6qQYjvz1GY
         Io7Sw0ZuZ/vMmIuo4tmlqwEMiaqpVUv2I+vZP6eMqMMyrIIu45F4y6GJpakDRAUEZmEd
         7knPIA6HuJA1Z4e6DzNc0siFymkVCgrkGc2Zf2GnGL53kkH4jg3VYC0U4oe5YszlNN7m
         pXFJ+ATNaXQso0TcFWKjSWQNJD/3GlwAlENKZPvjBgcHpHNLw8LzmOmYOGl5xcNJfWl4
         toXGmIu+fiawD9Y0SoW4HQTSG5lr4eAoBGj7/J9gWneiBRXnohHJByfZ+omWwWdd5ZuY
         bJYg==
X-Gm-Message-State: AOAM5313b9Bm3vjlLrbYr3XIfhFVDsKybB6Y3j1MZTRun3FQCSEE+2Ux
        KTCxGBCAz2C8i2F1j/erJgpb8Q==
X-Google-Smtp-Source: ABdhPJymaVvjjY6JwKfnCmUAVajzElj1JzVdJdUkNylxHTbSHDDGxSbXi1aiiyoTBmpE05nZ+9pBUQ==
X-Received: by 2002:a62:1e46:0:b029:1f3:ad4f:9c6b with SMTP id e67-20020a621e460000b02901f3ad4f9c6bmr718644pfe.64.1615025113705;
        Sat, 06 Mar 2021 02:05:13 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id e185sm4944223pfe.117.2021.03.06.02.05.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Mar 2021 02:05:13 -0800 (PST)
Date:   Sat, 6 Mar 2021 18:05:08 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/1] use RT_PROPERTIES table to implement efi=novamap
Message-ID: <20210306100507.GO17424@dragon>
References: <20210305093958.187358-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305093958.187358-1-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Mar 05, 2021 at 10:39:57AM +0100, Ard Biesheuvel wrote:
> This patch addresses an oversight on my part when I implemented Linux
> side support for the EFI RT properties table: SetVirtualAddressMap() is
> itself a runtime service which is only callable at runtime to begin with,
> and so the EFI stub should only call it if it is not marked as unsupported.
> 
> This may be useful for the Snapdragon EFI based laptops, which already rely
> on a special EFI driver to expose the correct DT based on metadata exposed
> by EFI. These systems ship with a broken implementation of SetVirtualAddressMap,
> which is currently being worked around by passing efi=novamap on the kernel.
> command line.
> 
> After applying this patch (which I intend to propose for backporting to 5.10),
> the same can be achieved by exposing a RT_PROP table that marks SetVAMap() as
> unsupported. And while at it, better mark the variable services as unsupported
> as well, since they don't work under Linux either.
> 
> I'm open to extending this with a Linux specific override value kept in a
> EFI variable, so that platforms that cannot support DtbLoader are able to
> implement something similar.

Yes, that will be much appreciated!  IMHO, this is definitely an useful
addition, as DtbLoader shouldn't be mandated.  In some cases, people may
choose to load DTB with other means, or DTB is not required at all.
Yeah, ACPI kernel is already useful for these laptops, not only for
running installer but also as a console based native arm64 machine.

Looking forward to something for testing :)

Shawn
