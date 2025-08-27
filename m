Return-Path: <linux-efi+bounces-4618-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E1B377AE
	for <lists+linux-efi@lfdr.de>; Wed, 27 Aug 2025 04:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390801B654C4
	for <lists+linux-efi@lfdr.de>; Wed, 27 Aug 2025 02:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746C272E41;
	Wed, 27 Aug 2025 02:23:52 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BEE27707;
	Wed, 27 Aug 2025 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261432; cv=none; b=GkeXB2AphecP+3xUTomZk3uQtec0neNQ+viDdj43RbN6II5jg6Y24moGGu4SU+R9ClmrUXww76X7ZyvTDbzsbPWlnDZDfhlnUSTaoP7DNYv/0IxxDKwQEMqwTgu/Z0q6FOsuPl+VZ4sovLUNzkrM+ZAzUHyW5Xnc1Ou5nJ6aaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261432; c=relaxed/simple;
	bh=AKi9/OHy1tHN9Xiukj7H9Mq4C66I06orms63TzLZEnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWsBth+owypdPUXgv0t/BPAQZot1GAHlM/0teR3wOYs4VxG/7I3H2c5yQdfoglFr7LKRIKj73LuzUeHJHZIgur/UIeMe4eUvshN9757XUn0OdV2tTpHiV5m0cYoclTFht0bCAwuBt1HCKmK2KwK71OpSF5gRwJKsq+JpXCDZxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cBSyD0LSRzYQtM6;
	Wed, 27 Aug 2025 10:23:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8FD1A1A0F22;
	Wed, 27 Aug 2025 10:23:46 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP4 (Coremail) with SMTP id gCh0CgAncY0wbK5ougC0AQ--.46889S3;
	Wed, 27 Aug 2025 10:23:46 +0800 (CST)
Message-ID: <e1212545-2013-775d-e3a8-07b3be2cfc00@huaweicloud.com>
Date: Wed, 27 Aug 2025 10:23:44 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare
To: Ard Biesheuvel <ardb@kernel.org>
Cc: jk@ozlabs.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, yi.zhang@huawei.com
References: <20250819090802.2258766-1-linan666@huaweicloud.com>
 <CAMj1kXHvEOTHHshS9uoL4RSZgJZgd9OR9qzPHYJ5xW2Vgeefcg@mail.gmail.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAMj1kXHvEOTHHshS9uoL4RSZgJZgd9OR9qzPHYJ5xW2Vgeefcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncY0wbK5ougC0AQ--.46889S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1DXrykAryrGw1UZw1kKrg_yoW5JF1Dpr
	WrG3WxKFZ5Xw1jy3yFvFn7Ja4jgan2qr43XFsFqr12gF97Wr1fWrZFgw1Y9Fyqvr18Xayk
	Wayqg3Waka13Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
	Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
	AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xF
	o4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x07UMnQUUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2025/8/26 21:32, Ard Biesheuvel 写道:
> On Tue, 19 Aug 2025 at 11:16, <linan666@huaweicloud.com> wrote:
>>
>> From: Li Nan <linan122@huawei.com>
>>
>> Observed on kernel 6.6 (present on master as well):
>>
>>    BUG: KASAN: slab-out-of-bounds in memcmp+0x98/0xd0
>>    Call trace:
>>     kasan_check_range+0xe8/0x190
>>     __asan_loadN+0x1c/0x28
>>     memcmp+0x98/0xd0
>>     efivarfs_d_compare+0x68/0xd8
>>     __d_lookup_rcu_op_compare+0x178/0x218
>>     __d_lookup_rcu+0x1f8/0x228
>>     d_alloc_parallel+0x150/0x648
>>     lookup_open.isra.0+0x5f0/0x8d0
>>     open_last_lookups+0x264/0x828
>>     path_openat+0x130/0x3f8
>>     do_filp_open+0x114/0x248
>>     do_sys_openat2+0x340/0x3c0
>>     __arm64_sys_openat+0x120/0x1a0
>>
>> If dentry->d_name.len < EFI_VARIABLE_GUID_LEN , 'guid' can become
>> negative, leadings to oob. The issue can be triggered as below:
>>
>>    T1                    T2
>>    lookup_open
>>     ->lookup
>>      simple_lookup
>>       d_add
>>       // invalid dentry is added to hash list
>>
>>                          lookup_open
>>                           d_alloc_parallel
>>                            __d_lookup_rcu
>>                             __d_lookup_rcu_op_compare
>>                              hlist_bl_for_each_entry_rcu
>>                              // invalid dentry can be retrieved
>>                               ->d_compare
>>                                efivarfs_d_compare
>>
>> Fix it by checking len before cmp.
>>
>> Fixes: da27a24383b2 ("efivarfs: guid part of filenames are case-insensitive")
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
>> ---
>> v2: optimize commit message
>>
> 
> Thanks for the fix, and for the elaborate description.
> 
> IIUC, two parallel lookups using an invalid filename can reproduce this?
> 

Thansk for your review.

Yes, the filename is invalid. I'll add that to the commit message in the 
next version.

>>   fs/efivarfs/super.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
>> index 23ff4e873651..c30d758e303a 100644
>> --- a/fs/efivarfs/super.c
>> +++ b/fs/efivarfs/super.c
>> @@ -152,7 +152,7 @@ static int efivarfs_d_compare(const struct dentry *dentry,
>>   {
>>          int guid = len - EFI_VARIABLE_GUID_LEN;
>>
> 
> Could we do a separate
> 
> if (guid <= 0)
>    return 1;
> 
> here, with a comment describing how that condition might become true?
> 

Okay, I will update it in v3.

>> -       if (name->len != len)
>> +       if (name->len != len || len <= EFI_VARIABLE_GUID_LEN)
> 
> ... and drop this change.
> 
>>                  return 1;
>>
>>          /* Case-sensitive compare for the variable name */
>> --
>> 2.39.2
>>
>>

-- 
Thanks,
Nan


