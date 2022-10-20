Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B74605FC6
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJTMKw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 08:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJTMKu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 08:10:50 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CAC114DF5;
        Thu, 20 Oct 2022 05:10:47 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 9E21C419E9CC;
        Thu, 20 Oct 2022 12:10:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9E21C419E9CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666267845;
        bh=qeYD9cbarvWNZmLV47q82H3noKNX8HJcybkzKWDNm5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=plTmaq2eJY8V20R9/dtzGjcnBpOp78CU/1JPlKFv4UDm8EX7JMA5Kjg/MOh8uoO10
         m7iYJgsdkSo9jzTx8+I7wq1Zk/9lEvMq8ZT5hsBywxnDRrpY9drHm3i3yXkzz8hAQS
         biHiGqAKVq8xjItOrIMg+KZcFCaWPquPR65hA5pQ=
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 15:10:45 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 10/16] x86/boot: Make console interface more abstract
In-Reply-To: <CAMj1kXE5g7=CuHvEj0Z4F9Y91W-5K0OzorC_Z1-JL-vvc9kksQ@mail.gmail.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <7a4b8d6827503ae0e30745014504c72f0c5d6316.1662459668.git.baskov@ispras.ru>
 <CAMj1kXE5g7=CuHvEj0Z4F9Y91W-5K0OzorC_Z1-JL-vvc9kksQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <3397e4295c9a1d5ffcd311027dd3b933@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-10-19 10:23, Ard Biesheuvel wrote:
> On Tue, 6 Sept 2022 at 12:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> To be able to extract kernel from EFI, console output functions
>> need to be replaceable by alternative implementations.
>> 
>> Make all of those functions pointers.
>> Move serial console code to separate file.
>> 
> 
> What does kernel_add_identity_map() have to do with the above? Should
> that be a separate patch?

It used to be dependent, but no longer is.
I'll split making kernel_add_identity_map() a function pointer
out into separate patch.

> 
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> ---
>>  arch/x86/boot/compressed/Makefile       |   2 +-
>>  arch/x86/boot/compressed/ident_map_64.c |  15 ++-
>>  arch/x86/boot/compressed/misc.c         | 109 +--------------------
>>  arch/x86/boot/compressed/misc.h         |  13 ++-
>>  arch/x86/boot/compressed/putstr.c       | 124 
>> ++++++++++++++++++++++++
>>  5 files changed, 146 insertions(+), 117 deletions(-)
>>  create mode 100644 arch/x86/boot/compressed/putstr.c
...
