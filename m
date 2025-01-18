Return-Path: <linux-efi+bounces-2663-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2D2A15C26
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2025 10:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCA9166AB6
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2025 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059035789D;
	Sat, 18 Jan 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="j6cJJBrb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5Rg6+It"
X-Original-To: linux-efi@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36081A32;
	Sat, 18 Jan 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737192462; cv=none; b=c+xBR0sKw8Tvi6WrFIR/N/lAGIOVz0uRuBFB9JLvmtB8LEOjQD6zGECke//xnClMEsEZAOBfura8UUgPu7ccsEmdht4TdajZ1y9QyOczowHyeHCrW1yDsWbPSytroNufm7Mh8cu7R3A8EuivXZiGJEHCztcOfDyLIZlhBVgl1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737192462; c=relaxed/simple;
	bh=QfFpxojFlK1cR6s836/jrQOwflKa0RmdYDZcDOcslH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCF7u4bu2eGrhl4clQb1sDKRJaljvhEpte2JVV/jW6WFCcNHLc8mgtYDIO1h+1GNpk/7mi21/kKYoZPlZjZX/WcZlZdEdmHWK7bSOV+YTfEOnMm6otjFEi9AECzzcE76gGQ0k8g8n7bpSBxSXsQIvf0H2Ek41QfwkrX7f/+xyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=j6cJJBrb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5Rg6+It; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F27051140142;
	Sat, 18 Jan 2025 04:27:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 18 Jan 2025 04:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737192458; x=1737278858; bh=hbbn5s1hjV
	hA5LwIyMZO8QF6OuOBer8UprGir9N3N+Q=; b=j6cJJBrbMHoVNQFPn1Wjt6y+nS
	tvAOBdojQrjrTHpw7Qnij8VUXNMa6v47xXzhHY/atIdw8BmSF2r81HIFI7OCx61o
	jx5wyqHQR9Ay3QYjY9zW1PCErmc2dNlYkv3IAu7tsuqyvGrC7nx7gtfwJTCFJFvk
	/jyNEdIpKOLrIL+NNvsX05iebJxlQVqe7qy/3b0Z32WKW3vpOxdP1cF2CUWV7ZJ3
	Bk4nwYSjD+lq2EX7LXaods9OvwfQjF1QAJ2Dl0dYSDBsZ+hwXVVXnX1DXF5tlJ+4
	2q2oYb1isxYVo1G85ukEjsX07FIeTdSbTYBs+DaI6P6yGHd97wldtx26vrZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737192458; x=1737278858; bh=hbbn5s1hjVhA5LwIyMZO8QF6OuOBer8UprG
	ir9N3N+Q=; b=Y5Rg6+ItKcPSj5jm7gbGr8i8zlNq6w+EsqcUHF1vW+YBe+a831z
	jLjLYOCGCc7BP4Ku2xNlKYkWguLiPv+zC56fRc0AGKdJ9iC+J/umoRz7x+4T8rV+
	JW8Lr1cOUw/u4jEBoVTCSJ0ftSeowRG8h81lTZMDue5LXSXL+DYJ1bdrWCGgS9oW
	w8s2AdQ632/hkP1Yfgb1UvEQvaPLTYSQH4sfU0CRLscyNhqSS2/r4eDV2bTNzLYS
	7vEgMH6xGt6P4Epk11qr5+vavg9OeiO1RkstTjgjBfK/PLndRqh7oQBcioV+yNcF
	dr4vSBuQMkE/KRzCzB9lEXUUuoBf4k/iYJw==
X-ME-Sender: <xms:CnSLZxj9ytDnMrHlhlIQcOZkxK9ECZxSnDROTVXLaDNpvguJCXDq5A>
    <xme:CnSLZ2Bv56_wDipr-PTRRhDoCLC95hEj-_Fs0r9mVmSFSCrSBagHJMgykWPAXdlMK
    JxsGTlVYD-bPQ>
X-ME-Received: <xmr:CnSLZxEEe7epnMwtgXKM1REft3ughQds-sP4zt9YRa76atJqpM91I_WTDgbyFzpUmEgWmci4emFFj5qcDOLhgwyxtZY6K2B5bMyjbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeihedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefh
    gfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CnSLZ2Rtl2eEZD_GaSHAwPe9ZeZS7HaeSPOecDIy2mKK69nxTeBQSA>
    <xmx:CnSLZ-wvNfSHNTrPmssysYm0s5Rsun5NxU7Td6DSvzwmjRL0fs-Yow>
    <xmx:CnSLZ84LKhrTnHduzjIiJ18_Y1J-i4-nF7ckEOI5nYuKUmmBR8Yx9g>
    <xmx:CnSLZzysB-NXC7fA_jywXk4AP0cUtcV6YSr-s42-4N-13F3iET0X3w>
    <xmx:CnSLZ1nY0fN7me7qxE7RqlLzrSGPehvB0TbkB7dPVjoiuVfHxBfH_69G>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jan 2025 04:27:38 -0500 (EST)
Date: Sat, 18 Jan 2025 10:27:36 +0100
From: Greg KH <greg@kroah.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>,
	linux-efi <linux-efi@vger.kernel.org>
Subject: Re: backport request
Message-ID: <2025011828-nutmeg-reverence-4063@gregkh>
References: <CAMj1kXFiGMeyQSMsYWuEgSnXVU4GfVC3JDLGhZ7L2=BEvxHVsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFiGMeyQSMsYWuEgSnXVU4GfVC3JDLGhZ7L2=BEvxHVsQ@mail.gmail.com>

On Sat, Jan 18, 2025 at 10:10:11AM +0100, Ard Biesheuvel wrote:
> Please backport
> 
> 0b2c29fb68f8bf3e87a9
> efi/zboot: Limit compression options to GZIP and ZSTD
> 
> to v6.12. Future work on kexec and EFI zboot will only support those
> compression methods, and currently, only Loongarch on Debian uses this
> with a different compression method (XZ) and so now is the time to
> make this change.

Now queued up, thanks.

greg k-h

