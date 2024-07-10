Return-Path: <linux-efi+bounces-1412-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AF992DCAD
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 01:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84A91C21266
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 23:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEE2156997;
	Wed, 10 Jul 2024 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="MtPoLmT2"
X-Original-To: linux-efi@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E514A4F7
	for <linux-efi@vger.kernel.org>; Wed, 10 Jul 2024 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654480; cv=none; b=qeQBpgE4ai9Bp0bIFX1cXyxczixYj8gG4Gp2YBKDIZ+EpFbkXbJwM469e1ymgxnImhRFASrlDC3Rp5DfQm9cQAPWMa+z35LTaOATPvSfxBKapH2vyO+G7unyjd1bXcdfdIfanGdUVFDMLM0BAStn+NX6ANm6bQeMU6JkwQumlNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654480; c=relaxed/simple;
	bh=Y3tLN1FUYKD9P0XY9Z8sgecxGAe2s3b3c1AJKp25whc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J/NZGZmlSw2rrGdtfbml2Ct+rjAwLu3oee5blHvGpduBBZIcOXD9iDOZ2QS/Ftq1axDVlYvN5bYoTaXAm0WgBw8SwSBEzkON6b+YGwImMmeS/wkgp/T0QH2fNuMOM97ryP3Eb3t/VU7sBiAtZokYdIljh0gu50xt7S/EaMveo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=MtPoLmT2; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id RcXRsVJ9C1zuHRgpZsHxaf; Wed, 10 Jul 2024 23:34:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RgpYsPxLZeieBRgpZsjROd; Wed, 10 Jul 2024 23:34:37 +0000
X-Authority-Analysis: v=2.4 cv=BoBWwpX5 c=1 sm=1 tr=0 ts=668f1a8d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=Z-4xmcrJcoJOMkTEJEUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OMjlRkTGVaZ5mRMMhNwEtO+KR2NFjEcJYgi4iuJ56C4=; b=MtPoLmT2H7/44fJRirxUKe6uhf
	0bKB6qR192CSSHZYFhmzsgFaQvZ7mrFSilii5wjbjxV1xb9XvmGC3C+xwycOprI9pnhtn6rC5nSNR
	qdALI+L6XsI3KEQ+2kBpKqJKKvCsYY2UvnzrzpfCKjfB302lOeE6+3SwL1V+uWjtDvfZ5wq6Tgd74
	7yhaanRylA3RFBi6c3MaqecMbZHrJZhoN9nze7kLMsdvBuJDkiNVA4ylsf0UvDsIBEYBoyDlZzM5t
	H3x3QLNRO0uAbYUC3Wsxu2cSbRBa9InT7JtnvJLNBm/ET/HH4LBtJjsq19ngIgfz2GYDJN/4fcFqG
	HqwMd3pg==;
Received: from [201.172.173.139] (port=54416 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRgpY-0006cj-0q;
	Wed, 10 Jul 2024 18:34:36 -0500
Message-ID: <175fc58f-b12a-4bc7-bc74-3365e5b0ee3e@embeddedor.com>
Date: Wed, 10 Jul 2024 17:34:35 -0600
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Replace efi_memory_attributes_table_t 0-sized array
 with flexible array
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Kees Cook <kees@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240710225538.work.224-kees@kernel.org>
 <d2b9e11a-749b-47cd-9cc2-0734ec5849b0@embeddedor.com>
Content-Language: en-US
In-Reply-To: <d2b9e11a-749b-47cd-9cc2-0734ec5849b0@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sRgpY-0006cj-0q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:54416
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 50
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCzFrkgwSjghRhvvR4ZfYp/ALBj9TADSrKqv3S+xn4odwAt+DgbGgMU+WoprvveaBU30aMM91b5mV6aLnI12lnwQWpdgv0CECziFwt9jPAIGjK9W2UXP
 cNJpDXP+QW6BN8mu/MpjqSkzdOos+hRvOs0Fy020vEMAETQ+bTKn8no5ne13yh8VkmccxM9J0ow/4ks71qRGKT5kMILCjYqjrXg=



On 10/07/24 17:32, Gustavo A. R. Silva wrote:
> 
> 
> On 10/07/24 16:55, Kees Cook wrote:
>> While efi_memory_attributes_table_t::entry isn't used directly as an
>> array, it is used as a base for pointer arithmetic. The type is wrong
>> as it's not technically an array of efi_memory_desc_t's; they could be
>> larger. Regardless, leave the type unchanged and remove the old style
>> "0" array size. Additionally replace the open-coded entry offset code
>> with the existing efi_early_memdesc_ptr() helper.
>>
>> Signed-off-by: Kees Cook <kees@kernel.org>
>> ---
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: linux-efi@vger.kernel.org
>> ---
>>   drivers/firmware/efi/memattr.c | 2 +-
>>   include/linux/efi.h            | 6 +++++-
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
>> index ab85bf8e165a..01142604e8df 100644
>> --- a/drivers/firmware/efi/memattr.c
>> +++ b/drivers/firmware/efi/memattr.c
>> @@ -164,7 +164,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
>>           bool valid;
>>           char buf[64];
>> -        valid = entry_is_valid((void *)tbl->entry + i * tbl->desc_size,
>> +        valid = entry_is_valid(efi_early_memdesc_ptr(tbl->entry, tbl->desc_size, i),
>>                          &md);
>>           size = md.num_pages << EFI_PAGE_SHIFT;
>>           if (efi_enabled(EFI_DBG) || !valid)
>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>> index 418e555459da..b06639c4f6a5 100644
>> --- a/include/linux/efi.h
>> +++ b/include/linux/efi.h
>> @@ -607,7 +607,11 @@ typedef struct {
>>       u32 num_entries;
>>       u32 desc_size;
>>       u32 flags;
>> -    efi_memory_desc_t entry[0];
>> +    /*
>> +     * There are @num_entries following, each of size @desc_size bytes,
>> +     * including an efi_memory_desc_t header.
>> +     */
>> +    efi_memory_desc_t entry[];
> 
> a candidate for future __counted_by(num_entries * desc_size) ? :p

ah no, this rather be something more like __sized_by(num_entries * desc_size).

--
Gustavo

> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks

