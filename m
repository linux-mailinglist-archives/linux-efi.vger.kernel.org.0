Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC3608BD4
	for <lists+linux-efi@lfdr.de>; Sat, 22 Oct 2022 12:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiJVKoe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Oct 2022 06:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiJVKoQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Oct 2022 06:44:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA96631BF6E;
        Sat, 22 Oct 2022 03:01:54 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e714329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e714:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 752A21EC0629;
        Sat, 22 Oct 2022 12:00:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666432836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8JIbHKcJJ+kMxdbJLrXmFhUHK09tqfA4e7vxfuzOL3s=;
        b=BJfz4jtTpZ9Fd4zl2nfhPjfuGwymwBFYWxmyqQiqR59npXdqgP1XxhKZEyqsL4qQcdMFod
        sxt+i/g3gZQBqiqetv9wP6LHjSdq5L6WGr9BGq6iHeq78+eSG1fIN+cgPL6x3AowP1L5Xa
        K54bH9dY+mAb/8fZoipOD5o+lL0angc=
Date:   Sat, 22 Oct 2022 12:00:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 6/7] apei/ghes: Use xchg_release() for updating new
 cache slot instead of cmpxchg()
Message-ID: <Y1O/QN32d2AlzEiA@zn.tnic>
References: <20221018082214.569504-1-justin.he@arm.com>
 <20221018082214.569504-7-justin.he@arm.com>
 <Y1OtRpLRwPPG/4Il@zn.tnic>
 <CAMj1kXFu36faTPoGSGPs9KhcKsoh_DE9X2rmwdenxaJwa3P_yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFu36faTPoGSGPs9KhcKsoh_DE9X2rmwdenxaJwa3P_yw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Oct 22, 2022 at 11:01:01AM +0200, Ard Biesheuvel wrote:
> But the point is that the new element we are adding has the same
> properties as the one we want to avoid replacing inadvertently,

No, we're removing the oldest element we found. The new one is anything
but we don't compare it to slot_cache which we're about to remove.

> and if the cmpxchg() failed, we just drop it on the floor.

Yeah, I guess the intent here was: oh well, we'll log that thing again
because our "throttling cache" didn't manage to enter it.

> So instead of dropping 'our' new element, we now drop 'the other' new
> element.

Aha, this is what you mean with logging something twice. That other new
element gets dropped so if it happens again, it'll get logged and if it
then gets entered in the cache properly, then it gets ignored on the
next logging run.

Oh well, fine with me.

> The correct approach here would be to rerun the selection loop on
> failure, but I doubt whether it is worth it. This is just a fancy rate
> limiter.

Yap, exactly.

Ok, so I'll try to summarize what we talked here in the commit message
so that it is written down somewhere for later.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
