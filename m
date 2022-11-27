Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987A0639D2A
	for <lists+linux-efi@lfdr.de>; Sun, 27 Nov 2022 22:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiK0VMr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Nov 2022 16:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiK0VMq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 27 Nov 2022 16:12:46 -0500
X-Greylist: delayed 244 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Nov 2022 13:12:45 PST
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE59BC86;
        Sun, 27 Nov 2022 13:12:45 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 3317D424A3; Sun, 27 Nov 2022 21:12:44 +0000 (GMT)
Date:   Sun, 27 Nov 2022 21:12:44 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Subject: Re: [PATCH v3 2/5] efi: stub: use random seed from EFI variable
Message-ID: <20221127211244.GB32253@srcf.ucam.org>
References: <20221122020404.3476063-1-Jason@zx2c4.com>
 <20221122020404.3476063-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122020404.3476063-3-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 22, 2022 at 03:04:01AM +0100, Jason A. Donenfeld wrote:

> +		 * We delete the seed here, and /hope/ that this causes EFI to
> +		 * also zero out its representation on disk. This is somewhat

Several implementations I've worked with simply append a deletion marker 
or append a new variable value until the variable store fills up 
entirely, at which point a garbage collection event is either run or 
scheduled for the next reboot. The spec doesn't define how this is 
handled so unfortunately I don't think there's any way to get a pony 
here.
