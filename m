Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDACF6060FB
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 15:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiJTNH3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 09:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiJTNH1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 09:07:27 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4171115DB03;
        Thu, 20 Oct 2022 06:07:24 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 885DD40D403D;
        Thu, 20 Oct 2022 13:07:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 885DD40D403D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666271239;
        bh=Fm3xulfEjrseVDMk6eOF4edzLS36E5lkjUcNbZAms6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yps6bo4xui0X6APcx20IjhqluRZUsPCmjPVkpw5gTEMQeLVLF30EAM634Mtp5wf98
         xnsVWJFV4VuQVP2379f1JWbvi6aAD41Ns1HnwmNTiMhVCkdG/IfqWRQgJ+tHTWJi1k
         xgr+KSa5Dtjp0wyjhb7MEA+dF+k4kyJvcMQlvURw=
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 16:07:19 +0300
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
Subject: Re: [PATCH 14/16] x86/build: Make generated PE more spec compliant
In-Reply-To: <CAMj1kXHeirfD07He4TDZepZr2HSXqwvDcuFG=iT8sgRA3t5-SQ@mail.gmail.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <f417e037d2967d9c1b387c63c66a7c050763a48c.1662459668.git.baskov@ispras.ru>
 <CAMj1kXHeirfD07He4TDZepZr2HSXqwvDcuFG=iT8sgRA3t5-SQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <9c9192e0509b696f46e559d447769b30@ispras.ru>
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

On 2022-10-19 10:39, Ard Biesheuvel wrote:
> On Tue, 6 Sept 2022 at 12:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Currently kernel image is not fully compliant PE image, so it may
>> fail to boot with stricter implementations of UEFI PE loaders.
>> 
>> Set minimal alignments and sizes specified by PE documentation [1]
>> referenced by UEFI specification [2]. Align PE header to 8 bytes.
> 
> 
>> Generate '.reloc' section with 2 entries and set reloc data directory.
> 
> Why?

It seems to me that I saw minimal size requirement in MS documentation,
but now I cannot find the proof of my words, so I've probably misread.
So I'll drop this change.
> 
> 
>> 
>> To make code more readable refactor tools/build.c:
>>         - Use mmap() to access kernel image.
>>         - Generate sections dynamically.
>>         - Setup sections protection. Since we cannot fit every
>>           needed section, set a part of protection flags
>>           dynamically during initialization. This step is omitted
>>           if CONFIG_EFI_DXE_MEM_ATTRIBUTES is not set.
>> 
> 
> If the commit log of a patch contains a bulleted list of the changes
> that it implements, it is a very strong indicator that it needs to be
> split up. Presenting this as a big ball of changes makes the life of a
> reviewed unnecessarily hard.
> 

Sorry for that, I'll try to separate this into several patches.
