Return-Path: <linux-efi+bounces-832-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C68885A12
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 14:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B371C21283
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 13:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B3784A38;
	Thu, 21 Mar 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="hdcQaOgQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E2224F2;
	Thu, 21 Mar 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028814; cv=pass; b=L8MHp0jjefmEAjZVx+QQPuHMQsYkFSvvmFe9J7iR9nlS9MVaf45OBrXlK3YjRndY9z3liu2Tr67G3LHxj57IUALfmSHKB+FHPFBgCZvQ3rI7yrSizVqXqK8QfAJ7nC9rpus7BKpM4spXcI76tEwLi8PdYaRTAFRiTCeXzD2pJSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028814; c=relaxed/simple;
	bh=x2ZyPeNOVWT4NgG0OiIppgda41Qexy4HYwyfAmD6nps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3W8urJQKrEZtP5r/vksDN2GD16wBsVCpCJVIVobK6gglfYiS+QKm7YH5wzhbRGGc0L3cItWGFhYX934UtZeLUFXLxPUWkRkvyKC+Ev0oi6uUWXBxUfynpECYVAnrZd0GbX5uoEZwn8S/1oq7TuczeNxHR17KGTzRi0FSLhlRT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=hdcQaOgQ; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1711028754; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CoXqJ3Q8+YqQfYIIFBcz82q3mokSxkvviaxPi4pkUD+LjFal9ccirN+mJk0Nzatpl6IdkL6iOjJDVbSZc+0e5c8r+A/Bw7EDEpffaiThmFmkiTZVTyEuPi+UdaXHn+PkPxj0o7aQ1CUIEqFuu/ahEnLqi3DUbM7Dnu0UlUXEAsI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1711028754; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c7mypxhq24TwOwkk7go39gJ4c0j/SRaCVim+D2aCUwM=; 
	b=VUaIOr1KbJ0KxovSfsJci8oMzSIj/D/jii5gedBAJMtL0tFbNRO0QhKSLxn1xQ6c/71dxXYiNywfjZ30cn3JxAGhGmvEy80xWwROescoqWHU2+TnTbW5odgJ1703JmWyVCUTkrH8kWpEpc8qURhSOaO/nzqD1EUkDbIZg7pePZQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711028754;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=c7mypxhq24TwOwkk7go39gJ4c0j/SRaCVim+D2aCUwM=;
	b=hdcQaOgQMk0VA4dgzM/w40MGd1Cw5xYr+kL7eHwooHcb4C1CCdE7g+AdeGiHI/EV
	MyI6C8mt4V1ErCsymDkOr5guRp2Dm9XRioTMj+Ztf/nMVtdYr5vO3is54gGx8Do4uQB
	BFqlTWRhEaKpAA5tPxXuoQyvGMWQERrnnAN1hTq8=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1711028752479775.6868681111625; Thu, 21 Mar 2024 06:45:52 -0700 (PDT)
Message-ID: <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
Date: Thu, 21 Mar 2024 09:45:48 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-2-ross.philipson@oracle.com>
 <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Ard!

On 2/15/24 02:56, Ard Biesheuvel wrote:
> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>>
>> From: Arvind Sankar <nivedita@alum.mit.edu>
>>
>> There are use cases for storing the offset of a symbol in kernel_info.
>> For example, the trenchboot series [0] needs to store the offset of the
>> Measured Launch Environment header in kernel_info.
>>
> 
> Why? Is this information consumed by the bootloader?

Yes, the bootloader needs a standardized means to find the offset of the 
MLE header, which communicates a set of meta-data needed by the DCE in 
order to set up for and start the loaded kernel. Arm will also need to 
provide a similar metadata structure and alternative entry point (or a 
complete rewrite of the existing entry point), as the current Arm entry 
point is in direct conflict with Arm DRTM specification.

> I'd like to get away from x86 specific hacks for boot code and boot
> images, so I would like to explore if we can avoid kernel_info, or at
> least expose it in a generic way. We might just add a 32-bit offset
> somewhere in the first 64 bytes of the bootable image: this could
> co-exist with EFI bootable images, and can be implemented on arm64,
> RISC-V and LoongArch as well.

With all due respect, I would not refer to boot params and the kern_info 
extension designed by the x86 maintainers as a hack. It is the 
well-defined boot protocol for x86, just as Arm has its own boot 
protocol around Device Tree.

We would gladly adopt a cross arch/cross image type, zImage and bzImage, 
means to embedded meta-data about the kernel that can be discovered by a 
bootloader. Otherwise, we are relegated to doing a per arch/per image 
type discovery mechanism. If you have any suggestions that are cross 
arch/cross image type that we could explore, we would be grateful and 
willing to investigate how to adopt such a method.

V/r,
Daniel

