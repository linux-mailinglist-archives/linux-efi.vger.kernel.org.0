Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D66D27451B
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 17:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIVPTO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 11:19:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62569 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVPTO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Sep 2020 11:19:14 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 11:19:12 EDT
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D5CF77977;
        Tue, 22 Sep 2020 11:12:50 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=4TyobxKGfDt8ZpPbXCwuotQH6lU=; b=r5qWCm
        ldMPR34PTngVZCEEvjpvVPi2dyoMEdHdtgMHTXY7d1fMFNVu1UnUgvXqzCHZJptY
        VQauPlPiu7Kp/gaaDbuCnvUwKTd6BAzupGT05JMZWWH+BUrAB6unr+bpX261GfQ0
        dm7HlPbJrD0b+t1nQZpZvtnGSPV8vWlLoYqFw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A1BA77976;
        Tue, 22 Sep 2020 11:12:50 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=qZ2Fq0EYgc9jw3s60wo/tDN9sDaGbjo+Rv/59aZNO98=; b=K30uM0n53afjxv2y5nNfLbdV6JQ9jQFG7sMf/Efbb8lJ1KzmgRGuCFUK8KYGvAx2wIB4NLkhSTFGN5mlF62RqPoM6hwFGq6y6ZzABHaoFDWN5ba1ZV3NvU1lHp7jOBckPQTaf/ShRpLp+NfM/9kS66lLTBhc4Jg0xmHFEJFKbyU=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F280977975;
        Tue, 22 Sep 2020 11:12:49 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 11C762DA00F6;
        Tue, 22 Sep 2020 11:12:49 -0400 (EDT)
Date:   Tue, 22 Sep 2020 11:12:48 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v2 10/10] ARM: p2v: reduce p2v alignment requirement to
 2 MiB
In-Reply-To: <CAMj1kXG+XuauH93OuQzx_2huWrUca+S6SKwqogXiaR2sQB727w@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.78.906.2009221109510.2680@knanqh.ubzr>
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-11-ardb@kernel.org> <CACRpkda=P-Kc=-ZhZo8vtW9CrFfCiBvfkqwfdipz4WO2Gb2L_g@mail.gmail.com> <CAMj1kXG+XuauH93OuQzx_2huWrUca+S6SKwqogXiaR2sQB727w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 14380E12-FCE6-11EA-ACCC-2F5D23BA3BAF-78420484!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 22 Sep 2020, Ard Biesheuvel wrote:

> By changing the patchable sequences and the patching logic to carry
> more bits of offset, we can improve this: 11 bits gives us 4 GiB >> 11
> == 2 MiB granularity, and so you never waste more than that amount by
> rounding up the physical start of DRAM to the next multiple of 2 MiB.
> (Note that 2 MiB granularity guarantees that the linear mapping can be
> created efficiently, whereas less than 2 MiB may result in the linear
> mapping needing another level of page tables)

That is IMHO the top argument for limiting it to 2 MiB.
It would be worth making this explicit in the commit log.


Nicolas
