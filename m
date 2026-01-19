Return-Path: <linux-efi+bounces-6022-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8F3D3BC35
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jan 2026 00:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30C8D3053821
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jan 2026 23:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBE02D060D;
	Mon, 19 Jan 2026 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqSlJFF1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1556128BA83;
	Mon, 19 Jan 2026 23:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768867038; cv=none; b=VCLq1dDmsm81uSIsPInnAi7VKAyvH4nypkANisNy1pgpvYE1HeZwN/NlzQbZUygi7TtgxHQPO06qNvTiE6xq8i8qrXDn75aAqH4FJPqWFYOzvKkDpV0SGIIecKO70eatzrQ3wt3PGkbK4FWxvQtuukoEU1c3mwx1jMpC6M9ol4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768867038; c=relaxed/simple;
	bh=Ymms9yZstnvBosvlJDW69N8zCazrKqkzBHDER+8GMkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTy+sQ6jKN7C/BHnFLamzrMY2kV4zKRHyNQUMaPS8IqkDNMFLM5l5/PEkjjOWfJayGDPw7Uq7nyq84XK4kaouWi6L8HjUUw4kiiz5c8ut8re6xkDCcN1jHwd1a34jG+mKg21AL2PKwg4WZ2bkgMgpA0gw2L9tFjct2CpLdTEXLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqSlJFF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79C0C116C6;
	Mon, 19 Jan 2026 23:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768867037;
	bh=Ymms9yZstnvBosvlJDW69N8zCazrKqkzBHDER+8GMkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gqSlJFF1p8EaqRan/QWfiqyPRR+l3N8NWdYO8KzA0XzAzHC2OUWwZrVV8MB7Eq7US
	 yq3JIYQLfmvlgRezYpiSDd9NN3J1yiriwDLiMLrlnhmVVY3tfWMwj9GdSSG30uOqUd
	 JkF2O1TYIZdFvL3Dv2bQFWvJbK3I6TF9/NOhrTywHiaWHwVyhVT2uaE5zbGgxFytzw
	 DOS1N02aiWwfD/Tow6xjS2hjdTIB+ca5sN/CMlT5/lzJc6hMCBDbF2fu4DpS9pGqIm
	 TeVGd1Q22M1dWebdj6AVN6eAlFhssSfF7uUO7nh6eqETNVXWFO7RbntSDWhmVJ5+vp
	 VvtAlAsobaf/g==
Date: Tue, 20 Jan 2026 01:57:13 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux.dev,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 02/28] tpm: Move TPM1 specific definitions and
 functions to new headers
Message-ID: <aW7E2dVlmjZIUivW@kernel.org>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-3-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215233316.1076248-3-ross.philipson@oracle.com>

On Mon, Dec 15, 2025 at 03:32:50PM -0800, Ross Philipson wrote:
> This gathers all the TPM1 definitions and structures into two separate
> header files (public tpm1.h and private tpm1_structs.h). The definitions
> moved to these files correspond to the TCG specification for TPM 1 family:
> 
> TPM 1.2 Main Specification
>  -  https://trustedcomputinggroup.org/resource/tpm-main-specification/
> 
> Note that the structures were pulled into tpm1_structs.h to allow their
> external reuse.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/char/tpm/tpm.h          | 98 +--------------------------------
>  drivers/char/tpm/tpm1-cmd.c     |  5 --
>  drivers/char/tpm/tpm1_structs.h | 97 ++++++++++++++++++++++++++++++++

I think you are overcomplicating the patch set and doing more
than you really need to do.

I.e. structs could go also just as well to tpm_command.h. We
will deal with if/when that file ever grows too large. It's
absolutely not a priority for this patch set.

>  include/linux/tpm1.h            | 34 +++++++++++-
>  4 files changed, 132 insertions(+), 102 deletions(-)
>  create mode 100644 drivers/char/tpm/tpm1_structs.h
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index ca391b2a211c..1f9f8540eede 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -50,105 +50,9 @@ enum tpm_addr {
>  	TPM_ADDR = 0x4E,
>  };
>  
> -#define TPM_WARN_RETRY          0x800
> -#define TPM_WARN_DOING_SELFTEST 0x802
> -#define TPM_ERR_DEACTIVATED     0x6
> -#define TPM_ERR_DISABLED        0x7
> -#define TPM_ERR_FAILEDSELFTEST  0x1C
> -#define TPM_ERR_INVALID_POSTINIT 38
> -
> -#define TPM_TAG_RQU_COMMAND 193
> -
>  /* TPM2 specific constants. */
>  #define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
>  
> -struct	stclear_flags_t {
> -	__be16	tag;
> -	u8	deactivated;
> -	u8	disableForceClear;
> -	u8	physicalPresence;
> -	u8	physicalPresenceLock;
> -	u8	bGlobalLock;
> -} __packed;
> -
> -struct tpm1_version {
> -	u8 major;
> -	u8 minor;
> -	u8 rev_major;
> -	u8 rev_minor;
> -} __packed;
> -
> -struct tpm1_version2 {
> -	__be16 tag;
> -	struct tpm1_version version;
> -} __packed;
> -
> -struct	timeout_t {
> -	__be32	a;
> -	__be32	b;
> -	__be32	c;
> -	__be32	d;
> -} __packed;
> -
> -struct duration_t {
> -	__be32	tpm_short;
> -	__be32	tpm_medium;
> -	__be32	tpm_long;
> -} __packed;
> -
> -struct permanent_flags_t {
> -	__be16	tag;
> -	u8	disable;
> -	u8	ownership;
> -	u8	deactivated;
> -	u8	readPubek;
> -	u8	disableOwnerClear;
> -	u8	allowMaintenance;
> -	u8	physicalPresenceLifetimeLock;
> -	u8	physicalPresenceHWEnable;
> -	u8	physicalPresenceCMDEnable;
> -	u8	CEKPUsed;
> -	u8	TPMpost;
> -	u8	TPMpostLock;
> -	u8	FIPS;
> -	u8	operator;
> -	u8	enableRevokeEK;
> -	u8	nvLocked;
> -	u8	readSRKPub;
> -	u8	tpmEstablished;
> -	u8	maintenanceDone;
> -	u8	disableFullDALogicInfo;
> -} __packed;
> -
> -typedef union {
> -	struct	permanent_flags_t perm_flags;
> -	struct	stclear_flags_t	stclear_flags;
> -	__u8	owned;
> -	__be32	num_pcrs;
> -	struct tpm1_version version1;
> -	struct tpm1_version2 version2;
> -	__be32	manufacturer_id;
> -	struct timeout_t  timeout;
> -	struct duration_t duration;
> -} cap_t;
> -
> -enum tpm_capabilities {
> -	TPM_CAP_FLAG = 4,
> -	TPM_CAP_PROP = 5,
> -	TPM_CAP_VERSION_1_1 = 0x06,
> -	TPM_CAP_VERSION_1_2 = 0x1A,
> -};
> -
> -enum tpm_sub_capabilities {
> -	TPM_CAP_PROP_PCR = 0x101,
> -	TPM_CAP_PROP_MANUFACTURER = 0x103,
> -	TPM_CAP_FLAG_PERM = 0x108,
> -	TPM_CAP_FLAG_VOL = 0x109,
> -	TPM_CAP_PROP_OWNER = 0x111,
> -	TPM_CAP_PROP_TIS_TIMEOUT = 0x115,
> -	TPM_CAP_PROP_TIS_DURATION = 0x120,
> -};
> -
>  enum tpm2_pt_props {
>  	TPM2_PT_NONE = 0x00000000,
>  	TPM2_PT_GROUP = 0x00000100,
> @@ -229,6 +133,8 @@ enum tpm2_pt_props {
>   * compiler warnings about stack frame size. */
>  #define TPM_MAX_RNG_DATA	128
>  
> +#include "tpm1_structs.h"
> +
>  extern const struct class tpm_class;
>  extern const struct class tpmrm_class;
>  extern dev_t tpm_devt;
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index f29827b454d2..02f20a0aa37d 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -505,11 +505,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>  }
>  EXPORT_SYMBOL_GPL(tpm1_getcap);
>  
> -struct tpm1_get_random_out {
> -	__be32 rng_data_len;
> -	u8 rng_data[TPM_MAX_RNG_DATA];
> -} __packed;
> -
>  /**
>   * tpm1_get_random() - get random bytes from the TPM's RNG
>   * @chip:	a &struct tpm_chip instance
> diff --git a/drivers/char/tpm/tpm1_structs.h b/drivers/char/tpm/tpm1_structs.h
> new file mode 100644
> index 000000000000..ad21376af5ab
> --- /dev/null
> +++ b/drivers/char/tpm/tpm1_structs.h
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2004 IBM Corporation
> + * Copyright (C) 2015 Intel Corporation
> + *
> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + *
> + * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> + *
> + * Device driver for TCG/TCPA TPM (trusted platform module).
> + * Specifications at www.trustedcomputinggroup.org
> + */
> +
> +#ifndef __TPM1_STRUCTS_H__
> +#define __TPM1_STRUCTS_H__
> +
> +struct	stclear_flags_t {
> +	__be16	tag;
> +	u8	deactivated;
> +	u8	disableForceClear;
> +	u8	physicalPresence;
> +	u8	physicalPresenceLock;
> +	u8	bGlobalLock;
> +} __packed;


Don't retain alignment.

> +
> +struct tpm1_version {
> +	u8 major;
> +	u8 minor;
> +	u8 rev_major;
> +	u8 rev_minor;
> +} __packed;
> +
> +struct tpm1_version2 {
> +	__be16 tag;
> +	struct tpm1_version version;
> +} __packed;
> +
> +struct	timeout_t {
> +	__be32	a;
> +	__be32	b;
> +	__be32	c;
> +	__be32	d;
> +} __packed;
> +
> +struct duration_t {
> +	__be32	tpm_short;
> +	__be32	tpm_medium;
> +	__be32	tpm_long;
> +} __packed;
> +
> +struct permanent_flags_t {
> +	__be16	tag;
> +	u8	disable;
> +	u8	ownership;
> +	u8	deactivated;
> +	u8	readPubek;
> +	u8	disableOwnerClear;
> +	u8	allowMaintenance;
> +	u8	physicalPresenceLifetimeLock;
> +	u8	physicalPresenceHWEnable;
> +	u8	physicalPresenceCMDEnable;
> +	u8	CEKPUsed;
> +	u8	TPMpost;
> +	u8	TPMpostLock;
> +	u8	FIPS;
> +	u8	operator;
> +	u8	enableRevokeEK;
> +	u8	nvLocked;
> +	u8	readSRKPub;
> +	u8	tpmEstablished;
> +	u8	maintenanceDone;
> +	u8	disableFullDALogicInfo;
> +} __packed;
> +
> +/* Gather all capabilities related information info one type */
> +typedef union {
> +	struct	permanent_flags_t perm_flags;
> +	struct	stclear_flags_t	stclear_flags;
> +	__u8	owned;
> +	__be32	num_pcrs;
> +	struct tpm1_version version1;
> +	struct tpm1_version2 version2;
> +	__be32	manufacturer_id;
> +	struct timeout_t  timeout;
> +	struct duration_t duration;
> +} cap_t;

Don't retain alignment here.

> +
> +struct tpm1_get_random_out {
> +	__be32 rng_data_len;
> +	u8 rng_data[TPM_MAX_RNG_DATA];
> +} __packed;
> +
> +#endif
> diff --git a/include/linux/tpm1.h b/include/linux/tpm1.h
> index 54c6c211eb9e..5fad94ac8d15 100644
> --- a/include/linux/tpm1.h
> +++ b/include/linux/tpm1.h
> @@ -47,7 +47,39 @@ enum tpm_command_ordinals {
>  	TPM_ORD_UNSEAL			= 24,
>  };
>  
> -/* Other constants */
> +enum tpm_capabilities {
> +	TPM_CAP_FLAG		= 4,
> +	TPM_CAP_PROP		= 5,
> +	TPM_CAP_VERSION_1_1	= 0x06,
> +	TPM_CAP_VERSION_1_2	= 0x1A,
> +};
> +
> +enum tpm_sub_capabilities {
> +	TPM_CAP_PROP_PCR		= 0x101,
> +	TPM_CAP_PROP_MANUFACTURER	= 0x103,
> +	TPM_CAP_FLAG_PERM		= 0x108,
> +	TPM_CAP_FLAG_VOL		= 0x109,
> +	TPM_CAP_PROP_OWNER		= 0x111,
> +	TPM_CAP_PROP_TIS_TIMEOUT	= 0x115,
> +	TPM_CAP_PROP_TIS_DURATION	= 0x120,
> +};
> +
> +/* Return Codes */
> +enum tpm_return_codes {
> +	TPM_BASE_MASK			= 0,
> +	TPM_NON_FATAL_MASK		= 0x00000800,
> +	TPM_SUCCESS			= TPM_BASE_MASK + 0,
> +	TPM_ERR_DEACTIVATED		= TPM_BASE_MASK + 6,
> +	TPM_ERR_DISABLED		= TPM_BASE_MASK + 7,
> +	TPM_ERR_FAIL			= TPM_BASE_MASK + 9,
> +	TPM_ERR_FAILEDSELFTEST		= TPM_BASE_MASK + 28,
> +	TPM_ERR_INVALID_POSTINIT	= TPM_BASE_MASK + 38,
> +	TPM_ERR_INVALID_FAMILY		= TPM_BASE_MASK + 55,
> +	TPM_WARN_RETRY			= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 0,
> +	TPM_WARN_DOING_SELFTEST		= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 2,
> +};
> +
> +/* Misc. constants */

These constants should be relocated in a separate patch.

>  #define SRKHANDLE                       0x40000000
>  #define TPM_NONCE_SIZE                  20
>  #define TPM_ST_CLEAR			1
> -- 
> 2.43.7
> 

BR, Jarkko

