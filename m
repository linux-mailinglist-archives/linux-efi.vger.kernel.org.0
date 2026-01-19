Return-Path: <linux-efi+bounces-6020-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB8BD3BBF9
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jan 2026 00:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A78A3032FE5
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jan 2026 23:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D62F6168;
	Mon, 19 Jan 2026 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us2gH29H"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2386A2E7635;
	Mon, 19 Jan 2026 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768866049; cv=none; b=bsxQSEp5ajL7BpnyODuQjQj2YmoVVqFEWx1AEy4LQd4O4++Ael1j9HnqN3qTjWqpZ+n0DJlAOd74KdYC/cRxI3or8X4u/1Yiu6dl3LhysopS+XRYXdvE2VFD71daFSfhHSMUEaRcC1e6xkneCOy6/XuYayPEcINmJVDD5XzaFZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768866049; c=relaxed/simple;
	bh=6NrPxPz4E43NAmZEFY9zOtn6zSC2DZZMKATrJDNpKPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKDggkLg4eRkZuF2/uKeJ8MopjaOkPuiJCdoNId0lOH+EcrCekjEm4KhYDI5InvNRwPbSwGl3502YG5gVaGUYzvvXW13LuXGQn+643u4HztIlXqFmGn6Ft2V34RAVO9aFDzm2eQU4X09cLLg78aGYaVMa+cTcMbmM2+fRrTeRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us2gH29H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5DDC116C6;
	Mon, 19 Jan 2026 23:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768866048;
	bh=6NrPxPz4E43NAmZEFY9zOtn6zSC2DZZMKATrJDNpKPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=us2gH29HvhoYcy8KLPl2/6iA9PWWRNEui+lLOpEboa9n5QgaiUTjPwADcxIJMlUvn
	 dAoy1PT3pDDksm/95GxauR6NgekSwirir/BqRTJ5qkukU8rfvUHbImJhmuEU1YVTuk
	 FLt46jEaDEKf3ZfXpo2V9xLkcBoBYaVbiSciLENDky3HoBrWDSwYL1OZuhRtyVe5Ra
	 64RvfTo2P33LRMD6ccVWtz466TJMk1WTOCSw6R74++X7c0uQ4OCieDNF/U6+fN+iR7
	 Llthdf1KpfnGisvODUZCj7neulEz2awu5O3ReQTikVIzG0aqbxYe3WJjDQzYy9joCA
	 EVZp1dDagPmnQ==
Date: Tue, 20 Jan 2026 01:40:43 +0200
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
Subject: Re: [PATCH v15 01/28] tpm: Initial step to reorganize TPM public
 headers
Message-ID: <aW7A-4xJSzln1HtH@kernel.org>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-2-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215233316.1076248-2-ross.philipson@oracle.com>

On Mon, Dec 15, 2025 at 03:32:49PM -0800, Ross Philipson wrote:
> Replace the existing public header tpm_command.h with the first two
> new public headers tpm1.h and tpm_common.h. In addition, related
> definitions in tpm1_cmd.c were moved to the new tpm1.h.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/char/tpm/tpm-buf.c                |  3 +-
>  drivers/char/tpm/tpm1-cmd.c               | 13 +-----
>  include/keys/trusted_tpm.h                |  1 -
>  include/linux/tpm.h                       |  3 ++
>  include/linux/tpm1.h                      | 55 +++++++++++++++++++++++
>  include/linux/tpm_command.h               | 30 -------------

Removing tpm_command.h causes unnecessary noise.

It would be better to retain tpm_command.h, and simply supplement
it with TPM2 constants.

Also, what is the reason to not have both TPM1 and TPM2 in tpm.h?

To put the question in other words: is there something in tpm.h that
would be incompatible with early boot code?

I'd rather tweak that than have more files...

>  include/linux/tpm_common.h                | 22 +++++++++
>  security/keys/trusted-keys/trusted_tpm1.c |  1 -
>  security/keys/trusted-keys/trusted_tpm2.c |  1 -
>  9 files changed, 82 insertions(+), 47 deletions(-)
>  create mode 100644 include/linux/tpm1.h
>  delete mode 100644 include/linux/tpm_command.h
>  create mode 100644 include/linux/tpm_common.h
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 1cb649938c01..dae23e6de269 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -3,7 +3,6 @@
>   * Handling of TPM command and other buffers.
>   */
>  
> -#include <linux/tpm_command.h>
>  #include <linux/module.h>
>  #include <linux/tpm.h>
>  
> @@ -296,7 +295,7 @@ void tpm1_buf_append_extend(struct tpm_buf *buf, u32 pcr_idx, const u8 *hash)
>  	if (buf->flags & TPM_BUF_INVALID)
>  		return;
>  
> -	if (!tpm1_buf_is_command(buf, TPM_ORD_EXTEND)) {
> +	if (!tpm1_buf_is_command(buf, TPM_ORD_PCR_EXTEND)) {
>  		WARN(1, "tpm_buf: invalid TPM_Extend command\n");
>  		buf->flags |= TPM_BUF_INVALID;
>  		return;
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index bc156d7d59f2..f29827b454d2 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -18,12 +18,9 @@
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
>  #include <linux/freezer.h>
> -#include <linux/tpm_command.h>
>  #include <linux/tpm_eventlog.h>
>  #include "tpm.h"
>  
> -#define TPM_MAX_ORDINAL 243
> -
>  /*
>   * Array with one entry per ordinal defining the maximum amount
>   * of time the chip could take to return the result.  The ordinal
> @@ -308,9 +305,6 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>  		return duration;
>  }
>  
> -#define TPM_ORD_STARTUP 153
> -#define TPM_ST_CLEAR 1
> -
>  /**
>   * tpm1_startup() - turn on the TPM
>   * @chip: TPM chip to use
> @@ -478,7 +472,6 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
>  	return rc;
>  }
>  
> -#define TPM_ORD_GET_CAP 101
>  ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>  		    const char *desc, size_t min_cap_length)
>  {
> @@ -574,7 +567,6 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  	return rc;
>  }
>  
> -#define TPM_ORD_PCRREAD 21
>  int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
>  {
>  	int rc;
> @@ -584,7 +576,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
>  		return -ENOMEM;
>  
>  	tpm_buf_init(buf, TPM_BUFSIZE);
> -	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
> +	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_READ);
>  	tpm_buf_append_u32(buf, pcr_idx);
>  
>  	rc = tpm_transmit_cmd(chip, buf, TPM_DIGEST_SIZE,
> @@ -599,7 +591,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
>  	return rc;
>  }
>  
> -#define TPM_ORD_CONTINUE_SELFTEST 83
>  /**
>   * tpm1_continue_selftest() - run TPM's selftest
>   * @chip: TPM chip to use
> @@ -716,8 +707,6 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>  	return rc;
>  }
>  
> -#define TPM_ORD_SAVESTATE 152
> -
>  /**
>   * tpm1_pm_suspend() - pm suspend handler
>   * @chip: TPM chip to use.
> diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> index 0fadc6a4f166..3a0fa3bc8454 100644
> --- a/include/keys/trusted_tpm.h
> +++ b/include/keys/trusted_tpm.h
> @@ -3,7 +3,6 @@
>  #define __TRUSTED_TPM_H
>  
>  #include <keys/trusted-type.h>
> -#include <linux/tpm_command.h>
>  
>  extern struct trusted_key_ops trusted_key_tpm_ops;
>  
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 8da49e8769d5..ef81e0b59657 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -25,6 +25,9 @@
>  #include <crypto/hash_info.h>
>  #include <crypto/aes.h>
>  
> +#include "tpm_common.h"
> +#include "tpm1.h"
> +
>  #define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
>  #define TPM_HEADER_SIZE		10
>  #define TPM_BUFSIZE		4096
> diff --git a/include/linux/tpm1.h b/include/linux/tpm1.h
> new file mode 100644
> index 000000000000..54c6c211eb9e
> --- /dev/null
> +++ b/include/linux/tpm1.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2004,2007,2008 IBM Corporation
> + *
> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + * Debora Velarde <dvelarde@us.ibm.com>
> + *
> + * Maintained by: <tpmdd_devel@lists.sourceforge.net>
> + *
> + * Device driver for TCG/TCPA TPM (trusted platform module).
> + * Specifications at www.trustedcomputinggroup.org
> + */
> +#ifndef __LINUX_TPM1_H__
> +#define __LINUX_TPM1_H__
> +
> +/*
> + * TPM 1.2 Main Specification
> + * https://trustedcomputinggroup.org/resource/tpm-main-specification/
> + */
> +
> +/* Command TAGS */
> +enum tpm_command_tags {
> +	TPM_TAG_RQU_COMMAND		= 193,
> +	TPM_TAG_RQU_AUTH1_COMMAND	= 194,
> +	TPM_TAG_RQU_AUTH2_COMMAND	= 195,
> +	TPM_TAG_RSP_COMMAND		= 196,
> +	TPM_TAG_RSP_AUTH1_COMMAND	= 197,
> +	TPM_TAG_RSP_AUTH2_COMMAND	= 198,
> +};
> +
> +/* Command Ordinals */
> +enum tpm_command_ordinals {
> +	TPM_ORD_CONTINUE_SELFTEST	= 83,
> +	TPM_ORD_GET_CAP			= 101,
> +	TPM_ORD_GET_RANDOM		= 70,
> +	TPM_ORD_PCR_EXTEND		= 20,
> +	TPM_ORD_PCR_READ		= 21,
> +	TPM_ORD_OSAP			= 11,
> +	TPM_ORD_OIAP			= 10,
> +	TPM_ORD_SAVESTATE		= 152,
> +	TPM_ORD_SEAL			= 23,
> +	TPM_ORD_STARTUP			= 153,
> +	TPM_ORD_UNSEAL			= 24,
> +};
> +
> +/* Other constants */
> +#define SRKHANDLE                       0x40000000
> +#define TPM_NONCE_SIZE                  20
> +#define TPM_ST_CLEAR			1
> +
> +#endif
> diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
> deleted file mode 100644
> index 02038972a05f..000000000000
> --- a/include/linux/tpm_command.h
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __LINUX_TPM_COMMAND_H__
> -#define __LINUX_TPM_COMMAND_H__
> -
> -/*
> - * TPM Command constants from specifications at
> - * http://www.trustedcomputinggroup.org
> - */
> -
> -/* Command TAGS */
> -#define TPM_TAG_RQU_COMMAND             193
> -#define TPM_TAG_RQU_AUTH1_COMMAND       194
> -#define TPM_TAG_RQU_AUTH2_COMMAND       195
> -#define TPM_TAG_RSP_COMMAND             196
> -#define TPM_TAG_RSP_AUTH1_COMMAND       197
> -#define TPM_TAG_RSP_AUTH2_COMMAND       198
> -
> -/* Command Ordinals */
> -#define TPM_ORD_OIAP                    10
> -#define TPM_ORD_OSAP                    11
> -#define TPM_ORD_EXTEND			20
> -#define TPM_ORD_SEAL                    23
> -#define TPM_ORD_UNSEAL                  24
> -#define TPM_ORD_GET_RANDOM              70
> -
> -/* Other constants */
> -#define SRKHANDLE                       0x40000000
> -#define TPM_NONCE_SIZE                  20
> -
> -#endif
> diff --git a/include/linux/tpm_common.h b/include/linux/tpm_common.h
> new file mode 100644
> index 000000000000..b8be669913dd
> --- /dev/null
> +++ b/include/linux/tpm_common.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2004,2007,2008 IBM Corporation
> + *
> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + * Debora Velarde <dvelarde@us.ibm.com>
> + *
> + * Maintained by: <tpmdd_devel@lists.sourceforge.net>
> + *
> + * Device driver for TCG/TCPA TPM (trusted platform module).
> + * Specifications at www.trustedcomputinggroup.org
> + */
> +#ifndef __LINUX_TPM_COMMON_H__
> +#define __LINUX_TPM_COMMON_H__
> +
> +#define TPM_MAX_ORDINAL 243
> +
> +#endif
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 6e6a9fb48e63..3717a06a5212 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -17,7 +17,6 @@
>  #include <keys/trusted-type.h>
>  #include <linux/key-type.h>
>  #include <linux/tpm.h>
> -#include <linux/tpm_command.h>
>  
>  #include <keys/trusted_tpm.h>
>  
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 0a99bd051a25..e6000c71eeb6 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -9,7 +9,6 @@
>  #include <linux/string.h>
>  #include <linux/err.h>
>  #include <linux/tpm.h>
> -#include <linux/tpm_command.h>
>  
>  #include <keys/trusted-type.h>
>  #include <keys/trusted_tpm.h>
> -- 
> 2.43.7
> 

BR, Jarkko

