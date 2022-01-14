Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE548E9C3
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jan 2022 13:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiANMUt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Jan 2022 07:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240969AbiANMUt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Jan 2022 07:20:49 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540B1C06173F
        for <linux-efi@vger.kernel.org>; Fri, 14 Jan 2022 04:20:49 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 66so8473228ybf.4
        for <linux-efi@vger.kernel.org>; Fri, 14 Jan 2022 04:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MAkMmnOMe9NMKorob6g8seLd4C0DSklHH7T74q+omyk=;
        b=QnLGmtyYeMmpag3WiMXk4IEqMWj0pP8AGxVajaC8Rs1s6nCvuZn+D+NHQWrxXMrhuV
         tHK2k3IFJVbeGp6+p0wBIgT5xPis9YcJ/KJSuyO6asErbqxfQiu4Wog0JqY4KEhg51Yx
         7QE+lTrRwzIMMOZC3mAmng3GLEKqsyajxYqWcL8ZVAT0ScpMPEcHAJoBTN4+KJlBsl1t
         ui7r7a2X/LA3jg7th5ENpJkfVNYdooSpujlBYEOvXVvtQyeBhGmGXLQtx0rEaGtyXTBA
         ggrWV6+UTqqggnQ/V2tOqPrVT6Npot7tIbvCWiuiqGRBJqwoVhLNLY9MSaPO4Qcheuc+
         PylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MAkMmnOMe9NMKorob6g8seLd4C0DSklHH7T74q+omyk=;
        b=df21UraBjifFy+5MgSJHvmUVKdqPxbYpjLXwBS+pAjE23k8pZ70+6urVUAdYkKYkFi
         zMhjOqDRGDXc1dv5J/4Q2aVnRqbZZZz/C5GEqXJJnQBK/JHmX+tDiKHtLP9UuZiW7aGI
         LcY3M/XyQ77VJEQxngmitkyTAmqICB1+wZJEVqLo9ttUiuqUT29tqf/DKnYL3C5bj2dh
         bPqVTK/tTQK7xgM/7jmIED6zPkFZkQxB/T0aYcIVZhxdY6CmzdUbvVZ78PRPoIeQkDwB
         HggK/f9JhDckQitHoIL9QgyfjM9bg44sufAolzeTzKI/BBP2L04Sp67wPShyxXqnNY+Q
         9urQ==
X-Gm-Message-State: AOAM531HvuXVMh2kTxUOb5hy31ZfySIoTx0V2pjXaXfYlAbm496wMSg8
        JC0Ild4a2X9AvEW3uVdu/N+fU+lQ8Yddm59WL2YBpg==
X-Google-Smtp-Source: ABdhPJy8h7Jl2pKbPuRhQfBLmCm+OgtCbyEMVkYBfTbYhpZi2wWRXIm2SkgtcDECJxeJHq7y/SS5Op8/g1ZZhK9FBOI=
X-Received: by 2002:a25:ea4a:: with SMTP id o10mr12517153ybe.442.1642162848353;
 Fri, 14 Jan 2022 04:20:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:3cd:0:0:0:0:0 with HTTP; Fri, 14 Jan 2022 04:20:47 -0800 (PST)
In-Reply-To: <YeFHcrUUopm5xrtZ@kernel.org>
References: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
 <20220113213027.457282-2-martin.fernandez@eclypsium.com> <YeFHcrUUopm5xrtZ@kernel.org>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Fri, 14 Jan 2022 09:20:47 -0300
Message-ID: <CAKgze5YLqSmjPsPJE8w_Z=1J=qQkj+QsOeweusXV+V-=q+qZiA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] mm/memblock: Tag memblocks with crypto capabilities
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/14/22, Mike Rapoport <rppt@kernel.org> wrote:
> On Thu, Jan 13, 2022 at 06:30:23PM -0300, Martin Fernandez wrote:
>> Add the capability to mark regions of the memory memory_type able of
>> hardware memory encryption.
>>
>> Also add the capability to query if all regions of a memory node are
>> able to do hardware memory encryption to call it when initializing the
>> nodes.
>>
>> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
>> ---
>>  include/linux/memblock.h |  5 ++++
>>  mm/memblock.c            | 49 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 54 insertions(+)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index 9dc7cb239d21..374c03e10b2e 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -41,6 +41,7 @@ extern unsigned long long max_possible_pfn;
>>   * via a driver, and never indicated in the firmware-provided memory map
>> as
>>   * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in
>> the
>>   * kernel resource tree.
>> + * @MEMBLOCK_CRYPTO_CAPABLE: capable of hardware encryption
>>   */
>>  enum memblock_flags {
>>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
>> @@ -48,6 +49,7 @@ enum memblock_flags {
>>  	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
>>  	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>>  	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>> +	MEMBLOCK_CRYPTO_CAPABLE = 0x10,  /* capable of hardware encryption */
>
> Nit: please keep the comments aligned with TAB.
>
>>  };
>>
>>  /**
>> @@ -121,6 +123,9 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t
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
>> index 1018e50566f3..61ec50647469 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -191,6 +191,27 @@ bool __init_memblock memblock_overlaps_region(struct
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
>
> Please add Return: description, otherwise kernel-doc is unhappy
>
>> + */
>> +bool __init_memblock memblock_node_is_crypto_capable(int nid)
>> +{
>> +	struct memblock_region *region;
>> +
>> +	for_each_mem_region(region) {
>> +		if ((memblock_get_region_node(region) == nid) &&
>> +		    !(region->flags & MEMBLOCK_CRYPTO_CAPABLE))
>> +			return false;
>> +	}
>
> As we discussed on v3, please add a printk if the same node has both
> crypto-capable and not crypto-capable regions.
>
> https://lore.kernel.org/all/Ya++1FwWzKr2wYQH@kernel.org/
>
>> +
>> +	return true;
>> +}
>> +
>>  /**
>>   * __memblock_find_range_bottom_up - find free area utility in bottom-up
>>   * @start: start of candidate range
>> @@ -885,6 +906,34 @@ static int __init_memblock
>> memblock_setclr_flag(phys_addr_t base,
>>  	return 0;
>>  }
>>
>> +/**
>> + * memblock_mark_crypto_capable - Mark memory regions capable of
>> hardware
>> + * encryption with flag MEMBLOCK_CRYPTO_CAPABLE.
>> + * @base: the base phys addr of the region
>> + * @size: the size of the region
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +int __init_memblock memblock_mark_crypto_capable(phys_addr_t base,
>> +						 phys_addr_t size)
>> +{
>> +	return memblock_setclr_flag(base, size, 1, MEMBLOCK_CRYPTO_CAPABLE);
>> +}
>> +
>> +/**
>> + * memblock_clear_crypto_capable - Clear flag MEMBLOCK_CRYPTO for a
>> + * specified region.
>> + * @base: the base phys addr of the region
>> + * @size: the size of the region
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +int __init_memblock memblock_clear_crypto_capable(phys_addr_t base,
>> +						  phys_addr_t size)
>> +{
>> +	return memblock_setclr_flag(base, size, 0, MEMBLOCK_CRYPTO_CAPABLE);
>> +}
>> +
>>  /**
>>   * memblock_mark_hotplug - Mark hotpluggable memory with flag
>> MEMBLOCK_HOTPLUG.
>>   * @base: the base phys addr of the region
>> --
>> 2.30.2
>>
>
> --
> Sincerely yours,
> Mike.
>

Ok, will do. Thanks for the feedback.
