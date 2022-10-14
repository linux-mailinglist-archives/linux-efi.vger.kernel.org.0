Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0555FF0D5
	for <lists+linux-efi@lfdr.de>; Fri, 14 Oct 2022 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJNPLb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Oct 2022 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJNPLa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Oct 2022 11:11:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7851A17;
        Fri, 14 Oct 2022 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hh+wBzcQrEQZd7oz4Q6gVYf4bZRMf51ALRJ27tTdtW4=; b=O/3G50wblRrnpDUyXmoXXLdlvN
        crK8xdQtjqyx9tcej2PjhhSOzwaNegLchL7oSwsEmqYB+ml5y9xnCmQ+6p/t0PTC/H5QMVIRkf6wD
        6GysgvUSXdUKvXQXiGSelKTbedcn0KeEBe5DCYp/LFESXcqF7cfQIAOklb2ycjT/U0P8rkrDaWnFY
        Su77dGhlHJU3xefgPElAZrdZPS72kKbOH43+1irKcyGJ3x5vylvyhemIGtLztJOJECn7afhNa6ehl
        8xbhIAIN7S3DsNvipbSO9EP25If9ZfJJTNQZgY1h6wTYyyu6wW7orhUyVQs6J1agFVaL8DwZiXsyR
        jb6saz0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojMKy-003RBT-3t; Fri, 14 Oct 2022 15:11:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29E6430008D;
        Fri, 14 Oct 2022 17:10:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 913BB2C1ACA78; Fri, 14 Oct 2022 17:10:57 +0200 (CEST)
Date:   Fri, 14 Oct 2022 17:10:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Justin He <Justin.He@arm.com>, Borislav Petkov <bp@alien8.de>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Message-ID: <Y0l8AeQCrMLYW6g3@hirez.programming.kicks-ass.net>
References: <20221010023559.69655-1-justin.he@arm.com>
 <20221010023559.69655-7-justin.he@arm.com>
 <Y0VGkUxpqiIzIFzB@zn.tnic>
 <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic>
 <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0gUpoaUBKw/jjaD@zn.tnic>
 <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
 <DBBPR08MB453845A7A15596F6FE96DBC9F7249@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXHrP_P79ObKPFFgpN-X7gN+zaN1vKbsQZTJGvm=Uoav3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHrP_P79ObKPFFgpN-X7gN+zaN1vKbsQZTJGvm=Uoav3g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 14, 2022 at 04:31:37PM +0200, Ard Biesheuvel wrote:
> +       if (slot != -1) {
> +               /*
> +                * Use release semantics to ensure that ghes_estatus_cached()
> +                * running on another CPU will see the updated cache fields if
> +                * it can see the new value of the pointer.
> +                */
> +               victim = xchg_release(ghes_estatus_caches + slot,
> +                                     RCU_INITIALIZER(new_cache));
> +
> +               /*
> +                * At this point, victim may point to a cached item different
> +                * from the one based on which we selected the slot. Instead of
> +                * going to the loop again to pick another slot, let's just
> +                * drop the other item anyway: this may cause a false cache
> +                * miss later on, but that won't cause any problems.
> +                */
> +               if (victim) {
> +                       call_rcu(&rcu_dereference(victim)->rcu,
> +                                ghes_estatus_cache_rcu_free);
		}

I think you can use unrcu_pointer() here instead, there should not be a
data dependency since the ->rcu member itself should be otherwise unused
(and if it were, we wouldn't care about its previous content anyway).

But only Alpha cares about that distinction anyway, so *shrug*.

While I much like the xchg() variant; I still don't really fancy the
verbage the sparse nonsense makes us do.

		victim = xchg_release(&ghes_estatus_caches[slot], new_cache);
		if (victim)
			call_rcu(&victim->rcu, ghes_estatus_cache_rcu_free);

is much nicer code.

Over all; I'd simply ignore sparse (I often do).

> +       }
>         rcu_read_unlock();
>  }
