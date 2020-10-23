Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D1729701C
	for <lists+linux-efi@lfdr.de>; Fri, 23 Oct 2020 15:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464372AbgJWNNC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Oct 2020 09:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S372950AbgJWNNC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 23 Oct 2020 09:13:02 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B3524248
        for <linux-efi@vger.kernel.org>; Fri, 23 Oct 2020 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603458782;
        bh=FB255QPtYI9+dDaYI4r55GJqC14tARHAROXFSsQ5GBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nFT3PpfimsaJUMQyGHoXzyXptrtlHnJxJBXCY/D15yea39akO+twEUeD52A/ccp7/
         hs9dk/Y3Ff0qZ/ZrBxcBwbgbUAMOp9LB5eUBZCiyurgCx4ZNeU7IqckfNwcfg3fBSO
         RZ7XmjUpcOE1fwn/EcSiJoPFwLHofC9mDgJ4UufI=
Received: by mail-ot1-f43.google.com with SMTP id t15so1294686otk.0
        for <linux-efi@vger.kernel.org>; Fri, 23 Oct 2020 06:13:01 -0700 (PDT)
X-Gm-Message-State: AOAM530JvfWX9HoeK71A6DXF/D7U6cABQCz6izHtmmA3ymQdk0D3vqnK
        ntb8RKzAOAmCd9qMQ5rMWxwC1QyAaruiw7M5KjE=
X-Google-Smtp-Source: ABdhPJxdwp1BUE/rr2viqldvqIg2gh3/LrpS15LMwXFV1WpgycpBUXzOAvejaV5uGSB0xwYJ6rzjJwSS1pjTzZaN4+k=
X-Received: by 2002:a05:6830:4028:: with SMTP id i8mr1428973ots.90.1603458781184;
 Fri, 23 Oct 2020 06:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201023120825.30466-1-ard.biesheuvel@arm.com>
 <20201023120825.30466-5-ard.biesheuvel@arm.com> <20201023124710.GD1664@vanye>
In-Reply-To: <20201023124710.GD1664@vanye>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 23 Oct 2020 15:12:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFKSf0HVxLt1GdqeuErFH+r-=NxTnPV7TYjg0b-9hXj7w@mail.gmail.com>
Message-ID: <CAMj1kXFKSf0HVxLt1GdqeuErFH+r-=NxTnPV7TYjg0b-9hXj7w@mail.gmail.com>
Subject: Re: [PATCH 4/4] linux: ignore FDT unless we need to modify it
To:     Leif Lindholm <leif@nuviainc.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>, grub-devel@gnu.org,
        Daniel Kiper <daniel.kiper@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 23 Oct 2020 at 14:47, Leif Lindholm <leif@nuviainc.com> wrote:
>
> On Fri, Oct 23, 2020 at 14:08:25 +0200, Ard Biesheuvel wrote:
> > Now that we implemented supported for the LoadFile2 protocol for initrd
> > loading, there is no longer a need to pass the initrd parameters via
> > the device tree. This means there is no longer a reason to update the
> > device tree in the first place, and so we can ignore it entirely.
>
> There is a change in behaviour here which I don't think matters, but
> I'll call it out anyway:
> If there was ever a kernel out there with an EFI stub that depended on
> a chosen node existing in the DT, and the one provide by firmware did
> not contain one, that setup would break from this *if* it didn't use
> an initrd.
>

I checked the Linux source, and the original code contributed by Roy
already contained the logic to create the /chosen node if it wants
there already. So we should be fine here.
