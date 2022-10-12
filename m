Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A055FCA25
	for <lists+linux-efi@lfdr.de>; Wed, 12 Oct 2022 19:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJLR7T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Oct 2022 13:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJLR7S (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Oct 2022 13:59:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035E1D8EDF
        for <linux-efi@vger.kernel.org>; Wed, 12 Oct 2022 10:59:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y191so1806618pfb.2
        for <linux-efi@vger.kernel.org>; Wed, 12 Oct 2022 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+oUQQ+NOkc0QprdtZXS+tTGPaRIPlunaMK86rsYyWQ=;
        b=JFh6GxxkOz8JaNcKsKjPLyHe1gNpLgVVbwBt4qZ1UYBlhvxvFgWPE4AuXA93vB1nK1
         ZPh1Ie1NBwrg37BzebmLRhO1uMB7c0BX2CZT+JvzTvUUrnSB0PtR/iYdsXbx+7mpxt3C
         q9pFzEvSm+ujLN9icxLCXhaGoHwb3QrGaJW/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+oUQQ+NOkc0QprdtZXS+tTGPaRIPlunaMK86rsYyWQ=;
        b=jZaEjPY7lfTY7GvUi+NSym37muPCHa/Guhwro8W1rLv0Hurr7lY+Fwir/e9eItf4I3
         UaO9VVz6jdASiO7z7NUKGyo+8AB1LXMy+t1CEp/GKTkWKRn5EAD+kSbpQpG7UZ4WAOvI
         hidycoccmQK6/U6Z6+natAC0qIwiNzVMZwt6uBOpHIU1jhII1UrcEgNwQc6LVU7zhWbU
         isdOIg4mBdD67bypJuNXO/6WVcXHelnQySVI2f++W774N98+vB4YBmkadprCEKTFpnkl
         0BymBPnf6Hjs8A2wqCbrpmzA6jgBD97lFCL6BQgPWjNX0Yo13d9Yde/gFXdGTNgjN7lL
         Y9Zg==
X-Gm-Message-State: ACrzQf3MFq5x2OmBg010sm0kk9m/kFUC5ygbFeQGnB81xp5lCxzTuSGC
        T1pNf1YQXg1Jt8+0mmxq5Kw5mA==
X-Google-Smtp-Source: AMsMyM4xDuOCoIFytmUw7DqbmMWbqve3w8w3bcT5sDaU5p0iV23C0mLCGZRD2rxXASIdG+/jRrZVtw==
X-Received: by 2002:a63:188:0:b0:43c:22e9:2d10 with SMTP id 130-20020a630188000000b0043c22e92d10mr26657335pgb.12.1665597555034;
        Wed, 12 Oct 2022 10:59:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v125-20020a622f83000000b00562ef28aac6sm134384pfv.185.2022.10.12.10.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 10:59:14 -0700 (PDT)
Date:   Wed, 12 Oct 2022 10:59:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        kernel-dev@igalia.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH 0/8] Some pstore improvements
Message-ID: <202210121059.A173694D06@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <166509868540.1834775.12982405101524535051.b4-ty@chromium.org>
 <839e44ed-ae89-dfd4-9c38-978ce2693910@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839e44ed-ae89-dfd4-9c38-978ce2693910@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 12, 2022 at 12:50:50PM -0300, Guilherme G. Piccoli wrote:
> On 06/10/2022 20:24, Kees Cook wrote:
> > On Thu, 6 Oct 2022 19:42:04 -0300, Guilherme G. Piccoli wrote:
> >> overall. Most of them are minors, but the implicit conversion thing
> >> is a bit more "relevant" in a sense it's more invasive and would fit
> >> more as a "fix".
> >>
> >> The code is based on v6.0, and it was tested with multiple compression
> >> algorithms (zstd, deflate, lz4, lzo, 842) and two backends (ramoops and
> >> efi_pstore) - I've used a QEMU UEFI guest and Steam Deck for this goal.
> >>
> >> [...]
> > 
> > Applied to for-next/pstore, thanks!
> > 
> > [1/8] pstore: Improve error reporting in case of backend overlap
> >       https://git.kernel.org/kees/c/55dbe25ee4c8
> > [2/8] pstore: Expose kmsg_bytes as a module parameter
> >       https://git.kernel.org/kees/c/1af13c2b6324
> > [3/8] pstore: Inform unregistered backend names as well
> >       https://git.kernel.org/kees/c/a4f92789f799
> > 
> 
> Thanks Kees! just a heads-up on how I'll proceed.
> 
> (a) Patches 1-3 were added already.
> 
> (b) MAINTAINERS patch was reworked by yourself in the other series, so
> I'll discard my version.
> 
> (c) I'll rework patches 4 and 8 and re-submit them plus patch 7
> (including the ACK from Ard).
> 
> (d) Gonna discard for now patch 5, planning to test a new version on top
> of the crypto acomp interface V2 from Ard/you.

Sounds good; thanks!

-- 
Kees Cook
