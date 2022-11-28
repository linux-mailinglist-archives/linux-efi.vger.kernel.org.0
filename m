Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C8C639E9D
	for <lists+linux-efi@lfdr.de>; Mon, 28 Nov 2022 02:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiK1BKi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Nov 2022 20:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiK1BKg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 27 Nov 2022 20:10:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64857DE97;
        Sun, 27 Nov 2022 17:10:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E000760F56;
        Mon, 28 Nov 2022 01:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766D8C433D6;
        Mon, 28 Nov 2022 01:10:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MU2OjMQq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669597831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=stMAcss9jJ+ArjSuYYut3Mj6Uflyd3mfK0Rrbcc1thA=;
        b=MU2OjMQqCEH71ivdAPT2TW0zRLPCiLYZ6ARGx++xJuTWOmhODjIUdCULwq8qwO8VuZVwR+
        giF10m4SCzuMU0SoKi75kEbguykMKyHDHscmKGgf+T2rQtKqDFlkYH+TfK6QzVT8cxXRdu
        jJSLwdGeGb4D2RxGBUf9j7lEstjrjq8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 18f5231d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Nov 2022 01:10:31 +0000 (UTC)
Date:   Mon, 28 Nov 2022 02:10:29 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Subject: Re: [PATCH v3 1/5] efi: vars: prohibit reading random seed variables
Message-ID: <Y4QKhRycxam5MIU1@zx2c4.com>
References: <20221122020404.3476063-1-Jason@zx2c4.com>
 <20221122020404.3476063-2-Jason@zx2c4.com>
 <20221127210040.GA32253@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221127210040.GA32253@srcf.ucam.org>
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

On Sun, Nov 27, 2022 at 09:00:40PM +0000, Matthew Garrett wrote:
> On Tue, Nov 22, 2022 at 03:04:00AM +0100, Jason A. Donenfeld wrote:
> > In anticipation of putting random seeds in EFI variables, it's important
> > that the random GUID namespace of variables remains hidden from
> > userspace. We accomplish this by not populating efivarfs with entries
> > from that GUID, as well as denying the creation of new ones in that
> > GUID.
> 
> What's the concern here? Booting an older kernel would allow a malicious 
> actor to either read the seed variable or set it to a value under their 
> control, so we can't guarantee that the information is secret.

The security model is the same as that of random seed files, on, say,
BSD. If you remove the hard drive or change the operating system or what
have you, then sure, you can fiddle with the seed and read it. But the
running operating system shouldn't show it to you if it can help it.
Consider, for example, systemd's use of EFI variables for the
SystemToken. There, they have PID 1 take care of chmod'ing it before
other processes start.  But of course a different OS or even EFI shell
could just read it. So, think of this as just basic runtime safety --
like what people do when they set the umask before writing a random seed
file -- rather than some type of ultimate secrecy.

(And either way, the larger picture is that it's much more important to
get as much random data from as many sources as possible as soon as
possible, rather than being overly paranoid about every one single
source that we start excluding sources. A plethora of sources is better
off here.)

Jason
