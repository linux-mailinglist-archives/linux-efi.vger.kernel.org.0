Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B447D44E
	for <lists+linux-efi@lfdr.de>; Wed, 22 Dec 2021 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343731AbhLVPf1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Dec 2021 10:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343728AbhLVPf0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Dec 2021 10:35:26 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F133C061401
        for <linux-efi@vger.kernel.org>; Wed, 22 Dec 2021 07:35:26 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id y68so7851663ybe.1
        for <linux-efi@vger.kernel.org>; Wed, 22 Dec 2021 07:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cwnIm+Pjf1RTUBBb5BRinhHvVqdyboPG2JJubsE04f4=;
        b=AG9Ug8PUwm0BhJU9O/vGcCjhoBDHg4gQq1bWPDSXIgj2KDi7CkFNOOv/u74Em02wkD
         os3Dou1fSrFsMcV35l/mRKBXXmx4l863Jip4zBJa8a1TLFmnPbO9Jd0vgmU4/ml+SJp0
         AbJnXpaUOdNLQG66dPGZNaDsXdpZLZUvB9A0B+yi6pz2BuCXZlzfZ8wO435oxxb1nos/
         Dx2yzjDENAgI2RyCbAgtcM/VZf8vakzzP+L9t5KekKiQzZ51av9j06vf6w1T/JHM5hvF
         Zp2YTI+rfHAO5KSW55ReosawsBPaxV2ZuuMmlvYvVHoHFiD3BN6TNjHpq7MrA88jUiOJ
         sX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cwnIm+Pjf1RTUBBb5BRinhHvVqdyboPG2JJubsE04f4=;
        b=mKQz74Cnu8mnyPbQwT/XU5ls7yYFPpAqkgjARE62livCw2iFYVmMovLxTl+fUgee2i
         T7eKBcRNq4j9NY6a1dEfnDiMkOYKu8Wu0G3d9UKz+YqCIJUYrLVCM5KKshepplJmGPF6
         t1lZHvWKI4H+qTV6j5HOTTE+zGX6Mk5jaxo9xOgea8ij/ahTile5o7yNnKQ3/HHHkehW
         nneJQddrgjEi0X1ol2Uu99l7QADARQ/n4Q3urMRYrlW+259+VrfK74h89Bnc1co57j2E
         21MPqd11R0NkYSX3K6RSWEn7UEL5JUIlmxVMqFl6WdRhp0BpHzBxzSJclUfmYElR15KV
         H0Lg==
X-Gm-Message-State: AOAM531lVOfkpcUpnS1U788CDxtPF2+g+D0H5HazP82dzTjBZjywrlb/
        rpqXK8O5RoF26Q9vQPIn6sjfid0KIbL4sfaHrZDAFA==
X-Google-Smtp-Source: ABdhPJw7mITeuoygQFK1MhJbMGiGJKKDtAs86FI3UP7IrYs5kVS/hvOy/t4bTtqxhCrOxSYegmcjo3RH5D7EXfQqA5A=
X-Received: by 2002:a25:3c07:: with SMTP id j7mr5487832yba.612.1640187325665;
 Wed, 22 Dec 2021 07:35:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:58c2:0:0:0:0:0 with HTTP; Wed, 22 Dec 2021 07:35:25
 -0800 (PST)
In-Reply-To: <YcF3C9kfVoRqKamp@kroah.com>
References: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
 <20211216192222.127908-4-martin.fernandez@eclypsium.com> <YcCxUHSMnUJgXIJF@kroah.com>
 <CAKgze5boi5h08ffpodqsKp5xNS=+u_zJWEVnExdbsXRgJ+eCTQ@mail.gmail.com> <YcF3C9kfVoRqKamp@kroah.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Wed, 22 Dec 2021 12:35:25 -0300
Message-ID: <CAKgze5a2Nv56e=wJwmBjPgAf2x7waZWXGJ1YDk6_DK-ahShXTg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] x86/e820: Tag e820_entry with crypto capabilities
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        rafael@kernel.org, rppt@kernel.org, akpm@linux-foundation.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/21/21, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Dec 20, 2021 at 05:27:00PM -0300, Martin Fernandez wrote:
>> On 12/20/21, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Thu, Dec 16, 2021 at 04:22:20PM -0300, Martin Fernandez wrote:
>> >> diff --git a/arch/x86/include/asm/e820/types.h
>> >> b/arch/x86/include/asm/e820/types.h
>> >> index 314f75d886d0..7b510dffd3b9 100644
>> >> --- a/arch/x86/include/asm/e820/types.h
>> >> +++ b/arch/x86/include/asm/e820/types.h
>> >> @@ -56,6 +56,7 @@ struct e820_entry {
>> >>  	u64			addr;
>> >>  	u64			size;
>> >>  	enum e820_type		type;
>> >> +	u8			crypto_capable;
>> >
>> > Why isn't this a bool?
>>
>> It was a bool initially, but Andy Shevchenko told me that it couldn't
>> be that way because boolean may not be part of firmware ABIs.
>
> Where does this structure hit an "ABI"?  Looks internal to me.  If not,
> then something just broke anyway.
>

I prefer that Andy answers.

Either way, I think that the enum will be the best option.

>> >> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> >> index bc0657f0deed..001d64686938 100644
>> >> --- a/arch/x86/kernel/e820.c
>> >> +++ b/arch/x86/kernel/e820.c
>> >> @@ -163,7 +163,7 @@ int e820__get_entry_type(u64 start, u64 end)
>> >>  /*
>> >>   * Add a memory region to the kernel E820 map.
>> >>   */
>> >> -static void __init __e820__range_add(struct e820_table *table, u64
>> >> start,
>> >> u64 size, enum e820_type type)
>> >> +static void __init __e820__range_add(struct e820_table *table, u64
>> >> start,
>> >> u64 size, enum e820_type type, u8 crypto_capable)
>> >
>> > Horrid api change, but it's internal to this file so oh well :(
>> >
>> > Hint, don't add flags to functions like this, it forces you to have to
>> > always remember what those flags are when you read the code.  Right now
>> > you stuck "0" and "1" in the function call, which is not instructional
>> > at all.
>> >
>> > Heck, why not make it an enum to have it be self-describing?  Like the
>> > type is here.  that would make it much better and easier to understand
>> > and maintain over time.
>> >
>>
>> Yes, an enum will absolutely improve things. I'll do that.
>>
>> >> @@ -327,6 +330,7 @@ int __init e820__update_table(struct e820_table
>> >> *table)
>> >>  	unsigned long long last_addr;
>> >>  	u32 new_nr_entries, overlap_entries;
>> >>  	u32 i, chg_idx, chg_nr;
>> >> +	u8 current_crypto, last_crypto;
>> >>
>> >>  	/* If there's only one memory region, don't bother: */
>> >>  	if (table->nr_entries < 2)
>> >> @@ -367,6 +371,7 @@ int __init e820__update_table(struct e820_table
>> >> *table)
>> >>  	new_nr_entries = 0;	 /* Index for creating new map entries */
>> >>  	last_type = 0;		 /* Start with undefined memory type */
>> >>  	last_addr = 0;		 /* Start with 0 as last starting address */
>> >> +	last_crypto = 0;
>> >>
>> >>  	/* Loop through change-points, determining effect on the new map: */
>> >>  	for (chg_idx = 0; chg_idx < chg_nr; chg_idx++) {
>> >> @@ -388,13 +393,17 @@ int __init e820__update_table(struct e820_table
>> >> *table)
>> >>  		 * 1=usable, 2,3,4,4+=unusable)
>> >>  		 */
>> >>  		current_type = 0;
>> >> +		current_crypto = 1;
>> >>  		for (i = 0; i < overlap_entries; i++) {
>> >> +			current_crypto = current_crypto &&
>> >> overlap_list[i]->crypto_capable;
>> >
>> > Is it a u8 or not?  You treat it as a boolean a lot :(
>> >
>> >>  			if (overlap_list[i]->type > current_type)
>> >>  				current_type = overlap_list[i]->type;
>> >>  		}
>> >>
>> >>  		/* Continue building up new map based on this information: */
>> >> -		if (current_type != last_type || e820_nomerge(current_type)) {
>> >> +		if (current_type != last_type ||
>> >> +		    current_crypto != last_crypto ||
>> >> +		    e820_nomerge(current_type)) {
>> >
>> > Why check it before calling e820_nomerge()?  Is that required?
>> >
>>
>> I don't see how the order of the checks matter, am I missing something?
>
> It might prevent this function from being called now when it previously
> was.  Is that ok?
>

Oh I see. No, that's not a problem. That if guard is to decide if you
need to start/close a region. e820_nomerge is to prevent merging
certain region types. In any case, the new check will cause less
merging, complying with what e820_nomerge says.
