Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F854A8B85
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 19:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353400AbiBCSYb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 13:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbiBCSYa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Feb 2022 13:24:30 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E62AC061714
        for <linux-efi@vger.kernel.org>; Thu,  3 Feb 2022 10:24:30 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id r65so11469028ybc.11
        for <linux-efi@vger.kernel.org>; Thu, 03 Feb 2022 10:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1fRhWHaiX3rkmKEuOvxk4MdWU+5ch329S/1ViDgbzuQ=;
        b=KX8rWrzrI4SmeeXMyhAJN94FJ/BtvuLWK+a+fEtNaIBeSUb/nXfmIj+MN9RQ0o7+mQ
         SwQe77+rarjoaurkLkwjWstN1NWmV+xd9D3Wn3XvJSyJukBCZpXcmD/HDqOwApqaTAak
         XGNvn02OrLI5jDtuy9UljW7DOLBN7KMgFEyXf/gf/4VpE4WqqiBa3B4q9wF3v5tDvzFs
         AqHfqKsKQt/6eF0lcKT5E8BYQjGIkPqsswV9TXkfHqhy55m1gPO5L0xwD4gXLybdIrfq
         zJUjnTeaQQUUkGj6vSUElVHZzCuVzQxX9ETcx+/12BQY9watxH97OYFpCpLkWbPlIgZz
         tXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1fRhWHaiX3rkmKEuOvxk4MdWU+5ch329S/1ViDgbzuQ=;
        b=DEFf1hQjWZYTGru+5L93S0vcntf5yKwyR4rOYyvG/SWudFe4PeUmuNvbItMpgitvoo
         9ngLnZq0YfyOY7tz1LDdalQvOGkxRlzZq83QVnqglPmR8CQDnu8w5gKXAtcYshyFQy0+
         JXW5ZAIaA8IPJ7Uh0CWCqEsmGETMDU2mpYTlXR8f9BfA6GltcvcP+LQaBThPrWYt3g55
         ff9RSEkk0XxQKXQ/1JIL3YFGMo0UVNwBr+bVS/eP1Lslv3VCWEEbTCXz1tgAsswoT2Gp
         Wxnn6i6BugLigQqjjB1P9bCwCUaZFMzX7P54dA24MXrJTC2+ZBOap4TvqqnLfXVW9P7U
         MVrw==
X-Gm-Message-State: AOAM5322qRgygG+u5YKUt0wFxvUzk6xnQWsxf/Zle3FPXRceuJuDdK1B
        Jsfy8JzsyTjCd1vePAKtG91lbdLJpdyl0jVq2y8RYZyxHlM=
X-Google-Smtp-Source: ABdhPJwUT60W3ByLAudmauSaRtgoF18uDF+5y3xNpKLwb86Fuj5obEj1Uw0y9+Xke1Xujg5UscpZstiv8/jNzr6gMZE=
X-Received: by 2002:a81:1d8f:: with SMTP id d137mr5310092ywd.383.1643912669833;
 Thu, 03 Feb 2022 10:24:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:1756:0:0:0:0:0 with HTTP; Thu, 3 Feb 2022 10:24:29 -0800 (PST)
In-Reply-To: <YfwZ6ne9ND1JaReS@kernel.org>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-2-martin.fernandez@eclypsium.com> <YfwZ6ne9ND1JaReS@kernel.org>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Thu, 3 Feb 2022 15:24:29 -0300
Message-ID: <CAKgze5ZVHax5AWP3Q764dSmjAJWncyZbn4ENQCkYs0ahbG9Haw@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] mm/memblock: Tag memblocks with crypto capabilities
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/3/22, Mike Rapoport <rppt@kernel.org> wrote:
> On Thu, Feb 03, 2022 at 01:43:23PM -0300, Martin Fernandez wrote:
>> +/**
>> + * memblock_node_is_crypto_capable - get if whole node is capable
>> + * of encryption
>> + * @nid: number of node
>> + *
>> + * Iterate over all memory memblock_type and find if all regions under
>> + * node @nid are capable of hardware encryption.
>> + *
>> + * Return:
>> + * true if every region in memory memblock_type is capable of
>> + * encryption, false otherwise.
>> + */
>> +bool __init_memblock memblock_node_is_crypto_capable(int nid)
>> +{
>> +	struct memblock_region *region;
>> +	bool crypto_capable = false;
>> +	bool not_crypto_capable = false;
>> +
>> +	for_each_mem_region(region) {
>> +		if (memblock_get_region_node(region) == nid) {
>> +			crypto_capable =
>> +				crypto_capable ||
>> +				(region->flags & MEMBLOCK_CRYPTO_CAPABLE);
>> +			not_crypto_capable =
>> +				not_crypto_capable ||
>> +				!(region->flags & MEMBLOCK_CRYPTO_CAPABLE);
>
> Isn't
>
>  			if (region->flags & MEMBLOCK_CRYPTO_CAPABLE)
> 				crypto_capable++;
> 			else
> 				not_crypto_capable++;
>
> simpler and clearer?
>
> (of course s/bool/int in the declaration)
>

Yes! It is. I like that.

>> +		}
>> +	}
>> +
>> +	if (crypto_capable && not_crypto_capable)
>> +		pr_warn_once("Node %d has regions that are encryptable and regions that
>> aren't",
>> +			     nid);
>
> This will print only the first node with mixed regions. With a single
> caller of memblock_node_is_crypto_capable() I think pr_warn() is ok.
>

Yes, you are correct, don't really want _once here.
