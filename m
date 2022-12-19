Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5F0650D07
	for <lists+linux-efi@lfdr.de>; Mon, 19 Dec 2022 15:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiLSOIg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Dec 2022 09:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiLSOIf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Dec 2022 09:08:35 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB49DE0A2;
        Mon, 19 Dec 2022 06:08:34 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 010C8419E9D7;
        Mon, 19 Dec 2022 14:08:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 010C8419E9D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1671458911;
        bh=cOvrBGL1daGiSnbPOu9jOYiOu8Dbls2LR4IVVeA1Mdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rkcxKyjlJFXPVmBNanyCv8CLsiTYqn329Vipy8bn0WMX93g/yGgg2AqeOhv+nGEgM
         iqrP572TJTOxMH9D3vLaRXNnFMdBi+LkqTONSXdshHyUQaIiS1ITcoRywpa+O/BKoQ
         VvCo+QHdHrDYcX0DO2yqqabH02Utpfh0a98gcYSU=
MIME-Version: 1.0
Date:   Mon, 19 Dec 2022 17:08:30 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Peter Jones <pjones@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 00/26] x86_64: Improvements at compressed kernel stage
In-Reply-To: <20221215192154.fuu47gsultcqd3wh@redhat.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <20221215192154.fuu47gsultcqd3wh@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <9b3c3314e4eeabc642409f5e6ff19c2a@ispras.ru>
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

On 2022-12-15 22:21, Peter Jones wrote:
> On Thu, Dec 15, 2022 at 03:37:51PM +0300, Evgeniy Baskov wrote:
>> This patchset is aimed
>> * to improve UEFI compatibility of compressed kernel code for x86_64
>> * to setup proper memory access attributes for code and rodata 
>> sections
>> * to implement W^X protection policy throughout the whole execution
>>   of compressed kernel for EFISTUB code path.
> 
> Hi Evgeniy,
> 
> Aside from some minor patch fuzz in patch 6 due to building this in
> today's Fedora rawhide kernel rather than mainline, this patch set 
> works
> for me.
> 
> Thanks!

Nice to hear that, thank you for testing again!
