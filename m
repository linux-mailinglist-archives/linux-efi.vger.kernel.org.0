Return-Path: <linux-efi+bounces-1247-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B78F390F2DB
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jun 2024 17:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072C81F24A4C
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jun 2024 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFBC1527B1;
	Wed, 19 Jun 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A9IiR2oQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7DD1CAA2;
	Wed, 19 Jun 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811918; cv=none; b=B1UJMw2LH5ri9NSWmKividqvNO45jvz3CFk/KCiuQbGCbSFGZq0OEiBl0c1ObLCOFKIFj97CAm5q1D2UcoxOfuLD2TTB88ob1noT9wnM1cCGeseWaItqodnxzHWjy61DWK4Rn6EOQLMYvx9G/f+2Ru3jJnKNx78gwIYEohUqXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811918; c=relaxed/simple;
	bh=fjs/HSbDS4tp/jn9C/h6sSXqZP5qij2ZouJdM0o1maU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=poKzomoGKW8EVLkW+8oCyo3YKiBwFyvbpbCQ8BJ5HdjYWjX/FxUY4k0H4tOAGfXNhhjcFv7GBbLOIXfxbURsrQXZOjr54tj5UD8h5VTlIrbb39FKqeKesPPO2trgbSawaeSU1lcS+EcOqpAO0+W8+nHI6h1A6N/iXyQZfLQqw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A9IiR2oQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JEpMFC016255;
	Wed, 19 Jun 2024 15:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	xKFYqoB155OgWsXMwJh8/xlXL+QoRB8FAIYdLU5RO84=; b=A9IiR2oQpsG6m7iC
	U+bvYJzwB8FTnrPmIonwnERFvsPReTKHLnnADGzsf+5Cuaxc18/yIy7iaIridZew
	ScQU8hq631G7H9j7Tr6w8LZbZF12MfbDVRucYfE5/WMMaq+TA3iU9jHvWVYU9uDF
	7gphVOPkEs6ltXsnLqUoLwbuXnOGpMjc1Lzkbxzw9RkG5tgwo0YgdKuIXyOTuWfC
	Y1gdtCKE8pqSgJK7GAUMYFIhIbIzmB7sYt/ki1spMnn59XazJNB+BFk8YIiOGf4l
	zwfxm3htdoR7SgCMO5Z+V+lKLu4MtuKkfZRqSoYwPED9UHNbWyPMiRU5mPUyMUf8
	uE4qUg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv14ug74j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:44:37 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45JFiatM003589;
	Wed, 19 Jun 2024 15:44:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv14ug74e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:44:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JEK1v7011052;
	Wed, 19 Jun 2024 15:22:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsndms1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:22:52 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JFMnYS61931950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 15:22:51 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B65358063;
	Wed, 19 Jun 2024 15:22:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C55458052;
	Wed, 19 Jun 2024 15:22:48 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.172.36])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 15:22:48 +0000 (GMT)
Message-ID: <ce7232469844231f768c2f5b4cacc4d48c2f1db3.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 0/8] Clavis LSM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Snowberg <eric.snowberg@oracle.com>,
        linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, mic@digikod.net,
        casey@schaufler-ca.com, stefanb@linux.ibm.com, ebiggers@kernel.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Date: Wed, 19 Jun 2024 11:22:47 -0400
In-Reply-To: <20240531003945.44594-1-eric.snowberg@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kk3i3-PWXGW8orAzEZTBq5y_ZAUx_dRY
X-Proofpoint-ORIG-GUID: w13BX0wkvUBrSH9H9FNy9Th8PuoH-n5q
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1011 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190115

Hi Eric,

On Thu, 2024-05-30 at 18:39 -0600, Eric Snowberg wrote:
> Introduce a new LSM called Clavis (Latin word meaning key).  The motivation
> behind this LSM is to provide access control for system keys.  Before spending
> more time on this LSM, I am sending this as an RFC to start a discussion to see
> if the current direction taken has a possibility of being accepted in the
> future.
> 
> Today the kernel has the following system keyrings: .builtin_trusted_keyring,
> .secondary_trusted_keyring, and the .machine.  It also has the .platform
> keyring which has limited capabilities; it can only be used to verify a kernel
> for kexec.

Please start the cover letter with the problem description/motivation, not the
solution.

From https://docs.kernel.org/process/submitting-patches.html: 

"Describe your problem. Whether your patch is a one-line bug fix or 5000 lines
of a new feature, there must be an underlying problem that motivated you to do
this work. Convince the reviewer that there is a problem worth fixing and that
it makes sense for them to read past the first paragraph."

For example,

Additional keys not built into the kernel could originally be loaded onto the
.secondary_trusted_keyring *only* if they were signed by a key built into the
kernel or by a key already on the .secondary_trusted_keyring.  The concern for
using the wrong key for signature verification was minimal.  With the ability of
loading Machine Owner Keys(MOK) keys onto the .machine keyring, which is linked
to the .secondary_trusted_keys keyring, key usage is a real concern.

To limit key usage ...

> 
> Today the kernel also tracks key usage for verification done with any of these
> keys. Current verification usage includes: VERIFYING_MODULE_SIGNATURE,
> VERIFYING_FIRMWARE_SIGNATURE, VERIFYING_KEXEC_PE_SIGNATURE,
> VERIFYING_KEY_SIGNATURE, VERIFYING_KEY_SELF_SIGNATURE, and
> VERIFYING_UNSPECIFIED_SIGNATURE. After these usage types were originally
> introduced, most additions have typically used the
> VERIFYING_UNSPECIFIED_SIGNATURE.
> 
> At the moment, besides the usage enforcement for .platform keys, any key
> contained within the system keyrings can be used for any verification
> purpose.  For example, a key that was originally created to sign kernel
> modules could be used for BPF verification.
> 
> This new LSM adds the ability to do access control for all system keys. When
> enabled, only the .builtin_trusted_keys are available for loading kernel
> modules and doing a kexec.  Until an ACL entry is added for a specific key, no
> other system key may be used for any other purpose.

Keys stored on the .builtin_trusted_keys keyring seem to always be permitted,
independent of a Clavis rule, which is fine, but the above paragraph needs to be
re-worded.

> 
> Enabling the LSM is done during initial boot by passing in a single asymmetric
> key id within a new "clavis=" boot param. The asymmetric key id must match one
> already contained within any of the system keyrings.  If a match is found, a
> link is created into the new .clavis keyring.  This key shall be used as the
> root of trust for any keyring ACL updates afterwards.
> 
> On UEFI systems the "clavis" boot param is mirrored into a new UEFI variable
> within the EFI stub code. This variable will persist until the next power on
> reset.  This same type of functionality is done within shim. Since this
> variable is created before ExitBootServices (EBS) it will not have the NVRAM
> bit set, signifying it was created during the Boot Services phase. This is
> being used so the "clavis" boot param can not be changed via kexec, thereby
> preventing a pivot of the root of trust.

Move this paragraph (and patch) to later.  Defining a new UEFI variable makes it
more difficult to test.  Consider defering introducing the new UEFI variable
patch to the end.

> 
> As mentioned earlier, this LSM introduces a new .clavis keyring.  Following
> boot, no new asymmetric keys can be added to this keyring and only the key
> designated via the initial boot param may be used. This LSM can not be started
> at any other point in time.  The .clavis keyring also holds the access control
> list for system keys. A new key type called clavis_key_acl is being introduced.
> This contains the usage followed by the asymmetric key id. To be added to the
> clavis keyring, the clavis_key_acl must be S/MIME signed by the sole asymmetric
> key contained within it. New ACL additions to the .clavis keyring may be added
> at any time.

Ok. To summarize, the Clavis policy rules are loaded at runtime onto the .clavis
keyring.  The Clavis rules must be signed by the key specified on the "clavis="
boot command line.  The only key on the .clavis keyring is the one specified on
the boot command line.

As far as I'm aware, this would be the first time policy rules are stored in a
keyring.

> 
> Currently this LSM does not require new changes or modifications to any user
> space tools.  It also does not have a securityfs interface.  Everything is
> done using the existing keyctl tool through the new .clavis keyring. The
> S/MIME signing can be done with a simple OpenSSL command. If additions or
> updates need to be added in the future, new ACL key types could be created.
> With this approach, maintainability should not be an issue in the future
> if missing items are identified.
> 
> Clavis must be configured at build time with CONFIG_SECURITY_CLAVIS=y. The list
> of security modules enabled by default is set with CONFIG_LSM.  The kernel
> configuration must contain CONFIG_LSM=clavis,[...] with [...] as the list of
> other security modules for the running system.
> 
> For setup and usage instructions, the final patch includes an admin-guide.
> 
> Future enhancements to this LSM could include:
> 
> 1. Subsystems that currently use system keys with
>    VERIFYING_UNSPECIFIED_SIGNATURE could be updated with their specific
>    usage type.  For example, a usage type for IMA, BPF, etc could be
>    added.

Being able to at least limit the key used to verify the IMA policy signature
would be nice to have earlier, rather than later.

> 
> 2. Currently, each clavis_key_acl must be individually signed.  Add the ability
>    to sign multiple clavis_key_acl entries within the same file.
> 
> 3. Currently, this LSM does not place key usage restrictions on the builtin
>    keys for kexec and kernel module verification. This was done to prevent a
>    regression that could  prevent the kernel from booting.  This could be
>    changed if there was a way at compile time to pre-populate the .clavis
>    keyring. This would allow the ephemeral key used to sign the kernel
>    modules to be included within the .clavis keyring, allowing the kernel
>    to boot.

I don't see a problem with trusting the builtin keys.  They should be trusted. 

> 
> 4. UEFI Secure Boot Advanced Targeting (SBAT) support. Since
>    the boot param is mirrored into UEFI before EBS is called,
>    this LSM could be enhanced to not only enforce key usage,
>    but also SBAT levels across kexec.
> 
> 5. Having the ability to allow platform keys to be on par with
>    all other system keys when using this LSM. This would be useful
>    for a user that controls their entire UEFI SB DB key chain and
>    doesn't want to use MOK keys.

Additional comments:

This patch set is dependent on CONFIG_{MODULE, KEXEC}_SIG being enabled:

- with CONFIG_MODULE_SIG_FORCE and CONFIG_KEXEC_SIG_FORCE configured.
- wit sig_enforce specified on the boot command line.
- with either Lockdown or CONFIG_IMA_ARCH_POLICY enforcing kexec/module
signature verification.

Without CONFIG_{MODULE, KEXEC}_SIG enabled and with CONFIG_IMA_ARCH_POLICY
enabled or similar rules, IMA would verify the kexec kernel image and kernel
modules without Clavis enforcement.

Mimi


