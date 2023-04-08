Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E69F6DBBB5
	for <lists+linux-efi@lfdr.de>; Sat,  8 Apr 2023 17:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDHPD2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Apr 2023 11:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDHPD1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Apr 2023 11:03:27 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133CCBDD9;
        Sat,  8 Apr 2023 08:03:23 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id B399144C1018;
        Sat,  8 Apr 2023 15:03:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B399144C1018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1680966200;
        bh=t1fiAMRSQhtjcs8sVxjX6AYa5QPz2gjw1esPovs3cBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LmuvIOak/kR6GTg1EiNJXRG0Ssbm5A0mWma2jI0ID1tEG9ZWf7V/vs+H5ObNHZqYE
         PVv8aejVaH+Expty948yBeYI688dHCrEGtbbXKa6ua84bEEdf5oA6gokf0ny3HGXpW
         vkpOz/ChfBll2umS83d7obn9usI2thUidpyobKQ4=
MIME-Version: 1.0
Date:   Sat, 08 Apr 2023 18:03:20 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 01/27] x86/boot: Align vmlinuz sections on page size
In-Reply-To: <20230405171333.GDZC2sPc3D7rDdK6TH@fat_crate.local>
References: <cover.1678785672.git.baskov@ispras.ru>
 <159597c484778da5e59c3a5728669f131f800b5a.1678785672.git.baskov@ispras.ru>
 <20230405171333.GDZC2sPc3D7rDdK6TH@fat_crate.local>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <de70f11174e8f8e294071b70542e23f5@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-04-05 20:13, Borislav Petkov wrote:

Sorry for delayed reply.

> On Tue, Mar 14, 2023 at 01:13:28PM +0300, Evgeniy Baskov wrote:
>> To protect sections on page table level each section needs to be
>> aligned on page size (4KB).
> 
> Protect against what?

Protect against invalid memory accesses, mainly caused by bugs, I guess.
I meant just applying tight memory attributes, sorry for the
bad wording. I will change it in the next version.

> 
>> Set sections alignment in linker script for the kernel decompressor
>> (boot/compressed/vmlinux.lds.S).
> 
> Do not talk about *what* the patch is doing in the commit message - 
> that
> should be obvious from the diff itself. Rather, concentrate on the 
> *why*
> it needs to be done.

Makes sense. I'll try to improve it before resubmitting.

> 
>> Also introduce symbols that can be used to reference compressed
>> kernel blob section later in the later patches.
> 
> Introduce those with the respective patch that uses them. This one is
> adding section alignment only and that's all that it should do.

Oh, good point, will do.

> 
> Thx.

Thanks,
Evgeniy Baskov
