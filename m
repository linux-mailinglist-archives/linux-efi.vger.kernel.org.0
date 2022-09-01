Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2BA5A9C69
	for <lists+linux-efi@lfdr.de>; Thu,  1 Sep 2022 18:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiIAQAL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Sep 2022 12:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiIAQAE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Sep 2022 12:00:04 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D82C1402C;
        Thu,  1 Sep 2022 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oaaEzGe48rQOZZkPwbRabi4a7HwDoRcH1qyMGnreP6o=; b=TNeAKdDphsY167amWFDivtvHcx
        QOkff0372Cyn1lw7ET6tMcbvafqkTEugQHob8Zrge9n4lDOjCa+LdHXg1VvoPv28XZE/EC28GzBKv
        OY1LUmCmgF9oXxmBaelyaP4OEl+ud3lR0TQkmH3cfFiQKoW0tx8SplmtuI3eqfRUbBtJipnMpchYk
        YhpVIhWI9FRx1Vbx1HKF0SUgl6hT6aDiJVBhBkP9dQcC8F9wY4sRQl6VvQlT9UqbYNNPaocpyufti
        Lil932NQEs/8A3YtMSPRPZU9HHkFANEivFIW6nPwc95q2WVtIGx/LA8q1b6dBodk1ojG01dbLMaKa
        fQD4Lfsg==;
Received: from 189-69-202-182.dial-up.telesp.net.br ([189.69.202.182] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oTmbh-007pDD-Iz; Thu, 01 Sep 2022 17:59:53 +0200
Message-ID: <f89cd87c-7d1c-d8e6-ed95-6876f0201872@igalia.com>
Date:   Thu, 1 Sep 2022 12:59:36 -0300
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
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YxDVPqVkdgQbAIvY@kroah.com>
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

+ Petr, since this was extensively discussed in the original thread [0]
and maybe he can help with the argument.

[0]
https://lore.kernel.org/lkml/20220427224924.592546-1-gpiccoli@igalia.com/


On 01/09/2022 12:52, Greg KH wrote:
> [...]

>> +	 * Perform the lock check before effectively trying
>> +	 * to acquire it on gsmi_shutdown_reason() to avoid
>> +	 * potential lockups in atomic context.
>> +	 */
>> +	if (spin_is_locked(&gsmi_dev.lock))
>> +		return NOTIFY_DONE;
>> +
> 
> What happens if the lock is grabbed right after testing for it?
> Shouldn't you use lockdep_assert_held() instead as the documentation
> says to?

How, if in this point only a single CPU (this one, executing the code)
is running?

Remember this is the panic path - before this point we disabled all
other CPUs, except this one executing the code. So, either the lock was
taken (and we bail), or it wasn't and it's safe to continue.

