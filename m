Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E599A4E6727
	for <lists+linux-efi@lfdr.de>; Thu, 24 Mar 2022 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344481AbiCXQl1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Mar 2022 12:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiCXQl1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Mar 2022 12:41:27 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9410F580C7;
        Thu, 24 Mar 2022 09:39:54 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id A606C40FDC14;
        Thu, 24 Mar 2022 16:39:47 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 24 Mar 2022 19:39:47 +0300
From:   baskov@ispras.ru
To:     ardb@kernel.org
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pjones@redhat.com
Subject: Re: [PATCH RFC v2 0/2] Handle UEFI NX-restricted page tables
In-Reply-To: <20220318163739.5doimyda5e3kdcef@redhat.com>
References: <20220224154330.26564-1-baskov@ispras.ru>
 <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
 <20220228183044.GA18400@srcf.ucam.org>
 <9787f1c1948cc640e70a50e4b929f44f@ispras.ru>
 <20220303204759.GA20294@srcf.ucam.org>
 <20220318163739.5doimyda5e3kdcef@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <20e2f5b9ab008b12f14e763127f5ca1b@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DOS_RCVD_IP_TWICE_B,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-03-18 19:37, Peter Jones wrote:
> On Thu, Mar 03, 2022 at 08:47:59PM +0000, Matthew Garrett wrote:
>> On Thu, Mar 03, 2022 at 04:42:07PM +0300, baskov@ispras.ru wrote:
>> > On 2022-02-28 21:30, Matthew Garrett wrote:
>> > > On Mon, Feb 28, 2022 at 05:45:53PM +0100, Ard Biesheuvel wrote:
>> > >
>> > > > Given that this is a workaround for a very specific issue arising on
>> > > > PI based implementations of UEFI, I consider this a quirk, and so I
>> > > > think this approach is reasonable. I'd still like to gate it on some
>> > > > kind of identification, though - perhaps something related to DMI like
>> > > > the x86 core kernel does as well.
>> > >
>> > > When the V1 patches were reviewed, you suggested allocating
>> > > EFI_LOADER_CODE rather than EFI_LOADER_DATA. The example given for a
>> > > failure case is when NxMemoryProtectionPolicy is set to 0x7fd4, in which
>> > > case EFI_LOADER_CODE, EFI_BOOT_SERVICES_CODE and
>> > > EFI_RUNTIEM_SERVICES_CODE should not have the nx policy applied. So it
>> > > seems like your initial suggestion (s/LOADER_DATA/LOADER_CODE/) should
>> > > have worked, even if there was disagreement about whether the spec
>> > > required it to. Is this firmware applying a stricter policy?
>> >
>> > Yes, this firmware is being modified to enforce stricter policy.
>> 
>> Ok. I think this should really go through the UEFI spec process - I
>> agree that from a strict interpretation of the spec, what this 
>> firmware
>> is doing is legitimate, but I don't like having a situation where we
>> have to depend on the DXE spec.
> 
> It's in the process of getting into the UEFI spec now as
> https://bugzilla.tianocore.org/show_bug.cgi?id=3519 .
> 
>> How does Windows handle this? Just update the page tables itself for 
>> any
>> regions it needs during boot?
> 
> Microsoft's bootloader sets up its own pagetables, though I believe
> they're switching it to use the (soon to be) standardized API.

The third version of the patch is the most close in structure
to the proposed protocol. And until the protocol is standardized and
implemented on problematic firmware, I think, it remains the better
solution in terms of simplicity and further porting to the new
protocol.

It is desirable to get the issue resolved, and make the kernel stricter
comply to the spec, without waiting for the new API implementation.
And later, switch the kernel to be using the protocol with
subsequent patches as soon as it gets usable.

So, is there a chance for these patches to be accepted in current
form, or with some modifications?

Thanks,
Baskov Evgeniy


