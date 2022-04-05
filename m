Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B284F534C
	for <lists+linux-efi@lfdr.de>; Wed,  6 Apr 2022 06:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389962AbiDFEGE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Apr 2022 00:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457662AbiDEQ2k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Apr 2022 12:28:40 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB287C166;
        Tue,  5 Apr 2022 09:26:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35:2589:2a93:190d:b787])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DA08F608;
        Tue,  5 Apr 2022 16:26:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DA08F608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1649176002; bh=hdowXzq/NUai0/4J9T9jKyuof812l1GFSJ0ykV3EZkg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nktbmN+5YYLHdx1ydR8Midr+mqkwl9GMf76yqvmv1uQerX1B+W/BGdR2toWFXiCOb
         qzH0Lsa3/sMI7VqKP65V8hfYGSTWhsB+s1XkwESyXV3plSKUxgPIq7/BM4S56fnocJ
         RxJAXwsjS6M38bq7g688zWIzY9/vo+rARpE7EpiellJ+MRTMeCFIC5FbdLK3WgutVV
         5M22JeWazCuQO+HoZ7E4P7zkMXCu38VIwE+O4Gg9NFTsN2GcskHMRtw9puTl5hkZ3B
         E7fJCiNJb0n1Rdmaap7B5c3yTWjh+aR/GbcPRQ01xwiSXbRufB6tixq4+H7u0dB2uJ
         d7rMR5z6VyoEw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] x86/efi: Remove references of EFI earlyprintk from
 documentation
In-Reply-To: <20220321045853.3324-1-akihiko.odaki@gmail.com>
References: <20220321045853.3324-1-akihiko.odaki@gmail.com>
Date:   Tue, 05 Apr 2022 10:26:41 -0600
Message-ID: <87bkxfebsu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Akihiko Odaki <akihiko.odaki@gmail.com> writes:

> x86 EFI earlyprink was removed with commit 69c1f396f25b ("efi/x86:
> Convert x86 EFI earlyprintk into generic earlycon implementation").

So I will confess that I don't know this area well enough to know
whether this patch makes sense or not.  To help with that, it would have
been good to CC Ard, who is the author of the patch you cite above.
Adding him now.

Ard, do you agree with this change (preserved below)?

Thanks,

jon

> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f5a27f067db9..fb39337f4123 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1252,7 +1252,7 @@
>  			Append ",keep" to not disable it when the real console
>  			takes over.
>  
> -			Only one of vga, efi, serial, or usb debug port can
> +			Only one of vga, serial, or usb debug port can
>  			be used at a time.
>  
>  			Currently only ttyS0 and ttyS1 may be specified by
> @@ -1267,7 +1267,7 @@
>  			Interaction with the standard serial driver is not
>  			very good.
>  
> -			The VGA and EFI output is eventually overwritten by
> +			The VGA output is eventually overwritten by
>  			the real console.
>  
>  			The xen option can only be used in Xen domains.
> -- 
> 2.35.1
