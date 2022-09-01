Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BF65A9D03
	for <lists+linux-efi@lfdr.de>; Thu,  1 Sep 2022 18:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiIAQZN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Sep 2022 12:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbiIAQZL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Sep 2022 12:25:11 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718DF1DA58;
        Thu,  1 Sep 2022 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vrexj/6cSquSJ/bGPFDnk6HjHs73DzbTlqlKEzOl078=; b=atuhApNAVapqq/ZUXq3tV4emKV
        5hKcbwfHRIH3ul2DDCVYmkj1Ltl71A2qqwofM0FkljmOAQdkNRu+/B5T5t0DAEAYWxsZ6BNCfeqXv
        BxVSTTwL8f9WQgvRHssCEwxQ5/OWAt+jBZTqfyi8oVUuXpY3SFudtxITQlwXHv/rxO7g6jghVrs6S
        qxgbaFnlpePpjbuLU+9+/HIvAkt4m0SLlhLJ9A3oU7eooFrmO5V0W5+DaUepRFvKipKrk3QpEv3XD
        h0ppNqAUI2ZZ2ADIkcedL6pL7lyuDKUgh3G2pCIikf3P7wv0OcEA+QytaAO95o0ylHvEzi0TPXTJM
        yVyVpZDQ==;
Received: from 189-69-202-182.dial-up.telesp.net.br ([189.69.202.182] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oTn01-007q2O-N8; Thu, 01 Sep 2022 18:25:01 +0200
Message-ID: <6bc5dbc3-2cdd-5cb8-1632-11de2008a85a@igalia.com>
Date:   Thu, 1 Sep 2022 13:24:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3] firmware: google: Test spinlock on panic path to avoid
 lockups
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, evgreen@chromium.org
Cc:     arnd@arndb.de, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@gpiccoli.net, ardb@kernel.org,
        davidgow@google.com, jwerner@chromium.org,
        Petr Mladek <pmladek@suse.com>
References: <20220819155059.451674-1-gpiccoli@igalia.com>
 <YxDVPqVkdgQbAIvY@kroah.com>
 <f89cd87c-7d1c-d8e6-ed95-6876f0201872@igalia.com>
 <YxDX9+p+58q2sip2@kroah.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YxDX9+p+58q2sip2@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 01/09/2022 13:04, Greg KH wrote:
> [...]
>>> What happens if the lock is grabbed right after testing for it?
>>> Shouldn't you use lockdep_assert_held() instead as the documentation
>>> says to?
>>
>> How, if in this point only a single CPU (this one, executing the code)
>> is running?
> 
> How are we supposed to know this here?
> 

Reading the code?
Or you mean, in the commit description this should be mentioned?
I can do that, if you prefer.


>> other CPUs, except this one executing the code. So, either the lock was
>> taken (and we bail), or it wasn't and it's safe to continue.
> 
> Then who else could have taken the lock?  And if all other CPUs are
> stopped, who cares about the lock at all?  Just don't grab it (you
> should check for that when you want to grab it) and then you can work
> properly at that point in time.
> 

I don't think it is so simple - we are in the panic path.
So, imagine the lock was taken in CPU0, where GSMI is doing some
operation. During that operation, CPU1 panics!

When that happens, panic() executes in CPU1, disabling CPU0 through
"strong" mechanisms (NMI). So, CPU0 had the lock, it is now off, and
when CPU1 goes through the panic notifiers, it'll eventually wait
forever for this lock in the GSMI handler, unless we have this patch
that would prevent the handler to run in such case.
Makes sense?


