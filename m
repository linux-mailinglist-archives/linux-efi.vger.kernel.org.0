Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B622355EC43
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 20:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiF1SK3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 14:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiF1SK2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 14:10:28 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCDF17E2E;
        Tue, 28 Jun 2022 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N5V6yhQZocPY9lrZhJiakOTZAyixUEqJkpQve70yjSk=; b=IgLPxRhsTgZvDEAJyg4Wb6LG7n
        Ufwno2GsVrmZzvT12hAjSGiT7G2nZ66BmBmLaZ1mKGSbytWgN1Hc3ewF38M3/eZVCRzMQLDSq3O6s
        PcvoX8BOkFmZA3lcbN3ss3f8ECBkITScAfe30tjLtAVp3Lnh9jkUk/hVmtB0a9HMirgmrZJ5EljNL
        1KQLcUk7F6PuI+N9kBsqU/EnoDAJmi6YS6q4uN6go7IiCWqFzX+vpKIEBvCQOldaFW5y3uvO8kdJ8
        EgcvPdpcKulgbLSFgQ4Pemx1we/b+V5c9mR5n3w4DGHXVmISREpyD2y6vXbd30aVg4EU0n8V0Tt1/
        rx0YQSFg==;
Received: from [84.78.148.123] (helo=[192.168.1.105])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1o6FfI-00CFAj-EV; Tue, 28 Jun 2022 20:10:20 +0200
Message-ID: <b11ff46a-2e20-01b6-cbd9-2038b7bf4bc9@igalia.com>
Date:   Tue, 28 Jun 2022 20:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/2] UEFI panic notification mechanism
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20220520195028.1347426-1-gpiccoli@igalia.com>
 <d3dd4f45-1d50-2164-447b-d4f27ac6e133@igalia.com>
 <CAMj1kXFDqhvE3R4ckD32ftkb66CjHZcGPCF0OsX6bev2MmnorA@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXFDqhvE3R4ckD32ftkb66CjHZcGPCF0OsX6bev2MmnorA@mail.gmail.com>
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

On 28/06/2022 09:49, Ard Biesheuvel wrote:
> On Thu, 2 Jun 2022 at 19:40, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>>
>> Hi Ard, apologies for annoying!
>>
> 
> No worries, just very busy :-)
> 
>> Just a friendly ping asking if you have any opinions about these patches.
>>
> 
> Honestly, I'm not sure I see the value of this. You want to 'notify
> the UEFI firmware' but the firmware doesn't really care about these
> variables, only your bespoke tooling does. EFI pstore captures far
> more data, so if you just wipe /sys/fs/pstore after each clean boot,
> you already have all the data you need, no?
> 
> Also, I'm in the process of removing the public efivar_entry_xxx() API
> - please look at the efi/next tree for a peek. This is related to your
> point 3), i.e., the efivar layer is a disaster in terms of consistency
> between different observers of the EFI variable store. Switching to
> efivar_set_variable() [the new API] should fix that.

Hi Ard, thanks a lot for your review! Lemme split my points in some
bullets below:

a) What about patch 1, is it good as-is?


b) Cool about efivar_set_variable(), could fix that in V2.


c) Now, to the most relevant thing, the value of this. I might be
mistaken, but is there any known way to let UEFI know a panic happened?
For now, maybe only my UEFI fw might use that (and the usage is very
nice, showing a panic logo), but this opens a myriad of potential uses.
We can think in RAM preserving mechanism conditional to panic scenarios,
special resets for panic vs. cold boot, and even maybe a firmware vmcore
capturing.

If there is any other way to let UEFI know about a panic, let me know
and that will likely be more than enough for me. Otherwise, do you think
such small code would be a big burden to carry, considering the
cost/benefit for my use case?

Thanks in advance for your analysis.
Cheers,


Guilherme
