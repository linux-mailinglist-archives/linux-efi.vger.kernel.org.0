Return-Path: <linux-efi+bounces-5786-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F23C9FA97
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 16:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D61E30680C2
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 15:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ECC314A9B;
	Wed,  3 Dec 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="D5PqznJH"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915830FF2F
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776522; cv=none; b=MGWPNoeLLWJ8sRw9FT1UdD99omwxH7fpR0H6jK74+fzn/K+REI5sSHy+bDpM80juj25ySrEqEfOaEqqhUrmGV0dbFKdm4z/PNSaFrXp3bWuR59ivzXXUSyv7vUwQJSEbzGegEo48NEJPDGkojwasnpyfhJiUzfV2SnKQt8uNfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776522; c=relaxed/simple;
	bh=v/w0DvGUT3zoricAfdunxT4oLeMNzlvoAqpy+A+khJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2BLI9UA3dZnQaqK/prkeABe/EAW4Glbw43IJ0kYt/ySyvlna0smDt+qmfK7puzPoObiZN6BdkW19E7fp83z1FXsE2Kf71a2/yAcThIV3152OsDuOL+tXms5UTMxH4Wy4B1e608UBVQqtWn3uVm6nAnoWfoRtWvpYeCoU7/iyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=D5PqznJH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7jFXEtGd28LIbJvowwbgrPDlPAxDDWwADDdp4ofsmeY=; b=D5PqznJH2INij4h3q/6h9MWuvt
	06hzki6WBmqn7UouHLOdZRURzjY5jg72ZUeQX+5DRKr7uEXK7qrmvoOY/DWPonqBjrPSn6t4DMTC2
	rk68raCACYC40ma89dpruHuG37ao5551gvoev2+4ZtuLua8mY/pv6RwD8RCepFHvqgkifQ8k0dwa1
	eKra7XPeV47/G8ZB6RJ9PxoTrz2WQA3bguSknnT22vJIpzotPKnjGmWrLzUD2RqzgG5NmdykbZiHH
	M9zUgGWOU+tld7rvFHH55bIklh0ojAHON/DWG4FS8f3udffLvjMEMEvkkLRX3mPTt8ihLv1LiIYfV
	nzo9G+/g==;
Received: from [186.208.73.94] (helo=[192.168.18.14])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vQoz9-008Jeq-RN; Wed, 03 Dec 2025 16:41:44 +0100
Message-ID: <c0f6df66-2c0c-43c7-815f-602beccf3931@igalia.com>
Date: Wed, 3 Dec 2025 12:41:39 -0300
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] FI fbcon fixes
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Thomas Zimmermann <tzimmermann@suse.de>,
 Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
References: <20251203093948.54296-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20251203093948.54296-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/12/2025 06:39, Tvrtko Ursulin wrote:
> Two generic fixes split out for easy review, one refactoring as requested, and
> then the last patch is the panel/mode quirk to allow for corruption free fbcon
> with simpledrmfb and efidrmfb on the Valve Steam Deck.
This series is:

Tested-by: Melissa Wen <mwen@igalia.com>

on LCD and OLED Steam Deck device.

In both devices, the issue is present and fixed by this series.

BR,

Melissa
>
> v2:
>   * s/unsigned/unsigned int/
>   * s/pitch/linelength/
>   * Removed comment explaining the Steam Deck quirk.
>   * Added patch to refactor quirk application via callbacks.
>
>   v3
>   * Added forgotten __initconst.
>   * Use separate callback for the fixup quirk.
>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: linux-efi@vger.kernel.org
>
> Tvrtko Ursulin (4):
>    efi: sysfb_efi: Replace open coded swap with the macro
>    efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
>    efi: sysfb_efi: Convert swap width and height quirk to a callback
>    efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve Steam Deck
>
>   drivers/firmware/efi/sysfb_efi.c | 72 ++++++++++++++++++++++++++++----
>   1 file changed, 64 insertions(+), 8 deletions(-)
>


