Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687935446DD
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jun 2022 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiFIJDF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jun 2022 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiFIJDE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jun 2022 05:03:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CBE1DF110
        for <linux-efi@vger.kernel.org>; Thu,  9 Jun 2022 02:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60FA4B82C8A
        for <linux-efi@vger.kernel.org>; Thu,  9 Jun 2022 09:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85C4C34114;
        Thu,  9 Jun 2022 09:03:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZeLfMltX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654765379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LiqM77oZJkQ5e5YW5eImuQ08mQhrjDYwpAWsu4v0lDk=;
        b=ZeLfMltXeuG/+E+nak0l1YcYMgKMxP7a8SziAyEss1MHpv753VNQ1MC0atDw9jzNpS/MFJ
        kXWKK2wIS1D6BJYhUifn4mwVT2gLcDyndpCMjPJLOyFqIjViSJv9GGgWj1uBR4iubd9KWj
        TUF0zBuyuQHTjudcayAeKKUhhlbuG4w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a38a95a3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 9 Jun 2022 09:02:59 +0000 (UTC)
Date:   Thu, 9 Jun 2022 11:02:57 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi: random: wait for CRNG to become ready before
 refreshing the seed
Message-ID: <YqG3QRovkHQ0TJib@zx2c4.com>
References: <20220608153216.1480073-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220608153216.1480073-1-ardb@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

I'm trying to break the analysis down a bit to figure out what should be
done here. Can you tell me if any of these points are incorrect?

Case 0) EFI fails to provide any randomness at all.
        Result: nothing happens on kexec; add_bootloader_randomness() is
	used by nobody.

Case 1) EFI provides randomness. Parent kernel is trust_bootloader=y.
        Child kernel is trust_bootloader=y.
	Result: parent makes new seed for child, and everything works fine.

Case 2) EFI provides randomness. Parent kernel is trust_bootloader=y.
        Child kernel is trust_bootloader=n.
	Result: parent makes new seed for child, which child doesn't
	credit, but everything still works fine.

Case 3) EFI provides randomness. Parent kernel is trust_bootloader=n.
        Child kernel is trust_bootloader=n.
	Result: parent makes new seed for child using a technically
	uninitialized RNG that is still of EFI-quality, which child
	doesn't credit, so everything still works fine.

Case 4) EFI provides randomness. Parent kernel is trust_bootloader=n.
        Child kernel is trust_bootloader=y.
	Result: parent makes new seed for child using a technically
	uninitialized RNG that is still of EFI-quality, which child then
	credits. On the surface, this seems bad. But actually, the
	randomness here is still at least as good as what EFI provided,
	which is what trust_bootloader=y means anyway. So I think this
	case is actually fine.

Since all cases are fine, I don't think this patch is actually needed.
The interesting thing about this exercise, though, is that the thing
that enables this conclusion is the base case 0, where we notice that
kexec doesn't pass a seed if EFI isn't passing any randomness in the
first place. Were that not so, then case 4 would be dangerous.

The question I have is whether the same holds for how device tree is
doing things. There, they check rng_is_initialized(), which means the
worst is avoided, I suppose, but doing so precludes the nice properties
that EFI has for cases 3 and 4. Is there a way to do things better
there, or not really?

Jason
