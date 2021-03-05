Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E8932E759
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 12:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCELpA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 06:45:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhCELom (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Mar 2021 06:44:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 270DC64F52;
        Fri,  5 Mar 2021 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614944682;
        bh=VwL3MAfgznY9beEgvDppA+wtvzHvDmLNXnQUgInI5Ho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bv/T2WrImYCwNj0PvlyI1nzAws5AsgZuyhCRr8wO/6x0GCR5C5kpNhfV8api4tJn5
         rpiHNw/c6BAnESfD9hZ3UtIgLb4sr6CekfO4MxMpjzYLs7rmwS7GmlseGBX7tmoW60
         I9Nhe7R16RAunf9UHRWopGoX5EB+lYckqZc0BmuDLrm0px+lNEYYevrwXOmpzXE77w
         c8mJaqzwTPsUKeSjb9LFzBqEanfjUp/kSSaFFPzb+nlSeM59sczG6aDpG4xTEfoNjW
         lR//hCqOd+Ab+ls/PruemcJimmupCYrQ4ghzf/fPKRiRKB7JZNugjIhqEQWPEqkD2Z
         D56VqDva+mMQA==
Received: by mail-oi1-f174.google.com with SMTP id d20so2143555oiw.10;
        Fri, 05 Mar 2021 03:44:42 -0800 (PST)
X-Gm-Message-State: AOAM531fN5qdSGGJX7ocP0MbNlPYpRvrc2ycssnev/+mQ9saceJL4xm6
        AbHYcbRuI1T2dj1VPqWTvEahnI/IR3ZURVdvNT0=
X-Google-Smtp-Source: ABdhPJwetXtiI2ZmRbeJBCvNoWXpD/650xschfQcx8bDbzRNssQf8UaGD/fHlaGXLPPXcq4DySYmnhsaFzdyNj8sev0=
X-Received: by 2002:aca:538c:: with SMTP id h134mr6644991oib.174.1614944681417;
 Fri, 05 Mar 2021 03:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20210305093958.187358-1-ardb@kernel.org>
In-Reply-To: <20210305093958.187358-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Mar 2021 12:44:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEJWk=8DVSPovtFh4TgJiymir9HviT5msVqBU1xNHVU0g@mail.gmail.com>
Message-ID: <CAMj1kXEJWk=8DVSPovtFh4TgJiymir9HviT5msVqBU1xNHVU0g@mail.gmail.com>
Subject: Re: [PATCH 0/1] use RT_PROPERTIES table to implement efi=novamap
To:     linux-efi <linux-efi@vger.kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 5 Mar 2021 at 10:40, Ard Biesheuvel <ardb@kernel.org> wrote:
>
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
>

... or perhaps even in a DT property that gets AND'ed with the
supported RT services mask bu the EFI stub before it boots the kernel
proper.
