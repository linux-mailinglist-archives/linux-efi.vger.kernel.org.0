Return-Path: <linux-efi+bounces-888-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2FC88FA03
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 09:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58661F25F1F
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 08:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A1F524DE;
	Thu, 28 Mar 2024 08:29:36 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60926AD8
	for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614576; cv=none; b=FEBoL7FC+6OqSdDS32AWRbsGz+EkzoWN5ms6XCjxerh8jTCAo6+2mJDH+QSQimNZV4J6c9bUiedG4S4qt9sDu7DbaffHB9OcA2PZrakpBUUiMOQquBVlexh0vDGt8SuGKhNs4XjkXd1JehBgreYbUFQlwSXFR9slpI+YpJp5q98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614576; c=relaxed/simple;
	bh=Hnz6Yh7JEIinBKeyVKOgY2Uk+CJQDsKtlRRh2b2oI0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ur1l8L+a3RWUnaOxSPN2qkZbGDOy8y4r2kRXIqB78lKVq1r+wZfW1RFpkyryCTry4fw8OmCtNkz0EaFT9bvjqtoq2jpLLslD43WEg8bM425j/8nloGvD6oxKs04qMsMijuRyp/hsRCmyQ/rgH7b35BYLBXyhWSBjFL3lDLygsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 17ADF30000868;
	Thu, 28 Mar 2024 09:21:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 03BF463C8; Thu, 28 Mar 2024 09:21:43 +0100 (CET)
Date: Thu, 28 Mar 2024 09:21:42 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, kazuma-kondo@nec.com,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] efi/libstub: Cast away type warning in use of max()
Message-ID: <ZgUollgbjAkTR0CD@wunner.de>
References: <20240326101850.914032-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326101850.914032-2-ardb+git@google.com>

On Tue, Mar 26, 2024 at 11:18:51AM +0100, Ard Biesheuvel wrote:
> Add a missing (u64) cast to alloc_min, which is passed into
> efi_random_alloc() as unsigned long, while efi_physical_addr_t is u64.
[...]
> --- a/drivers/firmware/efi/libstub/randomalloc.c
> +++ b/drivers/firmware/efi/libstub/randomalloc.c
> @@ -120,7 +120,7 @@ efi_status_t efi_random_alloc(unsigned long size,
>  			continue;
>  		}
>  
> -		target = round_up(max(md->phys_addr, alloc_min), align) + target_slot * align;
> +		target = round_up(max(md->phys_addr, (u64)alloc_min), align) + target_slot * align;

Why not

    max_t(u64, md->phys_addr, alloc_min)

?

