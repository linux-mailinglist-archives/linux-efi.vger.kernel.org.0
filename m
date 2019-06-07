Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7263913E
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfFGPnA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 11:43:00 -0400
Received: from foss.arm.com ([217.140.110.172]:43104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730720AbfFGPnA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 7 Jun 2019 11:43:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0CF280D;
        Fri,  7 Jun 2019 08:42:59 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86C973F718;
        Fri,  7 Jun 2019 08:42:58 -0700 (PDT)
Date:   Fri, 7 Jun 2019 16:42:56 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: "arm64: Silence gcc warnings about arch ABI drift" breaks clang
Message-ID: <20190607154256.GG28398@e103592.cambridge.arm.com>
References: <1559920965.6132.56.camel@lca.pw>
 <20190607152517.GC19862@fuggles.cambridge.arm.com>
 <1559921171.6132.57.camel@lca.pw>
 <20190607154010.GA41392@archlinux-epyc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607154010.GA41392@archlinux-epyc>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 07, 2019 at 08:40:10AM -0700, Nathan Chancellor wrote:
> On Fri, Jun 07, 2019 at 11:26:11AM -0400, Qian Cai wrote:
> > On Fri, 2019-06-07 at 16:25 +0100, Will Deacon wrote:
> > > On Fri, Jun 07, 2019 at 11:22:45AM -0400, Qian Cai wrote:
> > > > The linux-next commit "arm64: Silence gcc warnings about arch ABI drift" [1]
> > > > breaks clang build where it screams that unknown option "-Wno-psabi" and
> > > > generates errors below,
> > > 
> > > So that can be easily fixed with cc-option...
> > > 
> > > > [1] https://lore.kernel.org/linux-arm-kernel/1559817223-32585-1-git-send-ema
> > > > il-D
> > > > ave.Martin@arm.com/
> > > > 
> > > > ./drivers/firmware/efi/libstub/arm-stub.stub.o: In function
> > > > `install_memreserve_table':
> > > > ./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
> > > > `__efistub___stack_chk_guard'
> > > > ./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
> > > > `__efistub___stack_chk_guard'
> > > > ./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
> > > > `__efistub___stack_chk_guard'
> > > > ./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
> > > > `__efistub___stack_chk_guard'
> > > > ./linux/drivers/firmware/efi/libstub/arm-stub.c:94: undefined reference to
> > > > `__efistub___stack_chk_fail
> > > 
> > > ... but this looks unrelated. Are you saying you don't see these errors if
> > > you revert Dave's patch?
> > 
> > Yes.
> 
> I suspect the reason for this is -Wunknown-warning-option causes
> cc-option to fail. I see some disabled warnings like
> -Waddress-of-packed-member and -Wunused-const-variable when -Wno-psabi
> is unconditionally added.
> 
> I'll do some further triage but I think the obvious fix as Will
> suggested is to use cc-disable-warning. I'll send a patch.

Thanks for that.

Cheers
---Dave
