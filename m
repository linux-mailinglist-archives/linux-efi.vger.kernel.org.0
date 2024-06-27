Return-Path: <linux-efi+bounces-1299-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D50191A118
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jun 2024 10:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5771F2859E4
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jun 2024 08:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D90C6BFB0;
	Thu, 27 Jun 2024 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f7ND9KDc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D723BE;
	Thu, 27 Jun 2024 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475699; cv=none; b=JZECEP/tbXyWFbmXwxhpKe93qjtZTQlCt4amA/fXyZwzQwvtLCxq1c8QuYd4VFaj6qf+Zl5oXVMKsEzZ63iE6yoYOkQJb/j2T/i9myXVJXgHRldl0cTprYjOapg+qRqf7goDDybvQV+11M6NMoA6F/rT0vqCnln0siWlUmSf/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475699; c=relaxed/simple;
	bh=ZmR9CXwJJaD+GIfJYusbCJV15GW8oH+aU3JokSQJtKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZULOHWcLzfiW1uh2AG3ByX3/KkBcvWbpzOAk1g6qsXcCzqbZvUtwLBGbYNkI7W/KWK5VzWjxDvxgXsz4WPoiaKzm6VqbdI3O4ic8MPkfyZS3MRB3JeOT46P5gcU/H3sopmefDFumenTnLG5Vy4m2qVm/Lwkx3/rw4EuBYYAZ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f7ND9KDc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0826540E0218;
	Thu, 27 Jun 2024 08:08:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Q-NpYebjyMPP; Thu, 27 Jun 2024 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719475691; bh=wSf84zY5OWVPv4j64Nkb8nYxO0ZWwlNOcLJMMDH8L1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7ND9KDcT/S5ZvKEFt7cQGe45MdlcXNKN3YkXdYDwj/FBPhZ4xt6zNiKwAUvFrzHS
	 uXc7RmE/lJKL5svBwomMDfms/ysaBC5Zh9V8Av5C5TEQyJQ5c4eNlwfvntICeY6tuo
	 xr6c+ymm2sq1wsL21H2SdPDXjeGt4n3BAfZZ1wiLJtIUc5xThgL/sUJes+d1npiT50
	 wfpMNZZ0+NBetDG+LTrGg5qed67Z6kWYoDNeXJ4Gdz7avFdA1xZhfd1mIIR28s2E1N
	 S/RxaeLqSk0wGgMHvjEZTFwwrZ7zkhTi9zamxBuAYdO1x4qYkZwkq1VQXrBYfyD8M1
	 5BeimJZo9NRUgPorgLQUhvdZEnwwGZq9xAtn48hHvYKFwqyUtWgz1rdITl0sSsZKGN
	 1Ae4oHMSendfYDYBYFXEm0T+OuLi89VG7bXceXhx2wogJaFK5m01ouflnl1Je1B+lQ
	 /PamGnrxWzsIcnoQP5GdJ51xClaJ3CHGK7RKa8bYDfurXsryqQER+ctQffv2qLkL+z
	 SvnxQd9RTvOx2bcOSDzKRCVWNepxSLrgU2fWCglmtkPhwOje6xlph7Lk9EukUflDyM
	 wGnoo/aFUCNx4RH0arl/C2qRPKnANhfK79F9OKujoKip/bJc6Cq/67VZuHnI1/cbr5
	 EoAFF7JMmEoJzzHxNG1+W+Ig=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E1DFE40E0187;
	Thu, 27 Jun 2024 08:08:02 +0000 (UTC)
Date: Thu, 27 Jun 2024 10:08:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>, linux-efi <linux-efi@vger.kernel.org>
Cc: rafael@kernel.org, lenb@kernel.org, yazen.ghannam@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ACPI: PRM: Add PRM handler direct call support
Message-ID: <20240627080801.GDZn0d4Sr9y0B6zvPh@fat_crate.local>
References: <20240506174721.72018-1-john.allen@amd.com>
 <20240506174721.72018-2-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240506174721.72018-2-john.allen@amd.com>

On Mon, May 06, 2024 at 05:47:20PM +0000, John Allen wrote:
> Platform Runtime Mechanism (PRM) handlers can be invoked from either the
> AML interpreter or directly by an OS driver. Implement the direct call
> method.
> 
> Export the symbol as this will be used by modules such as the AMD
> Address Translation Library and likely others in the future.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> v2:
>   - Align statements setting fields in context buffer on '='
> ---
>  drivers/acpi/prmt.c  | 24 ++++++++++++++++++++++++
>  include/linux/prmt.h |  5 +++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index c78453c74ef5..1cfaa5957ac4 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -214,6 +214,30 @@ static struct prm_handler_info *find_prm_handler(const guid_t *guid)
>  #define UPDATE_LOCK_ALREADY_HELD 	4
>  #define UPDATE_UNLOCK_WITHOUT_LOCK 	5
>  
> +int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
> +{
> +	struct prm_handler_info *handler = find_prm_handler(&handler_guid);
> +	struct prm_module_info *module = find_prm_module(&handler_guid);
> +	struct prm_context_buffer context;
> +	efi_status_t status;
> +
> +	if (!module || !handler)
> +		return -ENODEV;
> +
> +	memset(&context, 0, sizeof(context));
> +	ACPI_COPY_NAMESEG(context.signature, "PRMC");
> +	context.identifier         = handler->guid;
> +	context.static_data_buffer = handler->static_data_buffer_addr;
> +	context.mmio_ranges        = module->mmio_info;
> +
> +	status = efi_call_acpi_prm_handler(handler->handler_addr,
> +					   (u64)param_buffer,
> +					   &context);
> +
> +	return efi_status_to_err(status);
> +}

+ linux-efi as Rafael wanted to make sure the environment is created properly
for the EFI runtime services call...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

