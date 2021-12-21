Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D766F47BA18
	for <lists+linux-efi@lfdr.de>; Tue, 21 Dec 2021 07:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhLUGlU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Dec 2021 01:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhLUGlU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Dec 2021 01:41:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A36DC061574;
        Mon, 20 Dec 2021 22:41:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7748B811BC;
        Tue, 21 Dec 2021 06:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF834C36AE7;
        Tue, 21 Dec 2021 06:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640068877;
        bh=ylv71IjLQIClbad2LwfXZJJ7QyLDq1p0XqsAvIfjF0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHJOk3sLAlFO7TaKjGyzKiY0cn6b7FUC2krnWAIRaPlVdE30eujy5kqtZvXwZM4j9
         x1m6PDM73EQaCKeFPtatH5b5fcnpEmc1cm7U+fLUW48b9eNEqZAaUUkSYMc2Qeqkk5
         uD7KEfIsnrosa6gkKzFyUOG/oUDmqEUxiS+ljIU0=
Date:   Tue, 21 Dec 2021 07:41:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        rafael@kernel.org, rppt@kernel.org, akpm@linux-foundation.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Subject: Re: [PATCH v4 3/5] x86/e820: Tag e820_entry with crypto capabilities
Message-ID: <YcF3C9kfVoRqKamp@kroah.com>
References: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
 <20211216192222.127908-4-martin.fernandez@eclypsium.com>
 <YcCxUHSMnUJgXIJF@kroah.com>
 <CAKgze5boi5h08ffpodqsKp5xNS=+u_zJWEVnExdbsXRgJ+eCTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgze5boi5h08ffpodqsKp5xNS=+u_zJWEVnExdbsXRgJ+eCTQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 20, 2021 at 05:27:00PM -0300, Martin Fernandez wrote:
> On 12/20/21, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Thu, Dec 16, 2021 at 04:22:20PM -0300, Martin Fernandez wrote:
> >> diff --git a/arch/x86/include/asm/e820/types.h
> >> b/arch/x86/include/asm/e820/types.h
> >> index 314f75d886d0..7b510dffd3b9 100644
> >> --- a/arch/x86/include/asm/e820/types.h
> >> +++ b/arch/x86/include/asm/e820/types.h
> >> @@ -56,6 +56,7 @@ struct e820_entry {
> >>  	u64			addr;
> >>  	u64			size;
> >>  	enum e820_type		type;
> >> +	u8			crypto_capable;
> >
> > Why isn't this a bool?
> 
> It was a bool initially, but Andy Shevchenko told me that it couldn't
> be that way because boolean may not be part of firmware ABIs.

Where does this structure hit an "ABI"?  Looks internal to me.  If not,
then something just broke anyway.

> >> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> >> index bc0657f0deed..001d64686938 100644
> >> --- a/arch/x86/kernel/e820.c
> >> +++ b/arch/x86/kernel/e820.c
> >> @@ -163,7 +163,7 @@ int e820__get_entry_type(u64 start, u64 end)
> >>  /*
> >>   * Add a memory region to the kernel E820 map.
> >>   */
> >> -static void __init __e820__range_add(struct e820_table *table, u64 start,
> >> u64 size, enum e820_type type)
> >> +static void __init __e820__range_add(struct e820_table *table, u64 start,
> >> u64 size, enum e820_type type, u8 crypto_capable)
> >
> > Horrid api change, but it's internal to this file so oh well :(
> >
> > Hint, don't add flags to functions like this, it forces you to have to
> > always remember what those flags are when you read the code.  Right now
> > you stuck "0" and "1" in the function call, which is not instructional
> > at all.
> >
> > Heck, why not make it an enum to have it be self-describing?  Like the
> > type is here.  that would make it much better and easier to understand
> > and maintain over time.
> >
> 
> Yes, an enum will absolutely improve things. I'll do that.
> 
> >> @@ -327,6 +330,7 @@ int __init e820__update_table(struct e820_table
> >> *table)
> >>  	unsigned long long last_addr;
> >>  	u32 new_nr_entries, overlap_entries;
> >>  	u32 i, chg_idx, chg_nr;
> >> +	u8 current_crypto, last_crypto;
> >>
> >>  	/* If there's only one memory region, don't bother: */
> >>  	if (table->nr_entries < 2)
> >> @@ -367,6 +371,7 @@ int __init e820__update_table(struct e820_table
> >> *table)
> >>  	new_nr_entries = 0;	 /* Index for creating new map entries */
> >>  	last_type = 0;		 /* Start with undefined memory type */
> >>  	last_addr = 0;		 /* Start with 0 as last starting address */
> >> +	last_crypto = 0;
> >>
> >>  	/* Loop through change-points, determining effect on the new map: */
> >>  	for (chg_idx = 0; chg_idx < chg_nr; chg_idx++) {
> >> @@ -388,13 +393,17 @@ int __init e820__update_table(struct e820_table
> >> *table)
> >>  		 * 1=usable, 2,3,4,4+=unusable)
> >>  		 */
> >>  		current_type = 0;
> >> +		current_crypto = 1;
> >>  		for (i = 0; i < overlap_entries; i++) {
> >> +			current_crypto = current_crypto && overlap_list[i]->crypto_capable;
> >
> > Is it a u8 or not?  You treat it as a boolean a lot :(
> >
> >>  			if (overlap_list[i]->type > current_type)
> >>  				current_type = overlap_list[i]->type;
> >>  		}
> >>
> >>  		/* Continue building up new map based on this information: */
> >> -		if (current_type != last_type || e820_nomerge(current_type)) {
> >> +		if (current_type != last_type ||
> >> +		    current_crypto != last_crypto ||
> >> +		    e820_nomerge(current_type)) {
> >
> > Why check it before calling e820_nomerge()?  Is that required?
> >
> 
> I don't see how the order of the checks matter, am I missing something?

It might prevent this function from being called now when it previously
was.  Is that ok?

thanks,

greg k-h
