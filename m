Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD4912E01F
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jan 2020 19:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgAAShC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jan 2020 13:37:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38241 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAAShC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jan 2020 13:37:02 -0500
Received: by mail-ot1-f66.google.com with SMTP id d7so49669111otf.5
        for <linux-efi@vger.kernel.org>; Wed, 01 Jan 2020 10:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8+LgrDTXxrAyzAw0RwZGEpTji/oOjaXA22yzdPDbF0=;
        b=ER+E7dCHHwS2LyjRD/sibbzhy4ilLrTDS0sxOpsAWtNtWZJIzJ4UsXI3Xuc0X39nFR
         G26VajH34OccYtdr+Spk/68MUyy6L3p5BLJ9hOzQd2yrRlszfiDp47kYOZaYTgEKf4os
         T4voUx1tZuDlevN8qv5QBHIjfqke6x6qv3H10OFOoCExN9dsWBS4BBZsYFLPPMO1Zkar
         nbwwUioLXnA/2pNkAakYWqCGgsqFk7LnlpZyEHUxuu7ebvKiM99vhN9fMMZbCV3a6XCN
         hIIp37SNuEpLr9F/Ypn7IhoqWkyhVkrYKWeb/1cuAT+i001byfj4LipH4tE5sGrd3Ypm
         a2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8+LgrDTXxrAyzAw0RwZGEpTji/oOjaXA22yzdPDbF0=;
        b=aMVii6I4fIiokkiUC/T8pO+/IqufwYzYWa4Cmd2aGIHL57TobahjpSQX50gnfS5/Le
         bfHSsOnqGkUM0EBa/alCaQD5/NWB1KdkeYCVZRcsNLmZgF4nmSuoRQwiH4d2aaf4drl6
         /CgF+YQowSO+37fbzP3t3bYcBL60MJ76a6sfMSKqDIOXSg1rN+yz4mNu1joO8Kq8NREp
         kKVHc54oMDAGKU/ir7aXUn8jJqZt57mcHnvSwvAB+ZHbftg8C2gn4EAvecW8iK5LUzI8
         nFeOnkBxY8tWZl+pDERCPhg/kwInmK3yha5jfmyunhtNd6BFrcUaHvogtmQLRqal4bEC
         kLBQ==
X-Gm-Message-State: APjAAAVIy53Vti8GgB3Tgzxy1K1cD6PMOG5QZ8ojWNz0TRqXk9lFO4Qo
        mDj45fU/RjKXqsCeLhdp1OprrhIuUqSIemrbom4+3g==
X-Google-Smtp-Source: APXvYqxWXdgchp08m0zeoknzHEMFoL9O+rhOarc8rGB6n6O+4jpJ7xdl8iJQjfEJCFf7EFr4drxCSnfwuKevgQPjq8w=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr50572049oto.207.1577903821166;
 Wed, 01 Jan 2020 10:37:01 -0800 (PST)
MIME-Version: 1.0
References: <157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157782987865.367056.15199592105978588123.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200101045141.GA15155@dhcp-128-65.nay.redhat.com> <CAPcyv4hSB9B5tiKVwtNOgDS6KS2Pj6f962OPBZVZpPjrBt6Z8A@mail.gmail.com>
 <20200101061505.GA15717@dhcp-128-65.nay.redhat.com> <20200101062047.GA16393@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200101062047.GA16393@dhcp-128-65.nay.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Jan 2020 10:36:50 -0800
Message-ID: <CAPcyv4ivPw7Z8y0yBT4j41=cgLqGjKafHHB==h=cC8aXvHK7Kw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] efi: Fix handling of multiple efi_fake_mem= entries
To:     Dave Young <dyoung@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, kexec@lists.infradead.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 31, 2019 at 10:21 PM Dave Young <dyoung@redhat.com> wrote:
>
> > > Does kexec preserve iomem? I.e. as long as the initial translation of
> > > efi entries to e820, and resulting resource tree, is preserved by
> > > successive kexec cycles then I think we're ok.
> >
> > It will not preserve them automatically, but that can be fixed if
> > needed.
> >
> > There are two places:
> > 1. the in kernel loader, we can do similar with below commit (for Soft
> > Reseved instead):
> > commit 980621daf368f2b9aa69c7ea01baa654edb7577b
> > Author: Lianbo Jiang <lijiang@redhat.com>
> > Date:   Tue Apr 23 09:30:07 2019 +0800
> >
> >     x86/crash: Add e820 reserved ranges to kdump kernel's e820 table
>
> Oops, that is for kdump only, for kexec, should update the kexec e820
> table.  But before doing that we need first to see if this is necessary.

We can cross that bridge later, but I expect it will eventually be
necessary. The soft-reservation facility will become more prevalent as
more platforms ship with DRAM differentiated memory ranges, like
high-bandwidth-memory, and the system needs to reserve it from general
kernel allocations. See commit 262b45ae3ab4 "x86/efi: EFI soft
reservation to E820 enumeration" and commit fe3e5e65c06e "efi:
Enumerate EFI_MEMORY_SP" for more details.
