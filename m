Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9FE639EAA
	for <lists+linux-efi@lfdr.de>; Mon, 28 Nov 2022 02:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiK1BMt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Nov 2022 20:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiK1BMr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 27 Nov 2022 20:12:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD7F63BB;
        Sun, 27 Nov 2022 17:12:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8021360F4E;
        Mon, 28 Nov 2022 01:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208F2C433B5;
        Mon, 28 Nov 2022 01:12:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nzbuDLVE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669597960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1OJzdibFjOZy7mWFF2eT9wN+vFZkU1CupWir6+Z42M4=;
        b=nzbuDLVE+zOn2qe3+1r+MtwspxrerCAqOZ1spt1UTDMFImpw8w3DR4ZOnn5YewvQmUpU0A
        F9raCn/IpptZasXMJbQ4De9U04U0fUVS79vPJieRgeyY/HJpq9bCTzf5CoU0WwA76npu+0
        84uw37NWgEJv7ZJKavS7Xizd0oo/c7c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fde10b80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Nov 2022 01:12:40 +0000 (UTC)
Date:   Mon, 28 Nov 2022 02:12:38 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Subject: Re: [PATCH v3 2/5] efi: stub: use random seed from EFI variable
Message-ID: <Y4QLBnoJGUoqwo4p@zx2c4.com>
References: <20221122020404.3476063-1-Jason@zx2c4.com>
 <20221122020404.3476063-3-Jason@zx2c4.com>
 <20221127211244.GB32253@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221127211244.GB32253@srcf.ucam.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Sun, Nov 27, 2022 at 09:12:44PM +0000, Matthew Garrett wrote:
> On Tue, Nov 22, 2022 at 03:04:01AM +0100, Jason A. Donenfeld wrote:
> 
> > +		 * We delete the seed here, and /hope/ that this causes EFI to
> > +		 * also zero out its representation on disk. This is somewhat
> 
> Several implementations I've worked with simply append a deletion marker 
> or append a new variable value until the variable store fills up 
> entirely, at which point a garbage collection event is either run or 
> scheduled for the next reboot. The spec doesn't define how this is 
> handled so unfortunately I don't think there's any way to get a pony 
> here.

Yea this is a bummer. During my first attempt at this, I actually
overwrote the whole thing with zeros and then deleted it. But Ard
pointed out that this doesn't make a difference anyway. But, as it turns
out, that's more or less the same thing that happens with seed files on
SSDs (nobody calls fstrim after overwriting a seed file). So at the very
least, it's no worse?

Jason
