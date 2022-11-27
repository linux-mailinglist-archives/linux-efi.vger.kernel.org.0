Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34CB639D35
	for <lists+linux-efi@lfdr.de>; Sun, 27 Nov 2022 22:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiK0VS7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Nov 2022 16:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiK0VS6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 27 Nov 2022 16:18:58 -0500
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F26BE14;
        Sun, 27 Nov 2022 13:18:54 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 00784424A4; Sun, 27 Nov 2022 21:00:40 +0000 (GMT)
Date:   Sun, 27 Nov 2022 21:00:40 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Subject: Re: [PATCH v3 1/5] efi: vars: prohibit reading random seed variables
Message-ID: <20221127210040.GA32253@srcf.ucam.org>
References: <20221122020404.3476063-1-Jason@zx2c4.com>
 <20221122020404.3476063-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122020404.3476063-2-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 22, 2022 at 03:04:00AM +0100, Jason A. Donenfeld wrote:
> In anticipation of putting random seeds in EFI variables, it's important
> that the random GUID namespace of variables remains hidden from
> userspace. We accomplish this by not populating efivarfs with entries
> from that GUID, as well as denying the creation of new ones in that
> GUID.

What's the concern here? Booting an older kernel would allow a malicious 
actor to either read the seed variable or set it to a value under their 
control, so we can't guarantee that the information is secret.
