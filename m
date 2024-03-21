Return-Path: <linux-efi+bounces-833-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21712885A6A
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 15:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDBF282245
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF24584FCF;
	Thu, 21 Mar 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="Dxc2Zkqh"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F484FCC;
	Thu, 21 Mar 2024 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030365; cv=pass; b=FZv1wav0mOaUALpVtZnkl9Mw4y6zOBvHAgW/A4R3u/qxzCw+e3gYhw6J3bksMZGYeOxrJntYueEKAlpyaujRBSDYmORzVGAT4bqVeX9kC/pxLVEcpmFy69eeduoinaV79h7UbumC4UoMwMcjqx/o4xdN42ruJq7/4tnlJlFsmXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030365; c=relaxed/simple;
	bh=n/4358FmQRHscPMWI0MY4CrcN5nOShQw37Npr/gIyX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5TzzjbOqLXX2gZjfaOrRKBN17Gn6gTIFfpV149EDVvLO6dck731XMLLAh4X8az8nlxg71nXvym2rYwh0OC78cpFTWx/0o501hUQoUA6KuTSY+yiWEkh8R/Q2daRWX4PpqQY6clxVzPcxqv8dbGzc8Xt9gCQnpVoSVh9b+W5jkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=Dxc2Zkqh; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1711030323; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xn4nh6v2LLqnzPV2I7j4/ac9rvsbeDIPqr6Bb9xDsPI29uIC/t9HQpXJ99nPXXfo45VKDOhy+8WkMDQegmWk9A/Yk4fsn+kJut7A1EWC7zV54Rlg+6kddWhloP797eIib7otqQekQIhOa0IGOtpXna3ev7tj0/vcX2q2QhF0vA8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1711030323; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZFDutfvhklXcK4cqq5JiEfITG/oIyUGfvA9UGjBd4cw=; 
	b=c4NsVlOQNh/Jv+X5Q89kNTITBp3fJ+WlTxGPYecZe3DxNgn27FJ4xS3KgnOHTWureGFhQA5cB+xQssQR0sWHqrjQT4s+hlV4ksr0pi1cqstFsmyPVp2UF6HyWBediDmw+nEXv4OcqIJYBNamL9hBtIKvZ1CE6gfNgLiziv0f9SI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711030323;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZFDutfvhklXcK4cqq5JiEfITG/oIyUGfvA9UGjBd4cw=;
	b=Dxc2Zkqhq1eNTm9uHvdeeGr0h30yHEwUKaWGdtmM9gQOeoP84bftmkFvcmgrcOE0
	NUmAcOHSzL6x0M/bixt4gL0RewCouR04kxzuJ2SwoS4UYQmS0J9lxGR9lrm+Vp6PVAQ
	MFzFWznnC0XomEKgsTmJWkXNCfSNeU8VreL7LuiY=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 17110303216563.5761394895970398; Thu, 21 Mar 2024 07:12:01 -0700 (PDT)
Message-ID: <66cded21-448b-47e1-a94c-aed94cc40dcd@apertussolutions.com>
Date: Thu, 21 Mar 2024 10:11:57 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/15] x86: Secure Launch late initcall platform module
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-15-ross.philipson@oracle.com>
 <CAMj1kXHXt6z94JCM2C5rLz-n9nGA46bb1eMbqcP5e7K9+NzPSg@mail.gmail.com>
 <c5bd3ee4-4bf1-4e9a-8e5d-12ee8e195d3d@apertussolutions.com>
 <CAMj1kXEUdj+==Ud_YWP2FP05St3KDsduzUMsOZzu9LRsLVsLVA@mail.gmail.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <CAMj1kXEUdj+==Ud_YWP2FP05St3KDsduzUMsOZzu9LRsLVsLVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Ard,

On 2/23/24 04:36, Ard Biesheuvel wrote:
> On Thu, 22 Feb 2024 at 14:58, Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>>
>> On 2/15/24 03:40, Ard Biesheuvel wrote:
>>> On Wed, 14 Feb 2024 at 23:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>>>>
>>>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>>>
>>>> The Secure Launch platform module is a late init module. During the
>>>> init call, the TPM event log is read and measurements taken in the
>>>> early boot stub code are located. These measurements are extended
>>>> into the TPM PCRs using the mainline TPM kernel driver.
>>>>
>>>> The platform module also registers the securityfs nodes to allow
>>>> access to TXT register fields on Intel along with the fetching of
>>>> and writing events to the late launch TPM log.
>>>>
>>>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>>>> Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>>
>>> There is an awful amount of code that executes between the point where
>>> the measurements are taken and the point where they are loaded into
>>> the PCRs. All of this code could subvert the boot flow and hide this
>>> fact, by replacing the actual taken measurement values with the known
>>> 'blessed' ones that will unseal the keys and/or phone home to do a
>>> successful remote attestation.
>>
>> To set context, in general the motivation to employ an RTM, Static or
>> Dynamic, integrity solution is to enable external platform validation,
>> aka attestation. These trust chains are constructed from the principle
>> of measure and execute that rely on the presence of a RoT for Storage
>> (RTS) and a RoT for Reporting (RTR). Under the TCG architecture adopted
>> by x86 vendors and now recently by Arm, those roles are fulfilled by the
>> TPM. With this context, lets layout the assumptive trusts being made here,
>>     1. The CPU GETSEC instruction functions correctly
>>     2. The IOMMU, and by extension the PMRs, functions correctly
>>     2. The ACM authentication process functions correctly
>>     3. The ACM functions correctly
>>     4. The TPM interactions function correctly
>>     5. The TPM functions correctly
>>
>> With this basis, let's explore your assertion here. The assertion breaks
>> down into two scenarios. The first is that the at-rest kernel binary is
>> corrupt, unintentionally (bug) or maliciously, either of which does not
>> matter for the situation. For the sake of simplicity, corruption of the
>> Linux kernel during loading or before the DRTM Event is considered an
>> equivalent to corruption of the kernel at-rest. The second is that the
>> kernel binary was corrupted in memory at some point after the DRTM event
>> occurs.
>>
>> For both scenarios, the ACM will correctly configure the IOMMU PMRs to
>> ensure the kernel can no longer be tampered with in memory. After which,
>> the ACM will then accurately measure the kernel (bzImage) and safely
>> store the measurement in the TPM.
>>
>> In the first scenario, the TPM will accurately report the kernel
>> measurement in the attestation. The attestation authority will be able
>> to detect if an invalid kernel was started and can take whatever
>> remediation actions it may employ.
>>
>> In the second scenario, any attempt to corrupt the binary after the ACM
>> has configured the IOMMU PMR will fail.
>>
>>
> 
> This protects the memory image from external masters after the
> measurement has been taken.

It blocks access before the measurement is taken.

> So any external influences in the time window between taking the
> measurements and loading them into the PCRs are out of scope here, I
> guess?

Correct, as long as the assumption that the user configured the kernel 
to program the IOMMU correctly after gaining control. In early versions 
of this series the correct IOMMU configuration was enforced. This was 
changed due to objections that the user should be free to configure the 
system how they see fit, even if it results in an insecure system.

> Maybe it would help (or if I missed it - apologies) to include a
> threat model here. I suppose physical tampering is out of scope?

I can take a look at what other security capabilities have documented in 
this area and provide a similar level of explanation.

I would not say physical tampering is out, I would say that it is 
supported to the degree to which the TPM was designed to mitigate it.

>>> At the very least, this should be documented somewhere. And if at all
>>> possible, it should also be documented why this is ok, and to what
>>> extent it limits the provided guarantees compared to a true D-RTM boot
>>> where the early boot code measures straight into the TPMs before
>>> proceeding.
>>
>> I can add a rendition of the above into the existing section of the
>> documentation patch that already discusses separation of the measurement
>> from the TPM recording code. As to the limits it incurs on the DRTM
>> integrity, as explained above, I submit there are none.
>>
> 
> Thanks for the elaborate explananation. And yes, please document this
> with the changes.

Ack.

V/r,
Daniel

