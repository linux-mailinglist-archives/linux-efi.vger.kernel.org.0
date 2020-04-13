Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488691A6AA8
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 18:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbgDMQ46 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 12:56:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61686 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732208AbgDMQ45 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Apr 2020 12:56:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D91CB503FC;
        Mon, 13 Apr 2020 12:56:54 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=TGcSsKqj++2O8decqUO56CacYEk=; b=nhCLzJ
        1YpZeqqDbXce1XOSOfUoP6eHXIN83t6R1k5NZ0e1fdyjZFtD3Bznk8v2nyV+0+Jk
        dfAUZvYC5ozUZYNZ3bq5KGosknJ/L1iC3Q8qfJGgOIK10RbG9i+SW6SesONKrLCR
        VzOK8Xj65UiglbyRuvrxEsA9ophjkLPfFmlGM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D192F503FB;
        Mon, 13 Apr 2020 12:56:54 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=IEeITl7XibPFqhGZUnk3n+MC9oMstM+Gdp+FQKlBW4U=; b=MZfPi/R+4VrOzRVI9QHR0ywswEhpEJ2rqJfryLQEhtaLWdRKdZqfiNisDKOGkKygGiBgmf8PpVw/aw6gDYM+UPIiYqf+03gT8vORxS6O0XaYvub/zvNjpcF5tNZrW6j59E+GTmaKIEWLheL4PqOH0uZFeptaRCZXzvaLsw8JpQk=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50E86503F1;
        Mon, 13 Apr 2020 12:56:54 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 35EB32DA0CC1;
        Mon, 13 Apr 2020 12:56:53 -0400 (EDT)
Date:   Mon, 13 Apr 2020 12:56:53 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 0/5] ARM: simplify handover from UEFI to
 decompressor
In-Reply-To: <20200413162135.14955-1-ardb@kernel.org>
Message-ID: <nycvar.YSQ.7.76.2004131254180.2671@knanqh.ubzr>
References: <20200413162135.14955-1-ardb@kernel.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: C7372624-7DA7-11EA-A44B-D1361DBA3BAF-78420484!pb-smtp2.pobox.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 13 Apr 2020, Ard Biesheuvel wrote:

> The EFI stub in the ARM kernel runs in the context of the firmware, which
> means it runs with the caches and MMU on. Currently, we relocate the zImage
> so it appears in the first 128 MiB, disable the MMU and caches and invoke
> the decompressor via its ordinary entry point. However, since we can pass
> the base of DRAM directly, there is no need to relocate the zImage, which
> also means there is no need to disable and re-enable the caches and create
> new page tables etc.
> 
> This simplification is implemented by patch #5. Patches #1 - #4 are
> prerequisite changes to permit the decompressor to execute from the
> offset chosen by the UEFI firmware.
> 
> Note that this applies onto v5.7-rc1 with Geert's patch 'ARM: boot: Obtain
> start of physical memory from DTB' applied [0]

Looks fine to me. As you mentioned, I really like the register liveness 
area reduction.

Reviewed-by: Nicolas Pitre <nico@fluxnic.net>


Nicolas
