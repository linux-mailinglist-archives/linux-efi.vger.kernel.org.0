Return-Path: <linux-efi+bounces-6075-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNAQDqV9f2klsAIAu9opvQ
	(envelope-from <linux-efi+bounces-6075-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sun, 01 Feb 2026 17:21:57 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B098C6710
	for <lists+linux-efi@lfdr.de>; Sun, 01 Feb 2026 17:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C4113004F53
	for <lists+linux-efi@lfdr.de>; Sun,  1 Feb 2026 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8846264A74;
	Sun,  1 Feb 2026 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="oTiSt5ZJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AC263F34;
	Sun,  1 Feb 2026 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769962914; cv=pass; b=ipRKgExmgPnBdIUDEAjY6UMY/m+FOFBbihkGd4dV+SFLJPzf8/pXJdEvWpItX4Gk8OyDt8LtQvag1lOXWhkFTrAQIqCqC5JCRR6OHWt7M/MrkYfu/x1StV5uyDkrf9a6DPHkTa2YtpqTpFEOQknVXKYLF0iwl3Fa0DYFE8tdhJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769962914; c=relaxed/simple;
	bh=wEqhhueRECF0KNX3O0Rb3OOvsLw2IhuQzlhLGOexWiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmfhfG5oAPrbe90xmMpeFUH5Oeb8A/5wGZ+QMngxS6HO9N6jaENZhquIiHxXLhGDhLUN3E12cCSz2VbLG10jZT2ICF3+ktKodYsE78b4t578uTVYtQflGQQiZ4zkSx5yQTxnBJCittwI3KxRVjfRY3c9jm6PcUQF66brsbv6uDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=oTiSt5ZJ; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1769962827; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eLrQVuj3RsXJTTpG5owHrnqFfaHxy6E8IRRb5+CwFA3Bzfi+mJmyXXqc5phB2v4xpkbjb7zHkYRBbS/RVZH2ks0toqesjWOmYyWNH9LBecfI8Wn3v3N4uzI67ntOYXPRdcR8r+Ga5IckWnHefS6oBQXkeMZW3d0YzBLK77sD9lE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769962827; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YIYCK59jh50spm8tJeld6eak6XiX3KK4FkOhjNCm+ws=; 
	b=bgIKAzESOhr623ZcPoiwK6IVCJRgVcxDo/joqJFPIWM0tFh8XkZV0pz2F8lGL6Tn3X/cX3M8AdWWJRTXfqNHMzSjYLIuPlK3CsEKeFjsndEgdsuJKPUIPKjBIdgO5b0GYCGfAwh3LgRwVt0oOtMVBpTs/RaxS6WLlDKDgBuB7iU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769962827;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YIYCK59jh50spm8tJeld6eak6XiX3KK4FkOhjNCm+ws=;
	b=oTiSt5ZJZIrN5X1fyRVpbvtQMlOSvHav0NhcbHW+q/3VDkax3N3xHblVzK2zAHPK
	BOpedbVBfCP7+j/MYLuMGdeF81TvsQg5EWue6+dA1HaKT1/KGm1dVSMIOnN3/GaX3Mq
	I6j6uM5TqURWbXbpA/Yc+M2FHXM9J5c5BsxDvZxs=
Received: by mx.zohomail.com with SMTPS id 1769962824390979.9307132328469;
	Sun, 1 Feb 2026 08:20:24 -0800 (PST)
Message-ID: <b94815dc-fc4d-4073-bfd6-31ab99a6b85b@apertussolutions.com>
Date: Sun, 1 Feb 2026 11:20:20 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 01/28] tpm: Initial step to reorganize TPM public
 headers
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
 ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
 trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-2-ross.philipson@oracle.com>
 <aW7A-4xJSzln1HtH@kernel.org>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 xsJuBFYrueARCACPWL3r2bCSI6TrkIE/aRzj4ksFYPzLkJbWLZGBRlv7HQLvs6i/K4y/b4fs
 JDq5eL4e9BdfdnZm/b+K+Gweyc0Px2poDWwKVTFFRgxKWq9R7McwNnvuZ4nyXJBVn7PTEn/Z
 G7D08iZg94ZsnUdeXfgYdJrqmdiWA6iX9u84ARHUtb0K4r5WpLUMcQ8PVmnv1vVrs/3Wy/Rb
 foxebZNWxgUiSx+d02e3Ad0aEIur1SYXXv71mqKwyi/40CBSHq2jk9eF6zmEhaoFi5+MMMgX
 X0i+fcBkvmT0N88W4yCtHhHQds+RDbTPLGm8NBVJb7R5zbJmuQX7ADBVuNYIU8hx3dF3AQCm
 601w0oZJ0jGOV1vXQgHqZYJGHg5wuImhzhZJCRESIwf+PJxik7TJOgBicko1hUVOxJBZxoe0
 x+/SO6tn+s8wKlR1Yxy8gYN9ZRqV2I83JsWZbBXMG1kLzV0SAfk/wq0PAppA1VzrQ3JqXg7T
 MZ3tFgxvxkYqUP11tO2vrgys+InkZAfjBVMjqXWHokyQPpihUaW0a8mr40w9Qui6DoJj7+Gg
 DtDWDZ7Zcn2hoyrypuht88rUuh1JuGYD434Q6qwQjUDlY+4lgrUxKdMD8R7JJWt38MNlTWvy
 rMVscvZUNc7gxcmnFUn41NPSKqzp4DDRbmf37Iz/fL7i01y7IGFTXaYaF3nEACyIUTr/xxi+
 MD1FVtEtJncZNkRn7WBcVFGKMAf+NEeaeQdGYQ6mGgk++i/vJZxkrC/a9ZXme7BhWRP485U5
 sXpFoGjdpMn4VlC7TFk2qsnJi3yF0pXCKVRy1ukEls8o+4PF2JiKrtkCrWCimB6jxGPIG3lk
 3SuKVS/din3RHz+7Sr1lXWFcGYDENmPd/jTwr1A1FiHrSj+u21hnJEHi8eTa9029F1KRfocp
 ig+k0zUEKmFPDabpanI323O5Tahsy7hwf2WOQwTDLvQ+eqQu40wbb6NocmCNFjtRhNZWGKJS
 b5GrGDGu/No5U6w73adighEuNcCSNBsLyUe48CE0uTO7eAL6Vd+2k28ezi6XY4Y0mgASJslb
 NwW54LzSSM0uRGFuaWVsIFAuIFNtaXRoIDxkcHNtaXRoQGFwZXJ0dXNzb2x1dGlvbnMuY29t
 PsJ6BBMRCAAiBQJWK7ngAhsjBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBTc6WbYpR8
 KrQ9AP94+xjtFfJ8gj5c7PVx06Zv9rcmFUqQspZ5wSEkvxOuQQEAg6qEsPYegI7iByLVzNEg
 7B7fUG7pqWIfMqFwFghYhQzOwU0EViu54BAIAL6MXXNlrJ5tRUf+KMBtVz1LJQZRt/uxWrCb
 T06nZjnbp2UcceuYNbISOVHGXTzu38r55YzpkEA8eURQf+5hjtvlrOiHxvpD+Z6WcpV6rrMB
 kcAKWiZTQihW2HoGgVB3gwG9dCh+n0X5OzliAMiGK2a5iqnIZi3o0SeW6aME94bSkTkuj6/7
 OmH9KAzK8UnlhfkoMg3tXW8L6/5CGn2VyrjbB/rcrbIR4mCQ+yCUlocuOjFCJhBd10AG1IcX
 OXUa/ux+/OAV9S5mkr5Fh3kQxYCTcTRt8RY7+of9RGBk10txi94dXiU2SjPbassvagvu/hEi
 twNHms8rpkSJIeeq0/cAAwUH/jV3tXpaYubwcL2tkk5ggL9Do+/Yo2WPzXmbp8vDiJPCvSJW
 rz2NrYkd/RoX+42DGqjfu8Y04F9XehN1zZAFmCDUqBMa4tEJ7kOT1FKJTqzNVcgeKNBGcT7q
 27+wsqbAerM4A0X/F/ctjYcKwNtXck1Bmd/T8kiw2IgyeOC+cjyTOSwKJr2gCwZXGi5g+2V8
 NhJ8n72ISPnOh5KCMoAJXmCF+SYaJ6hIIFARmnuessCIGw4ylCRIU/TiXK94soilx5aCqb1z
 ke943EIUts9CmFAHt8cNPYOPRd20pPu4VFNBuT4fv9Ys0iv0XGCEP+sos7/pgJ3gV3pCOric
 p15jV4PCYQQYEQgACQUCViu54AIbDAAKCRBTc6WbYpR8Khu7AP9NJrBUn94C/3PeNbtQlEGZ
 NV46Mx5HF0P27lH3sFpNrwD/dVdZ5PCnHQYBZ287ZxVfVr4Zuxjo5yJbRjT93Hl0vMY=
In-Reply-To: <aW7A-4xJSzln1HtH@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[apertussolutions.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[apertussolutions.com];
	TAGGED_FROM(0.00)[bounces-6075-lists,linux-efi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpsmith@apertussolutions.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[apertussolutions.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8B098C6710
X-Rspamd-Action: no action

On 1/19/26 18:40, Jarkko Sakkinen wrote:
> On Mon, Dec 15, 2025 at 03:32:49PM -0800, Ross Philipson wrote:
>> Replace the existing public header tpm_command.h with the first two
>> new public headers tpm1.h and tpm_common.h. In addition, related
>> definitions in tpm1_cmd.c were moved to the new tpm1.h.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   drivers/char/tpm/tpm-buf.c                |  3 +-
>>   drivers/char/tpm/tpm1-cmd.c               | 13 +-----
>>   include/keys/trusted_tpm.h                |  1 -
>>   include/linux/tpm.h                       |  3 ++
>>   include/linux/tpm1.h                      | 55 +++++++++++++++++++++++
>>   include/linux/tpm_command.h               | 30 -------------
> 
> Removing tpm_command.h causes unnecessary noise.
> 
> It would be better to retain tpm_command.h, and simply supplement
> it with TPM2 constants.
> 
> Also, what is the reason to not have both TPM1 and TPM2 in tpm.h?
> 
> To put the question in other words: is there something in tpm.h that
> would be incompatible with early boot code?
> 
> I'd rather tweak that than have more files...

Every #include in tpm.h will break in the early boot code. I don't see 
any way to avoid having one header that is the device driver header that 
integrates with mainline features and at least one header that holds the 
general TPM definitions.

We will move everything that was broken out into tpm_command.h, making 
it the header with the general definitions. I would raise the question 
of whether tpm_command.h would be the best name of the file after 
definition reloactions

>>   include/linux/tpm_common.h                | 22 +++++++++
>>   security/keys/trusted-keys/trusted_tpm1.c |  1 -
>>   security/keys/trusted-keys/trusted_tpm2.c |  1 -
>>   9 files changed, 82 insertions(+), 47 deletions(-)
>>   create mode 100644 include/linux/tpm1.h
>>   delete mode 100644 include/linux/tpm_command.h
>>   create mode 100644 include/linux/tpm_common.h
>>
>> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
>> index 1cb649938c01..dae23e6de269 100644
>> --- a/drivers/char/tpm/tpm-buf.c
>> +++ b/drivers/char/tpm/tpm-buf.c
>> @@ -3,7 +3,6 @@
>>    * Handling of TPM command and other buffers.
>>    */
>>   
>> -#include <linux/tpm_command.h>
>>   #include <linux/module.h>
>>   #include <linux/tpm.h>
>>   
>> @@ -296,7 +295,7 @@ void tpm1_buf_append_extend(struct tpm_buf *buf, u32 pcr_idx, const u8 *hash)
>>   	if (buf->flags & TPM_BUF_INVALID)
>>   		return;
>>   
>> -	if (!tpm1_buf_is_command(buf, TPM_ORD_EXTEND)) {
>> +	if (!tpm1_buf_is_command(buf, TPM_ORD_PCR_EXTEND)) {
>>   		WARN(1, "tpm_buf: invalid TPM_Extend command\n");
>>   		buf->flags |= TPM_BUF_INVALID;
>>   		return;
>> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
>> index bc156d7d59f2..f29827b454d2 100644
>> --- a/drivers/char/tpm/tpm1-cmd.c
>> +++ b/drivers/char/tpm/tpm1-cmd.c
>> @@ -18,12 +18,9 @@
>>   #include <linux/mutex.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/freezer.h>
>> -#include <linux/tpm_command.h>
>>   #include <linux/tpm_eventlog.h>
>>   #include "tpm.h"
>>   
>> -#define TPM_MAX_ORDINAL 243
>> -
>>   /*
>>    * Array with one entry per ordinal defining the maximum amount
>>    * of time the chip could take to return the result.  The ordinal
>> @@ -308,9 +305,6 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>>   		return duration;
>>   }
>>   
>> -#define TPM_ORD_STARTUP 153
>> -#define TPM_ST_CLEAR 1
>> -
>>   /**
>>    * tpm1_startup() - turn on the TPM
>>    * @chip: TPM chip to use
>> @@ -478,7 +472,6 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
>>   	return rc;
>>   }
>>   
>> -#define TPM_ORD_GET_CAP 101
>>   ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>>   		    const char *desc, size_t min_cap_length)
>>   {
>> @@ -574,7 +567,6 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>>   	return rc;
>>   }
>>   
>> -#define TPM_ORD_PCRREAD 21
>>   int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
>>   {
>>   	int rc;
>> @@ -584,7 +576,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
>>   		return -ENOMEM;
>>   
>>   	tpm_buf_init(buf, TPM_BUFSIZE);
>> -	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
>> +	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_READ);
>>   	tpm_buf_append_u32(buf, pcr_idx);
>>   
>>   	rc = tpm_transmit_cmd(chip, buf, TPM_DIGEST_SIZE,
>> @@ -599,7 +591,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
>>   	return rc;
>>   }
>>   
>> -#define TPM_ORD_CONTINUE_SELFTEST 83
>>   /**
>>    * tpm1_continue_selftest() - run TPM's selftest
>>    * @chip: TPM chip to use
>> @@ -716,8 +707,6 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>>   	return rc;
>>   }
>>   
>> -#define TPM_ORD_SAVESTATE 152
>> -
>>   /**
>>    * tpm1_pm_suspend() - pm suspend handler
>>    * @chip: TPM chip to use.
>> diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
>> index 0fadc6a4f166..3a0fa3bc8454 100644
>> --- a/include/keys/trusted_tpm.h
>> +++ b/include/keys/trusted_tpm.h
>> @@ -3,7 +3,6 @@
>>   #define __TRUSTED_TPM_H
>>   
>>   #include <keys/trusted-type.h>
>> -#include <linux/tpm_command.h>
>>   
>>   extern struct trusted_key_ops trusted_key_tpm_ops;
>>   
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index 8da49e8769d5..ef81e0b59657 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -25,6 +25,9 @@
>>   #include <crypto/hash_info.h>
>>   #include <crypto/aes.h>
>>   
>> +#include "tpm_common.h"
>> +#include "tpm1.h"
>> +
>>   #define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
>>   #define TPM_HEADER_SIZE		10
>>   #define TPM_BUFSIZE		4096
>> diff --git a/include/linux/tpm1.h b/include/linux/tpm1.h
>> new file mode 100644
>> index 000000000000..54c6c211eb9e
>> --- /dev/null
>> +++ b/include/linux/tpm1.h
>> @@ -0,0 +1,55 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2004,2007,2008 IBM Corporation
>> + *
>> + * Authors:
>> + * Leendert van Doorn <leendert@watson.ibm.com>
>> + * Dave Safford <safford@watson.ibm.com>
>> + * Reiner Sailer <sailer@watson.ibm.com>
>> + * Kylene Hall <kjhall@us.ibm.com>
>> + * Debora Velarde <dvelarde@us.ibm.com>
>> + *
>> + * Maintained by: <tpmdd_devel@lists.sourceforge.net>
>> + *
>> + * Device driver for TCG/TCPA TPM (trusted platform module).
>> + * Specifications at www.trustedcomputinggroup.org
>> + */
>> +#ifndef __LINUX_TPM1_H__
>> +#define __LINUX_TPM1_H__
>> +
>> +/*
>> + * TPM 1.2 Main Specification
>> + * https://trustedcomputinggroup.org/resource/tpm-main-specification/
>> + */
>> +
>> +/* Command TAGS */
>> +enum tpm_command_tags {
>> +	TPM_TAG_RQU_COMMAND		= 193,
>> +	TPM_TAG_RQU_AUTH1_COMMAND	= 194,
>> +	TPM_TAG_RQU_AUTH2_COMMAND	= 195,
>> +	TPM_TAG_RSP_COMMAND		= 196,
>> +	TPM_TAG_RSP_AUTH1_COMMAND	= 197,
>> +	TPM_TAG_RSP_AUTH2_COMMAND	= 198,
>> +};
>> +
>> +/* Command Ordinals */
>> +enum tpm_command_ordinals {
>> +	TPM_ORD_CONTINUE_SELFTEST	= 83,
>> +	TPM_ORD_GET_CAP			= 101,
>> +	TPM_ORD_GET_RANDOM		= 70,
>> +	TPM_ORD_PCR_EXTEND		= 20,
>> +	TPM_ORD_PCR_READ		= 21,
>> +	TPM_ORD_OSAP			= 11,
>> +	TPM_ORD_OIAP			= 10,
>> +	TPM_ORD_SAVESTATE		= 152,
>> +	TPM_ORD_SEAL			= 23,
>> +	TPM_ORD_STARTUP			= 153,
>> +	TPM_ORD_UNSEAL			= 24,
>> +};
>> +
>> +/* Other constants */to address your concern over diff churn
>> +#define SRKHANDLE                       0x40000000
>> +#define TPM_NONCE_SIZE                  20
>> +#define TPM_ST_CLEAR			1
>> +
>> +#endif
>> diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
>> deleted file mode 100644
>> index 02038972a05f..000000000000
>> --- a/include/linux/tpm_command.h
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> -#ifndef __LINUX_TPM_COMMAND_H__
>> -#define __LINUX_TPM_COMMAND_H__
>> -
>> -/*
>> - * TPM Command constants from specifications at
>> - * http://www.trustedcomputinggroup.org
>> - */
>> -
>> -/* Command TAGS */
>> -#define TPM_TAG_RQU_COMMAND             193
>> -#define TPM_TAG_RQU_AUTH1_COMMAND       194
>> -#define TPM_TAG_RQU_AUTH2_COMMAND       195
>> -#define TPM_TAG_RSP_COMMAND             196
>> -#define TPM_TAG_RSP_AUTH1_COMMAND       197
>> -#define TPM_TAG_RSP_AUTH2_COMMAND       198
>> -
>> -/* Command Ordinals */
>> -#define TPM_ORD_OIAP                    10
>> -#define TPM_ORD_OSAP                    11
>> -#define TPM_ORD_EXTEND			20
>> -#define TPM_ORD_SEAL                    23
>> -#define TPM_ORD_UNSEAL                  24
>> -#define TPM_ORD_GET_RANDOM              70
>> -
>> -/* Other constants */
>> -#define SRKHANDLE                       0x40000000
>> -#define TPM_NONCE_SIZE                  20
>> -
>> -#endif
>> diff --git a/include/linux/tpm_common.h b/include/linux/tpm_common.h
>> new file mode 100644
>> index 000000000000..b8be669913dd
>> --- /dev/null
>> +++ b/include/linux/tpm_common.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2004,2007,2008 IBM Corporation
>> + *
>> + * Authors:
>> + * Leendert van Doorn <leendert@watson.ibm.com>
>> + * Dave Safford <safford@watson.ibm.com>
>> + * Reiner Sailer <sailer@watson.ibm.com>
>> + * Kylene Hall <kjhall@us.ibm.com>
>> + * Debora Velarde <dvelarde@us.ibm.com>
>> + *
>> + * Maintained by: <tpmdd_devel@lists.sourceforge.net>
>> + *
>> + * Device driver for TCG/TCPA TPM (trusted platform module).
>> + * Specifications at www.trustedcomputinggroup.org
>> + */
>> +#ifndef __LINUX_TPM_COMMON_H__
>> +#define __LINUX_TPM_COMMON_H__
>> +
>> +#define TPM_MAX_ORDINAL 243
>> +
>> +#endif
>> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
>> index 6e6a9fb48e63..3717a06a5212 100644
>> --- a/security/keys/trusted-keys/trusted_tpm1.c
>> +++ b/security/keys/trusted-keys/trusted_tpm1.c
>> @@ -17,7 +17,6 @@
>>   #include <keys/trusted-type.h>
>>   #include <linux/key-type.h>
>>   #include <linux/tpm.h>
>> -#include <linux/tpm_command.h>
>>   
>>   #include <keys/trusted_tpm.h>
>>   
>> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>> index 0a99bd051a25..e6000c71eeb6 100644
>> --- a/security/keys/trusted-keys/trusted_tpm2.c
>> +++ b/security/keys/trusted-keys/trusted_tpm2.c
>> @@ -9,7 +9,6 @@
>>   #include <linux/string.h>
>>   #include <linux/err.h>
>>   #include <linux/tpm.h>
>> -#include <linux/tpm_command.h>
>>   
>>   #include <keys/trusted-type.h>
>>   #include <keys/trusted_tpm.h>
>> -- 
>> 2.43.7
>>
> 
> BR, Jarkko

V/r,
DPS


