Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08D665236D
	for <lists+linux-efi@lfdr.de>; Tue, 20 Dec 2022 16:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiLTPEe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Dec 2022 10:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiLTPEe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Dec 2022 10:04:34 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C27DE4C
        for <linux-efi@vger.kernel.org>; Tue, 20 Dec 2022 07:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1671548672;
        bh=7oCsdI9zLO08Sb/m4aXYFhOYvcFPTe4K4dO8xrAtML8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=nF2F2B/DQnpHlAR/BkabC6ygQj3x3H9Pv3OEr9G71KDh6QodYFk83VwRGAsdYasHD
         6A9/R2QZyUsPou+6qO29Q5vcZOuM/Df0jdGvGQgs3nhtBTkqL9Dgvor8jdxD4ITYqU
         INp/Wcx5LEMrqSgC3SeSqrOg63aXvupEYbyjL0DE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0336B1280A84;
        Tue, 20 Dec 2022 10:04:32 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2yZ54v8ISEDV; Tue, 20 Dec 2022 10:04:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1671548671;
        bh=7oCsdI9zLO08Sb/m4aXYFhOYvcFPTe4K4dO8xrAtML8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=gC1YtY2lrxBB+x3FPM9LAiDo7NZhYdBUlXMuVqVfj4OjktusviH+lEKvotoGwCj2u
         /OpRyxiQaYoJy8t4aE/zUoWGSDTP8X9HxFlCGxiso9+3vUaseywzFTYIDFZYckwPRI
         U3flOGGGo3kwzNver//tUKWhilxDRGPpf3Baskbk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3C4DD1280796;
        Tue, 20 Dec 2022 10:04:31 -0500 (EST)
Message-ID: <bfd82c75c5a387a0cad0da4ebe6e9d4c87ca7ac0.camel@HansenPartnership.com>
Subject: Re: Queries about disabling EFI runtime services late
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Coiby Xu <coxu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Date:   Tue, 20 Dec 2022 10:04:28 -0500
In-Reply-To: <CALu+AoSXOCJPH0edbb-BmyTz2zUywY8-QfjYjjKJggSTmK=WyQ@mail.gmail.com>
References: <CALu+AoSXOCJPH0edbb-BmyTz2zUywY8-QfjYjjKJggSTmK=WyQ@mail.gmail.com>
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

On Tue, 2022-12-20 at 11:43 +0800, Dave Young wrote:
> Hi Ard,
> 
> Real time kernels usually disable efi runtime for latency issues,

Could you say a bit more about this?  I was under the impression we
only call efi runtime services when asked: for variable or capsule
updates or if you use the EFI RTC.  So if you don't use EFI services in
a real time kernel, you shouldn't suffer any latency issues due to
having them enabled.

>  but for some use cases, e.g. when Secure Boot is used kexec needs to
> get the UEFI keys to verify the kernel signatures with
> kexec_file_load syscall.

It's not just kexec.  Without EFI variable services, you won't be able
to update the MoK keys for new kernels either.

James


> 
> Do you have suggestions on how to make both work?
> Is it possible to have something like CONFIG_EFI_DISABLE_RUNTIME_LATE
> so the runtime can be disabled after init phase or a runtime switch
> in sysctl?
> 
> Thanks
> Dave
> 

