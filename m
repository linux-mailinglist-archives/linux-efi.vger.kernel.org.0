Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E214169D1AB
	for <lists+linux-efi@lfdr.de>; Mon, 20 Feb 2023 17:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjBTQrk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Feb 2023 11:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjBTQrj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Feb 2023 11:47:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682FD206A3
        for <linux-efi@vger.kernel.org>; Mon, 20 Feb 2023 08:47:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B085B80D49
        for <linux-efi@vger.kernel.org>; Mon, 20 Feb 2023 16:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80BAC433A7
        for <linux-efi@vger.kernel.org>; Mon, 20 Feb 2023 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676911586;
        bh=oG+LhLB0NyfLsU3CuBuHidNZD1EwuE4FH2OtbzemcOQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c1NW1/MKwsC3y1ar8Pbu8WBBEKOEDrzH2KJoZSbotYum9Giq74Z24D1+z96RNcu3T
         rOBjHtAnmGp0og/6FSk1S6q9apIdR4ZLYwQA5Gi4efDrvvgCVhZ7UQvRZv5T/AfZei
         ZtMlL+YyHhu4kDjAfDqBHhSE9LmU9h+eZDCP9yBcaGfGjfcT5b8jWxm5RCR38G5+vz
         XWK9rKnz407mphmZ2KzdKyV/58RiixuoTFFcxNBBHgQzePp4IH5/zFH6jMRWTJbV8Z
         e8lX84913fmjRYRQSU6Uj6WPlk9LvAGAPlnojJtOtUA/nzio3UK3q4hg2QSA/0kmAx
         Oa0xtRpqwuOqw==
Received: by mail-lj1-f171.google.com with SMTP id f16so1724187ljq.10
        for <linux-efi@vger.kernel.org>; Mon, 20 Feb 2023 08:46:26 -0800 (PST)
X-Gm-Message-State: AO0yUKVVXZrRxj1yQKiDFnLVMyLnsi/OVKioaljy2jbw5PwAGjiZYD9P
        JiDYmrFgyW4jHbtRo75y+DZ3o1oi+HNFdVIMGPM=
X-Google-Smtp-Source: AK7set+ccYQ4Po5bFe4Ol4kISLKahTlpHWnrc/rLr98huZMhuR+nUVtq8QnQEncc8Bzm58JWVBVwE3gPDcWtFrzfKNk=
X-Received: by 2002:a05:651c:b9b:b0:293:527d:3386 with SMTP id
 bg27-20020a05651c0b9b00b00293527d3386mr822519ljb.2.1676911584790; Mon, 20 Feb
 2023 08:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20230206124938.272988-1-ardb@kernel.org> <20230206124938.272988-3-ardb@kernel.org>
 <20230208130007.GA13529@willie-the-truck> <CAMj1kXEReR30NYgHS67W2RH0z=0HdG4UrkBKuTXwFN9NrNE6wg@mail.gmail.com>
 <Y+Owvx0e24gZb7hy@FVFF77S0Q05N.cambridge.arm.com> <CAMj1kXG5iG=ok_nWnt7Tj5-Evwen4VvOQoNpVHh5mPU2mbCDWQ@mail.gmail.com>
 <Y/OXdpfcsoPxgHdq@sirena.org.uk>
In-Reply-To: <Y/OXdpfcsoPxgHdq@sirena.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 20 Feb 2023 17:46:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHj6mrQE9Bm1k9Ef+TH6oU4zY+CAnzLQUVjMOUczH9W1g@mail.gmail.com>
Message-ID: <CAMj1kXHj6mrQE9Bm1k9Ef+TH6oU4zY+CAnzLQUVjMOUczH9W1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi: arm64: Wire up BTI annotation in memory
 attributes table
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 20 Feb 2023 at 16:53, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Feb 08, 2023 at 03:36:40PM +0100, Ard Biesheuvel wrote:
>
> > OTOH, what is the penalty for setting the GP attribute and using the
> > translation table on a core that does not implement BTI?
>
> The concern with doing that for Linux was what would happen if someone
> implemented a system with mixed BTI/no BTI support and then a task got
> preempted and moved between the two, you might end up with PSTATE.BTYPE
> incorrectly set and trigger a spurious fault.  That shouldn't be an
> issue for EFI runtime services.

Right, I hadn't figured that. But as you say, this shouldn't affect
EFI runtime services, as they are non-preemptible and therefore
non-migratable.
