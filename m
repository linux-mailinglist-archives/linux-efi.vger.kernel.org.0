Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E650A608B91
	for <lists+linux-efi@lfdr.de>; Sat, 22 Oct 2022 12:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJVK0J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Oct 2022 06:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJVKZg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Oct 2022 06:25:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB91530A0C3;
        Sat, 22 Oct 2022 02:41:14 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e714329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e714:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2ED81EC081C;
        Sat, 22 Oct 2022 10:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666428235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LAAUutkMNwRJvSBRF7vXejNpYFemGCHXaPI20oOLK6A=;
        b=Eh7nlzGA8kY5yyMI6zaYUPf6irbjDwP+32esWnYNvsyLyabGUl9Fiwk10vvskGV2GqK8M1
        Tnj4H0l0KFO3HYYqYvbDj20M/1soB4FM4lYI3eyfZE++okvEPWgMWRd9KssoyXDJu/f+av
        HWk6Zt/Yb4DM/hsbUpH6fuZlwZrqzps=
Date:   Sat, 22 Oct 2022 10:43:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jia He <justin.he@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
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
Message-ID: <Y1OtRpLRwPPG/4Il@zn.tnic>
References: <20221018082214.569504-1-justin.he@arm.com>
 <20221018082214.569504-7-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221018082214.569504-7-justin.he@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 18, 2022 at 08:22:13AM +0000, Jia He wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> ghes_estatus_cache_add() selects a slot, and either succeeds in
> replacing its contents with a pointer to a new cached item, or it just
> gives up and frees the new item again, without attempting to select
> another slot even if one might be available.
> 
> Since only inserting new items is needed, the race can only cause a failure
> if the selected slot was updated with another new item concurrently,
> which means that it is arbitrary which of those two items gets
> dropped. This means the cmpxchg() and the special case are not necessary,

Hmm, are you sure about this?

Looking at this complex code, I *think* the intent of the cache is to
collect already reported errors - the ghes_estatus_cached() checks - and
the adding happens when you report a new one:

        if (!ghes_estatus_cached(estatus)) {
                if (ghes_print_estatus(NULL, ghes->generic, estatus))
                        ghes_estatus_cache_add(ghes->generic, estatus);

Now, the loop in ghes_estatus_cache_add() is trying to pick out the,
well, oldest element in there. Meaning, something which got reported
already but a long while ago. There's even a sentence trying to say what
this does:

/*
 * GHES error status reporting throttle, to report more kinds of
 * errors, instead of just most frequently occurred errors.
 */

And the cmpxchg() is there to make sure when that selected element
slot_cache is removed, it really *is* that element that gets removed and
not one which replaced it in the meantime.

So it is likely I'm missing something here but it sure looks like this
is some sort of a complex, lockless, LRU scheme...

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
