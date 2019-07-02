Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D97F55D985
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jul 2019 02:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGCAqn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Jul 2019 20:46:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44560 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGCAqn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Jul 2019 20:46:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id e3so667246wrs.11
        for <linux-efi@vger.kernel.org>; Tue, 02 Jul 2019 17:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7PbiqxZ6N1zfuiJYD7wJ93Pdo9aQh0IzeX8dcJ4X5FU=;
        b=pSfYXKs/eqzCFbQjrWkC99dJ2GBbcgfGiqD4o3TT1CTRmGJKlgGUmxb64JYxtewy9i
         P4m7J1uixRsx52J41BThoDYqSjJKJBBVrDWCyj9I8Ea61Y92rPgjr1pLTBd0RQJPFzmU
         M7V32ufMqcgtq8htDIXCzupTlkp4UjI9gHxwKnnjp9I5KC8XIMpLESjEz2ky6JmdWBUZ
         fpUrAlbfT2IsMegG37jVJuagyqNW4pkpQtkIeE58VcZQYGISG+P5AuwWh7z/Nf5nXZpG
         e0YVm2O6FdZtWrWdqJ8y44qc1Kznwh6KOm+3xKsBu3WKOzbgEmB8k1YSrTXZcEvtEq40
         T4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7PbiqxZ6N1zfuiJYD7wJ93Pdo9aQh0IzeX8dcJ4X5FU=;
        b=T6yKmsKqbc8TQ+n8/iO/fxAIubftcXL5fJfWVUCmha2z0LUkTRXspTWM3mvQq4R0hG
         yBRmbY2WcFV82eDHW6nIKGKQ8bqHZB/aRemz6AUDpKnKYnIm/HCppTgKgoYmg9U7Tlq0
         5tgKNdZnXHVrPNcs2RD7XdUh9TXg9npD5Hh2wn7zfFinpBSEMlAhxM+SQedvHXnRFuTx
         gITOwtQ5pc4WESkMFang+uxQDKSR63G9V/1zQlZn9bIF1DgQPT3/cqtkAc+Tmx0RcArl
         hmJs7gogMcLjE7GJUVs31+RUUquc/njU4kDMZ8Q5bD7mLnSHQqeXv5A7EvwBD7akcqk3
         BfAw==
X-Gm-Message-State: APjAAAVtCbDLM+COllyF+Vqkk3aqiXsCg9xHDXEDp5mrYzDa7k2hK3CJ
        ZLzEGWQaO+FZ1T7M1Svg7EFFCU0vS6c=
X-Google-Smtp-Source: APXvYqxy3HQDztVC6uezZn9eBQs5Zkluz0+aQTRZh5ueKntVlQ8XLFFH3aUcx4MBnkHOUdh7vxHexg==
X-Received: by 2002:a5d:6182:: with SMTP id j2mr14634480wru.275.1562104795656;
        Tue, 02 Jul 2019 14:59:55 -0700 (PDT)
Received: from bivouac.eciton.net (bivouac.eciton.net. [2a00:1098:0:86:1000:23:0:2])
        by smtp.gmail.com with ESMTPSA id w25sm226281wmk.18.2019.07.02.14.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 14:59:54 -0700 (PDT)
Date:   Tue, 2 Jul 2019 22:59:53 +0100
From:   Leif Lindholm <leif.lindholm@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Alexander Graf <agraf@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Julien Thierry <julien.thierry@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] efi/libstub: detect panel-id
Message-ID: <20190702215953.wdqges66hx3ge4jr@bivouac.eciton.net>
References: <20190630203614.5290-1-robdclark@gmail.com>
 <20190630203614.5290-3-robdclark@gmail.com>
 <CAKv+Gu_8BOt+f8RTspHo+se-=igZba1zL0+jWLV2HuuUXCKYpA@mail.gmail.com>
 <CAKv+Gu-KhPJxxJA3+J813OPcnoAD4nHq6MhiRTJSd_5y1dPNnw@mail.gmail.com>
 <CAF6AEGv+uAXVV6Q78n=jP0YRDjYn9OS=Xec9MU0+_7EBirxF5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGv+uAXVV6Q78n=jP0YRDjYn9OS=Xec9MU0+_7EBirxF5w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 02, 2019 at 02:01:49PM -0700, Rob Clark wrote:
> > > So we are dealing with a platform that violates the UEFI spec, since
> > > it does not bother to implement variable services at runtime (because
> > > MS let the vendor get away with this).
> >
> > To clarify, the above remark applies to populating the DT from the OS
> > rather than from the firmware.
> 
> yeah, it isn't pretty, but there *are* some other similar cases where
> efi-stub is populating DT.. (like update_fdt_memmap() and
> kaslr-seed)..

The problem isn't with the stub updating the DT, the problem is what
it updates it with.

update_fdt_memmap() is the stub filling in the information it
communicates to the main kernel.

kaslr-seed sets a standard property using a standard interface if that
interface is available to it at the point of execution.

Since what we're doing here is dressing up an ACPI platform to make it
look like it was a DT platform, and since we have the ability to tweak
the DT before ever passing it to the kernel, let's just do that.

Yes, I know I said I'd rather not, but it's way nicer than sticking
platform-specific hacks into the EFI stub.

(If adding it as a DT property is indeed the thing to do.)

> > ... but saving variables at boot time for consumption at runtime is
> > something that we will likely see more of in the future.
> 
> I think this will be nice, but it also doesn't address the need for a
> quirk to get this into /chosen..  I guess we *could* use a shim or
> something that runs before the kernel to do this.  But that just seems
> like a logistical/support nightmare.
>
> There is one kernel, and there
> are N distro's, so debugging a users "I don't get a screen at boot"
> problem because their distro missed some shim patch really just
> doesn't seem like a headache I want to have.

The distros should not need to be aware *at all* of the hacks required
to disguise these platforms as DT platforms.

If they do, they're already device-specific installers and have
already accepted the logistical/support nightmare.

/
    Leif
