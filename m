Return-Path: <linux-efi+bounces-3970-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05194AE821E
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 13:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAAD4A405F
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 11:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9728625D539;
	Wed, 25 Jun 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBZy8yaj"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9721494C3
	for <linux-efi@vger.kernel.org>; Wed, 25 Jun 2025 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852391; cv=none; b=RwqfNGO4slpPkMDE2DapDQLjpsmIMJV0q2f58cW3sX/nvWqjBscazLR2s7aKtBVvsodRCZ5IG67UI2g3Hes2jrP7k4OFZf28JXBlyqMBZ/bMoVu5MibSRHp1NZhZdYDc/l3oeUX/EeWikhbdEN0Hi8Z94ZW7OXJznhbzrwd7JKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852391; c=relaxed/simple;
	bh=wHC06+XDQXM2g63t+meeqhE3uQJP0n7nF2pLYZwxmUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKWQUvnEENZ4NAIDJYFm4orkjRC1rz9JBzZtVqCkeBNXvVklROHdEXRTfOa4eQvJJaadyySoP9fpCct+PaievogalxRRrMktxVLnb4ObBq0O7qL9RX9R8FGzAvV8Gd8cELVsEqGNLwe/5zA+LafrLtLbsxraK1WGhT7yrAioGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBZy8yaj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750852387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4Xv+4iFOSQyhQxAlU+cPqAXaAkqD/p8+Wz48p9hJkc=;
	b=MBZy8yaj6XYsJwotG0qJF7CbAPd/e1XLSmQf0oMy5upRSCxx5CXSYeT6+fcR+KYRULaz1s
	eEyHNrfqYATVlhD1mI5Zgmpz7fevaSi52OBOImvcB0acWFms/ijpCMZJCVRXTp9UbwhGQT
	oHyRK5XeROlzsuH6vnGogxSaPwTLluw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-LiX6dINzM5GzkvZKRixnUg-1; Wed,
 25 Jun 2025 07:53:04 -0400
X-MC-Unique: LiX6dINzM5GzkvZKRixnUg-1
X-Mimecast-MFC-AGG-ID: LiX6dINzM5GzkvZKRixnUg_1750852382
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 610CC195608C;
	Wed, 25 Jun 2025 11:53:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.244])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47272180035C;
	Wed, 25 Jun 2025 11:53:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id AF16D18000A3; Wed, 25 Jun 2025 13:52:58 +0200 (CEST)
Date: Wed, 25 Jun 2025 13:52:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ard Biesheuvel <ardb@kernel.org>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/sev: let sev_es_efi_map_ghcbs map the caa
 pages too
Message-ID: <rite3te5udzekwbbujmga5kyyjjm5gfphhqoxlhtsncgckq6rm@7m7owl5jgubz>
References: <20250602105050.1535272-1-kraxel@redhat.com>
 <20250602105050.1535272-3-kraxel@redhat.com>
 <20250624130158.GIaFqhxjE8-lQqq7mt@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624130158.GIaFqhxjE8-lQqq7mt@fat_crate.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

>  	for_each_possible_cpu(cpu) {
>  		data = per_cpu(runtime_data, cpu);
> @@ -1066,6 +1069,14 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
>  
>  		if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags))
>  			return 1;
> +
> +		address = per_cpu(svsm_caa_pa, cpu);
> +		if (!address)
> +			return 1;
> +
> +		pfn = address >> PAGE_SHIFT;
> +		if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags_enc))
> +			return 1;
>  	}

The kernel allocates the caa page(s) only when running under svsm, see
alloc_runtime_data(), so this is not correct.  I think we either have to
return to the original behavior of only doing something in case address
is not NULL, or wrap the caa code block into a 'if (snp_vmpl) { ... }',
following what alloc_runtime_data() is doing.

take care,
  Gerd


