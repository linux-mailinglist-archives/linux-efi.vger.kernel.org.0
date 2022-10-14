Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58765FEBD9
	for <lists+linux-efi@lfdr.de>; Fri, 14 Oct 2022 11:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiJNJlB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Oct 2022 05:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJNJk7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Oct 2022 05:40:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAD95300D;
        Fri, 14 Oct 2022 02:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6AD3B822A2;
        Fri, 14 Oct 2022 09:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B061C43143;
        Fri, 14 Oct 2022 09:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665740453;
        bh=AncuZXGLT2khpBBT4J1GOXDx/f4gLmzsl4pImnV0mo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AfG6aqIZ0bDgkg9n+xvPg19glPTnvvS2zpoq3nY73tIkS3Q/ta6wBFyk8HvGHSxdN
         FcTNfjg6IIchxl3B8kUbEpeR0SN6v34KZhY+n6nj0ZhNndF1VE0B22xdwKtGlny3CS
         6ZNi2FwJ/Vig88OLGblWSS5xYm7dBLIrLcbInVIqath+EJvGknnm1ThrkdKHH14eoA
         DZH1q/W6w7eBe/z5uwC3xHQX1gqu+IaXaRdaCZpy6m6qFVpYoNgYUbIPzYWIwTcnHD
         dhWMFmi5VJJKt3XZHPgNPJHNrhV9EZ01ecVsRzbBpvH8wiKUEx0VylxKQselb5/bCf
         uKu5zZspB2ASA==
Received: by mail-lf1-f45.google.com with SMTP id b1so6352390lfs.7;
        Fri, 14 Oct 2022 02:40:53 -0700 (PDT)
X-Gm-Message-State: ACrzQf1CGEwlBJLeUSeXRBVZDOAvFw9a3a+JScJJgphVTo/ztERbFWrn
        bzvCeHKonNK3CstTm7IX31g3TzaKDpB5o/R3XjA=
X-Google-Smtp-Source: AMsMyM7qjZ3CZSPyze/S46oOGpxLxLLOdR2le548sw16cpjxD43ujYyF+tssFYA6iJm2BupjSNvcTEqVicplpQT1fBc=
X-Received: by 2002:a05:6512:3119:b0:4a2:d749:ff82 with SMTP id
 n25-20020a056512311900b004a2d749ff82mr1498182lfb.637.1665740451016; Fri, 14
 Oct 2022 02:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221010023559.69655-1-justin.he@arm.com> <20221010023559.69655-7-justin.he@arm.com>
 <Y0VGkUxpqiIzIFzB@zn.tnic> <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic> <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0gUpoaUBKw/jjaD@zn.tnic> <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
 <Y0hAuBkmiUGfCs8/@hirez.programming.kicks-ass.net> <Y0hN+Cd8ZT1d9f7e@zn.tnic>
In-Reply-To: <Y0hN+Cd8ZT1d9f7e@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Oct 2022 11:40:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGQmo9xstNY9B8Mp2gujXLTqCsV1u3PQKLtHg-WpWeLDA@mail.gmail.com>
Message-ID: <CAMj1kXGQmo9xstNY9B8Mp2gujXLTqCsV1u3PQKLtHg-WpWeLDA@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Justin He <Justin.He@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
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
        nd <nd@arm.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 13 Oct 2022 at 19:42, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Oct 13, 2022 at 06:45:44PM +0200, Peter Zijlstra wrote:
> > Borislav is thinking too much x86. Failed cmpxchg() does indeed not
> > imply any memory ordering for all architectures -- and while the memory
> > clobber (aka. barrier()) is equivalent to an smp_wmb() on x86, that most
> > certainly doesn't hold for non x86 code.
>
> Right, but the patch was addied by an Intel person, CCed:
>
> 152cef40a808 ("ACPI, APEI, GHES, Error records content based throttle")a
>
> So I don't think he was thinking about ARM when doing that.
>
> And that commit message doesn't say one whit why that memory barrier is
> needed there.
>
> Reading that comment, it sounds like he wanted a hw memory barrier -
> MFENCE - but I don't see how normal data dependency wouldn't enforce the proper order
> already...
>
> So that barrier looks out of place there.
>

The cache struct pointer should not be published until after the
struct itself is fully populated. So on the producer side, some kind
of hardware barrier is definitely needed, or the struct may appear
half-baked to other cores that can read the updated pointer.

But as Peter points out, cmpxchg() itself has the required barrier
semantics already, so the separate smp_wmb() is likely unnecessary.
And as I suggested earlier, a full barrier is not necessary so we
could relax this to cmpxchg_release() if desired.

OTOH the code seems to be working fine as is, so why modify it at all?
(apart from the purely cosmetic changes)

> Btw, this is the next perfect example why I'm asking people to write
> proper commit messages so that when we do git archeology later, we can
> figure out why something was done the way it has been.
>
> And in this case, we can't. ;-\
>
> Because writing proper commit messages is for losers. Yeah, right.</sarcasm>
>

Yeah, agree there.
