Return-Path: <linux-efi+bounces-3251-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3168AA82165
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 11:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0551BC063C
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F48525D8EA;
	Wed,  9 Apr 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ/6lBxU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E6C25D52E;
	Wed,  9 Apr 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192438; cv=none; b=SX53YaXlTSoHSbGL1ksKZV4Y6nmV6MZlskHDIHaZsYvoSOFQeTh9X+SDNrKdkB/cCfsPfXzyGOtNSnj08vKaKyn9Kcc46lkhBpJDpyApHpss4kXc3i6m8u5vUE/PZOH6r7lYbFe1eJ83dBQIqvPKVmMAnuE82nZBuMt8PHOIrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192438; c=relaxed/simple;
	bh=icwaBQvh/HJIJ6hX6T22ITYkWekWbrmc/qHIVRHQwds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0W35WqxO3R2dxv9c9pz5G/rVhprtJx+qxgtAh9LS75ENPH0OfOK/4pfj3FLUfXoQZtz5Wi09ZJE4T5CTJoqxfGIrrNXUeGmiXOS7omF9v5dKoP+B8GBdROfDx5wpnUzo/VUKZc4y70cQKSLvzy3g/2ShN8edvtXupnqxiKA//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ/6lBxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B61DC4CEEF;
	Wed,  9 Apr 2025 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744192437;
	bh=icwaBQvh/HJIJ6hX6T22ITYkWekWbrmc/qHIVRHQwds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZ/6lBxUzo13gwEpKsh1bD6PUEQhrPkZxXHAUMoM8SfUDt7rGc9DFH5XaISA8Arx8
	 tDG3Lt+0E1Axe11thVlO5MFz8ly4BnkDisPufGiKacd64nSjtd5rrytlAWLSZ6m4LJ
	 y1gHtF763P89JER+0aU5O/JJpVSxoHdzzaEI0tGxBtkXbXwPWo53QabVXkmX7wC1I7
	 hQaOYxWBYHttb69FzZIcvEKrv7bPofehbYfLakcU02oV493JsRMifEIlpOKuIfq7yH
	 6s0LETMca+C5PsZQJ1kbapx4E+HUAUip2MBtN4P2N8RTPcXr0S+6zgCjzGOfTRAHNv
	 i7nQ97tvnKCRA==
Date: Wed, 9 Apr 2025 11:53:52 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v3 1/7] x86/boot/startup: Disable objtool validation for
 library code
Message-ID: <Z_ZDsIDaKxgbpHJZ@gmail.com>
References: <20250408085254.836788-9-ardb+git@google.com>
 <20250408085254.836788-10-ardb+git@google.com>
 <f4ac5bf3-d380-45c3-a48c-2969cd49b32c@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4ac5bf3-d380-45c3-a48c-2969cd49b32c@intel.com>


* Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com> wrote:

> 
> On 4/8/2025 2:22 PM, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > The library code built under arch/x86/boot/startup is not intended to be
> > linked into vmlinux but only into the decompressor and/or the EFI stub.
> > 
> > This means objtool validation is not needed here, and may result in
> > false positive errors for things like missing retpolines.
> > 
> > So disable it for all objects added to lib-y
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Solves https://lore.kernel.org/intel-gfx/CAMj1kXEfBMczOmA2+dMMubuD-qE59GTAiV2E_9m8KNG4-rgP6Q@mail.gmail.com/T/#mbf2913e778475b70617390d4a5d0244295b9cb8c
> 
> Tested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

Thank you for the testing!

	Ingo

