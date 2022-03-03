Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CED4CBF02
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 14:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiCCNnB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 08:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiCCNm6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 08:42:58 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D683D18A79E;
        Thu,  3 Mar 2022 05:42:12 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id C45D140D403D;
        Thu,  3 Mar 2022 13:42:07 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 03 Mar 2022 16:42:07 +0300
From:   baskov@ispras.ru
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 0/2] Handle UEFI NX-restricted page tables
In-Reply-To: <20220228183044.GA18400@srcf.ucam.org>
References: <20220224154330.26564-1-baskov@ispras.ru>
 <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
 <20220228183044.GA18400@srcf.ucam.org>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <9787f1c1948cc640e70a50e4b929f44f@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-02-28 21:30, Matthew Garrett wrote:
> On Mon, Feb 28, 2022 at 05:45:53PM +0100, Ard Biesheuvel wrote:
> 
>> Given that this is a workaround for a very specific issue arising on
>> PI based implementations of UEFI, I consider this a quirk, and so I
>> think this approach is reasonable. I'd still like to gate it on some
>> kind of identification, though - perhaps something related to DMI like
>> the x86 core kernel does as well.
> 
> When the V1 patches were reviewed, you suggested allocating
> EFI_LOADER_CODE rather than EFI_LOADER_DATA. The example given for a
> failure case is when NxMemoryProtectionPolicy is set to 0x7fd4, in 
> which
> case EFI_LOADER_CODE, EFI_BOOT_SERVICES_CODE and
> EFI_RUNTIEM_SERVICES_CODE should not have the nx policy applied. So it
> seems like your initial suggestion (s/LOADER_DATA/LOADER_CODE/) should
> have worked, even if there was disagreement about whether the spec
> required it to. Is this firmware applying a stricter policy?

Yes, this firmware is being modified to enforce stricter policy.

Also, the kernel still uses memory, that is not allocated via
EFI boot services, for trampoline placement in the first 640K of
address space, for which NX bit is also set.
The exact address for trampoline code is chosen only after
the EfiExitBootServices() call. And, I think, changing the
code in such way that trampoline is allocated beforehand will
touch more code paths.

Thanks,
Baskov Evgeniy
