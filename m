Return-Path: <linux-efi+bounces-2979-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 008BCA5E92A
	for <lists+linux-efi@lfdr.de>; Thu, 13 Mar 2025 02:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E563B81BE
	for <lists+linux-efi@lfdr.de>; Thu, 13 Mar 2025 01:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676EDF50F;
	Thu, 13 Mar 2025 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="bLwtccGY"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8346610C;
	Thu, 13 Mar 2025 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741827811; cv=pass; b=I8G6xYzOtesUgk9hiyH15vq10ZaSzjtttjzjmctWk+VUToXrSkaoWYP0H3pFpocIAngiYWAaCn7I7A42L56QM1JNH8X6uXDHYEADeQBBPdjXZKbiELH/s8wP9BMEpyOJEAgz6xmNpQ0F1xleTnxpjOltPsdWFHYyED0xD71jKAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741827811; c=relaxed/simple;
	bh=Xe3B4hZH/39/1+ZMlB91zwQAW7BESAh9yC8Kk4Poq64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLLsVr1TQ6AGenQeuZxDHaelFTo9xFngxEMXyBs3WIkTRx3Jx4LMlheRUH0Cr+Xc34IG7xm9tu55ya8kjjsv8HqdgQ3tVxdogXM2zif6YIq9gH5kY1u3w0rZ3C4kG2QHhsHbGDhGM2Fw5f2EqDii5KlyG6eV7c3wRQcD16PaCXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=bLwtccGY; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1741827791; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aYqMtTqG+3p/MkkiUTzJHc0ZxysbxdP9h+M3dXq8Ml2nGJ8plJM4KVlPTmWlqPYhuE7GmbSDvjd6bzNFCkw2bfR8pPtn6t2b/5JMvJ0isiFnqWw8yF86tMRgwgCkC/vwQk4G5TXJQvn7QU5abSV10UdC5avkEozKSy02MRAwLLs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741827791; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PeCprVw92CsL02sIwDel1VhQLuEYGEuNiwZXot++wG0=; 
	b=oBoePiScMNSLd7Gn2io+GSdzJaQ1xDMOJ53bRGh495lIsDxot7z4JeD/pmKyK2wkpZ5EPK5m428O3mgkLB9SziJsIPyaLZ8Bju/0/1oSCpjAfm4JlsRuxlvcaMLCr1OgzMooYYOE3aBfWpr8lp7qUZD1vc77WWyDygn5Jh5Whvs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741827791;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=PeCprVw92CsL02sIwDel1VhQLuEYGEuNiwZXot++wG0=;
	b=bLwtccGYu5TkXjhgc/TouFRTBpkNdtlCehACVl3JVIjZdIwqgGZ+p9PxHClDPkoB
	fzRSAlw35yjGp1+ijF1cxkAr+9CH5xuhHRIyFOexiLbcEsXsdAdeJ6AN70Ja5TJ2wbK
	U+9dZHDCrlNf3fXnjRMg6rCFX+mT9zZ7+zbDu/v4=
Received: by mx.zohomail.com with SMTPS id 1741827788003628.5791664550408;
	Wed, 12 Mar 2025 18:03:08 -0700 (PDT)
Message-ID: <18b174c5-1b1a-4c1c-ad55-0168eb58350c@zohomail.com>
Date: Thu, 13 Mar 2025 09:03:05 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
 linux-efi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310223839.31342-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250310223839.31342-2-Smita.KoralahalliChannabasappa@amd.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250310223839.31342-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112270372dcc6d7d8e91220cd4f0b000029f7c72569e97a3b5cbc51e5a2ea8ec402eb324e50cd3daf2d:zu08011227875961aed2394afabe7f5c840000110cc8c0f03617f41081dc088d9a73e640a182697eedee418f:rf0801122d1d8295c2f4af958307a0a4ff0000066c9f27c7a3b6d06b704efcad7d07900ad2df7c240e9f11fdfaf7d67329fb:ZohoMail
X-ZohoMailClient: External

On 3/11/2025 6:38 AM, Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records. Introduce support for handling and logging CXL Protocol
> errors.
>
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error trace native CXL AER endpoint errors. Reuse them
> to trace FW-First Protocol errors.
>
> Since the CXL code is required to be called from process context and
> GHES is in interrupt context, use workqueues for processing.
>
> Similar to CXL CPER event handling, use kfifo to handle errors as it
> simplifies queue processing by providing lock free fifo operations.
>
> Add the ability for the CXL sub-system to register a workqueue to
> process CXL CPER protocol errors.
>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
[snip]
> +int cxl_ras_init(void)
> +{
> +	int rc;
> +
> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +
> +	return rc;
> +}

Just one minor comment.

This rc is not needed, can return cxl_cper_register_prot_err_work() directly.


Reviewed-by: Li Ming <ming.li@zohomail.com>


