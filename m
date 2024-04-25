Return-Path: <linux-efi+bounces-974-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A978B229D
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 15:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683572853C3
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D786149C66;
	Thu, 25 Apr 2024 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eosGQqeo";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eosGQqeo"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25F149C5E;
	Thu, 25 Apr 2024 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051494; cv=none; b=Q5q+dtk/AsymeQfn586MJaRRyUDhXI1pYQB4f+y2PdJfQjUJTKb80AGqWEsZFqb+QHhUSZdVo53NL+0T/7LPygSWqOJILDSct1mKH7kPDXAymtxowhlsw+g94e8QmRzHNpjC/G8sjVr0QBJPT7pNbF1gU1oDsMVKznCc0HBFQ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051494; c=relaxed/simple;
	bh=ozjaLJHhWZpDTgLDXvd1VlEiwMrroifvmzMJERJwjEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CnbB6UQ/6JJQ6YUe7o6T/OigZjJpxKxzM1QvcklasDdQ4Uw/vZL1aHbMySI/kNqVurCHc/BOSWQcrwaEO9alyFE6436TZ6ZQwjYmPZuKxu+hFfK8qSxmF5rlWVU9h872j4jOL+DoBK455gttISoQGW9u14FpWGdQbAwB151xn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=eosGQqeo; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=eosGQqeo; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714051491;
	bh=ozjaLJHhWZpDTgLDXvd1VlEiwMrroifvmzMJERJwjEw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=eosGQqeowpDPkjn7yZa3it8SLlwPDU4EN0NhcxI7x/BMV9snDWs9UUbUNnpEOg3Uj
	 2dyl3DoImzR/mxCzR6CeauSwWgMlntG8swy+vv+lDshSi7/Iev4tgge038eYCa8fPU
	 M/Fa5LaI1/cmtvGdp4cJAISb7SrlKhADUYt1FRzc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6C9AD1286C62;
	Thu, 25 Apr 2024 09:24:51 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id aSEB-T6M91Te; Thu, 25 Apr 2024 09:24:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714051491;
	bh=ozjaLJHhWZpDTgLDXvd1VlEiwMrroifvmzMJERJwjEw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=eosGQqeowpDPkjn7yZa3it8SLlwPDU4EN0NhcxI7x/BMV9snDWs9UUbUNnpEOg3Uj
	 2dyl3DoImzR/mxCzR6CeauSwWgMlntG8swy+vv+lDshSi7/Iev4tgge038eYCa8fPU
	 M/Fa5LaI1/cmtvGdp4cJAISb7SrlKhADUYt1FRzc=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5A95912864AA;
	Thu, 25 Apr 2024 09:24:50 -0400 (EDT)
Message-ID: <f6259f0a28b80db78d28475105ae7f37655a58ee.camel@HansenPartnership.com>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Lennart Poettering <mzxreary@0pointer.de>, Ard Biesheuvel
 <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Mikko Rapeli
	 <mikko.rapeli@linaro.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Date: Thu, 25 Apr 2024 09:24:48 -0400
In-Reply-To: <ZiopXE6-AucAB9NM@gardel-login>
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
	 <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
	 <ZiZhSfgeAdrbnaVL@nuoska>
	 <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
	 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
	 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
	 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
	 <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
	 <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
	 <ZiopXE6-AucAB9NM@gardel-login>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-04-25 at 11:58 +0200, Lennart Poettering wrote:
[...]
> General purpose distros typically don't build all TPM drivers into
> the kernel, but ship some in the initrd instead. Then, udev is
> responsible for iterating all buses/devices and auto-loading the
> necessary drivers. Each loaded bus driver might make more devices
> available for which more drivers then need to be loaded, and so on.
> Some of the busses are "slow" in the sense that we don't really know
> a precise time when we know that all devices have now shown up, there
> might always be slow devices that haven't popped up yet. Iterating
> through the entire tree of devices in sysfs is often quite slow in
> itself too, it's one of the most time consuming parts of the boot in
> fact. This all is done asynchronously hence: we
> enumerate/trigger/kmod all devices as quickly as we can, but we
> continue doing other stuff at the same time.

So let me make a suggestion that you can use now.  Since all you
currently care about is the EFI/ACPI device, there is always a single
sysfs entry that corresponds to that (so you shouldn't need the log
entry as an indicator):

/sys/bus/acpi/devices/MSFT0101\:00

That link (or a kobject uevent if you prefer to look for that) will
always appear regardless of whether a driver has attached or not.  When
the driver actually attaches, a driver/ directory will appear where the
link points.

The device link is added when the acpi scan is initiated as a
subsys_initcall, which is before all the filesystem initcalls, so it
should run before the initrd is mounted.

Is this enough for now and we can think about a more generic indicator
that all drivers have been probed later?

James


