Return-Path: <linux-efi+bounces-947-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B128ACD1C
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 14:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44853B2454C
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 12:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EC214A0A5;
	Mon, 22 Apr 2024 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="vmnu2zzK";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="vmnu2zzK"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76914A0A3;
	Mon, 22 Apr 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789766; cv=none; b=qMN1rmyxSf1cU8dmOPf8SjfaBV9uPxn+y3EZqBjkJCo90b61xnAlig/VBKRiS7GVKuCE/5ENBZ0+XLIEPEwuTqD+BlEpQB2wHC1gQ4VdD9bNPw95IcdCW4UvTo+YvJ47pbhaClsUseiqXhNdszV6VVcJM1WQrqHFtufUDJdU3uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789766; c=relaxed/simple;
	bh=eLPBVgVLHtZoIwSikYHS9+/VqRYyuQb/X9rEDXUkyq8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MKXXXyqQgpzAsUK8tBhHLTl9siL28Ochx2Nxuk8WRsb0hiKO+QhvD+RPeKhOWPiv8Houtudb9lF9I1TCBlJqexZRhBTGyAxQ4/3KyoK/UkdrPcshYptIBlwjwmd0ZgyWAUunQXiX+0jrelA5q1mdR0vANGmSNqCX5kQFlHvVODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=vmnu2zzK; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=vmnu2zzK; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1713789764;
	bh=eLPBVgVLHtZoIwSikYHS9+/VqRYyuQb/X9rEDXUkyq8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=vmnu2zzKcABpFlPx1X0yhrr/pvNmCqH9ygfBE9h1//eTRG4NHkT5xUmvhn4W5qGRa
	 cjk6nrWzkiC3xM5d+T9OcQWotXciiMw7GTGIBgBTlXKQAlbeSoEikdzsveawmyVekV
	 Me0rvO+n0TvUMVrxpYvtZfiFJc6Xek4SKUCi1jbM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 426E41281DBE;
	Mon, 22 Apr 2024 08:42:44 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id HrCx1R4F-lCE; Mon, 22 Apr 2024 08:42:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1713789764;
	bh=eLPBVgVLHtZoIwSikYHS9+/VqRYyuQb/X9rEDXUkyq8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=vmnu2zzKcABpFlPx1X0yhrr/pvNmCqH9ygfBE9h1//eTRG4NHkT5xUmvhn4W5qGRa
	 cjk6nrWzkiC3xM5d+T9OcQWotXciiMw7GTGIBgBTlXKQAlbeSoEikdzsveawmyVekV
	 Me0rvO+n0TvUMVrxpYvtZfiFJc6Xek4SKUCi1jbM=
Received: from [172.20.13.230] (wsip-184-177-54-3.hr.hr.cox.net [184.177.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5DE3D1280393;
	Mon, 22 Apr 2024 08:42:43 -0400 (EDT)
Message-ID: <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mikko Rapeli <mikko.rapeli@linaro.org>, Ard Biesheuvel
 <ardb@kernel.org>,  linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Lennart Poettering <lennart@poettering.net>
Date: Mon, 22 Apr 2024 08:42:41 -0400
In-Reply-To: <20240422112711.362779-1-mikko.rapeli@linaro.org>
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-04-22 at 14:27 +0300, Mikko Rapeli wrote:
> Userspace needs to know if TPM kernel drivers need to be loaded
> and related services started early in the boot if TPM device
> is used and available.

This says what but not why.  We already have module autoloading that
works correctly for TPM devices, so why is this needed?

We do have a chicken and egg problem with IMA in that the TPM driver
needs to be present *before* any filesystem, including the one the TPM
modules would be on, is mounted so executions can be measured into IMA
(meaning that if you use IMA the TPM drivers must be built in) but this
sounds to be something different. However, because of the IMA problem,
most distributions don't end up compiling TPM drivers as modules
anyway.

Is what you want simply that tpm modules be loaded earlier?

James


