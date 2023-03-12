Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099016B65DD
	for <lists+linux-efi@lfdr.de>; Sun, 12 Mar 2023 13:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCLMKz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 12 Mar 2023 08:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCLMKk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 12 Mar 2023 08:10:40 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DE87DBA;
        Sun, 12 Mar 2023 05:10:39 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id E9C4E44C1026;
        Sun, 12 Mar 2023 12:10:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E9C4E44C1026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678623038;
        bh=4qoX9n/L8Phc5k4mKmrmAxLep0XMV0xtLDWTM61Mlqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QRHP699+QFrJElbcWoftLhs2cvD23uikMW1UpMIhWYBfmUoIfqZjJhGeuMUOI/mxc
         6iXcu4YVfVmhpwlNXynLSgJ0RaNXNMGsZ/jM33VhCYSPXMoOYvBlLsZqZb7sOQeqNe
         XPguW3SFzH7ydZ0xBfTtG7Ys+qdyLTppKBJ1qltw=
MIME-Version: 1.0
Date:   Sun, 12 Mar 2023 15:10:37 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 17/26] x86/boot: Reduce size of the DOS stub
In-Reply-To: <CAMj1kXEySE_GuNx+xLPu9pvkZoA6Sph=7BZt-gzVCi4pD1COPA@mail.gmail.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <cb62472011a0c4151276b6a05b83b60b1bf6f352.1671098103.git.baskov@ispras.ru>
 <CAMj1kXHnQZ2EDg1F_whTPHajYvqox7Ss35aqUyJuC8RLyiuCxg@mail.gmail.com>
 <ec07e6f7af7b901ad3ff1aa9a8c8fbcb@ispras.ru>
 <CAMj1kXEySE_GuNx+xLPu9pvkZoA6Sph=7BZt-gzVCi4pD1COPA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <1df46f0fa7a2643d2d6ecf7262b61eea@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-03-11 20:27, Ard Biesheuvel wrote:
> On Sat, 11 Mar 2023 at 15:49, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> On 2023-03-10 17:59, Ard Biesheuvel wrote:
>> > On Thu, 15 Dec 2022 at 13:40, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> >>
>> >> This is required to fit more sections in PE section tables,
>> >> since its size is restricted by zero page located at specific offset
>> >> after the PE header.
>> >>
>> >> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> >> Tested-by: Peter Jones <pjones@redhat.com>
>> >> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> >
>> > I'd prefer to rip this out altogether.
>> >
>> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=9510f6f04f579b9a3f54ad762c75ab2d905e37d8
>> 
>> Sounds great! Can I replace this patch with yours in v5?
>> 
> 
> Of course.
> 
>> >
>> > (and refer to the other thread in linux-efi@)
>> 
>> Which thread exactly? The one about the removal of
>> real-mode code?
>> 
> 
> Yes, this one
> 
> https://lore.kernel.org/linux-efi/20230308202209.2980947-1-ardb@kernel.org/

Thanks!
