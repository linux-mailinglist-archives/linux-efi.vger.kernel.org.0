Return-Path: <linux-efi+bounces-648-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ABF85FA84
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 14:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E057C1F25775
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461AC135410;
	Thu, 22 Feb 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="kdQUKRiX"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A5134CC2;
	Thu, 22 Feb 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610307; cv=pass; b=O/xNImC0GKSEONuIY/JVVy0qcs/ZahBX9FCRSnxEz+6Ephj27mxlYqiG9ej001dXRHllJsK3WVAFe79bfiGbxPKqkf9vzEdInzUAa7FO+FGo8nYCRaHinrGaeBguLX7rpXUDviGajhGtSJYPanwfWo42P6cEapJeh8UYmUq/QyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610307; c=relaxed/simple;
	bh=0nZv+wg21e2+IJAoWoz5tN561DDxkxRps2XuzwPDWyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLihGKSbGOB79F56NlkWe5l1gKp0qXm9bkIRT3/hT5THfrfkp9LZDeAmCBBGpgltxsEaRAlcfVpTXZbZbAj0/ew4Ji/IDC2lA5h270g+2Yg+vqJ8Tz7sDIv/pXHpxBU6B2Rw+e9qyik8rPUSEy71T7Eh+brRa3nXaQETao+3SSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=kdQUKRiX; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1708610250; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cHub6epmobdZVnGj8YMH2ybbVIPn7E0HfOR+Za7lnnjBbrMuXJ+YEsJdAa4yyHu8wV7uqL7+CCwUa7/1yEq6cYYaAfxff7NrUxMfOy/X6nWJSI4lKnFT5v0+JlHFAMu70jnmpttDZm8BJSfb6HVV+hnLZaBrCvDDIJdBHHoL0W4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708610250; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y83exyPy9st5PBYw7nPtC9FL3Mvmc5XFbN033jciyfA=; 
	b=mRQ1I4xyfS8mqOGqs6LTsADo6PTaYzdju5mZdfdKCC5GNWmuX26HSRvJwpGkD4HwLOAOzrGpF16FIR1xukVSbX5HeqPCsswG0qsKc1qSxF9y9qcR4Ieq+Snf9VyUhMgRanFnlDGB8Et4LIyrZjKhPTtNNjTN4uiQAF0qYnic80g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708610250;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Y83exyPy9st5PBYw7nPtC9FL3Mvmc5XFbN033jciyfA=;
	b=kdQUKRiXO+b/CGWjER4qU7sfdtjxiVPhauuppMpzjmEhCQb+e2ebgYuCH4SYCORG
	yOdZIgVgEhYKX3Th24MomoturmlwITCXXn0iEGgB2wo0db6N+zQKfTNYr83kDBR4Hge
	+ZzuP4pfQwTBLoQd3VMTB4+Dk+kIOQq4KOsZbmCM=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1708610247838305.8350062521944; Thu, 22 Feb 2024 05:57:27 -0800 (PST)
Message-ID: <c5bd3ee4-4bf1-4e9a-8e5d-12ee8e195d3d@apertussolutions.com>
Date: Thu, 22 Feb 2024 08:57:24 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/15] x86: Secure Launch late initcall platform module
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
 <20240214221847.2066632-15-ross.philipson@oracle.com>
 <CAMj1kXHXt6z94JCM2C5rLz-n9nGA46bb1eMbqcP5e7K9+NzPSg@mail.gmail.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <CAMj1kXHXt6z94JCM2C5rLz-n9nGA46bb1eMbqcP5e7K9+NzPSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/15/24 03:40, Ard Biesheuvel wrote:
> On Wed, 14 Feb 2024 at 23:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>>
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> The Secure Launch platform module is a late init module. During the
>> init call, the TPM event log is read and measurements taken in the
>> early boot stub code are located. These measurements are extended
>> into the TPM PCRs using the mainline TPM kernel driver.
>>
>> The platform module also registers the securityfs nodes to allow
>> access to TXT register fields on Intel along with the fetching of
>> and writing events to the late launch TPM log.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> There is an awful amount of code that executes between the point where
> the measurements are taken and the point where they are loaded into
> the PCRs. All of this code could subvert the boot flow and hide this
> fact, by replacing the actual taken measurement values with the known
> 'blessed' ones that will unseal the keys and/or phone home to do a
> successful remote attestation.

To set context, in general the motivation to employ an RTM, Static or 
Dynamic, integrity solution is to enable external platform validation, 
aka attestation. These trust chains are constructed from the principle 
of measure and execute that rely on the presence of a RoT for Storage 
(RTS) and a RoT for Reporting (RTR). Under the TCG architecture adopted 
by x86 vendors and now recently by Arm, those roles are fulfilled by the 
TPM. With this context, lets layout the assumptive trusts being made here,
   1. The CPU GETSEC instruction functions correctly
   2. The IOMMU, and by extension the PMRs, functions correctly
   2. The ACM authentication process functions correctly
   3. The ACM functions correctly
   4. The TPM interactions function correctly
   5. The TPM functions correctly

With this basis, let's explore your assertion here. The assertion breaks 
down into two scenarios. The first is that the at-rest kernel binary is 
corrupt, unintentionally (bug) or maliciously, either of which does not 
matter for the situation. For the sake of simplicity, corruption of the 
Linux kernel during loading or before the DRTM Event is considered an 
equivalent to corruption of the kernel at-rest. The second is that the 
kernel binary was corrupted in memory at some point after the DRTM event 
occurs.

For both scenarios, the ACM will correctly configure the IOMMU PMRs to 
ensure the kernel can no longer be tampered with in memory. After which, 
the ACM will then accurately measure the kernel (bzImage) and safely 
store the measurement in the TPM.

In the first scenario, the TPM will accurately report the kernel 
measurement in the attestation. The attestation authority will be able 
to detect if an invalid kernel was started and can take whatever 
remediation actions it may employ.

In the second scenario, any attempt to corrupt the binary after the ACM 
has configured the IOMMU PMR will fail.


> At the very least, this should be documented somewhere. And if at all
> possible, it should also be documented why this is ok, and to what
> extent it limits the provided guarantees compared to a true D-RTM boot
> where the early boot code measures straight into the TPMs before
> proceeding.

I can add a rendition of the above into the existing section of the 
documentation patch that already discusses separation of the measurement 
from the TPM recording code. As to the limits it incurs on the DRTM 
integrity, as explained above, I submit there are none.

v/r,
dps

