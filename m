Return-Path: <linux-efi+bounces-2489-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0319FDEA2
	for <lists+linux-efi@lfdr.de>; Sun, 29 Dec 2024 11:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587FD1615B6
	for <lists+linux-efi@lfdr.de>; Sun, 29 Dec 2024 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98987083F;
	Sun, 29 Dec 2024 10:38:36 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3237C33086;
	Sun, 29 Dec 2024 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735468716; cv=none; b=Fe50cHLHdoGkvMujNDSUtTFxFFwgBjlrJOpRq6yCya5wqo+Ptcc0J1N9qEoNoFDXzNX/OFUmLNsv6FsafX8zxCKsvJa2I/oo1o00JD8AGssl/UaNfTqngJhdyXMogMM1H1M0B9tmWeUD2ZgF/1e3/MsYX/BGkoo2CRcDUZ2Bv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735468716; c=relaxed/simple;
	bh=t2uTADVocY+WgHVkHPrCkNSE9pIX0T7DWY0RTimNynQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwyaKcwNsDduXjdYbwZzEh5WeU5BkUzyyoHxvFSSxrMqiGAYQK9uKlq0lrVBlepJpGg1PkP3k4CiKzJyG3mrSSBmbiLV+KdL/KT/O3WmgaeZ3DQS30FGcWhWwZk6jzRTTHcN6TuEKl9y4xnYo64swX7x6uMFbYN/xuXtegZ494g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id A75892800B1AC;
	Sun, 29 Dec 2024 11:38:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 952F736FBD7; Sun, 29 Dec 2024 11:38:24 +0100 (CET)
Date: Sun, 29 Dec 2024 11:38:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Lleyton Gray <lleyton@fyralabs.com>, gargaditya08@live.com,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH] x86/efistub: Add options for forcing Apple set_os
 protocol
Message-ID: <Z3EmoNWbkbYZ7NZO@wunner.de>
References: <20241228202212.89069-1-lleyton@fyralabs.com>
 <Z3EdkuCBzTGzTHK3@wunner.de>
 <CAMj1kXHWoD78QdFnEY_=Mtz02zN3rhN5+Skgv=fHG91TD8Mmvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHWoD78QdFnEY_=Mtz02zN3rhN5+Skgv=fHG91TD8Mmvw@mail.gmail.com>

On Sun, Dec 29, 2024 at 11:08:55AM +0100, Ard Biesheuvel wrote:
> IIRC, the original issue is about not being able to use the discrete
> GPU with the built-in panel, and the issue about an external GPU did
> come up in the discussion - however, this does not affect the built-in
> panel at all.

The original issue was that the integrated GPU is hidden (powered off)
unless the set_os protocol is used.  So only the discrete GPU is
available, which results in terrible battery life.  Using set_os
keeps the iGPU exposed so the OS can switch to it and power off
the dGPU.

We could have solved this by checking whether there are two PCI devices
with VGA class in the system.  But that would have triggered in the
iGPU + eGPU case.  We wanted to avoid that and thus quirked for the
DMI product names instead.

Thanks,

Lukas

