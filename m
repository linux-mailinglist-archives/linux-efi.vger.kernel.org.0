Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3354622888
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 11:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiKIKe7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 05:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKIKe7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 05:34:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25571A051
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 02:34:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FD2AB81D82
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 10:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE14AC433C1;
        Wed,  9 Nov 2022 10:34:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PuSt810Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667990092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XGTxeO7PmLfRbzg8Xd9J/VsHZxqLqk+xCoVZgFyXFFQ=;
        b=PuSt810ZflEMlkO6xDxFHH9R5xsiV8XHCXTQmevvcBTZ5RgWJBgY76esKhFM8rWq28Ap73
        +/QiRMr5NxcpZI3+VU36hmURuRjd8E72aV+9rv4pW8MlKrjRTucY7GeOUD4KCvaYFOFsS1
        6bca81ynyyxrgMAzP4Y+ZNR7GMBPR/c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5dc26dcd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Nov 2022 10:34:51 +0000 (UTC)
Date:   Wed, 9 Nov 2022 11:34:50 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH v4] efi: random: combine bootloader provided RNG seed
 with RNG protocol output
Message-ID: <Y2uCSvoAguYsWotP@zx2c4.com>
References: <20221109095558.2572896-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221109095558.2572896-1-ardb@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Looking good! Thanks. A few brief comments.

On Wed, Nov 09, 2022 at 10:55:58AM +0100, Ard Biesheuvel wrote:
> The recommended seed
> size is 32 bytes, anything beyond that is disregarded when the seeds are
> concatenated.

This should read, "The recommended seed size is 32 bytes, and seeds
larger than 512 bytes are considered corrupted and ignored entirely."

> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Lennart Poettering <lennart@poettering.net>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I was thinking it might be best to add:

   Cc: stable@vger.kernel.org

"Don't clobber existing GUID" seems like it's arguably a fix.

>  	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> -			     sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
> +			     struct_size(seed, bits, seed_size),
>  			     (void **)&seed);
>  	if (status != EFI_SUCCESS)
>  		return status;

Should this print "Failed to something something, retaining
bootloader-supplied seed only", like the err_freepool case?

> +	efi_warn("Failed to obtain seed from EFI_RNG_PROTOCOL%s\n",
> +		 prev_seed ? ", retaining bootloader supplied seed only" : "");

"bootloader-supplied" with the hyphen, right?

If you make any of the above changes, feel free to do it when you commit
this. IOW, my comments are nits, so:

    Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

Also, I verified that kexec correctly sets everything back to 32 bytes
with this line:
    size = min(seed->size, EFI_RANDOM_SEED_SIZE);
So that's good.

Jason
