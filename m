Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2496041629E
	for <lists+linux-efi@lfdr.de>; Thu, 23 Sep 2021 18:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbhIWQDu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Sep 2021 12:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242397AbhIWQDr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Sep 2021 12:03:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD2C061766
        for <linux-efi@vger.kernel.org>; Thu, 23 Sep 2021 09:02:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so28546911lfu.5
        for <linux-efi@vger.kernel.org>; Thu, 23 Sep 2021 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLOxhnwH/JaVIhRbDcxcZPpiYGHLJbtd0CRIGAWnOsw=;
        b=QMXOiJ6n28J2emY/y7cY9+DD4h8Pn0KRvNWmJxYGi/2iw91Mhhsv5k4E/yi6SvFmH+
         cwsdxpHCcIaSp+pnaMQx9j8vfDg38b4ujoTb2lzS4jvwjrgaoWuJfcNbrdzMUshkRDfy
         wyxZpTZP4dsY0GDCSs5bbcT3wFiFu+kSB/Akk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLOxhnwH/JaVIhRbDcxcZPpiYGHLJbtd0CRIGAWnOsw=;
        b=tP4/uU9LMfCDiBeinMYZXsm369aDGk2zSjoKZ6neCg5yTJDrufq2LGyiz6XFixRMlt
         kfbx85vq8rxiug1fK+f8ktIntUS9UqWX9ZuUGNKIGlUIqjyeZHVlfZf8cv59EWnVG6cF
         k6NNvWHsAqMFocb8K71qF+0BWHi79KULXUF9rqAyUEyOo7l95L/6mkCi2+0Ockpt2cE4
         EQNT8oQEvI2W/mebo1uEcaFTfDzFoVUoWzDHP4Ujn5dWp9x3yMjhh96yb86OgLz+mWis
         UJCDr69W/hpNuIS8v09wx/v62arb8ukitrvEim9CMLW2qIh+6fIp21JlOwN9N+wF9dBZ
         qc2w==
X-Gm-Message-State: AOAM532kx5OctbIjq9ynPWBlizo14PTjqiodGKLGzNJXCrGzRbvQZO1Y
        whzNey6etnYclPW+EyI+H6GltPOKpxxBgotg
X-Google-Smtp-Source: ABdhPJz4meSQKUnepkt9bF4Zwf853NycoJGmDx9NLpCqWD7roQgvbtIcNYxGzd+1cr9/HO9nN9CPSg==
X-Received: by 2002:a05:6512:15a0:: with SMTP id bp32mr4941466lfb.509.1632412932340;
        Thu, 23 Sep 2021 09:02:12 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r2sm492176lfm.78.2021.09.23.09.02.02
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:02:06 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id s3so2739102ljp.11
        for <linux-efi@vger.kernel.org>; Thu, 23 Sep 2021 09:02:02 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr5950451ljc.249.1632412922441;
 Thu, 23 Sep 2021 09:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210923074335.12583-1-rppt@kernel.org>
In-Reply-To: <20210923074335.12583-1-rppt@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Sep 2021 09:01:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJB8H5pZz-AKaSJ7ViRtdxQGJT7eOByp8DJx2OwZSYwA@mail.gmail.com>
Message-ID: <CAHk-=wiJB8H5pZz-AKaSJ7ViRtdxQGJT7eOByp8DJx2OwZSYwA@mail.gmail.com>
Subject: Re: [PATCH 0/3] memblock: cleanup memblock_free interface
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KVM list <kvm@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-usb@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 23, 2021 at 12:43 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> The core change is in the third patch that makes memblock_free() a
> counterpart of memblock_alloc() and adds memblock_phys_alloc() to be a

^^^^^^^^^^^^^^^^^^^
> counterpart of memblock_phys_alloc().

That should be 'memblock_phys_free()'

HOWEVER.

The real reason I'm replying is that this patch is horribly buggy, and
will cause subtle problems that are nasty to debug.

You need to be a LOT more careful.

From a trivial check - exactly because I looked at doing it with a
script, and decided it's not so easy - I found cases like this:

-               memblock_free(__pa(paca_ptrs) + new_ptrs_size,
+               memblock_free(paca_ptrs + new_ptrs_size,

which is COMPLETELY wrong.

Why? Because now that addition is done as _pointer_ addition, not as
an integer addition, and the end result is something completely
different.

pcac_ptrs is of type 'struct paca_struct **', so when you add
new_ptrs_size to it, it will add it in terms of that many pointers,
not that many bytes.

You need to use some smarter scripting, or some way to validate it.

And no, making the scripting just replace '__pa(x)' with '(void *)(x)'
- which _would_ be mindless and get the same result - is not
acceptable either, because it avoids one of the big improvements from
using the right interface, namely having compiler type checking (and
saner code that people understand).

So NAK. No broken automated scripting patches.

               Linus
