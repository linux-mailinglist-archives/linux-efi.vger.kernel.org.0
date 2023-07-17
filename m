Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD2D7565FF
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jul 2023 16:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjGQOOc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Jul 2023 10:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjGQOOb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Jul 2023 10:14:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB61A8;
        Mon, 17 Jul 2023 07:14:30 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 660F31EC0B09;
        Mon, 17 Jul 2023 16:14:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689603268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=z8ifxq0kveuq3PccC7kM0bj/asO5IGY3QtO4+hrMof8=;
        b=V/sVrQzUTaaTmkBHvq0+c8/0rGAIYYHToiRb8Q8oFgl60lZAb+ETr8Asjvvs9+GQqqaKGW
        I2+QZSxRweUsGGWnkQPpVIlZeFdt9oxHAlqpgtuXrWsbF+NmHS9tc7u8a7xrAdwRIqrFU0
        cxI8OWPz3imilhWcR/N/Nny3xgk4wPA=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v5iLYOMiPSGC; Mon, 17 Jul 2023 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689603266; bh=z8ifxq0kveuq3PccC7kM0bj/asO5IGY3QtO4+hrMof8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bwJKEkeZlwT5QPB+h41zCnUOu9TMqr9t32QXNywFbkUjGdqnTaNIpKP9yQ2D38CTD
         QGVbaRAJ1c0YlPhRUNBmwYT9t6buWvtE9lj2k3prOozLviPcM5Fu2wlfPq72rf1jsc
         6VXf5tXYkZwlxBh4Jjn2LBtlI/spARvNlNADuNnzKQV/YLiNy3rv82Fnbqfye8/SM/
         y2iCfs7LWPiSw6lHzRVYlZ9YDp7NZpv/kqV5IR/Fc2YnqMlaa6VzBhWkCXNzlyPYLQ
         YKR+vW1ObeTPiKp6AjgpyHydsytTpjzE6e5F3KIdYxdKsOi5kltg+vTnaKpRwQ6NJ2
         op72jdKCN8W5uEtPQCquBwOcF/CRz+mPlGFT+TvO0flG9oTsqyscVaFKxfGiSca/6E
         0/DID+Snh4w9HnsN/UI1ihGJydEHqlbpK8TljM5oGjLGMoCB6mQGpGypvSwkCOW+JU
         sq657gGTXOe9zHbgZhQjfY5UDoBS1u83uzpGCneB1AOMxegm7BjkOlW235hsBVX3JI
         hbh8kCS3mr/lqLsSV5m+EnP6XpGOB7qfggC1dAn/M8gATgR5LDgUEyNNqcasrGCOrN
         e0bPgOC2QGunIeKsUZJNbrlxQ0vFtqNUtjOyFxUQMm4WcOhnvDXuo/pd5joptSVndV
         eX+Ylnq26dASuPpPjOjD9x5U=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE31440E019D;
        Mon, 17 Jul 2023 14:14:13 +0000 (UTC)
Date:   Mon, 17 Jul 2023 16:14:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tao Liu <ltao@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 17, 2023 at 09:53:06PM +0800, Tao Liu wrote:
> ...snip...
> [   21.360763]  nvme0n1: p1 p2 p3
> [   21.364207] igc 0000:03:00.0: PTM enabled, 4ns granularity
> [   21.421097] pps pps1: new PPS source ptp1
> [   21.425396] igc 0000:03:00.0 (unnamed net_device) (uninitialized): PHC added
> [   21.457005] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth
> (5.0 GT/s PCIe x1 link)
> [   21.465210] igc 0000:03:00.0 eth1: MAC: ...snip...
> [   21.473424] igc 0000:03:00.0 enp3s0: renamed from eth1
> [   21.479446] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [   21.486405] #PF: supervisor read access in kernel mode
> [   21.491519] mmc1: Failed to initialize a non-removable card
> [   21.491538] #PF: error_code(0x0000) - not-present page
> [   21.502229] PGD 0 P4D 0
> [   21.504773] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   21.509133] CPU: 3 PID: 402 Comm: systemd-udevd Not tainted 6.5.0-rc1+ #1
> [   21.515905] Hardware name: ...snip...
> [   21.522851] RIP: 0010:kernfs_dop_revalidate+0x2b/0x120

So something's weird here - my patch should not cause a null ptr deref
here.

> [   21.527995] Code: 1f 44 00 00 83 e6 40 0f 85 07 01 00 00 41 55 41
> 54 55 53 48 8b 47 30 48 89 fb 48 85 c0 0f 84 a2 00 00 00 48 8b a87

This looks weird too. There's no "<>" brackets denoting which byte it
was exactly where RIP pointed to when the NULL ptr happened.

Do

make fs/kernfs/dir.s

and upload dir.s and the dir.o file somewhere.

In any case, my patch shouldn't be causing this. At least I don't see
it.

I'm testing a better version of the patch and it should not cause this
thing even less.

> The stack trace may not be the same all the time, I didn't dive deep
> into the root cause, but it looks to me the patch will cause an
> unknown issue. Also I tested the patch on kernel-5.14.0-318.el9, it

This is the upstream kernel mailing list so those Frankenstein kernels
are all left to you.

Good luck. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
