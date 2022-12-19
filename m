Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA60650CE9
	for <lists+linux-efi@lfdr.de>; Mon, 19 Dec 2022 15:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiLSOAb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Dec 2022 09:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiLSOAa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Dec 2022 09:00:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EB75F99;
        Mon, 19 Dec 2022 06:00:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE273B80E2A;
        Mon, 19 Dec 2022 14:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C245C433D2;
        Mon, 19 Dec 2022 14:00:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HgejK6BM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1671458420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6wRbMMeXtTvfCbZJJJTglfnt7xRdpJs1iadlSbJZcKM=;
        b=HgejK6BMq0N4ml/rRu/TDtyjhttfXCgIlN2NXXR2p1o2sj3OnrjxYnoeOMjRzqRk4N2fn6
        fQrvufHW+YBiKMW9SlN4xC2eDy7z2x8/xTeh4GUvRXHjZ+aw10LPVIW9mMcfcL6NkunTrT
        EFdqiqoxd/vmc/VqTYvkcnj0JC/FAzA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 10ad1dce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Dec 2022 14:00:20 +0000 (UTC)
Date:   Mon, 19 Dec 2022 15:00:17 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH v2] efi: random: fix NULL-deref when refreshing seed
Message-ID: <Y6Bucfoykf2lMdQQ@zx2c4.com>
References: <20221219101237.9872-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221219101237.9872-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 19, 2022 at 11:12:37AM +0100, Johan Hovold wrote:
> Do not try to refresh the RNG seed in case the firmware does not support
> setting variables.
> 
> This is specifically needed to prevent a NULL-pointer dereference on the
> Lenovo X13s with some firmware revisions, or more generally, whenever
> the runtime services have been disabled (e.g. efi=noruntime or with
> PREEMPT_RT).
> 
> Fixes: e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Changes in v2
>  - amend commit message with a comment on this being needed whenever the
>    runtime services have been disabled

I'll queue up the one with the amended commit message.

Jason
