Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDC25B115D
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 02:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiIHAg0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 20:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIHAgR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 20:36:17 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F757653;
        Wed,  7 Sep 2022 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nSJLgRjMMl1YkRTkbAlqniyD6fRuPD0gktBDc/jlsrE=; b=TCjCWGiEFMk23m6+LxhdrFDhkv
        Q+SO4QJj4H79/wc8YSJk3Kky+PrV8n22Pc0jHOAwFq+PZ9FpesfvUS25fYYpHSpSvHwoJ4iEtSu36
        Zo7Vzl7AISwqnlGL78+CBGlIE8Nt6+n14KhGs35CQGPClpSZ/iLnUKwyT8JCaYcNGztVoOFGzA+GY
        mNmB99nCqS4gwKCH8qM3wX4S+7WBC00m6usmaDVB8U0hyIb3NBFXonuflPU70iAbPS4cwWwXKCuSR
        H/KUCyAX1aDS66TtUiLpOMZHoHSNUkgxN4TVqINPMc+2GF2JoQu4j3TDjrs8Q3Hea5OVMdAwb2N9+
        lhDL1U5Q==;
Received: from [177.215.76.177] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oW5WZ-00D2UE-5F; Thu, 08 Sep 2022 02:36:07 +0200
Message-ID: <887931a4-c1df-8b4b-6594-864b96e50217@igalia.com>
Date:   Wed, 7 Sep 2022 21:35:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3] firmware: google: Test spinlock on panic path to avoid
 lockups
Content-Language: en-US
To:     Evan Green <evgreen@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel@gpiccoli.net, Ard Biesheuvel <ardb@kernel.org>,
        David Gow <davidgow@google.com>,
        Julius Werner <jwerner@chromium.org>
References: <20220819155059.451674-1-gpiccoli@igalia.com>
 <YxDVPqVkdgQbAIvY@kroah.com>
 <f89cd87c-7d1c-d8e6-ed95-6876f0201872@igalia.com>
 <YxDX9+p+58q2sip2@kroah.com>
 <6bc5dbc3-2cdd-5cb8-1632-11de2008a85a@igalia.com>
 <YxDhiSDs4YcUrqV5@kroah.com>
 <85683284-db85-7e3a-57bd-750e1c204e3e@igalia.com>
 <YxD56RTI9v/P2QOL@kroah.com>
 <b050f00b-6c3a-a0d9-a3c1-175a724faf1c@igalia.com>
 <YxEBCVRgWE8VTZaf@kroah.com>
 <794efe45-2fef-0d3f-b6d0-f2f451be850c@igalia.com>
 <20220901151320.3cff1767f88cfb33f394e9cb@linux-foundation.org>
 <CAE=gft7bZ0DaX3YuVq4BgruC3JFSBvO=NQsak=K1cM3qh1qJww@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAE=gft7bZ0DaX3YuVq4BgruC3JFSBvO=NQsak=K1cM3qh1qJww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 06/09/2022 14:09, Evan Green wrote:
> [...]
> 
> I basically came to the same conclusion as Andrew. It seems like this
> patch does fix a problem, which is a panic coming in on another CPU
> and NMIing on top of a CPU doing a normal operation holding this lock.
> The problem seems pretty theoretical, but I suppose I don't have
> numbers one way or another since any attempt to gather numbers would
> be reliant on this very mechanism. My Reviewed-by tag is already on
> there.
> -Evan

Thanks for the feedback Evan and Andrew.

So if Greg (or anybody else) doesn't oppose, I'll send a V4 with the
commit message/comment suggestions.

Cheers,


Guilherme
