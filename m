Return-Path: <linux-efi+bounces-6077-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODOJEDt+f2khsAIAu9opvQ
	(envelope-from <linux-efi+bounces-6077-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sun, 01 Feb 2026 17:24:27 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B426C67AC
	for <lists+linux-efi@lfdr.de>; Sun, 01 Feb 2026 17:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4216230057BB
	for <lists+linux-efi@lfdr.de>; Sun,  1 Feb 2026 16:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86726562D;
	Sun,  1 Feb 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="srF4UjmD"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009B26738D;
	Sun,  1 Feb 2026 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769963063; cv=pass; b=YaTZbcDZZR++Iv1oYrOJ8CApUjsLOHEOLrVYKlQ15pKcJm6QvGtvSv/86ReSAnbCVQboqdGcVI9zwPsyJwxMm/s6x9KN+p7rQp0TDSDP9Jxonp6cwfvt7xNFBYu1LA5BDH2+WabaSFGSUqy8elQkvcSjiuHkLVL4ghLmrCJJ8gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769963063; c=relaxed/simple;
	bh=gz7JzYEX32+UneDT+1y1TEhC72ZYfZF1Y4zl1zCOyt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjZDeDL/Il7nu+YsU0YNQg8zfooqYY36gDDBWPTXMzcGycgxG5qbfJ7f2i1YzDsy6D1RFZLaIB+/6yKEdbQCuJ5n9U3aRfdxsROIEfsuoyjRQR/ZPcyTUXO9Rf4lRr3HNv8r9Bf0O4jKkOb7IzOjF3ho4jfQg5CCUx14jcjXs+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=srF4UjmD; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1769963003; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NJVH0cYmByB0Kq6vuJZJrwJBFGy987NMivxiMW15FjX932DdFzAIP5rvbp8S5CyzSlTGVimtEFebnc3owiWBXs1ZmNHZsVfFaREjYmJJiyKdrHmvUyEVbv0IfdHmrvV0vi6J23TcCE82pgnVB7KWgOQnxnrMo9MbTMaF/KL/WNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769963003; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gang1C4CllF1r3zmhNL+D5i2O4iT3MRc0+oAelOqd/o=; 
	b=Xq+AVtvcXglRAG/4vfgOZdqc8xUcw39gN7X2Ds3G/mGNK+rlSkVp0CxTPAqx8LvyD+dtX4ZoPL7lEiqT+zgBuNP230Nd6/gm3WbIxghu8p8XeiXA8f8QBJfMaIZqS/W9G6P8UEEuhPvdbl5jHdjQKwnjMJWtcTOUCfyMLHbyhuk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769963003;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gang1C4CllF1r3zmhNL+D5i2O4iT3MRc0+oAelOqd/o=;
	b=srF4UjmDPKDMVBBOx9G39Z8s2vSqcvEWZaz4heIWnGT4/uGBhe74nP7rdfnesdJa
	G46R2lRHV5O2TiiuYhywTobDSFwX0fGRVcROJb8BQ4fBDxBuH6UAgNUa7SvfNrWUKY0
	kwjrEHlJiW2CBQyUUvPzyoX1LK/CsrhhMUy4ir44=
Received: by mx.zohomail.com with SMTPS id 1769963000738545.2953699572172;
	Sun, 1 Feb 2026 08:23:20 -0800 (PST)
Message-ID: <7aad3461-f0a5-42ff-ba9b-b52edd7d36db@apertussolutions.com>
Date: Sun, 1 Feb 2026 11:23:17 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 02/28] tpm: Move TPM1 specific definitions and
 functions to new headers
Content-Language: en-US
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
 <20251215233316.1076248-3-ross.philipson@oracle.com>
 <aW7E2dVlmjZIUivW@kernel.org>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <aW7E2dVlmjZIUivW@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[apertussolutions.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[apertussolutions.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6077-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpsmith@apertussolutions.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[apertussolutions.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,trustedcomputinggroup.org:url,apertussolutions.com:email,apertussolutions.com:dkim,apertussolutions.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B426C67AC
X-Rspamd-Action: no action

On 1/19/26 18:57, Jarkko Sakkinen wrote:
> On Mon, Dec 15, 2025 at 03:32:50PM -0800, Ross Philipson wrote:
>> This gathers all the TPM1 definitions and structures into two separate
>> header files (public tpm1.h and private tpm1_structs.h). The definitions
>> moved to these files correspond to the TCG specification for TPM 1 family:
>>
>> TPM 1.2 Main Specification
>>   -  https://trustedcomputinggroup.org/resource/tpm-main-specification/
>>
>> Note that the structures were pulled into tpm1_structs.h to allow their
>> external reuse.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   drivers/char/tpm/tpm.h          | 98 +--------------------------------
>>   drivers/char/tpm/tpm1-cmd.c     |  5 --
>>   drivers/char/tpm/tpm1_structs.h | 97 ++++++++++++++++++++++++++++++++
> 
> I think you are overcomplicating the patch set and doing more
> than you really need to do.
> 
> I.e. structs could go also just as well to tpm_command.h. We
> will deal with if/when that file ever grows too large. It's
> absolutely not a priority for this patch set.

Ack.

>>   include/linux/tpm1.h            | 34 +++++++++++-
>>   4 files changed, 132 insertions(+), 102 deletions(-)
>>   create mode 100644 drivers/char/tpm/tpm1_structs.h
>>
>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index ca391b2a211c..1f9f8540eede 100644
>> --- a/drivers/char/tpm/tpm.h
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -50,105 +50,9 @@ enum tpm_addr {
>>   	TPM_ADDR = 0x4E,
>>   };
>>   
>> -#define TPM_WARN_RETRY          0x800
>> -#define TPM_WARN_DOING_SELFTEST 0x802
>> -#define TPM_ERR_DEACTIVATED     0x6
>> -#define TPM_ERR_DISABLED        0x7
>> -#define TPM_ERR_FAILEDSELFTEST  0x1C
>> -#define TPM_ERR_INVALID_POSTINIT 38
>> -
>> -#define TPM_TAG_RQU_COMMAND 193
>> -
>>   /* TPM2 specific constants. */
>>   #define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
>>   
>> -struct	stclear_flags_t {
>> -	__be16	tag;
>> -	u8	deactivated;
>> -	u8	disableForceClear;
>> -	u8	physicalPresence;
>> -	u8	physicalPresenceLock;
>> -	u8	bGlobalLock;
>> -} __packed;
>> -
>> -struct tpm1_version {
>> -	u8 major;
>> -	u8 minor;
>> -	u8 rev_major;
>> -	u8 rev_minor;
>> -} __packed;
>> -
>> -struct tpm1_version2 {
>> -	__be16 tag;
>> -	struct tpm1_version version;
>> -} __packed;
>> -
>> -struct	timeout_t {
>> -	__be32	a;
>> -	__be32	b;
>> -	__be32	c;
>> -	__be32	d;
>> -} __packed;
>> -
>> -struct duration_t {
>> -	__be32	tpm_short;
>> -	__be32	tpm_medium;
>> -	__be32	tpm_long;
>> -} __packed;
>> -
>> -struct permanent_flags_t {
>> -	__be16	tag;
>> -	u8	disable;
>> -	u8	ownership;
>> -	u8	deactivated;
>> -	u8	readPubek;
>> -	u8	disableOwnerClear;
>> -	u8	allowMaintenance;
>> -	u8	physicalPresenceLifetimeLock;
>> -	u8	physicalPresenceHWEnable;
>> -	u8	physicalPresenceCMDEnable;
>> -	u8	CEKPUsed;
>> -	u8	TPMpost;
>> -	u8	TPMpostLock;
>> -	u8	FIPS;
>> -	u8	operator;
>> -	u8	enableRevokeEK;
>> -	u8	nvLocked;
>> -	u8	readSRKPub;
>> -	u8	tpmEstablished;
>> -	u8	maintenanceDone;
>> -	u8	disableFullDALogicInfo;
>> -} __packed;
>> -
>> -typedef union {
>> -	struct	permanent_flags_t perm_flags;
>> -	struct	stclear_flags_t	stclear_flags;
>> -	__u8	owned;
>> -	__be32	num_pcrs;
>> -	struct tpm1_version version1;
>> -	struct tpm1_version2 version2;
>> -	__be32	manufacturer_id;
>> -	struct timeout_t  timeout;
>> -	struct duration_t duration;
>> -} cap_t;
>> -
>> -enum tpm_capabilities {
>> -	TPM_CAP_FLAG = 4,
>> -	TPM_CAP_PROP = 5,
>> -	TPM_CAP_VERSION_1_1 = 0x06,
>> -	TPM_CAP_VERSION_1_2 = 0x1A,
>> -};
>> -
>> -enum tpm_sub_capabilities {
>> -	TPM_CAP_PROP_PCR = 0x101,
>> -	TPM_CAP_PROP_MANUFACTURER = 0x103,
>> -	TPM_CAP_FLAG_PERM = 0x108,
>> -	TPM_CAP_FLAG_VOL = 0x109,
>> -	TPM_CAP_PROP_OWNER = 0x111,
>> -	TPM_CAP_PROP_TIS_TIMEOUT = 0x115,
>> -	TPM_CAP_PROP_TIS_DURATION = 0x120,
>> -};
>> -
>>   enum tpm2_pt_props {
>>   	TPM2_PT_NONE = 0x00000000,
>>   	TPM2_PT_GROUP = 0x00000100,
>> @@ -229,6 +133,8 @@ enum tpm2_pt_props {
>>    * compiler warnings about stack frame size. */
>>   #define TPM_MAX_RNG_DATA	128
>>   
>> +#include "tpm1_structs.h"
>> +
>>   extern const struct class tpm_class;
>>   extern const struct class tpmrm_class;
>>   extern dev_t tpm_devt;
>> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
>> index f29827b454d2..02f20a0aa37d 100644
>> --- a/drivers/char/tpm/tpm1-cmd.c
>> +++ b/drivers/char/tpm/tpm1-cmd.c
>> @@ -505,11 +505,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>>   }
>>   EXPORT_SYMBOL_GPL(tpm1_getcap);
>>   
>> -struct tpm1_get_random_out {
>> -	__be32 rng_data_len;
>> -	u8 rng_data[TPM_MAX_RNG_DATA];
>> -} __packed;
>> -
>>   /**
>>    * tpm1_get_random() - get random bytes from the TPM's RNG
>>    * @chip:	a &struct tpm_chip instance
>> diff --git a/drivers/char/tpm/tpm1_structs.h b/drivers/char/tpm/tpm1_structs.h
>> new file mode 100644
>> index 000000000000..ad21376af5ab
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm1_structs.h
>> @@ -0,0 +1,97 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2004 IBM Corporation
>> + * Copyright (C) 2015 Intel Corporation
>> + *
>> + * Authors:
>> + * Leendert van Doorn <leendert@watson.ibm.com>
>> + * Dave Safford <safford@watson.ibm.com>
>> + * Reiner Sailer <sailer@watson.ibm.com>
>> + * Kylene Hall <kjhall@us.ibm.com>
>> + *
>> + * Maintained by: <tpmdd-devel@lists.sourceforge.net>
>> + *
>> + * Device driver for TCG/TCPA TPM (trusted platform module).
>> + * Specifications at www.trustedcomputinggroup.org
>> + */
>> +
>> +#ifndef __TPM1_STRUCTS_H__
>> +#define __TPM1_STRUCTS_H__
>> +
>> +struct	stclear_flags_t {
>> +	__be16	tag;
>> +	u8	deactivated;
>> +	u8	disableForceClear;
>> +	u8	physicalPresence;
>> +	u8	physicalPresenceLock;
>> +	u8	bGlobalLock;
>> +} __packed;
> 
> 
> Don't retain alignment.
> 

Okay.

>> +
>> +struct tpm1_version {
>> +	u8 major;
>> +	u8 minor;
>> +	u8 rev_major;
>> +	u8 rev_minor;
>> +} __packed;
>> +
>> +struct tpm1_version2 {
>> +	__be16 tag;
>> +	struct tpm1_version version;
>> +} __packed;
>> +
>> +struct	timeout_t {
>> +	__be32	a;
>> +	__be32	b;
>> +	__be32	c;
>> +	__be32	d;
>> +} __packed;
>> +
>> +struct duration_t {
>> +	__be32	tpm_short;
>> +	__be32	tpm_medium;
>> +	__be32	tpm_long;
>> +} __packed;
>> +
>> +struct permanent_flags_t {
>> +	__be16	tag;
>> +	u8	disable;
>> +	u8	ownership;
>> +	u8	deactivated;
>> +	u8	readPubek;
>> +	u8	disableOwnerClear;
>> +	u8	allowMaintenance;
>> +	u8	physicalPresenceLifetimeLock;
>> +	u8	physicalPresenceHWEnable;
>> +	u8	physicalPresenceCMDEnable;
>> +	u8	CEKPUsed;
>> +	u8	TPMpost;
>> +	u8	TPMpostLock;
>> +	u8	FIPS;
>> +	u8	operator;
>> +	u8	enableRevokeEK;
>> +	u8	nvLocked;
>> +	u8	readSRKPub;
>> +	u8	tpmEstablished;
>> +	u8	maintenanceDone;
>> +	u8	disableFullDALogicInfo;
>> +} __packed;
>> +
>> +/* Gather all capabilities related information info one type */
>> +typedef union {
>> +	struct	permanent_flags_t perm_flags;
>> +	struct	stclear_flags_t	stclear_flags;
>> +	__u8	owned;
>> +	__be32	num_pcrs;
>> +	struct tpm1_version version1;
>> +	struct tpm1_version2 version2;
>> +	__be32	manufacturer_id;
>> +	struct timeout_t  timeout;
>> +	struct duration_t duration;
>> +} cap_t;
> 
> Don't retain alignment here.
> 

Okay.

>> +
>> +struct tpm1_get_random_out {
>> +	__be32 rng_data_len;
>> +	u8 rng_data[TPM_MAX_RNG_DATA];
>> +} __packed;
>> +
>> +#endif
>> diff --git a/include/linux/tpm1.h b/include/linux/tpm1.h
>> index 54c6c211eb9e..5fad94ac8d15 100644
>> --- a/include/linux/tpm1.h
>> +++ b/include/linux/tpm1.h
>> @@ -47,7 +47,39 @@ enum tpm_command_ordinals {
>>   	TPM_ORD_UNSEAL			= 24,
>>   };
>>   
>> -/* Other constants */
>> +enum tpm_capabilities {
>> +	TPM_CAP_FLAG		= 4,
>> +	TPM_CAP_PROP		= 5,
>> +	TPM_CAP_VERSION_1_1	= 0x06,
>> +	TPM_CAP_VERSION_1_2	= 0x1A,
>> +};
>> +
>> +enum tpm_sub_capabilities {
>> +	TPM_CAP_PROP_PCR		= 0x101,
>> +	TPM_CAP_PROP_MANUFACTURER	= 0x103,
>> +	TPM_CAP_FLAG_PERM		= 0x108,
>> +	TPM_CAP_FLAG_VOL		= 0x109,
>> +	TPM_CAP_PROP_OWNER		= 0x111,
>> +	TPM_CAP_PROP_TIS_TIMEOUT	= 0x115,
>> +	TPM_CAP_PROP_TIS_DURATION	= 0x120,
>> +};
>> +
>> +/* Return Codes */
>> +enum tpm_return_codes {
>> +	TPM_BASE_MASK			= 0,
>> +	TPM_NON_FATAL_MASK		= 0x00000800,
>> +	TPM_SUCCESS			= TPM_BASE_MASK + 0,
>> +	TPM_ERR_DEACTIVATED		= TPM_BASE_MASK + 6,
>> +	TPM_ERR_DISABLED		= TPM_BASE_MASK + 7,
>> +	TPM_ERR_FAIL			= TPM_BASE_MASK + 9,
>> +	TPM_ERR_FAILEDSELFTEST		= TPM_BASE_MASK + 28,
>> +	TPM_ERR_INVALID_POSTINIT	= TPM_BASE_MASK + 38,
>> +	TPM_ERR_INVALID_FAMILY		= TPM_BASE_MASK + 55,
>> +	TPM_WARN_RETRY			= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 0,
>> +	TPM_WARN_DOING_SELFTEST		= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 2,
>> +};
>> +
>> +/* Misc. constants */
> 
> These constants should be relocated in a separate patch.
> 

Okay.

>>   #define SRKHANDLE                       0x40000000
>>   #define TPM_NONCE_SIZE                  20
>>   #define TPM_ST_CLEAR			1
>> -- 
>> 2.43.7
>>
> 
> BR, Jarkko


