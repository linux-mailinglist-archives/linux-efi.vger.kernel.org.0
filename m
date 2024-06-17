Return-Path: <linux-efi+bounces-1234-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A564290B4E9
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 17:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1231C21837
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFCF14EC7D;
	Mon, 17 Jun 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XyYMD27m"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BDF28F3;
	Mon, 17 Jun 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637398; cv=none; b=WC+jdJ9n+YNZyEzMFPNbqw6pJagU6MIHIpp71S+i5kIIja0UpKw4OLFN080XHiyRGfsoRCByev8CfO92pB8lBw676+10FLt+8fSKlsS0SABNx6v24GirFEDkUNjVQt1bqdLqHIvZVsv6dDEc1SZrp5luO7G2O6qDDrPNSW7wT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637398; c=relaxed/simple;
	bh=jT0rAstJk9KMGZXnnmHWZRLkARXtg2bJVhfHUB5Hg5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pna80lu1U947POV64w8iejSaySdBxJbH7Ztjqw4YFGx5X8gzN57pHjUN+76Cmz0y/cr4jUAxS91dCd0T5G7YrFewX3uG+UoSOkTIDpBwrgvUlc7s4wnk3N07jBU7b//mI0nZGSjgM0WbUYHwB6WIWESCdqHahD+3UfdMtySIh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XyYMD27m; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DweQqiSPnI73gLN0HTCwmU3H1dTkoKcPiSNA1+IYy/U=; b=XyYMD27m6qYdn6W/COMUedwjoA
	AVafTiZuKvRBg82JmG10lDIGSlJsNG2FKUitFh7XgWN1tOuZ8NlDLqXC8k1aPtzn1duT0DMzkV77b
	WGXhJQw2gsWJUgANcMk8wBr9VcGdcHKR39N/9qNstH24iXPbxMHr4rBw0IrCaTmP83mFcKNy34Skb
	2PcPq4NnXBPw5mxwHn2OYARlWeh0u9JMv835ir6OctkF5OPm03FjCrTp2QkOuz8Op4sfa1RY/QyNT
	N06zMhr/L05mMv4P3AtrLjO61tLH8H5wqBpbQ0tcQt+mRrdYAED79GhOVGck2eE3H9LhByP8m4NtX
	q66tvrZQ==;
Received: from [177.45.213.110] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sJE5o-004MgA-Sl; Mon, 17 Jun 2024 17:16:25 +0200
Message-ID: <53728bf9-8395-831c-f6bc-be79a379fe8a@igalia.com>
Date: Mon, 17 Jun 2024 12:16:19 -0300
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH AUTOSEL 6.1 07/29] efi: pstore: Return proper errors on
 UEFI failures
To: Sasha Levin <sashal@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
References: <20240617132456.2588952-1-sashal@kernel.org>
 <20240617132456.2588952-7-sashal@kernel.org>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240617132456.2588952-7-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/2024 10:24, Sasha Levin wrote:
> From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> 
> [ Upstream commit 7c23b186ab892088f76a3ad9dbff1685ffe2e832 ]
> 
> Right now efi-pstore either returns 0 (success) or -EIO; but we
> do have a function to convert UEFI errors in different standard
> error codes, helping to narrow down potential issues more accurately.
> 
> So, let's use this helper here.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Following Ard's comment for the other releases, let's not backport this one.

Thanks,


Guilherme

