Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A6F510591
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 19:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiDZRk7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiDZRk7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 13:40:59 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF28712D940
        for <linux-efi@vger.kernel.org>; Tue, 26 Apr 2022 10:37:50 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id w187so24881342ybe.2
        for <linux-efi@vger.kernel.org>; Tue, 26 Apr 2022 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tH/YgBif6d6yzwmumvRLfWV+AljH646yqRcC2C5Xmag=;
        b=El35gwLQGL+3kGJERF8gp0inRfDgb8jqvTTV/IGHhywPc7DF/bR5K5hk5LRBmn1uqL
         vGL5Go4qrIdBIKDY8qV3+z0bU1A1YLWT/DGoTiV8/NEKbUTdllXwl4YUrLR5cDoSNiix
         5BzO3+o/yqTvkpGlQY7PjxOnAsG7WJJcl0Gcbc1k0C4vcro8NNETJPFo+773PN0ej84I
         tAcTq/yj0TWaXXih9rfMtTD+Cza2WtiLwjJjP25UximL75DGVuC/RNDWBH753+8WnBvl
         Ed7gzIkSgtuYjGN5NS5T+PNWhUGjiUbr2uPDA3lVTxp+/SiawFEhTZJTa5VOUnz4toOV
         yGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tH/YgBif6d6yzwmumvRLfWV+AljH646yqRcC2C5Xmag=;
        b=x2/7R4SyByOEJvtSb6oGQguGD+/vRKCeeWjXBhDEXo7lptLFwYuwy3oRC8XOCZfDhz
         SwDWvhap9As0jxgXLFzlF/exF+Y2T8l+D4ksJs5lq/QxkUMmeuH2p5tYMMIHj2dTPk7Q
         8K7ijfiErqaLT8kivkRMx7jK+VfX18K1sOyG1aFMQPk9qgGNFjy97i+4ap84PoNfzokZ
         mKCNqDuzKs+uKNdjG2uXjZxcocJ6JGwmN717cNJ3Uo0wR9a+g9/wfUTyspAMLpB+Eg/E
         +cNYVat71mUTmsHbYATVvb5np9wLiA1+vlho82uyuUv/lr/tCOxyH1+mCOAtMfKfgMc2
         3W6g==
X-Gm-Message-State: AOAM530uSRklYr1BgB+lv5biDe4Mp/0XIcE+r2EN6HFxdQ5rg5lAqw62
        KapwYeJ58dVN+aUK/roiXQg6EXA0O5oS1T8E2rbFpoXofxY=
X-Google-Smtp-Source: ABdhPJz1HJ1Wqfc/OMXGlEWodjJTdhl+j6KWkOff8Bx0FMZco18xRQS2BiQyyC+zw/RofYtnfxABe28XP3iE3H3aNyo=
X-Received: by 2002:a05:6902:150c:b0:648:94be:2c7e with SMTP id
 q12-20020a056902150c00b0064894be2c7emr7100545ybu.601.1650994670167; Tue, 26
 Apr 2022 10:37:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:10a:0:0:0:0:0 with HTTP; Tue, 26 Apr 2022 10:37:49 -0700 (PDT)
In-Reply-To: <a02186b9-b72c-1484-2973-c59272ae0a7e@intel.com>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
 <20220425171526.44925-6-martin.fernandez@eclypsium.com> <a02186b9-b72c-1484-2973-c59272ae0a7e@intel.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 26 Apr 2022 14:37:49 -0300
Message-ID: <CAKgze5Y1bKUAqPHEY71y_puTmuV2K02qjt0qzwO-KA3SYio0Tw@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] x86/e820: Refactor e820__range_remove
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/26/22, Dave Hansen <dave.hansen@intel.com> wrote:
> On 4/25/22 10:15, Martin Fernandez wrote:
>> +/**
>> + * e820__range_remove() - Remove an address range from e820_table.
>> + * @start: Start of the address range.
>> + * @size: Size of the address range.
>> + * @old_type: Type of the entries that we want to remove.
>> + * @check_type: Bool to decide if ignore @old_type or not.
>> + *
>> + * Remove [@start, @start + @size) from e820_table. If @check_type is
>> + * true remove only entries with type @old_type.
>> + *
>> + * Return: The size removed.
>> + */
>
> The refactoring looks promising.  But, there's a *LOT* of kerneldoc
> noise, like:
>
>> + * @table: Target e820_table.
>> + * @start: Start of the range.
>> + * @size: Size of the range.
>
> and this:
>
>> + * struct e820_type_updater_data - Helper type for
>> + * __e820__range_update().
>> + * @old_type: old_type parameter of __e820__range_update().
>> + * @new_type: new_type parameter of __e820__range_update().
>
> Those are just a pure waste of bytes.  I suspect some more judicious
> function comments would also make the diffstat look more palatable.
>

I can get rid off of the kerneldocs and just put normal comments for some
functions that really need them.

> Also, in general, the naming is a bit verbose.  You might want to trim
> some of those names down, like:
>
>> +static bool __init crypto_updater__should_update(const struct e820_entry
>> *entry,
>> +						 const void *data)
>> +{
>> +	const struct e820_crypto_updater_data *crypto_updater_data =
>> +		(const struct e820_crypto_updater_data *)data;
>

Yes I agree on this. Do you have any suggestions for these kind of
functions? I want to explicitly state that these functions are in some of
namespace and are different of the other ones.

In the end I don't think this is very harmful since these functions are one-time
used (in a single place), is not the case that you have to use them everywhere..

> Those are just some high-level comments.  This also needs some really
> careful review of the refactoring to make sure that it doesn't break any
> of the existing e820 users.
>

I'm glad to hear more people's thoughts on this. Thanks for the feedback.
