Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79B0639D5D
	for <lists+linux-efi@lfdr.de>; Sun, 27 Nov 2022 22:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiK0Vgc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Nov 2022 16:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiK0Vgc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 27 Nov 2022 16:36:32 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E048BF4B;
        Sun, 27 Nov 2022 13:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1669584990;
        bh=a9NhAStjD7FLJTivyWouVNmZblRBEYvdKaS6vE5iZdc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=m1PkZ8tXfACO7QzCEdxlVcZZyQBU2RF/DZDfL/7QR4BhJ/m8UJId2WJSW6tRFaD6X
         OLUbH58hIgn5D41kMbWhAcNfhDRLVWzuEbR6UP8C1GCP3Dn0xZfjxuTNTKL5D2r296
         nJtwT4KXztFZLyU/Jgoe0ndn+a9pbFDqBjBdQQq4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5486D128056E;
        Sun, 27 Nov 2022 16:36:30 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UOYNxvcUsjU4; Sun, 27 Nov 2022 16:36:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1669584989;
        bh=a9NhAStjD7FLJTivyWouVNmZblRBEYvdKaS6vE5iZdc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=QXO+AdNUbqf79fXTbSko41JBJobKp2dbpA8q01c5iOMgh2GDnJK2iYTSYwGXHupld
         jv7DY+aVvqC/0AGb+MVk+yUtbPa7mIstmaBGDMtksI8MWdiRtJRrPOXKvRliWRpUFN
         oa1P7iKl/3vNbMt7f1ZVT7HbUPxM1c4vVZnf5QE8=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 601091280520;
        Sun, 27 Nov 2022 16:36:29 -0500 (EST)
Message-ID: <cf70394e2d49393da370e7c7b2bf662c671b3f5e.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC v1 5/6] efi: efivarfs: prohibit reading random seed
 variables
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>
Date:   Sun, 27 Nov 2022 16:36:27 -0500
In-Reply-To: <CAHmME9obGun7zEMKQ1Td4u+rnzi3MexaUAj30W5UMYvJ62mw3Q@mail.gmail.com>
References: <20221116161642.1670235-1-Jason@zx2c4.com>
         <20221116161642.1670235-6-Jason@zx2c4.com>
         <CAMj1kXHZ60DCz6zgOqfQ-jBEuhc3XwvhieNbJUCY40hdEWt9CQ@mail.gmail.com>
         <7837b12a39b1d6721387ca95554c79003bd16c4e.camel@HansenPartnership.com>
         <CAHmME9obGun7zEMKQ1Td4u+rnzi3MexaUAj30W5UMYvJ62mw3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2022-11-16 at 21:08 +0100, Jason A. Donenfeld wrote:
> On Wed, Nov 16, 2022 at 8:42 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > It would be nice if they could be boot services only ... then they
> > disappear naturally, but that would mean the rng would have to
> > initialize and save in the EFI stub before ExitBootServices, which
> > doesn't seem practical.
> 
> That would be nice, but the whole idea is it gets updated by Linux's
> RNG, so that won't work. `boot|runtime` it is, then.

But then you can't use the only security mechanism we have in EFI
(keeping sensitive information in BS only variables which can only be
accessed by EFI signed entities).  If you can't take advantage of that
then there's no security point in placing the seed in EFI and you might
as well simply write it to a file.

Artificially trying to hide the variables from efivarfs has no real
security value either, as I think you can appreciate if you try the
thought experiment of trying to get a VFS modification to hide the
random seed file past Al ... I'll get the thought experiment popcorn.

James

