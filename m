Return-Path: <linux-efi+bounces-5106-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 829ADC0097B
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 12:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1948A3AA8CB
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4DA2D9ECD;
	Thu, 23 Oct 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yX8OD/im"
X-Original-To: linux-efi@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7606265621;
	Thu, 23 Oct 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216960; cv=none; b=YshuqSHhcd38nEcT8WnfLK09DP5ObA5Ks4YAU3keFv4wDqHtZXmRT/5liBpDucBsJ74xbmEgppbET/BdD2OWc0V+G8E++4RBsJNzQVmJY3kLo2Fcdrk6LJiBKLXvk05Ksq+PqSPPmehodwpiE2lCcSVYvMtXqWOq8iJ3iVspWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216960; c=relaxed/simple;
	bh=Sl9GzBtS8VTh0y1HpiVjHSFV21aZYl+ykG2S01BM3vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVM9NcNktEaz4kGTWNIIt2sw2p91n/JXBfdTie7nbtngAjJfKgdhm5obzb8xTHb1IyKLIC51y9H5qb5DGC+T1SzvRvVmjSKtLgIwf45Op0gKu1bNw3QgTr5EZH4F5QI8T6XX9vzK5atVlHvWuhZv9zSu/VLzunZOC1OuMBzoALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yX8OD/im; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LkjOKeAb49sis7EWwyWb6dVtEtQGuocPuWXQlDktOeQ=; b=yX8OD/im5FX8eC/QjhMrbbUjFn
	PeNDZhCP4RIpJg2TVmknhZO4G/ZGcASouffR782DL2Rd/GWyV7g6MQF+fcoMbnSCkPJGeOr8gm5KU
	H80jT0YsD1Bnj0IeXfXRKEx+x/jdEtelXZX48HLQLcwdxEbXa7nxdMKn/PQcS3W3eYlnGBbmFjfek
	tAscqFiPtLNIUGaY8vkj9x0b2RnwlWNrdsL2/TjV9QWH7ha+VrUIV06N5h1PgGBns34H5QfbycFdf
	l+LKaYWmhDo/ztWYWKgYWrJO0FpdDmEFvLOctBdMhKMaNZ/p2CUgJ05ob+tbX/vmTFKz+x8BGHyIL
	tFrj05uA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47994)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vBsz5-000000006DR-2v8s;
	Thu, 23 Oct 2025 11:55:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vBsz3-000000001ci-2V28;
	Thu, 23 Oct 2025 11:55:53 +0100
Date: Thu, 23 Oct 2025 11:55:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Qiang Ma <maqianga@uniontech.com>
Cc: ardb@kernel.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Remove duplicate function calls and useless message
Message-ID: <aPoJuaoqjZ9L9ifl@shell.armlinux.org.uk>
References: <20251023082051.75183-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023082051.75183-1-maqianga@uniontech.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 23, 2025 at 04:20:51PM +0800, Qiang Ma wrote:
> From: Qiang Ma <maqianga@uniontech.com>
> 
> This patchset removes duplicate function calls and useless debug message

This isn't a patch set. This is a cover message with no patches threaded
to it. This makes it difficult to find the patches.

Please ensure that patches are threaded to the cover message.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

