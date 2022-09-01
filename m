Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98F65A9E6B
	for <lists+linux-efi@lfdr.de>; Thu,  1 Sep 2022 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiIARrs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Sep 2022 13:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiIARrY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Sep 2022 13:47:24 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A162A72C;
        Thu,  1 Sep 2022 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jG1diFKmAnHq55rmungboNRp5UxEdvvxP5T+GF1eM+o=; b=JmJhfwm9B+IKOtcaWKo8wllhi9
        bIoTPO8pisJ8sBfD8BhnjGd3T2x1tYWNwjZXD+5bbwQmmBpzcrJ26LIJcZ1eEuiyOACVvu+y18I3v
        lEXMQxdqsXD3ERXToXsaDXBxJkuoGVgDXVdS/EuWvm5olQmzmVHzdB3Zq1g1Prmg89VW/sQcWkS9S
        5M+/SfB9u80s1Njbe6gh8GeZ9N3UidFntusoNzxnTRW/uzl1dabwZukyaLl4cslsI0G92S1B/iOEB
        d07vzEPEylgobuA03CarQQooRZL0YAgwiodM8PoJzPM1RBP8v94PQOaGaOGf8omX+TlH8HQ7ugaU9
        mUp/Rocg==;
Received: from 189-69-202-182.dial-up.telesp.net.br ([189.69.202.182] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oToHN-007s7h-Q5; Thu, 01 Sep 2022 19:47:02 +0200
Message-ID: <85683284-db85-7e3a-57bd-750e1c204e3e@igalia.com>
Date:   Thu, 1 Sep 2022 14:46:48 -0300
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
 <6bc5dbc3-2cdd-5cb8-1632-11de2008a85a@igalia.com>
 <YxDhiSDs4YcUrqV5@kroah.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YxDhiSDs4YcUrqV5@kroah.com>
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

On 01/09/2022 13:44, Greg KH wrote:
> [...]
>>> How are we supposed to know this here?
>>>
>>
>> Reading the code?
>> Or you mean, in the commit description this should be mentioned?
> 
> Yes, and in the comment as this type of call is very rare and should
> almost never be used.

OK, I can add that, for sure.


>> [...]
>> I don't think it is so simple - we are in the panic path.
> 
> Great, then the lock doesn't matter :)
> 
>> So, imagine the lock was taken in CPU0, where GSMI is doing some
>> operation. During that operation, CPU1 panics!
>>
>> When that happens, panic() executes in CPU1, disabling CPU0 through
>> "strong" mechanisms (NMI). So, CPU0 had the lock, it is now off, and
>> when CPU1 goes through the panic notifiers, it'll eventually wait
>> forever for this lock in the GSMI handler, unless we have this patch
>> that would prevent the handler to run in such case.
>> Makes sense?
> 
> I'm trying to say "if you are in panic, never grab the lock in the first
> place".  So change the place when you grab the lock, not here.
> 

Evan, any comment here?
I think the patch is still well suited for this case. Suggestions on how
to improve it are welcome, of course.

I honestly didn't understand exactly what you're suggesting Greg...
Mind clarifying?

Cheers,


Guilherme
