Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E4645E07B
	for <lists+linux-efi@lfdr.de>; Thu, 25 Nov 2021 19:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhKYS0p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Nov 2021 13:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbhKYSYp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Nov 2021 13:24:45 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCC8C061377
        for <linux-efi@vger.kernel.org>; Thu, 25 Nov 2021 10:12:33 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y68so13951797ybe.1
        for <linux-efi@vger.kernel.org>; Thu, 25 Nov 2021 10:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k6C5uqkyNy2xtb3b3WbhQVmPCAI59RGmDlNE5qISUfA=;
        b=SKgHyqqq6L3BZ/v38ZxKpHG71u8LWeJFx6QrDi0+oCW1TAsKedhcY8ppMoOVMEYP/2
         WWQ0XhyHxuVUjtQ6bOM8LL92XhL+Br9bT/zft1i91EPR+g+Liy6LjqTEWb5e8CUkrhpb
         P+hayjy80LcuVB4PJqaCuobDWt/ZKJIvh7nbjp+j4bkM0mT5N8ZDScgbcENpuKa9nLPa
         MYTFA7UFB+sUosmbPOl1JT2SMTa82VXQgo6uRXfmLS2IdJLiiSiLMZwrwK1uY3/1ZGVl
         tHZhkBi0C9NICLgaDJ3vA/JSEHInOEwwJU9gmGhOhqR3FxeLWpNBWa8ARhZEDPO4kpkN
         fing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k6C5uqkyNy2xtb3b3WbhQVmPCAI59RGmDlNE5qISUfA=;
        b=zbitBE7cjyLbHotWd7AQw25D89IwZr4PeZi7hKVwW0/6lRGQHnwIgOj4XeAX3huNIw
         loqaWCj89S8ucKqhFN1xTXDdAU6ItsbzkkAO4GW9n6KUcDQ7DbxBiTztN6dcotFQByJH
         p0d2dkU7LKO9aBnXU/hrn0bf83foTb6JgjLLuPufP0D3aioZO+ij8lNzLrPRkBRdpbJl
         MCSFBB0fy2vbfIf1iDbpRENcHWUW30mQPqoL0sJYYRQ0u0bz6Kw2mMSLYp7dgnj1EOGP
         TDEJkV/XTcCV466oy2pPW4sYlsn7eco8pi4S4vDjoiPIefV+Obl5Jyx5QjgCKqPxh8ty
         7srg==
X-Gm-Message-State: AOAM532BUUhNFLyVqsX+ESkZGWcFEbcgqtwuIJq/vsCZBe78ss9Shrm/
        TQQPTM/I/0b08Vh64bZGJ0Uy0CbTRzQfG6l548g6XQ==
X-Google-Smtp-Source: ABdhPJw1j7TflN3fccVJLKaboY0VKuo8k/SaK1enpzeQtkrcfMAqmVHXQWAVGBGC4n9kwWmne4DNL4hXOA37jJTGwwc=
X-Received: by 2002:a25:3b4f:: with SMTP id i76mr8536738yba.217.1637863952639;
 Thu, 25 Nov 2021 10:12:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0d:c905:0:0:0:0:0 with HTTP; Thu, 25 Nov 2021 10:12:32
 -0800 (PST)
In-Reply-To: <68e2a4ef-2bc7-7fa5-e5bd-58759fa57820@linux.ibm.com>
References: <20211124203459.4578-1-martin.fernandez@eclypsium.com>
 <20211124203459.4578-4-martin.fernandez@eclypsium.com> <68e2a4ef-2bc7-7fa5-e5bd-58759fa57820@linux.ibm.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Thu, 25 Nov 2021 15:12:32 -0300
Message-ID: <CAKgze5ZpO+_rsXa0C2aBscUEYcAthtZKtW5iguAYasCX0g93fQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] x86/e820: Tag e820_entry with crypto capabilities
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/25/21, Dov Murik <dovmurik@linux.ibm.com> wrote:
> On 24/11/2021 22:34, Martin Fernandez wrote:
>> +extern u64  e820__range_mark_as_crypto(u64 start, u64 size);
>
> I suggest: e820__range_mark_as_crypto_capable
> (as you do in other function and field names)
>

Yes, good catch. Thanks.

>>  /* Remove a range of memory from the E820 table: */
>> @@ -573,6 +604,9 @@ u64 __init e820__range_remove(u64 start, u64 size,
>> enum e820_type old_type, bool
>>  		/* Is the new range completely covered? */
>>  		if (entry->addr < start && entry_end > end) {
>>  			e820__range_add(end, entry_end - end, entry->type);
>> +			if (entry->crypto_capable)
>> +				e820__range_mark_as_crypto(end, entry_end - end);
>> +
>
> Why introduce this new function call instead of adding an extra
> 'crypto_capable' argument to e820__range_add() ?

I thought about it, but I would like not to change the signature of
e820__range_add. Either way, here I could use __e820__range_add which
it does accept crypto_capable as an argument, just as I did in
e820__range_update.
