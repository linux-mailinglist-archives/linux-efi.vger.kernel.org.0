Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE31639EF7
	for <lists+linux-efi@lfdr.de>; Mon, 28 Nov 2022 02:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiK1Bf2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Nov 2022 20:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK1Bf2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 27 Nov 2022 20:35:28 -0500
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A69AE65;
        Sun, 27 Nov 2022 17:35:24 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 15B6A424A2; Mon, 28 Nov 2022 01:35:23 +0000 (GMT)
Date:   Mon, 28 Nov 2022 01:35:23 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Subject: Re: [PATCH v3 2/5] efi: stub: use random seed from EFI variable
Message-ID: <20221128013523.GA6780@srcf.ucam.org>
References: <20221122020404.3476063-1-Jason@zx2c4.com>
 <20221122020404.3476063-3-Jason@zx2c4.com>
 <20221127211244.GB32253@srcf.ucam.org>
 <Y4QLBnoJGUoqwo4p@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4QLBnoJGUoqwo4p@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 28, 2022 at 02:12:38AM +0100, Jason A. Donenfeld wrote:

> Yea this is a bummer. During my first attempt at this, I actually
> overwrote the whole thing with zeros and then deleted it. But Ard
> pointed out that this doesn't make a difference anyway. But, as it turns
> out, that's more or less the same thing that happens with seed files on
> SSDs (nobody calls fstrim after overwriting a seed file). So at the very
> least, it's no worse?

Anyone with the ability to directly read the flash variable store is 
almost certainly in a position to do worse things, so I wouldn't worry 
about it.
