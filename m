Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7DF271176
	for <lists+linux-efi@lfdr.de>; Sun, 20 Sep 2020 01:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgISX7F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 19 Sep 2020 19:59:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56730 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgISX7E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 19 Sep 2020 19:59:04 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Sep 2020 19:59:03 EDT
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B543EB5E2;
        Sat, 19 Sep 2020 19:49:32 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=baHkjzKYrRruyUP97NAFjFjhlMA=; b=vtYxWi
        ObtRNmgidijKO+HiXxuDPpQCNNQbr+WkLh9VoObZnwM3r9rW9vExgfaDvc+bsU6x
        VL8P0cfkMcrYIe5xu8JcOXiBlItKaBfOkJSEqi9vBmOQPiALn87wS7MoVnxZmSKM
        nvr3LiKmhSM0syze8ytUyYcLqTyNx+gnlW+NU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ECA9BEB5E1;
        Sat, 19 Sep 2020 19:49:31 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=DOc4gSWeeyTL3vk16ovFZoFxHF/x+N37vjYFCT39RUQ=; b=xw3YHjjG1dUq54HPtaRpCwEFGhdtIp8fcjnsw5NSnMoTSbHfx9E4WMIGxhtB0SWV+X+UttBPQ8dZ/KBUztBDs61wYVazwopLZsvnCj9B/oKPQanc+RU2h/akuTBVkgT2ctPODyLz/dbGpuxyvvMXVZbx8MCQdjDLll6f37BlP0U=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DAFE7EB5E0;
        Sat, 19 Sep 2020 19:49:28 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id EB9D82DA0182;
        Sat, 19 Sep 2020 19:49:26 -0400 (EDT)
Date:   Sat, 19 Sep 2020 19:49:26 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC/RFT PATCH 0/6] ARM: p2v: reduce min alignment to 2 MiB
In-Reply-To: <20200918103102.18107-1-ardb@kernel.org>
Message-ID: <nycvar.YSQ.7.78.906.2009191937560.1560@knanqh.ubzr>
References: <20200918103102.18107-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: C1C39AEE-FAD2-11EA-AA2B-843F439F7C89-78420484!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 18 Sep 2020, Ard Biesheuvel wrote:

> This series is inspired by Zhei Len's series [0], which updates the
> ARM p2v patching code to optionally support p2v relative alignments
> of as little as 64 KiB.
> 
> Reducing this alignment is necessary for some specific Huawei boards,
> but given that reducing this minimum alignment will make the boot
> sequence more robust for all platforms, especially EFI boot, which
> no longer relies on the 128 MB masking of the decompressor load address,
> but uses firmware memory allocation routines to find a suitable spot
> for the decompressed kernel.
> 
> This series is not based on Zhei Len's code, but addresses the same
> problem, and takes some feedback given in the review into account:
> - use of a MOVW instruction to avoid two adds/adcs sequences when dealing
>   with the carry on LPAE
> - add support for Thumb2 kernels as well
> - make the change unconditional - it will bit rot otherwise, and has value
>   for other platforms as well.
> 
> The first four patches are general cleanup and preparatory changes.
> Patch #5 implements the switch to a MOVW instruction without changing
> the minimum alignment.
> Patch #6 reduces the minimum alignment to 2 MiB.
> 
> Tested on QEMU in ARM/!LPAE, ARM/LPAE, Thumb2/!LPAE and Thumb2/LPAE modes.

At this point I think this really ought to be split into a file of its 
own... and maybe even rewritten in C. Even though I wrote the original 
code, I no longer understand it without re-investing time into it. But 
in either cases the whole of head.S would need to have its registers 
shuffled first to move long lived values away from r0-r3,ip,lr to allow 
for standard function calls.


Nicolas
