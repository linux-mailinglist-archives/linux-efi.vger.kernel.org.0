Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D28E5B4F6E
	for <lists+linux-efi@lfdr.de>; Sun, 11 Sep 2022 16:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIKOg1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 11 Sep 2022 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIKOgZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 11 Sep 2022 10:36:25 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D42A26AE1;
        Sun, 11 Sep 2022 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kpsNGXGOItgP3sw4KOrd3S9yFWs1L7+N0vhR0sDgBaY=; b=jOSVKasy912ZupPC6tF4+4gA4E
        aq/7HZeJs78AhM0F8XVNCL1U8z3elkPNGUXZGTsUcxtQkh7zzgz5hGAvQ1wOzRZcURsJfniKKd223
        7AlEeEcOdrK6OgysxCzoHOTePSWlzgDwjOFaSgkEaOaBoJhwKH/j9ll0Qjc0jhsZajGqgcl7mwo9s
        ggoU5EFBIA5MYAfujMOiXPRupEN0KkUx6LYbkUYO7yG+t2NGzGieOyeXHoyfdTnbQYMijkg+8ixy+
        L3R/8M8AambOj55ErYdhSOi/ujlatQB3b96K32Jid4J61ZMfSKvi3nZ6udL1hWpsQ7+mcxYzghkz1
        KVv8HkuQ==;
Received: from [177.215.76.177] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oXO4H-00FOtz-Ut; Sun, 11 Sep 2022 16:36:18 +0200
Message-ID: <e8ce8fb4-baac-b3a5-5d6d-418e20c8d2d9@igalia.com>
Date:   Sun, 11 Sep 2022 11:36:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V2] efi: efibc: Guard against allocation failure
Content-Language: en-US
To:     ardb@kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, matt@codeblueprint.co.uk, mjg59@srcf.ucam.org
References: <20220909194214.186731-1-gpiccoli@igalia.com>
 <04d65bd7-a6b2-bb14-fd69-632542ae9e86@wanadoo.fr>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <04d65bd7-a6b2-bb14-fd69-632542ae9e86@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/09/2022 01:56, Christophe JAILLET wrote:
> [...]
>>   	wdata = kmalloc(MAX_DATA_LEN * sizeof(efi_char16_t), GFP_KERNEL);
> Hi,
> 
> even if mostly useless in this case, kmalloc_array()?
> 
> Or certainly maybe even better, kstrndup()?
> 
> CJ
> 

Thanks! It's up to Ard, I could rework with this change if makes sense.
Cheers,


Guilherme
