Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B075503557
	for <lists+linux-efi@lfdr.de>; Sat, 16 Apr 2022 10:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiDPIuz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 Apr 2022 04:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiDPIuy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 Apr 2022 04:50:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00549D9E8B;
        Sat, 16 Apr 2022 01:48:21 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2B92A2CC;
        Sat, 16 Apr 2022 08:48:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2B92A2CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650098901; bh=wL3NkiIKFRdID28VPA7Y7koeQlHQ1FfnpEFD9gBGabE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IuQQnXtH7YOY0hKaNn75/nwtHB8ScUrzlWYrQ9//YLDGKrwYtXAmDDHbkZqbF2dtJ
         VxyHvnRSWGdKgiQKkkriH1W5clEMFgmn05MHwn3NxfkC+C2jEW8CsI2jQdAr4LowxB
         PHaa/sxgo1jH0YXwNBH+xV1sMuPaxBEYgnmP69BWWqFHb2qeEpLRvosQ060MJEY2Ri
         1Fypoean6uBLsIgIkv+hiEmxvJWF9I3F+3aiOmbbx46Ur4z8ROaBrGBeFBZTEdwrcl
         iM4hxInGzLf8q9fNgBkK/8DT9FgGi16RJJpUSzkzBlRz6TPEQWfS587+y8zJE5tJsV
         x9N5q+hAG8CGw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Akihiko Odaki <akihiko.odaki@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/efi: Remove references of EFI earlyprintk from
 documentation
In-Reply-To: <CAMj1kXGHQm7yy2QPCEVRiXBzb8HWOHzKMCuoS+mbnBKujEXQnA@mail.gmail.com>
References: <20220321045853.3324-1-akihiko.odaki@gmail.com>
 <87bkxfebsu.fsf@meer.lwn.net>
 <CAMj1kXGHQm7yy2QPCEVRiXBzb8HWOHzKMCuoS+mbnBKujEXQnA@mail.gmail.com>
Date:   Sat, 16 Apr 2022 02:48:17 -0600
Message-ID: <87v8v92z3i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ard Biesheuvel <ardb@kernel.org> writes:

> On Tue, 5 Apr 2022 at 18:26, Jonathan Corbet <corbet@lwn.net> wrote:
>>
>> Akihiko Odaki <akihiko.odaki@gmail.com> writes:
>>
>> > x86 EFI earlyprink was removed with commit 69c1f396f25b ("efi/x86:
>> > Convert x86 EFI earlyprintk into generic earlycon implementation").
>>
>> So I will confess that I don't know this area well enough to know
>> whether this patch makes sense or not.  To help with that, it would have
>> been good to CC Ard, who is the author of the patch you cite above.
>> Adding him now.
>>
>> Ard, do you agree with this change (preserved below)?
>>
>
> Yes, it looks fine to me.
>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Great.  Applied, thanks.

jon
