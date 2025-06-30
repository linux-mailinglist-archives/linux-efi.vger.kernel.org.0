Return-Path: <linux-efi+bounces-4049-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 160D8AEDC7A
	for <lists+linux-efi@lfdr.de>; Mon, 30 Jun 2025 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062C01887171
	for <lists+linux-efi@lfdr.de>; Mon, 30 Jun 2025 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B225C28983A;
	Mon, 30 Jun 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMrUwMkz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A52749E1;
	Mon, 30 Jun 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285706; cv=none; b=B4kMzNnfDBJzHSuG5rmu7C1CArPHVOfUk1hVaHiyGa858XusqGvCLqFw5tNpCrnmhx6/d8FI2L18D5Fvlg1Pnznt0Ts6U2U70SB4h3Ibqjq0i50i5bC6c9eE4F0pivNijVStuhIIGGp9l4J1OrDf8RZ6tVGmNEa/hcNqVn7QatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285706; c=relaxed/simple;
	bh=lsvia4jB5cwuxRsdD89/gppA5DNlBI8D4wea+9BDgIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXqqKB8jclIIIALsKMamQRIGuQ9JPSxTW3uLJSYh81tx0nwRmeTV8b4FmsGWTWW9+A9E3YsnU8d3iGm/RNcf/oQFErG+YIeNYTedHucoBFfCr79jIi2sxdGmv+4ByxIWlU6dmy0A7f8fBwVfvNYb+hRs6UyTBFNDQNBEVg8RtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMrUwMkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E027BC4CEE3;
	Mon, 30 Jun 2025 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751285705;
	bh=lsvia4jB5cwuxRsdD89/gppA5DNlBI8D4wea+9BDgIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMrUwMkzKVMeySSCgkTEwgLP2ucOR46mj+OjA/EG3sG7d1uSS34jeoW1FyKfG+/Fr
	 ukUNvw24XXyZQgqJBy9eM7S2ju9HeIWOMWRgV5Su183QaFfzd+g1V6FBhk8OyWHEDu
	 J9S93IFUAggYjJs0d+F0WkiEYr25gL/pyNRHshnYn7EspUPVU9eP/p2GTRFDJRlh/H
	 pV9hzSApTV7bqO59ZXsk0FLQM+wpSPIPsh0nc7STVr/Hidk8OuoZW4Ru7ZEuHwqQQx
	 TmRQTyLhiOWRTJJ1zGJAcGpDyLcWBEf6VnkNOhSKnZCp4y/uY6j2o71tZpyz5PZ3cD
	 eutUtAbenFnAw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uWDPc-000000007jB-0OqY;
	Mon, 30 Jun 2025 14:15:04 +0200
Date: Mon, 30 Jun 2025 14:15:04 +0200
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
Message-ID: <aGJ_yIdfZil0EhoU@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-1-aacca9306cee@oss.qualcomm.com>
 <aF0bLtnABcGTi0wM@hovoldconsulting.com>
 <zw5u5c2itmpxq34d22y5wmtr32d4zsmjj5clf77ryeqs5jgd4v@t3wjfyj43yra>
 <aF1CX2uWZ_KaMDVR@hovoldconsulting.com>
 <CAO9ioeWwyxSgG9DNYpW-Z_SU_Scv+4sSBs8UeZnxFz+tOaESEQ@mail.gmail.com>
 <aF6OQqD9V7AYUkwO@hovoldconsulting.com>
 <h6huo4dohj6y5ne6ehs7ysjnarhtlztyycuztaixpvumvskmjj@x64n7svubc3q>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h6huo4dohj6y5ne6ehs7ysjnarhtlztyycuztaixpvumvskmjj@x64n7svubc3q>

On Sat, Jun 28, 2025 at 06:05:51PM +0300, Dmitry Baryshkov wrote:
> On Fri, Jun 27, 2025 at 02:27:46PM +0200, Johan Hovold wrote:

> > Ok, so then there are no current drivers that will benefit from your
> > change, but you may (or may not) need it if you enable RO efivars on
> > this particular platform. That is, this patch is not actually fixing
> > anything that is broken currently.
> 
> I'd leave that to a discretion of EFI / EFI vars maintainers. RTC driver
> definitely is broken in its current state.

Again, no. We only need this when you start enabling RO efivars on
Qualcomm platforms. So you're not fixing anything that is currently
broken.

Johan

