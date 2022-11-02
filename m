Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24DF6163F9
	for <lists+linux-efi@lfdr.de>; Wed,  2 Nov 2022 14:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKBNlg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Nov 2022 09:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiKBNle (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Nov 2022 09:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CF22AC7B
        for <linux-efi@vger.kernel.org>; Wed,  2 Nov 2022 06:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6795619A3
        for <linux-efi@vger.kernel.org>; Wed,  2 Nov 2022 13:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C49EC4314D;
        Wed,  2 Nov 2022 13:41:28 +0000 (UTC)
Date:   Wed, 2 Nov 2022 13:41:25 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        will@kernel.org, linux-efi@vger.kernel.org, maz@kernel.org
Subject: Re: [PATCH] arm64: efi: Recover from synchronous exceptions
 occurring in firmware
Message-ID: <Y2JzhYP8eBkgiXta@arm.com>
References: <20221028150112.2883620-1-ardb@kernel.org>
 <CAMj1kXFcAFEKTuaF5RfMrktoT0+w_E80tDiFoDWA-7vezCxPdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFcAFEKTuaF5RfMrktoT0+w_E80tDiFoDWA-7vezCxPdA@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 02, 2022 at 10:08:28AM +0100, Ard Biesheuvel wrote:
> On Fri, 28 Oct 2022 at 17:01, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Unlike x86, which has machinery to deal with page faults that occur
> > during the execution of EFI runtime services, arm64 has nothing like
> > that, and a synchronous exception raised by firmware code brings down
> > the whole system.
> >
> > With more EFI based systems appearing that were not built to run Linux
> > (such as the Windows-on-ARM laptops based on Qualcomm SOCs), as well as
> > the introduction of PRM (platform specific firmware routines that are
> > callable just like EFI runtime services), we are more likely to run into
> > issues of this sort, and it is much more likely that we can identify and
> > work around such issues if they don't bring down the system entirely.
> >
> > Since we already use a EFI runtime services call wrapper in assembler,
> > we can quite easily add some code that captures the execution state at
> > the point where the call is made, allowing us to revert to this state
> > and proceed execution if the call triggered a synchronous exception.
> >
> > Given that the kernel and the firmware don't share any data structures
> > that could end up in an indeterminate state, we can happily continue
> > running, as long as we mark the EFI runtime services as unavailable from
> > that point on.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Does anyone mind if I take this via the EFI tree for v6.1?

No, feel free to take it.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
