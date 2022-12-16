Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3183A64F1DE
	for <lists+linux-efi@lfdr.de>; Fri, 16 Dec 2022 20:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiLPTkN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Dec 2022 14:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiLPTkL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Dec 2022 14:40:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F54D69AB6;
        Fri, 16 Dec 2022 11:40:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99417B81DFA;
        Fri, 16 Dec 2022 19:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB1FC433D2;
        Fri, 16 Dec 2022 19:40:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BKzgy7QE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1671219604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+8M0TJ0JPGb70GgPvLxeM0TlWsbNc1cq2r/tYrLQ1o=;
        b=BKzgy7QER/wWpy4sux7J5OQDYj3xj6y5TZHDOLQZe77BvFEMWneXbPRbcNZdZwg+6XQuMZ
        wDsFL3aKElYmqppzrcMsLLRCn48epGzLhkb7ZZOpVWC5iP5285W0KRkV1PEWJF18/2EecC
        4csh2L0RvDT24WrrNIFKcOCovxH0p34=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 34729c18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 16 Dec 2022 19:40:03 +0000 (UTC)
Date:   Fri, 16 Dec 2022 12:39:56 -0700
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] efi: random: fix NULL-deref when refreshing seed
Message-ID: <Y5zJT9Z37GSpd59l@zx2c4.com>
References: <20221216091514.6298-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221216091514.6298-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 16, 2022 at 10:15:14AM +0100, Johan Hovold wrote:
> Do not try to refresh the RNG seed in case the firmware does not support
> setting variables.
> 
> This is specifically needed to prevent a NULL-pointer dereference on the
> Lenovo X13s with some firmware revisions.
> 
> Fixes: e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Thanks very much for this, and sorry for the breakage. I'll try to get
this in before rc1 is cut, as I've got some other changes scheduled for
late in the merge window to send anyway.

Jason
