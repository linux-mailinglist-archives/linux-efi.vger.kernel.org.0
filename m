Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CC047DFA0
	for <lists+linux-efi@lfdr.de>; Thu, 23 Dec 2021 08:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346858AbhLWHdX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Dec 2021 02:33:23 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16853 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346855AbhLWHdX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Dec 2021 02:33:23 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JKMNF6Z8jz91sQ;
        Thu, 23 Dec 2021 15:32:29 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 15:33:21 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 15:33:20 +0800
Subject: Re: [PATCHv3] efi: apply memblock cap after memblock_add()
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Pingfan Liu <kernelfans@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-efi@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211214040157.27443-3-kernelfans@gmail.com>
 <20211215021348.8766-1-kernelfans@gmail.com>
 <7060b244-03d3-e81f-f545-cf2d4fe5c2dd@huawei.com>
Message-ID: <99322a5a-42c3-29b8-df57-f096f9ac95e9@huawei.com>
Date:   Thu, 23 Dec 2021 15:33:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7060b244-03d3-e81f-f545-cf2d4fe5c2dd@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2021/12/22 16:00, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/12/15 10:13, Pingfan Liu wrote:
>>  
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 18a2df431bfd..aa07ef5cab5f 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -972,7 +972,7 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>>   * location from flat tree
>>   * @node: reference to node containing usable memory range location ('chosen')
>>   */
>> -static void __init early_init_dt_check_for_usable_mem_range(void)
>> +void __init early_init_dt_check_for_usable_mem_range(void)
> 
> Why do I see a parameter 'node'?

Sorry, I just saw that the patch 1/2 in v2 was also applied.

> 
> master:
> drivers/of/fdt.c:976:static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
> 
> next:
> drivers/of/fdt.c:980:static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
> 
>>  {
>>  	const __be32 *prop;
>>  	int len;
>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>> index cf48983d3c86..ad09beb6d13c 100644
>> --- a/include/linux/of_fdt.h
>> +++ b/include/linux/of_fdt.h
>> @@ -62,6 +62,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
>>  				     int depth, void *data);
>>  extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
>>  				     int depth, void *data);
>> +extern void early_init_dt_check_for_usable_mem_range(void);
>>  extern int early_init_dt_scan_chosen_stdout(void);
>>  extern void early_init_fdt_scan_reserved_mem(void);
>>  extern void early_init_fdt_reserve_self(void);
>> @@ -86,6 +87,7 @@ extern void unflatten_and_copy_device_tree(void);
>>  extern void early_init_devtree(void *);
>>  extern void early_get_first_memblock_info(void *, phys_addr_t *);
>>  #else /* CONFIG_OF_EARLY_FLATTREE */
>> +static inline void early_init_dt_check_for_usable_mem_range(void) {}
>>  static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
>>  static inline void early_init_fdt_scan_reserved_mem(void) {}
>>  static inline void early_init_fdt_reserve_self(void) {}
>>
