Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C050FE24
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 15:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350587AbiDZNCt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350489AbiDZNCR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 09:02:17 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB9A1815FB
        for <linux-efi@vger.kernel.org>; Tue, 26 Apr 2022 05:59:05 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id f38so32801194ybi.3
        for <linux-efi@vger.kernel.org>; Tue, 26 Apr 2022 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=klvWna6aVMmD5xzd2dumZFpFxfWMKshDlMPwR9QCUhU=;
        b=Snve9f0KfXixZ+c8vg5EYkQfEnS0VOwMlEfbjzSmmLeKl3CV3QY7OoAEGlUCMMiKpD
         R3uI1qO6ciPKkLK5vtAtgpjFqwIkNnMkoTIIlq14jZ76GdxyOBwkxciG6k+P3CLvjiiz
         d+oMOO+GBwo5DcLFG2CBUSHN7gROk7mk7kOsagRBNNw+0te+8pMeTBDhlZ8z6gI8V1nB
         OwcO7pjnH+wqR7qbdlDmbAwik4TDeQZ2HGgpg4HMQ78iHj0vjE5dn+I5qeu85IiTJdFW
         vB92ZbAXdrOk8XW/osb3yXoM0AJ/fCZoICH/8pvrXNcyr3lJ561gTCb3ThZOCTE8HCXH
         NdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=klvWna6aVMmD5xzd2dumZFpFxfWMKshDlMPwR9QCUhU=;
        b=AX6y/sW2NhDMY8u1EroSPf/wR6E1Cj9Y7KVCUEaaUfMkjOCSNX9ItPzlWyHBsWpn0u
         zKmTrZ6ODyIo9rKTj6EoFJjbg2D8EKZpLxJw6fOrDQB2JZ5HfsfC46eCtPu5NOgyyCS/
         x/K2kTeVxGAaXqM8pAFpM8XkTANtfobK1uWQP6nuCQXVZWW+hxH3uvjb4jhFVGX82QqR
         K+5KG4XPgyeGFATYrT3YIHiDjreEvBsrjLA04fEpJg4kVx+MLr55AgG9IAxdPpqjY1jM
         D5wcwoQK5RmlME0lSEVmMXlrKLUIvSjX5lXARrBD+CCC7k+024X9jWzuA1KJ/c0rq+G+
         NRpg==
X-Gm-Message-State: AOAM532CqQG1FpSTXmPoMCCpVU1SRBBLiQMTnYl0s9fT8f9nCpzQdgzt
        qO81snJgi6flIK0Y2Oi7WNebE/PFIRLtQSXayFbsew==
X-Google-Smtp-Source: ABdhPJySiRxTZpBhh3bZw12NdC/YImhj5Q/qK8XHR85blgIx7xY01atU3xGEYkhR1DoyFQ8iXTAaEH22Gry149h26oE=
X-Received: by 2002:a25:8b03:0:b0:628:8cff:ed6c with SMTP id
 i3-20020a258b03000000b006288cffed6cmr21036112ybl.513.1650977944764; Tue, 26
 Apr 2022 05:59:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:10a:0:0:0:0:0 with HTTP; Tue, 26 Apr 2022 05:59:04 -0700 (PDT)
In-Reply-To: <YmeM5fklUssR/74e@kernel.org>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
 <20220425171526.44925-2-martin.fernandez@eclypsium.com> <YmeM5fklUssR/74e@kernel.org>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 26 Apr 2022 09:59:04 -0300
Message-ID: <CAKgze5YwTD3neYjKNZzLz6DLWxpGPohGCDGT6oJn-KUdAxyCfg@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] mm/memblock: Tag memblocks with crypto capabilities
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/26/22, Mike Rapoport <rppt@kernel.org> wrote:
> On Mon, Apr 25, 2022 at 02:15:19PM -0300, Martin Fernandez wrote:
>> Add the capability to mark regions of the memory memory_type able of
>> hardware memory encryption.
>>
>> Also add the capability to query if all regions of a memory node are
>> able to do hardware memory encryption to call it when initializing the
>> nodes. Warn the user if a node has both encryptable and
>> non-encryptable regions.
>>
>> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
>> ---
>>  include/linux/memblock.h |  5 ++++
>>  mm/memblock.c            | 62 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 67 insertions(+)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index 50ad19662a32..00c4f1a20335 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -40,6 +40,7 @@ extern unsigned long long max_possible_pfn;
>>   * via a driver, and never indicated in the firmware-provided memory map
>> as
>>   * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in
>> the
>>   * kernel resource tree.
>> + * @MEMBLOCK_CRYPTO_CAPABLE: capable of hardware encryption
>>   */
>>  enum memblock_flags {
>>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
>> @@ -47,6 +48,7 @@ enum memblock_flags {
>>  	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
>>  	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>>  	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>> +	MEMBLOCK_CRYPTO_CAPABLE = 0x10,	/* capable of hardware encryption */
>>  };
>>
>>  /**
>> @@ -120,6 +122,9 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t
>> size);
>>  void memblock_trim_memory(phys_addr_t align);
>>  bool memblock_overlaps_region(struct memblock_type *type,
>>  			      phys_addr_t base, phys_addr_t size);
>> +bool memblock_node_is_crypto_capable(int nid);
>> +int memblock_mark_crypto_capable(phys_addr_t base, phys_addr_t size);
>> +int memblock_clear_crypto_capable(phys_addr_t base, phys_addr_t size);
>>  int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
>>  int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>>  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index e4f03a6e8e56..fe62f81572e6 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -191,6 +191,40 @@ bool __init_memblock memblock_overlaps_region(struct
>> memblock_type *type,
>>  	return i < type->cnt;
>>  }
>>
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
>
> I'd s/in memory memblock_type/in @nid
>

Good, thanks.

>> + * encryption, false otherwise.
>> + */
>> +bool __init_memblock memblock_node_is_crypto_capable(int nid)
>> +{
>> +	struct memblock_region *region;
>> +	int crypto_capables = 0;
>> +	int not_crypto_capables = 0;
>> +
>> +	for_each_mem_region(region) {
>> +		if (memblock_get_region_node(region) == nid) {
>> +			if (region->flags & MEMBLOCK_CRYPTO_CAPABLE)
>> +				crypto_capables++;
>> +			else
>> +				not_crypto_capables++;
>> +		}
>> +	}
>> +
>> +	if (crypto_capables > 0 && not_crypto_capables > 0)
>> +		pr_warn("Node %d has %d regions that are encryptable and %d regions
>> that aren't",
>> +			nid, not_crypto_capables, crypto_capables);
>> +
>> +	return not_crypto_capables == 0;
>
> This will return true for memoryless nodes as well. Do you mean to consider
> them as capable of encryption?
>

Not really, I didn't think about that to be honest. I don't think it's
a good idea to consider them as capable, right?
