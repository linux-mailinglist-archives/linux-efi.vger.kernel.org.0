Return-Path: <linux-efi+bounces-2087-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF419B89DE
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 04:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1581F24145
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 03:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE8B13FD83;
	Fri,  1 Nov 2024 03:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="efDuU9/Z";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="efDuU9/Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D913A24D;
	Fri,  1 Nov 2024 03:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730431071; cv=none; b=l2iuAHKU3o7A8Q/DPu6crS/nfqzBlpyNL7YiCm5tWh40tczTpaIDaZ0lJqSt0vCbnwLE5OVfTyRw1RLZHIHQG9LcyMhSgnRBV4PR8q1rtG1WB35yCWR47pVuWrtf0UQ/Oix+kRIwPUFXS0GAJfoCvyF/vC/OXpkirF4fOFVNVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730431071; c=relaxed/simple;
	bh=nxjll38E6fkaKQQHuECcDsC3eYGfdaj9xNUPAl8lBo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rdpsIz0/5JMhyCL7Lq6sxNOrF44M3ize/aA6xh6P3WW0S+Ku9zBcRyxmADy4DJpS2QQXE0xBmTYlPQgLsOSMPvkVkt4IINNp3cgrIgNSP41tW/hLdwSZcw4dPRw8o1ec6jHcKQtVBk+mowlSWhWNfwfT4voGMB5yxkENKsf0c4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=efDuU9/Z; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=efDuU9/Z; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730431066;
	bh=nxjll38E6fkaKQQHuECcDsC3eYGfdaj9xNUPAl8lBo0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=efDuU9/Zbc3f0lTndGZZEaRkDrG0Vz4pkv0GarqSEP+mPgMbWQESJXtyMSMYAXr0k
	 vvqCMaZ8nOjlI3hHuiTAhY+9FWTrrmCu0qw6UeP3/JoojaiyoVeoTQjmgTZTiiWhl1
	 v80oxR3ctZUE3xhMRwCkCnopo24wBKz6RgVUs1AY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9E01512819B1;
	Thu, 31 Oct 2024 23:17:46 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id OblsZ3dP4NMJ; Thu, 31 Oct 2024 23:17:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730431066;
	bh=nxjll38E6fkaKQQHuECcDsC3eYGfdaj9xNUPAl8lBo0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=efDuU9/Zbc3f0lTndGZZEaRkDrG0Vz4pkv0GarqSEP+mPgMbWQESJXtyMSMYAXr0k
	 vvqCMaZ8nOjlI3hHuiTAhY+9FWTrrmCu0qw6UeP3/JoojaiyoVeoTQjmgTZTiiWhl1
	 v80oxR3ctZUE3xhMRwCkCnopo24wBKz6RgVUs1AY=
Received: from [10.250.250.46] (122x212x32x58.ap122.ftth.ucom.ne.jp [122.212.32.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BDC0E12817AD;
	Thu, 31 Oct 2024 23:17:41 -0400 (EDT)
Message-ID: <685f3f00ddf88e961e2d861b7c783010774fe19d.camel@HansenPartnership.com>
Subject: Re: [PATCH v11 18/20] tpm: Add sysfs interface to allow setting and
 querying the default locality
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org,  x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
 mjg59@srcf.ucam.org, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
 luto@amacapital.net, nivedita@alum.mit.edu, herbert@gondor.apana.org.au, 
 davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
 dwmw2@infradead.org,  baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com,  trenchboot-devel@googlegroups.com
Date: Fri, 01 Nov 2024 12:17:24 +0900
In-Reply-To: <20240913200517.3085794-19-ross.philipson@oracle.com>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
	 <20240913200517.3085794-19-ross.philipson@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-13 at 13:05 -0700, Ross Philipson wrote:
> Expose a sysfs interface to allow user mode to set and query the
> default locality set for the TPM chip.

What does a user need this for?  It somewhat conflicts with the idea of
running the kernel and user space TPM access in separate localities for
the purposes of key release, so we can seal keys to only release in the
kernel by policy.  When I last talked about this I thought we'd
probably use 0 for user and, say 2, for the kernel (mainly because
prior incarnations of this patch set seemed to access the TPM in
locality 2 from the kernel).  It really doesn't matter *what* locality
we use for the kernel and the user as long as it's known ahead of time
and the user can't gain access to the kernel locality.

Regards,

James


