Return-Path: <linux-efi+bounces-466-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5421848B92
	for <lists+linux-efi@lfdr.de>; Sun,  4 Feb 2024 07:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0388A1C21CE9
	for <lists+linux-efi@lfdr.de>; Sun,  4 Feb 2024 06:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B1079D9;
	Sun,  4 Feb 2024 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gyaNse+t";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gyaNse+t"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7063479D8;
	Sun,  4 Feb 2024 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029215; cv=none; b=Hha5Hygy+D6km1YmyFgE9JVeRNGGEHWN25LKwIyJFVxhjJhkpb5vKM2pgcDwkKMkRME0EzUeHO1BkhCIyf8h7BbSXEVMhcbBKdEJWBcN/TEB9co4u50HoO4oKuqBj5x3lF+fBNHeLsxT4XtatRc+x26m+cVlS/tJtyMftl8DpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029215; c=relaxed/simple;
	bh=9EZjewRDbHwyi78hHdRj+6LOGoRQu+XpNx4Nu3ODRm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pUbzztKFbihqMRbG2we4iYtm19YaavZ92zqevYalOt8rMYxX9xS6MG1IQUaDXlQnoIYdI6HylHSQU50LH6pUA8E77PYt8uyR7EPOKGoc2rGesI60IUtd/MfkVxkiSmA17+I/JwHRhCo7S3sw65E4P0Swr32xYaUvQYUiTdLulT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gyaNse+t; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gyaNse+t; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707029211;
	bh=9EZjewRDbHwyi78hHdRj+6LOGoRQu+XpNx4Nu3ODRm8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gyaNse+tWvxmVJsFcSHmeDTeemmSn08pG9GlabmlZ8LxLQUhOxqtyzrHAtLhtYyJt
	 S9hFTXpGSiTAbtr3iyPseR7ArvYdeOGcTK8evhPmLcSVunRdTFl3EBVDvHlWeaANJe
	 eBQOpLgSCNjahCrkTXd5KI/oDIeo//tQFdEdeMnM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id DEA5712811A2;
	Sun,  4 Feb 2024 01:46:51 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id qxufTY8Auqmz; Sun,  4 Feb 2024 01:46:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707029211;
	bh=9EZjewRDbHwyi78hHdRj+6LOGoRQu+XpNx4Nu3ODRm8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gyaNse+tWvxmVJsFcSHmeDTeemmSn08pG9GlabmlZ8LxLQUhOxqtyzrHAtLhtYyJt
	 S9hFTXpGSiTAbtr3iyPseR7ArvYdeOGcTK8evhPmLcSVunRdTFl3EBVDvHlWeaANJe
	 eBQOpLgSCNjahCrkTXd5KI/oDIeo//tQFdEdeMnM=
Received: from [172.22.2.140] (66.224-78-194.adsl-static.isp.belgacom.be [194.78.224.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 947F1128114D;
	Sun,  4 Feb 2024 01:46:49 -0500 (EST)
Message-ID: <82a84e769875c70279348179c1b2b63a16770c8e.camel@HansenPartnership.com>
Subject: Re: [PATCH v1] efi/libstub: Add Confidential Computing (CC)
 measurement support
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Date: Sun, 04 Feb 2024 07:46:44 +0100
In-Reply-To: <20240203075736.3982371-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: 
	<20240203075736.3982371-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sat, 2024-02-03 at 07:57 +0000, Kuppuswamy Sathyanarayanan wrote:
> If the virtual firmware implements TPM support, TCG2 protocol will be
> used for kernel measurements and event logging support. But in CC
> environment, not all platforms support or enable the TPM feature.
> UEFI specification [1] exposes protocol and interfaces used for
> kernel measurements in CC platforms without TPM support.
> 
> Currently, the efi-stub only supports the kernel related measurements
> for the platform that supports TCG2 protocol. So, extend it add
> CC measurement protocol (EFI_CC_MEASUREMENT_PROTOCOL) and event
> logging support. Event logging format in the CC environment is the
> same as TCG2.

Why do we have to do this anymore?  Given that you're already pushing
patches that map RTMRs to TPM PCRs:

https://lore.kernel.org/lkml/20240128212532.2754325-4-sameo@rivosinc.com/

Can't you just add a stub TCG2 driver to EFI that exposes only the
ability to log and measure using this mapping?  That way all our
existing code will "just work" without the need to understand anything
about confidential computing or add new code to do the measurement?

James


