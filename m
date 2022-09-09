Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9870F5B403E
	for <lists+linux-efi@lfdr.de>; Fri,  9 Sep 2022 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIITzI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Sep 2022 15:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiIITzG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Sep 2022 15:55:06 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AE95756B;
        Fri,  9 Sep 2022 12:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+EfySkeUE1JliUGkKRGldSXOPN09Mvht9g17GgJO/FY=; b=j+jof1YgrsTCDcYzQu00+9nrE6
        lu+TXAFHDkIL20e/CGY9JwmMIQXWDtSOuNF2bO5Ocl61FT5j1dapXHaw2uagy3EWaBaQtBSteUREd
        6fv0hUE/B2C4lBE/MOxYY+U/XgoucfDsv9lWpuLd2iDC3bHaWr61syNujclfloTSSqdZquGwCW95Y
        MLv3mYKJ6CsnM66Ck0eztcZt08brD2QgLiV7zKaJZ2SCTIlPBNWMlORa+1uammgpBZac8wVNs9NJv
        qTCqN/WKFAOX0WTWi6/y0/lJ0NHRZNp5x+HQxImRTgbcywEbwrVkPgeNsT5wSkwMWOhTQ5iq2tBVe
        5Ws6yL9Q==;
Received: from [177.215.76.177] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oWk58-00E66k-5o; Fri, 09 Sep 2022 21:54:30 +0200
Message-ID: <75eef98f-8dd0-6769-21bb-14f21b9fd693@igalia.com>
Date:   Fri, 9 Sep 2022 16:54:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/3] The UEFI panic notification mechanism, 2nd round
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, keescook@chromium.org,
        matt@codeblueprint.co.uk, mjg59@srcf.ucam.org, tony.luck@intel.com
References: <20220729194532.228403-1-gpiccoli@igalia.com>
 <468b8369-84c2-da12-1eb0-6ec16d160b34@igalia.com>
 <CAMj1kXGMmpLF8Sfcm16E+QpKosPgUGQ7FpO9qknoKxjyXY1zUQ@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXGMmpLF8Sfcm16E+QpKosPgUGQ7FpO9qknoKxjyXY1zUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 05/09/2022 06:50, Ard Biesheuvel wrote:
> [...]
>> Hi Ard, sorry for the ping =]
>>
>> Any opinions in this one? Patch 2 is a simple fix, BTW.
> 
> Hey,
> 
> No worries about the ping - apologies for the late response, I was on vacation.

Hi Ard, no need for apologies at all - this is a known vacation period
in the year =)


> 
> I still don't see the point of this series, but I will take the fix if
> you could please rebase it so it doesn't depend on the first patch.
> 

That part is sad heheh
I mean, it's a pity I could convince you - I still don't see how can
kernel let UEFI know about a panic without this patch (or pstore, which
I still think is the wrong way and sometimes impossible to use, due to
other pstore backend usage).

Anyway, nothing I can do about that it seems, unfortunately heheh

Submitted the V2 fix here:
https://lore.kernel.org/linux-efi/20220909194214.186731-1-gpiccoli@igalia.com/

Thanks,


Guilherme

