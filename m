Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83DE605E6F
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 13:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiJTLFo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 07:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiJTLFm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 07:05:42 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ED011F4BC;
        Thu, 20 Oct 2022 04:05:31 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0A0B040D403D;
        Thu, 20 Oct 2022 11:05:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0A0B040D403D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666263928;
        bh=5nyZu9zbyZQkn1yMUyXsSQkh3IfzDySokwqJAcsKRCg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f3sXzuOR1nPhHEECi3o557B2M3QIspwU3OGXzVqGInFdxo605ltEoce4HANMYSMmM
         lT8OCKc1DicmXiXZG7CJVTJAJWpuDWPT1WVtw7hEkliT/UEPK07Txy1JzMIKL0Vo7n
         I/Zow9hRC77Wmwne4UyL4b0oRNg1lInSfI0/5Zqg=
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 14:05:27 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Peter Jones <pjones@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/16] x86_64: Improvements at compressed kernel stage
In-Reply-To: <20221018210447.sg3tddaujre6orgc@redhat.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <20221018210447.sg3tddaujre6orgc@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <a2aa9cf7f04a33080269ad351e81bafa@ispras.ru>
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

On 2022-10-19 00:04, Peter Jones wrote:
> On Tue, Sep 06, 2022 at 01:41:04PM +0300, Evgeniy Baskov wrote:
>> This patchset is aimed
>> * to improve UEFI compatibility of compressed kernel code for x86_64
>> * to setup proper memory access attributes for code and rodata 
>> sections
>> * to implement W^X protection policy throughout the whole execution
>>   of compressed kernel for EFISTUB code path.
> 
> Hi Evgeniy,
> 
> I've tested this set of patches with the Mu firmware that supports the 
> W^X
> feature and a modified bootloader to also support it, and also with an
> existing firmware and the grub2 build in fedora 36.  On the firmware
> without W^X support, this all works for me.  With W^X support, it works
> so long as I use CONFIG_EFI_STUB_EXTRACT_DIRECT, though I still need
> some changes in grub's loader.  IMO that's a big step forward.
> 
> I can't currently make it work with W^X enabled but without direct
> extraction, and I'm still investigating why not, but I figured I'd give
> you a heads up.

Hi Peter,

Thank you for testing!

Without direct extraction enabled this patch set does not implement 
total W^X
and needs to allocate RWX memory regions, since it should go through 
common
code path that relocates kernel. So if the firmware does not allow 
allocating
RWX regions, it might prevent the kernel from booting, I think. I will 
look
into that problem soon and let you know it I find anything.

Thanks,
Evgeniy Baskov
