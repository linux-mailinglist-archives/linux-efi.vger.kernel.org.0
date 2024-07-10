Return-Path: <linux-efi+bounces-1411-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12A492DCA6
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 01:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F39B20D5F
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 23:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13B314D428;
	Wed, 10 Jul 2024 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="oqeixckt"
X-Original-To: linux-efi@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A1143742
	for <linux-efi@vger.kernel.org>; Wed, 10 Jul 2024 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654337; cv=none; b=WwwOryUUwDcBbG/Jp9ZPkDTGw8DZqtWU1WJ95C/wfX9kyAeZj2hwkEle9Lgp9R/aTcx2ufWuK2ahmqmbReUBFpHsBiFr9FBZ8YdUxLoBkpmCV6LGgWx6cz0yzjzPhuNjLdaFiSttp8kvYMR9i+bI8AAfBvtG6Ea9Cy69VjoXHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654337; c=relaxed/simple;
	bh=BZrliTLUkbOemqBrs18jJgI0MU1A0uCOS2PxezPrWuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONV8Lu6HO/433QR+vL6Ex+csmgMJY00qpS5occBlCSLCYet6bUg3Ww+q0Pbii14/MOMYG4O2TEUX3dgTO4QbRh0ZLBEIib2lDwHuySyi5Rg7TGDw/ctAHrEKYdnFG74MrfuRGO5MZxBgISAI0TGKUmxXYBamV8mYDNEAg8hnMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=oqeixckt; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id RcXWs4D0sVpzpRgnHsRwmj; Wed, 10 Jul 2024 23:32:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RgnGsdctRJYlLRgnHsyVXL; Wed, 10 Jul 2024 23:32:15 +0000
X-Authority-Analysis: v=2.4 cv=CKIsXwrD c=1 sm=1 tr=0 ts=668f19ff
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=9vBBgvin8fPGMG66eBEA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yFXQTbu+/ZAkw/3UzA5PbO+dqooOFZvFP6+QlCyMc4A=; b=oqeixcktuZoNYiUqd9oCrlZBpG
	Y4ZKopnC82Agt/6s/Gn0eJxp6otYb4dES25xOpHOYtipqCl5JYIJ1DxnQVziroL47hz9VqZKq1hB3
	70CphY0OYJ+H3ZRmPxRlon3piREsbqPBrhHHxp/69Bquo9rkJMSMjzLfKiq3zH+rs1gK+ut7H2szQ
	uaK23CaqT+t1vSfefgYLu38vz+sWz8Urma6WhokWQZvg84ewQoO7U8IgUgnINGMvpkAgiCM1EYeO7
	v0PsiZmmUP7hFWsQoruhbH+2dMfaUGhrafhDY0PGgcPw/9Q1CgNthHy2s/y0byYISQcncH/dobSzy
	McW0JJOg==;
Received: from [201.172.173.139] (port=45468 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRgnG-00042E-0j;
	Wed, 10 Jul 2024 18:32:14 -0500
Message-ID: <d2b9e11a-749b-47cd-9cc2-0734ec5849b0@embeddedor.com>
Date: Wed, 10 Jul 2024 17:32:13 -0600
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Replace efi_memory_attributes_table_t 0-sized array
 with flexible array
To: Kees Cook <kees@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240710225538.work.224-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240710225538.work.224-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sRgnG-00042E-0j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:45468
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 45
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJR7MIF6QvhRpPXjA1tGYwVMn3ewLCXCnq4P3sxugqguIDfagytUfqEDDdfMabCP2lDx0wmwiO7WeIdXFJkkN3B9JTjf0Pl/j/pcPhYKFt55+5NwXt6W
 PGuKd9LOPW9NUNR5lNEnuGP/J73x886IVkeGKvXyNa76kWsuWyzKV9L8da0AfN9N+WBts9sd9XTa7U0UqQlJzycOoaht1WOUZcQ=



On 10/07/24 16:55, Kees Cook wrote:
> While efi_memory_attributes_table_t::entry isn't used directly as an
> array, it is used as a base for pointer arithmetic. The type is wrong
> as it's not technically an array of efi_memory_desc_t's; they could be
> larger. Regardless, leave the type unchanged and remove the old style
> "0" array size. Additionally replace the open-coded entry offset code
> with the existing efi_early_memdesc_ptr() helper.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> ---
>   drivers/firmware/efi/memattr.c | 2 +-
>   include/linux/efi.h            | 6 +++++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> index ab85bf8e165a..01142604e8df 100644
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -164,7 +164,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
>   		bool valid;
>   		char buf[64];
>   
> -		valid = entry_is_valid((void *)tbl->entry + i * tbl->desc_size,
> +		valid = entry_is_valid(efi_early_memdesc_ptr(tbl->entry, tbl->desc_size, i),
>   				       &md);
>   		size = md.num_pages << EFI_PAGE_SHIFT;
>   		if (efi_enabled(EFI_DBG) || !valid)
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 418e555459da..b06639c4f6a5 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -607,7 +607,11 @@ typedef struct {
>   	u32 num_entries;
>   	u32 desc_size;
>   	u32 flags;
> -	efi_memory_desc_t entry[0];
> +	/*
> +	 * There are @num_entries following, each of size @desc_size bytes,
> +	 * including an efi_memory_desc_t header.
> +	 */
> +	efi_memory_desc_t entry[];

a candidate for future __counted_by(num_entries * desc_size) ? :p

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

>   } efi_memory_attributes_table_t;
>   
>   typedef struct {

