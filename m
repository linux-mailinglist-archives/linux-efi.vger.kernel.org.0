Return-Path: <linux-efi+bounces-2784-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9138AA2F89A
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 20:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0AB3A0704
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 19:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3352566CB;
	Mon, 10 Feb 2025 19:25:55 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2A25E46C;
	Mon, 10 Feb 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215555; cv=none; b=NWqf09S0iyXSu41ITE3SKGkMoJyu0dDEh+hwQEzvsMX/+VUbNpcRu7uMTbTKv1e9HXq57OwZymVb/BNHW1m2IxEIvgrXqyMoUw1k3g67trl6SuHDppbv+pPROLoPgCwY/e+uHIeUYDG7UzH/5toVqmL7YfCspEHU35dH8siQceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215555; c=relaxed/simple;
	bh=JLrIHvcMfDESnQCoY0goFByP4FrecpGOavPA8S3yvAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLGRFbTQYvL3Jnzj1vJ7z9mo+BCTCeVz8473NvdPRd6pXN5QV8WaemmhSMUzNAnmatRPHmV0s3DFLjxUWgj/AAxlCXEIB/7Dw8eGGnQnhObWbzY4By6rOEIz17v+S7REfq8QwbRxyxyhmzDPrDyGyaWjfj22GDwla48IaMI1/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4761228008798;
	Mon, 10 Feb 2025 20:25:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 17F603EB81E; Mon, 10 Feb 2025 20:25:50 +0100 (CET)
Date: Mon, 10 Feb 2025 20:25:50 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Lleyton Gray <lleyton@fyralabs.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, gargaditya08@live.com,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH] x86/efistub: Add options for forcing Apple set_os
 protocol
Message-ID: <Z6pSvg1qzALcuV94@wunner.de>
References: <20241228202212.89069-1-lleyton@fyralabs.com>
 <Z3EdkuCBzTGzTHK3@wunner.de>
 <CAMj1kXHWoD78QdFnEY_=Mtz02zN3rhN5+Skgv=fHG91TD8Mmvw@mail.gmail.com>
 <Z3EmoNWbkbYZ7NZO@wunner.de>
 <CAMj1kXEb9NPSwEr2brHYJtFQhnW55hoPycjcAgoPAfjU5ZFqZw@mail.gmail.com>
 <abe2274b-4341-4212-85a8-113273ce1b18@fyralabs.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abe2274b-4341-4212-85a8-113273ce1b18@fyralabs.com>

Hi Lleyton,

my apologies for the delay.

On Sun, Dec 29, 2024 at 07:09:15PM -0800, Lleyton Gray wrote:
> On 12/29/24 10:22, Ard Biesheuvel wrote:
> > On Sun, 29 Dec 2024 at 11:38, Lukas Wunner <lukas@wunner.de> wrote:
> > > The original issue was that the integrated GPU is hidden (powered off)
> > > unless the set_os protocol is used.  So only the discrete GPU is
> > > available, which results in terrible battery life.  Using set_os
> > > keeps the iGPU exposed so the OS can switch to it and power off
> > > the dGPU.
> > 
> > Yeah, so it would be good to know what issue are trying to fix with
> > this patch.
>
> I believe this is another issue that requires the same set_os quirk. In
> specific, amdgpu fails to initialize when using an AMD eGPU in a T2 system,
> unless the set_os protocol is used. Because it's currently quirked for the
> product names of dual-gpu T2 Macs, if you're on a system that doesn't match
> those names (ex. 2018 Mac Mini), there's no way to enable the protocol to
> get an eGPU working.

How does the amdgpu initialization issue manifest itself exactly?

Could you either provide full dmesg output both for the failing case
and the success case (i.e. with your patch)?

E.g. could you open a bug on bugzilla.kernel.org and attach the dmesg
output or at least provide a dmesg excerpt with the relevant amdgpu
initialization messages?

Any patch to fix the issue needs to provide a proper explanation
of what's going wrong without the patch and why, so that anyone
working on the code in the future can understand why the change
was made.  Just stating that amdgpu fails to initialize isn't
sufficient in my view.

Thanks,

Lukas

