Return-Path: <linux-efi+bounces-1515-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B625A93F3B9
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jul 2024 13:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44631C20970
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jul 2024 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366D41459FD;
	Mon, 29 Jul 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sY85OY8U"
X-Original-To: linux-efi@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F5A23CE;
	Mon, 29 Jul 2024 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251583; cv=none; b=AY4BasH4I/n0KVKbmH4WnQugua09MaDs4Zymf07DvCJJ24XUDAepepxmM2HqeXEtFralk5orSl2OlTXMHyS11263kkZNJ603v0f/dL76zz/07qh2QPzrN0MigMIv5QgoKsDKs9vLkoJSjZuTXLypqyQALYG9sMKv65YGaUk4vug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251583; c=relaxed/simple;
	bh=vYubvS1UXRwWxn8mvYAlPVqboP4AHdh1plC49bFrMLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmdylloz7IMAb2OQNB2Jbj2qxy853xInnsanqNZ+OxYspAliWaplsj/CL5MdV1VQ8/mO71KZYwh3xsQ4lTOEwRSMFnF0/TwygQTYgmcx2//H9vYeD9rkqFgWHQ9DsFxxrxX2XZ3mYMB3bd1zIGYyWnbRXUpIx3AO4fTTu7804Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sY85OY8U; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8tAGfUWTEBc7Hb4XMVgA1OMLyKRPLmdQgK/RpBT96kI=; b=sY85OY8UZF3/cBc/4a+ZKFJMW5
	t5MlGxtYJfYLTy5RDEgCPOicEQjLuKujsM0N9+2hgCwGIPsDJRnaYcouA6GHKTqEy448fKz0Yo5P3
	i34KoeE2ULGtg6DfHE1LWdZQNQjOfIsJcTxrpZ0ShsMvGO+NWU8cauiN9zLrZC0cRkWkVf1g1QInO
	d4s7aulyQH68RbrTjMfiWxkjyiE4GQ1oDeHcxHDgusCgOqJ/asqz8DSht8aoIbEq3A9qHnWji7EPt
	C0ypg1i/mqru/jn9xgb5af5Gyv055qoa8O1cQppxd2dFBNEA295wA6cUmX9Am0YohIR+S2R4SlTQa
	gyl8QwuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60728)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYOIn-0003zi-1w;
	Mon, 29 Jul 2024 12:12:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYOIm-0004Gs-SD; Mon, 29 Jul 2024 12:12:28 +0100
Date: Mon, 29 Jul 2024 12:12:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: ardb@kernel.org, arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	linus.walleij@linaro.org, eric.devolder@oracle.com, robh@kernel.org,
	kees@kernel.org, masahiroy@kernel.org, palmer@rivosinc.com,
	samitolvanen@google.com, xiao.w.wang@intel.com,
	alexghiti@rivosinc.com, nathan@kernel.org, jan.kiszka@siemens.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] ARM: Add support for STACKLEAK gcc plugin
Message-ID: <Zqd5HCx/GiMtXnlZ@shell.armlinux.org.uk>
References: <20240624023612.2134144-1-ruanjinjie@huawei.com>
 <b8792d9c-c2a2-6808-f94b-e3b826232f78@huawei.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8792d9c-c2a2-6808-f94b-e3b826232f78@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 22, 2024 at 10:53:10AM +0800, Jinjie Ruan wrote:
> Gentle ping.

You submitted it on 27th June to the patch system. I applied it on 2nd
July, and you would have received an automatic notification of that.

I have been on vacation from 6th July through to the 28th inclusive. As
seems to be the norm, the merge window opened during my vacation time,
in this case, 14th to 28th.

Nevertheless, the pull request was sent to Linus on Saturday 27th.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

