Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB9638EEE
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 17:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfFGPZX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 11:25:23 -0400
Received: from foss.arm.com ([217.140.110.172]:42662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729462AbfFGPZV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 7 Jun 2019 11:25:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8A39346;
        Fri,  7 Jun 2019 08:25:20 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D270C3F718;
        Fri,  7 Jun 2019 08:25:19 -0700 (PDT)
Date:   Fri, 7 Jun 2019 16:25:17 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Subject: Re: "arm64: Silence gcc warnings about arch ABI drift" breaks clang
Message-ID: <20190607152517.GC19862@fuggles.cambridge.arm.com>
References: <1559920965.6132.56.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559920965.6132.56.camel@lca.pw>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 07, 2019 at 11:22:45AM -0400, Qian Cai wrote:
> The linux-next commit "arm64: Silence gcc warnings about arch ABI drift" [1]
> breaks clang build where it screams that unknown option "-Wno-psabi" and
> generates errors below,

So that can be easily fixed with cc-option...

> [1] https://lore.kernel.org/linux-arm-kernel/1559817223-32585-1-git-send-email-D
> ave.Martin@arm.com/
> 
> ./drivers/firmware/efi/libstub/arm-stub.stub.o: In function
> `install_memreserve_table':
> ./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
> `__efistub___stack_chk_guard'
> ./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
> `__efistub___stack_chk_guard'
> ./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
> `__efistub___stack_chk_guard'
> ./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
> `__efistub___stack_chk_guard'
> ./linux/drivers/firmware/efi/libstub/arm-stub.c:94: undefined reference to
> `__efistub___stack_chk_fail

... but this looks unrelated. Are you saying you don't see these errors if
you revert Dave's patch?

Will
