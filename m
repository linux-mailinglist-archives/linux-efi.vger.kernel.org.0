Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA262C73D
	for <lists+linux-efi@lfdr.de>; Wed, 16 Nov 2022 19:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiKPSII (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Nov 2022 13:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPSII (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Nov 2022 13:08:08 -0500
X-Greylist: delayed 504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 10:08:06 PST
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A2FEE1D;
        Wed, 16 Nov 2022 10:08:06 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id EFB82E8019B;
        Wed, 16 Nov 2022 18:59:38 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 72FBE1600BB; Wed, 16 Nov 2022 18:59:38 +0100 (CET)
Date:   Wed, 16 Nov 2022 18:59:38 +0100
From:   Lennart Poettering <lennart@poettering.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH RFC v1 0/6] Use EFI variables for random seed
Message-ID: <Y3UlCjbhXwZG0dEH@gardel-login>
References: <20221116161642.1670235-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116161642.1670235-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mi, 16.11.22 17:16, Jason A. Donenfeld (Jason@zx2c4.com) wrote:

> Commit messages are rather sparse at the moment. I'll fill those out for
> the next non-RFC patchset if this idea isn't immediately demolished.
>
> The biggest consideration is wear leveling on the EFI variable flash
> chips. However, EFI *already* winds up writing to non-volatile memory on
> every single boot anyway, so maybe it's not actually a big deal?

So as mentioned elsewhere: This might (probably more than) double the
wear on the flash chips, since firmware is unlikely to batch these
writes with the monotonic counter write.

I have no idea how realistic these issues are, there's a lot of
handwaving involved, but to sidestep the issue I put sd-boot's seed in
a file on disk (which should not have issues that much with wear)
instead of efi vars.

Lennart
