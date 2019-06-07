Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF439832
	for <lists+linux-efi@lfdr.de>; Sat,  8 Jun 2019 00:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfFGWHb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 18:07:31 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37642 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfFGWHb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 18:07:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id t76so2492662oih.4
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGEZCq4BaB0BTmaxAgEOcEo5gt0ixIUPtlfxemX6hgM=;
        b=I7uX+XkPq30rDOBES7lZLtn2RuTlwu8H49lynwqqgbzn6tDiumPRUUp6+4qx3l/Zsb
         JWpb9lLV2z6EpE6NHJlXf1it5n7SH41A9225xugntFqCFmN5Z1bm8jowGF7e/IoWR127
         govnUM+DtIfiqJHkuNAKHWOCtk/4XD7+dcPYVbZYMzUEk+OkMIV0lDZkV78TXFipFEjn
         DjncY7YNXkKtdLJz0veHu0tX8PBQYHwaB+p3psLv+UehWNVc/ZNSLscPbnBjmCHkaIZN
         o1JdA45jLNIxywGzhNQY9Mje9p5d4K/D5LK3ykqSAIbtNb6TQeAw1T+zEWxEBVs7U9Fa
         GMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGEZCq4BaB0BTmaxAgEOcEo5gt0ixIUPtlfxemX6hgM=;
        b=fY4+qCh3Vl/c01pF3fLGBJQXogUbh2EaXQSYADO/ShDwpijMX1IDYeTynoftRCmDQi
         s9n1iXoTmrRTKpTstrIod38QtOXJJ3JJhEP82WV6SEudCfm3CNWFWm+JDDbxIGjzyf6S
         uw9PbMUwnsy0Arxlt5v9oI1mZZGij2QmCFh5OoDZiJYqdi5WBvm2QKeafwkO/VI0nlBW
         X9XsxOASHszJOmZ+8HZrDKbLXjro7Ru1huwyFc2BlcGk0bxvS61Yej+JJ4XUHST72lj+
         ELnGSc5iBXPlZ3o85UxL033N+x1yse+uMaOICKa7Vp9NwFNtEzTDGjEkxgitwcscyJRx
         nFoQ==
X-Gm-Message-State: APjAAAWeAOywR91bMtn5t+MSCXGw8WGyfRYxOUAAT66X6R5NqKAA1Ihj
        XcN5Px5bHYAqr97QNvaQ3rD5d7sBUiPY9EdPAiLFYw==
X-Google-Smtp-Source: APXvYqxE/1PgkxbnHhZHBRAeTY8Q1Ee7PJ9GYgBKUGqAB0DBQ3cfdExLt+dw34qnHsAX7njVOtuBFeCm+g1p+GCmhN4=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr5377897oii.0.1559945250435;
 Fri, 07 Jun 2019 15:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155993564854.3036719.3692507629721494555.stgit@dwillia2-desk3.amr.corp.intel.com>
 <f6c2d673-a202-4ad5-7055-5aaece9356e1@intel.com> <CAPcyv4iFG3Z9xL9TSmqLVHxLZ6oiz-uWD6iKgJ8LF4f0n=m9=w@mail.gmail.com>
 <c8b2048e-5e0f-fdbe-1347-4e36de6c0387@intel.com>
In-Reply-To: <c8b2048e-5e0f-fdbe-1347-4e36de6c0387@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Jun 2019 15:07:19 -0700
Message-ID: <CAPcyv4h-LLqmvHfRPYDcvNLexZrEiBcNbui0bz3z1TAydMB0Uw@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] efi: Enumerate EFI_MEMORY_SP
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 7, 2019 at 2:12 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/7/19 1:03 PM, Dan Williams wrote:
> >> Separate from these patches, should we have a runtime file that dumps
> >> out the same info?  dmesg isn't always available, and hotplug could
> >> change this too, I'd imagine.
> > Perhaps, but I thought /proc/iomem was that runtime file. Given that
> > x86/Linux only seems to care about the the EFI to E820 translation of
> > the map and the E820 map is directly reflected in /proc/iomem, do we
> > need another file?
>
> Probably not.
>
> I'm just trying to think of ways that we can debug systems where someone
> "loses" a bunch of memory, especially if they're moving from an old
> kernel to a new one with these patches.  From their perspective, they
> just lost a bunch of expensive memory.
>
> Do we owe a pr_info(), perhaps?  Or even a /proc/meminfo entry for how
> much memory these devices own?

We have this existing print when this bit is found:

[    0.023650] e820: update [mem 0x240000000-0x43fffffff] usable ==>
application reserved

...but perhaps /proc/meminfo could grow:

ApplicationReservedOffline
ApplicationReservedOnline

...to show the relative amount of this memory that has been routed to
device-dax and how much has been returned to the core-mm?
