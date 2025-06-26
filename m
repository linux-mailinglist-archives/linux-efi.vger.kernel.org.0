Return-Path: <linux-efi+bounces-4012-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297EDAE9DD6
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 14:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F131891A15
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 12:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF19C2E11C0;
	Thu, 26 Jun 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImCv6ObT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09CF25B30A;
	Thu, 26 Jun 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942303; cv=none; b=dHeKrKE2c58cRk5Ug8Y1+r0qm1ldn2FWSsOgcxnbBLqbmveXGzyfExGdXnfrBJWuMVBOle7e99JnP66HnMBiAKAHpUqttDWmwl8pe6yOauTZPW0lv/EgAKkc0BsYGyfBlUbF5b3VJaAdlHECLosffpw1Gh2k3GBMg1me5pTLYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942303; c=relaxed/simple;
	bh=8afNf7PyPPaAQWANU7A3DLhpaQ+s9j1MDXRhxYStnjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7K08nDHI72nl7w7K5qPTawrPEvcVzHaqtsWUDUs3UDaulrgH4ELc9cOd7aGklotop1sZmmxDwXvW4dVJ+lafTksZUYUgde0GFZ4/8qznqkXlPnTJ+UC/KuLmgqUBuezv1buxJ9IyuS63YeDz2g61TEJec0dRX1F4bFdYQAen3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImCv6ObT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828A6C4CEEB;
	Thu, 26 Jun 2025 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750942303;
	bh=8afNf7PyPPaAQWANU7A3DLhpaQ+s9j1MDXRhxYStnjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImCv6ObToIuXugjVBqaNgFeXhZChj1a82IRrLH+3tN2CrHKIh2EIw3YC9E0TEbZ7K
	 X30O3wYuHkBKaFx/L3rCEwrXw+JhF8sfIK8MfnL8K1tA0a9n8cxPKcUQvip226z7fo
	 KgbtgP7eimMk5TBd2prDdGutJzIFLJZFZOMs+V60HDf/WmdAA/zbyZz9V+6a3xwtaO
	 uYnHDw+UAZe8xx/I8IL60apeV+Ip/UWmD849kujQnEVRBW+e872LwXGppmFHwwFpR6
	 8DG9iLyfOdYv0d4yfYQGddjjflnIX5bVLLIMe9oA+waW4FL2JlbLfmdE+Q6CfURM20
	 VaUjlcwNELXag==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUm4t-000000002F3-2CQw;
	Thu, 26 Jun 2025 14:51:43 +0200
Date: Thu, 26 Jun 2025 14:51:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 1/8] efi: efivars: don't crash in
 efivar_set_variable{,_locked} in r/o case
Message-ID: <aF1CX2uWZ_KaMDVR@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-1-aacca9306cee@oss.qualcomm.com>
 <aF0bLtnABcGTi0wM@hovoldconsulting.com>
 <zw5u5c2itmpxq34d22y5wmtr32d4zsmjj5clf77ryeqs5jgd4v@t3wjfyj43yra>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zw5u5c2itmpxq34d22y5wmtr32d4zsmjj5clf77ryeqs5jgd4v@t3wjfyj43yra>

On Thu, Jun 26, 2025 at 02:03:44PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 26, 2025 at 12:04:30PM +0200, Johan Hovold wrote:
> > On Wed, Jun 25, 2025 at 01:53:20AM +0300, Dmitry Baryshkov wrote:
> > > If efivar implementation doesn't provide write support, then calling
> > > efivar_set_variable() (e.g. when PM8xxx RTC driver tries to update the
> > > RTC offset) will crash the system. Prevent that by checking that
> > > set_variable callback is actually provided and fail with an
> > > EFI_WRITE_PROTECTED if it is not.
> > > 
> > > Fixes: 472831d4c4b2 ("efi: vars: Add thin wrapper around EFI get/set variable interface")
> > 
> > I don't think a fixes tag is warranted here as it currently appears to
> > be expected that the callers check if setvar is supported before calling
> > this helper (e.g. by calling efivar_supports_writes() as efivarfs does).
> 
> It is not documented as such. So, I think, we'd better not crash the
> callers.

You need to look at the backstory to determine that before jumping to
conclusions (e.g. start by looking at f88814cc2578 ("efi/efivars: Expose
RT service availability via efivars abstraction")).

> > So should perhaps be fixed in the RTC driver if we agree that supporting
> > read-only offsets is indeed something we want.
> > 
> > Are there any other current user that may possibly benefit from
> > something like this?
> 
> efi-pstore comes to my mind.

No, that driver is also disabled when efivar_supports_writes() returns
false.

Johan

