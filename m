Return-Path: <linux-efi+bounces-476-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F7684953D
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 09:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC9A2811A9
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01D71119C;
	Mon,  5 Feb 2024 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="JO8W1Dpu";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="JO8W1Dpu"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FD1118A;
	Mon,  5 Feb 2024 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121234; cv=none; b=CtKSHLDYdaUdU0+ZWuHsLeixyBpLekIfZmvX16z/f8HxlMVu/tdN2HuljUyh+mKZmoY3eBZKFf8E61mavvPd3mKu3orJhSml0s3YVcm52D68umsubUJmrZGZ1X69j1uMp1ii6PcTRvBrRpchXbJHLRWRFeWOJ1yqwcOP+5G5OEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121234; c=relaxed/simple;
	bh=eu/BwH8FT7BImKJToQrnKLcDXyUO2zgZpz9MD25cU7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fKXY3ftXWrYoRyjKqqrV4nIlmOawikbUgK+jWxNzmqnSnyRDIKs5liVFHxjz4f/YDLYJAhmQOC1455J2WemRpxJX/8Gp/LiCSBwEyycHnY7pDXUVvxC/BRJlEEBnG0rmhaeXyYWaQgG9RtAteFaQ+BbnKHj/epARxX9er8mSdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=JO8W1Dpu; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=JO8W1Dpu; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707121231;
	bh=eu/BwH8FT7BImKJToQrnKLcDXyUO2zgZpz9MD25cU7c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=JO8W1DpurgTMXtNTCNU8J4q0FM0xnYE3RKeCmnYYjfmQctLVTu2DwSjh7fUrjZlF4
	 SNdHlHvxdgviuQHj9v1NAIsErUxsmDK4pLIK9aziX8UXYD7k2oD0zwmJqkFuBgq6yq
	 6k+3M22sZN3Dz+0UIn+qBvSSHc7tQQxUvrojYU9w=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A05DD12868CE;
	Mon,  5 Feb 2024 03:20:31 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id UQll_wppCcMJ; Mon,  5 Feb 2024 03:20:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707121231;
	bh=eu/BwH8FT7BImKJToQrnKLcDXyUO2zgZpz9MD25cU7c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=JO8W1DpurgTMXtNTCNU8J4q0FM0xnYE3RKeCmnYYjfmQctLVTu2DwSjh7fUrjZlF4
	 SNdHlHvxdgviuQHj9v1NAIsErUxsmDK4pLIK9aziX8UXYD7k2oD0zwmJqkFuBgq6yq
	 6k+3M22sZN3Dz+0UIn+qBvSSHc7tQQxUvrojYU9w=
Received: from [172.20.9.170] (62-244-190-9.cust.exponential-e.net [62.244.190.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 04A2C1286899;
	Mon,  5 Feb 2024 03:20:29 -0500 (EST)
Message-ID: <7357618f02b87786f06f3e10b50f1247f328f07a.camel@HansenPartnership.com>
Subject: Re: [PATCH v1] efi/libstub: Add Confidential Computing (CC)
 measurement support
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, "Yao, Jiewen"
	 <jiewen.yao@intel.com>, "Lu, Ken" <ken.lu@intel.com>
Date: Mon, 05 Feb 2024 08:20:27 +0000
In-Reply-To: <6a696340-b57c-4fa5-bb2e-b3a0257453bc@linux.intel.com>
References: 
	<20240203075736.3982371-1-sathyanarayanan.kuppuswamy@linux.intel.com>
	 <82a84e769875c70279348179c1b2b63a16770c8e.camel@HansenPartnership.com>
	 <6a696340-b57c-4fa5-bb2e-b3a0257453bc@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2024-02-04 at 12:27 -0800, Kuppuswamy Sathyanarayanan wrote:
> +Jiewen & Ken (RTMR firmware owner)
> 
> On 2/3/24 10:46 PM, James Bottomley wrote:
> > On Sat, 2024-02-03 at 07:57 +0000, Kuppuswamy Sathyanarayanan
> > wrote:
> > > If the virtual firmware implements TPM support, TCG2 protocol
> > > will be used for kernel measurements and event logging support.
> > > But in CC environment, not all platforms support or enable the
> > > TPM feature. UEFI specification [1] exposes protocol and
> > > interfaces used for kernel measurements in CC platforms without
> > > TPM support.
> > > 
> > > Currently, the efi-stub only supports the kernel related
> > > measurements for the platform that supports TCG2 protocol. So,
> > > extend it add CC measurement protocol
> > > (EFI_CC_MEASUREMENT_PROTOCOL) and event logging support. Event
> > > logging format in the CC environment is the same as TCG2.
> >  
> > Why do we have to do this anymore?  Given that you're already
> > pushing patches that map RTMRs to TPM PCRs:
> > 
> > https://lore.kernel.org/lkml/20240128212532.2754325-4-sameo@rivosinc.com/
> 
> IMHO, I am not sure whether we need this mapping support . I have
> already mentioned the same comment in [1]. If we support extension
> and logging via configFS ABI, why again support PCR mapping?
> 
> https://lore.kernel.org/lkml/2bd7c80b-9cd8-4450-a410-c3739d224167@linux.intel.com/

Well, the point is if it can be done, you can push the measurement and
logging all the way down into the TCG driver and not have to modify any
upper layer code at all (so less chance of introducing bugs).  It would
be a single change instead of patching everywhere there's a
measurement.

> > Can't you just add a stub TCG2 driver to EFI that exposes only the
> > ability to log and measure using this mapping?  That way all our
> > existing code will "just work" without the need to understand
> > anything about confidential computing or add new code to do the
> > measurement?
> 
> I am not familiar with the EFI implementation, but I think a new
> protocol is added to handle future CC extensions (which could deviate
> from TCG2)

OK, but you could add a new driver for just that functionality only
when you actually deviate and handle all of the current functionality
in the non-deviating TCG driver.  Nothing forbids a feature from having
multiple driver attachments.

James

>  and to support platforms that does not support or enable TPM
> feature. So modifying the TCG2 driver in EFI may not work for the
> above-mentioned cases. I think the EFI driver part of this support
> is already merged.
> 
> Jiewen/Ken may have more comments about this proposal.


