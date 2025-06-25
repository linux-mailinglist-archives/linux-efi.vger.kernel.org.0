Return-Path: <linux-efi+bounces-3971-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A21AE82E7
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8C8188B483
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA625F7BC;
	Wed, 25 Jun 2025 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="APH1KeW1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807125F7B7;
	Wed, 25 Jun 2025 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855247; cv=none; b=u6zCZBBu+uptu4kPCt73hoEjn5Pkx5AuACKiOtRUTTN7bs7Nd9Ux2VI0CojiRvqO/uNif7buOUYMYDh84ssGfOfcgNguC+LSVj96a50A2QD4XFvrFtVE95aJ3XXmyyXh1yLkovWGmzf7HYNbfq6ApGuoJqy1ywZzcFwXCbxDva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855247; c=relaxed/simple;
	bh=3piVdJ5Rpoay1vw4fI4wqae5TWO4qrTJb4cY0WDEBlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSBQmBc4+VFfuhuwvo9x1ccag77Ehms0WmV0FNb3xSbfDdev0/Y5XOvM6VkewQWYDieqDlBFtMbtRgnNKMbvpHMDhyJZbX0pJlTodcGVpYdSN9OplTY05l8nongukEMIb/Meor4gAu39V0cwezse18zj+Xgv0m5H0L168t2r8lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=APH1KeW1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7E7A440E019C;
	Wed, 25 Jun 2025 12:40:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4Sglr0zU2P5r; Wed, 25 Jun 2025 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750855233; bh=Qu0uqHS6hS+NYYsyy4KTtifG0A6XpwmdiXwgTehuKT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APH1KeW1XE225jC7yQvxkqrpLTXdlfBPvQGqhrUXh0IGjNbB7HohLrhXgaIcj5ph/
	 AiFGR1OIKJyL+jYlP73gBurq1OmR/9xCHkfnwEnnNU/utjSoYTkccpc0vDBUpD2i8C
	 GRlT0uw+17R4AKuqwIJs2daPAMavYTdGVRMXciI36Ae3nPAWxXEPubBW9+vI8SgBJf
	 C8dNYDjBS9mzSVzi9vuItH00H2UDeubMKwdDgkVAnmUBhfixXbQAQMmi5gLMHSWMEx
	 pcNJ0gCVlE45qW6ly5YOhGiLHZydFEoiEG7TfqiGbi+BAhsOUglks+iASLgsJmkjg0
	 aW0j2V945zMiVn4RytCUk/V40ojvI4xIqp0JzLdOcpcbOGTYvKaieUJDJmvs1zZbU1
	 9kI/PLd2cz7sT/Ez7LuU9PqMUOECQohWng5GK+WHG7G7NURCFKdh+Dd9om3aG2W5WP
	 1SnpHy+0HhGIgiezHeZNhSHO1hDNKNqC/qcNq17tzysgYNIv0uj60pTD9Qem7UsjMb
	 Z2Eebte5Peo+VtgdVi77LMBA49RIr0htzv6H9IYYS4ri6kIV+35D7G/u7b1AzneLZl
	 7TxrbYHt1zLvgR4mne3L7zFHjs+KTj4E0viZzqKPkWNHDy277SEUMXQsOrlEjAIOEm
	 95/mgwy/Cq9vBQ7udgdSG3Es=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E3F6A40E00CE;
	Wed, 25 Jun 2025 12:40:21 +0000 (UTC)
Date: Wed, 25 Jun 2025 14:40:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/sev: let sev_es_efi_map_ghcbs map the caa
 pages too
Message-ID: <20250625124016.GCaFvuMA9oApInTVyI@fat_crate.local>
References: <20250602105050.1535272-1-kraxel@redhat.com>
 <20250602105050.1535272-3-kraxel@redhat.com>
 <20250624130158.GIaFqhxjE8-lQqq7mt@fat_crate.local>
 <rite3te5udzekwbbujmga5kyyjjm5gfphhqoxlhtsncgckq6rm@7m7owl5jgubz>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rite3te5udzekwbbujmga5kyyjjm5gfphhqoxlhtsncgckq6rm@7m7owl5jgubz>

On Wed, Jun 25, 2025 at 01:52:58PM +0200, Gerd Hoffmann wrote:
> The kernel allocates the caa page(s) only when running under svsm, see
> alloc_runtime_data(), so this is not correct.  I think we either have to
> return to the original behavior of only doing something in case address
> is not NULL

Yes, we're doing something only when the address is not NULL.

Or maybe I'm missing what you're trying to tell me...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

