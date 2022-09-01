Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A0D5A9F85
	for <lists+linux-efi@lfdr.de>; Thu,  1 Sep 2022 21:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiIATCd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Sep 2022 15:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiIATCc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Sep 2022 15:02:32 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E586F57E;
        Thu,  1 Sep 2022 12:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fEq7ylXFVAD0/Jym3hdJKK4evsjkFDxgx44dOr3dnPM=; b=gkA2hI4dMcnOiridULo7op/MPs
        qkaaLntakJEq85jBxO0CoAztAK8QHCtnDdPErZqq9+AkL/gllioPMqfTn0MCpg55pk78cGIkiBLzx
        RYjOuw90T8RjeYukCPsn3EOXC5lo0SWV6PF/tZXqbXmJAk/qV3fuXb8aT97kVW2OdouXROpLSA51O
        6KYhZSqEpjOfzzi+vbV6BTnXriFhpYc3Nt76Qk1I/RU5W7nNxIKxZzf2DO6hAxZe6M+UnAzHrNnCm
        Rc1fwk5LmuqHLEPGhEuJbMYAQWET5FpYeQ7e27nYIOYuqrxVQHlfKhGB4sGA0Zy/Eo/f5zDl812fV
        8ElKfy0A==;
Received: from 189-69-202-182.dial-up.telesp.net.br ([189.69.202.182] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oTpSK-007uUo-4P; Thu, 01 Sep 2022 21:02:24 +0200
Message-ID: <794efe45-2fef-0d3f-b6d0-f2f451be850c@igalia.com>
Date:   Thu, 1 Sep 2022 16:02:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3] firmware: google: Test spinlock on panic path to avoid
 lockups
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     evgreen@chromium.org, arnd@arndb.de, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@gpiccoli.net, ardb@kernel.org,
        davidgow@google.com, jwerner@chromium.org
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
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YxEBCVRgWE8VTZaf@kroah.com>
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

On 01/09/2022 15:59, Greg KH wrote:
> [...]
> Ick, I don't know, this all feels odd.  I want someone else to review
> this and give their ack on the patch before I'll take it so someone else
> can share in the blame :)
> 
> thanks,
> 
> greg k-h

LOL, that's OK for me! Evan seems to be fine with it BTW.

Let's see if Petr can jump in, also adding Andrew here since he's
usually merging stuff for panic.
Cheers,


Guilherme
