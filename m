Return-Path: <linux-efi+bounces-1482-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CFB93B326
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6904B1C22B09
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EFA54657;
	Wed, 24 Jul 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Q/GDs2p9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E26134AC;
	Wed, 24 Jul 2024 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832768; cv=none; b=nk1teX26I1lHCK5CPsVLuwLUo37zoQs3pxv+6YDN/2AtayWP/tNCTYXuNGQwHKPc9E5lqBVT+557YO2f3pRqqcZCOUVyLr4DaGDcwdOZUWXOLgtAb4B8eqy5l2ax6PdKGnnmDw3YQFSO/jtnbLWFdWxibyPxrBczV8cCxWh3UPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832768; c=relaxed/simple;
	bh=1UR/Rl29EOkVXXKtByzEVNjTorXRyez/OCWiAKbF9nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q84MXFH+fxSxzX5Zsyd2/DT2GLyUsHAU7eOHcfJ1nAQQP4aIR1cD6/jq50nx5HuSwCd1fZqPzDm0EckXj3qWtQIKPpBg72PUAXF6MVPoX8+JUwQJfC7nLWGSBko0/lIvGjGRRo26fhw0j0m+jld0dS7YFvammuvm2AvLRfl6JGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Q/GDs2p9; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O9XHup018789;
	Wed, 24 Jul 2024 14:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=+PVD4s92WUj9d8l4iny/fls
	0Ls8G3YMtd4Sqn1HT1hc=; b=Q/GDs2p9gJQ6rUR+t+ItEjPN05Gl6OslwV6pGYU
	EAbUDFlfQ9MsipWYV8JvVrVlFJr/DfRUhb11gklahgcTLIb0ZCltxx6JekY8TbU5
	to4D9Emeikufyr37vhIcmZNkPL0TL4VAENW2BRX2Ef3/RYLaDR/jH42x45X6Vuei
	gzBPHlZF+w2+rfGGq2WImWFvS9Am/JlWC73/Hn0pI8ydxPi70LqcyUofjKqoAruM
	hguXunQbmlrzA0ZFxHPk6IxaUoEam6jsFIDlDwy5o1tJWeLFiwOVAW52PkOta1Yi
	++aogtoN5O+M//yWqyTeDokPSnXtqwaNmdPzk6F9/Kygu4A==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 40jhqyyycv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 14:51:36 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 3C35213784;
	Wed, 24 Jul 2024 14:51:34 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 97BF38065D6;
	Wed, 24 Jul 2024 14:51:28 +0000 (UTC)
Date: Wed, 24 Jul 2024 09:51:26 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>,
        Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86/mm/ident_map: Use gbpages only where full GB
 page should be mapped.
Message-ID: <ZqEU7gC9VU_loVfV@swahl-home.5wahls.com>
References: <20240717213121.3064030-1-steve.wahl@hpe.com>
 <20240717213121.3064030-3-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717213121.3064030-3-steve.wahl@hpe.com>
X-Proofpoint-GUID: yf7PEnjMT5Ilut-VNU81f0H91Zhd63t4
X-Proofpoint-ORIG-GUID: yf7PEnjMT5Ilut-VNU81f0H91Zhd63t4
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_13,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407240109

Gentle ping: Can someone please take the time to review this patch?

This patch was previously approved by Dave Hansen, but was reverted.

Full series (of 2 + cover leter) viewable at:

https://lore.kernel.org/all/20240717213121.3064030-1-steve.wahl@hpe.com/

Thanks.

--> Steve Wahl, HPE

On Wed, Jul 17, 2024 at 04:31:21PM -0500, Steve Wahl wrote:
> When ident_pud_init() uses only gbpages to create identity maps, large
> ranges of addresses not actually requested can be included in the
> resulting table; a 4K request will map a full GB.  This can include a
> lot of extra address space past that requested, including areas marked
> reserved by the BIOS.  That allows processor speculation into reserved
> regions, that on UV systems can cause system halts.
> 
> Only use gbpages when map creation requests include the full GB page
> of space.  Fall back to using smaller 2M pages when only portions of a
> GB page are included in the request.
> 
> No attempt is made to coalesce mapping requests. If a request requires
> a map entry at the 2M (pmd) level, subsequent mapping requests within
> the same 1G region will also be at the pmd level, even if adjacent or
> overlapping such requests could have been combined to map a full
> gbpage.  Existing usage starts with larger regions and then adds
> smaller regions, so this should not have any great consequence.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Tested-by: Pavin Joseph <me@pavinjoseph.com>
> Tested-by: Sarah Brofeldt <srhb@dbc.dk>
> Tested-by: Eric Hagberg <ehagberg@gmail.com>
> ---
>  arch/x86/mm/ident_map.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
> index 968d7005f4a7..a204a332c71f 100644
> --- a/arch/x86/mm/ident_map.c
> +++ b/arch/x86/mm/ident_map.c
> @@ -26,18 +26,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
>  	for (; addr < end; addr = next) {
>  		pud_t *pud = pud_page + pud_index(addr);
>  		pmd_t *pmd;
> +		bool use_gbpage;
>  
>  		next = (addr & PUD_MASK) + PUD_SIZE;
>  		if (next > end)
>  			next = end;
>  
> -		if (info->direct_gbpages) {
> -			pud_t pudval;
> +		/* if this is already a gbpage, this portion is already mapped */
> +		if (pud_leaf(*pud))
> +			continue;
> +
> +		/* Is using a gbpage allowed? */
> +		use_gbpage = info->direct_gbpages;
>  
> -			if (pud_present(*pud))
> -				continue;
> +		/* Don't use gbpage if it maps more than the requested region. */
> +		/* at the begining: */
> +		use_gbpage &= ((addr & ~PUD_MASK) == 0);
> +		/* ... or at the end: */
> +		use_gbpage &= ((next & ~PUD_MASK) == 0);
> +
> +		/* Never overwrite existing mappings */
> +		use_gbpage &= !pud_present(*pud);
> +
> +		if (use_gbpage) {
> +			pud_t pudval;
>  
> -			addr &= PUD_MASK;
>  			pudval = __pud((addr - info->offset) | info->page_flag);
>  			set_pud(pud, pudval);
>  			continue;
> -- 
> 2.26.2
> 

-- 
Steve Wahl, Hewlett Packard Enterprise

