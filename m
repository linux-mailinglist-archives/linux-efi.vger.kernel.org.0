Return-Path: <linux-efi+bounces-6023-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9914DD3BC4F
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jan 2026 01:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C74E9300969A
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jan 2026 00:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC590A930;
	Tue, 20 Jan 2026 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t10SaOiH"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66C500965;
	Tue, 20 Jan 2026 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768867841; cv=none; b=cnBOL7OCvqTrd7wne7v5/ssOlS4/1aN8LdBU9oLtdYu4fmQ9ZAjjcxTaxnQzx18RPd8fOmYuRfWUy4kAZG3hoUajjSZzPBjva8wjQ2ZKMoqgsZ4yFWtfhEkwyeNtQkbi9Y4zdJPxdtKVLXnlQw21zabqpiMqlBqGQvIh/dpKE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768867841; c=relaxed/simple;
	bh=UYhkcw7jT1kDejb0HUjsjFTLq54ojVOMKU7QLWxq7a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjHBk083lt6Lo+d5ofDC2I8qGorho7h5DMfZquRh3Z0+myO4rPSvP26bIL9DMVkygB7abujFVinVFSsX5tkt2xCbS9GVTFhB5cwuz48ZKNxbcRAlF6rDuR61lUWqH2DxuBCv0h5TSL5FbAqpz45Ayn5FV++aJejWPwXErNOOY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t10SaOiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A936C116C6;
	Tue, 20 Jan 2026 00:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768867841;
	bh=UYhkcw7jT1kDejb0HUjsjFTLq54ojVOMKU7QLWxq7a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t10SaOiHvxDSb6/ZEchM2kpSMSAjd8YhA1P0+glMiPbt77/kn7WASwSHtzv+6AzHW
	 hZBw8D/EqHctBuDmAlsbrKMnZOUqP56YVfvZbv6wswJZ3ea3w4q5BzzwlyzsAJGZAd
	 1+HVVCSW0OG9fYYlP+1fplsC8gPaf1o2KaE2uMoCji72b7gh/CBK05j8jflna1ny4W
	 jxaC4ORERDvpNYD6cMyu0n4qZc89YObI3xvhbWpA0mfq07p/UPbS3DCNqH1xLO+p5z
	 +7iG2skk/OWddtHmEHb8cUZMnyB/V2VuL/YjSzXT9f9YdMZNDDx/R0ID1Q1pJ/OS+q
	 VO3fkIpdSqe4Q==
Date: Tue, 20 Jan 2026 02:10:36 +0200
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
Subject: Re: [PATCH v15 19/28] x86/tpm: Early TPM PCR extending driver
Message-ID: <aW7H_LwhYux0ajtq@kernel.org>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-20-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215233316.1076248-20-ross.philipson@oracle.com>

On Mon, Dec 15, 2025 at 03:33:07PM -0800, Ross Philipson wrote:
> Introduce an early driver that can interact minimally with the
> TPM. This allows the Secure Launch startup code to extend measurement
> values into the TPM's DRTM PCR banks early in the launch process.
> 
> This driver implementation is very minimal, only supporting basic
> initialization and extend commands. An extend command can be sent to both
> a TPM 2.0 or 1.2 chip but only the TIS/FIFO interface is currently
> supported. The CRB interface is currently not supported. The TCG specs
> for these interface can be found here:
> 
> https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
> https://trustedcomputinggroup.org/resource/tpm-2-0-mobile-command-response-buffer-interface-specification/
> 
> The driver could be extended for further operations if needed. This
> TPM dirver implementation relies as much as possible on existing mainline
> kernel TPM code.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Wouldn't it be possible to simply link code from tpm-interface.c and
re-use PCR functions from tpm1-cmd.c and tpm2-cmd.c?

We can even split transmit code from rest of tpm-interface.c if that
is necessary for some reason.

I.e. link the code and define ops re-using code below.

If using tpm_transmit is impossible, less ideally you could also
implement your own tpm_transmit_cmd and link tpm1-cmd.o and tpm2-cmd.o,
which will work out as the symbol is there.

> ---
>  arch/x86/boot/compressed/Makefile           |   1 +
>  arch/x86/boot/compressed/early_tpm_extend.c | 601 ++++++++++++++++++++
>  arch/x86/boot/compressed/tpm.h              |  42 ++
>  3 files changed, 644 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/early_tpm_extend.c
>  create mode 100644 arch/x86/boot/compressed/tpm.h
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 0ea8a11ec271..b108e0edf367 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -114,6 +114,7 @@ endif
>  
>  slaunch-objs += $(obj)/sha1.o
>  slaunch-objs += $(obj)/sha256.o
> +slaunch-objs += $(obj)/early_tpm_extend.o
>  
>  vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(slaunch-objs)
>  
> diff --git a/arch/x86/boot/compressed/early_tpm_extend.c b/arch/x86/boot/compressed/early_tpm_extend.c
> new file mode 100644
> index 000000000000..7cfdb7969878
> --- /dev/null
> +++ b/arch/x86/boot/compressed/early_tpm_extend.c
> @@ -0,0 +1,601 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2010-2012 United States Government, as represented by
> + * the Secretary of Defense.  All rights reserved.
> + *
> + * based off of the original tools/vtpm_manager code base which is:
> + * Copyright (c) 2005, Intel Corp.
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + *   * Redistributions of source code must retain the above copyright
> + *     notice, this list of conditions and the following disclaimer.
> + *   * Redistributions in binary form must reproduce the above
> + *     copyright notice, this list of conditions and the following
> + *     disclaimer in the documentation and/or other materials provided
> + *     with the distribution.
> + *   * Neither the name of Intel Corporation nor the names of its
> + *     contributors may be used to endorse or promote products derived
> + *     from this software without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> + * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> + * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
> + * OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <crypto/sha2.h>
> +#include <asm/msr.h>
> +#include <asm/io.h>
> +
> +#include <linux/tpm_common.h>
> +#include <linux/tpm1.h>
> +#include <linux/tpm2.h>
> +#include <linux/tpm_ptp.h>
> +#include <linux/tpm_buf.h>
> +
> +#include "../../../../drivers/char/tpm/tpm1_structs.h"
> +#include "../../../../drivers/char/tpm/tpm2_structs.h"
> +
> +#include "tpm.h"
> +
> +static u8 tpm_buf_page[PAGE_SIZE];
> +
> +/*
> + * Single threaded environment only running on BSP. Use a single shared
> + * page for all TPM extend operations.
> + */
> +static inline struct tpm_buf *tpm_buf_alloc_page(void)
> +{
> +	memset(tpm_buf_page, 0, PAGE_SIZE);
> +	return (struct tpm_buf *)tpm_buf_page;
> +}
> +
> +static inline void tpm_buf_free_page(void)
> +{
> +	memset(tpm_buf_page, 0, PAGE_SIZE);
> +}
> +
> +/* Pull in TPM buffer management support */
> +#undef WARN
> +#define WARN(c, f...)
> +#undef WARN_ON
> +#define WARN_ON(c) (0)
> +
> +#include "../../../../drivers/char/tpm/tpm-buf.c"
> +
> +static u32 tpm_get_alg_size(u16 alg_id)
> +{
> +	switch (alg_id) {
> +	case TPM_ALG_SHA1:
> +		return TPM_DIGEST_SIZE;
> +	case TPM_ALG_SHA256:
> +	case TPM_ALG_SM3_256:
> +		return SHA256_DIGEST_SIZE;
> +	case TPM_ALG_SHA384:
> +		return SHA384_DIGEST_SIZE;
> +	case TPM_ALG_SHA512:
> +	default:
> +		return SHA512_DIGEST_SIZE;
> +	};
> +}
> +
> +static inline u8 tpm_read8(struct tpm_chip *chip, u32 field)
> +{
> +	void *mmio_addr = (void *)(uintptr_t)(chip->baseaddr | field);
> +	return readb(mmio_addr);
> +}
> +
> +static inline void tpm_write8(struct tpm_chip *chip, u32 field, u8 val)
> +{
> +	void *mmio_addr = (void *)(uintptr_t)(chip->baseaddr | field);
> +	writeb(val, mmio_addr);
> +}
> +
> +static inline u32 tpm_read32(struct tpm_chip *chip, u32 field)
> +{
> +	void *mmio_addr = (void *)(uintptr_t)(chip->baseaddr | field);
> +	return readl(mmio_addr);
> +}
> +
> +static inline void tpm_write32(struct tpm_chip *chip, u32 field, u32 val)
> +{
> +	void *mmio_addr = (void *)(uintptr_t)(chip->baseaddr | field);
> +	writel(val, mmio_addr);
> +}
> +
> +static unsigned long ticks_per_ms = (5UL * 1000 * 1000 /* cpu_khz */ / 1000);
> +
> +static inline ktime_t tpm_now_ms(void)
> +{
> +	return rdtsc()/ticks_per_ms;
> +}
> +
> +/*
> + * We're far too early to calibrate time.  Assume a 5GHz processor (the upper
> + * end of the Fam19h range), which causes us to be wrong in the safe direction
> + * on slower systems.
> + */
> +static inline void tpm_mdelay(unsigned int msecs)
> +{
> +	unsigned long ticks = msecs * ticks_per_ms;
> +	unsigned long s, e;
> +
> +	s = rdtsc();
> +	do {
> +		cpu_relax();
> +		e = rdtsc();
> +	} while ((e - s) < ticks);
> +}
> +
> +static inline u8 __tis_status(struct tpm_chip *chip)
> +{
> +	return tpm_read8(chip, TPM_STS(chip->locality));
> +}
> +
> +static inline void __tis_cancel(struct tpm_chip *chip)
> +{
> +	/* This causes the current command to be aborted */
> +	tpm_write8(chip, TPM_STS(chip->locality), TPM_STS_COMMAND_READY);
> +}
> +
> +static int __tis_get_burstcount(struct tpm_chip *chip)
> +{
> +	ktime_t stop;
> +	int burstcnt;
> +
> +	stop = tpm_now_ms() + chip->timeout_d;
> +	do {
> +		burstcnt = tpm_read8(chip, (TPM_STS(chip->locality) + 1));
> +		burstcnt += tpm_read8(chip, TPM_STS(chip->locality) + 2) << 8;
> +
> +		if (burstcnt)
> +			return burstcnt;
> +
> +		tpm_mdelay(TPM_TIMEOUT);
> +	} while (tpm_now_ms() < stop);
> +
> +	return -EBUSY;
> +}
> +
> +static int __tis_wait_for_stat(struct tpm_chip *chip, u8 mask, ktime_t timeout)
> +{
> +	ktime_t stop;
> +	u8 status;
> +
> +	if ((__tis_status(chip) & mask) == mask)
> +		return 0;
> +
> +	stop = tpm_now_ms() + timeout;
> +	do {
> +		tpm_mdelay(TPM_TIMEOUT);
> +
> +		status = __tis_status(chip);
> +		if ((status & mask) == mask)
> +			return 0;
> +	} while (tpm_now_ms() < stop);
> +
> +	return -ETIME;
> +}
> +
> +static int __tis_recv_data(struct tpm_chip *chip, u8 *buf, int count)
> +{
> +	int size = 0;
> +	int burstcnt;
> +
> +	while (size < count && __tis_wait_for_stat(chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, chip->timeout_c) == 0) {
> +		burstcnt = __tis_get_burstcount(chip);
> +
> +		for ( ; burstcnt > 0 && size < count; --burstcnt)
> +			buf[size++] = tpm_read8(chip, TPM_DATA_FIFO(chip->locality));
> +	}
> +
> +	return size;
> +}
> +
> +/**
> + * tpm_tis_check_locality - Check if the given locality is the active one
> + * @chip:	The TPM chip instance
> + * @loc:	The locality to check
> + *
> + * Return: true - locality active, false - not active
> + */
> +bool tpm_tis_check_locality(struct tpm_chip *chip, int loc)
> +{
> +	if ((tpm_read8(chip, TPM_ACCESS(loc)) & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) == (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) {
> +		chip->locality = loc;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * tpm_tis_release_locality - Release the active locality
> + * @chip:	The TPM chip instance
> + */
> +void tpm_tis_release_locality(struct tpm_chip *chip)
> +{
> +	if ((tpm_read8(chip, TPM_ACCESS(chip->locality)) & (TPM_ACCESS_REQUEST_PENDING | TPM_ACCESS_VALID)) == (TPM_ACCESS_REQUEST_PENDING | TPM_ACCESS_VALID))
> +		tpm_write8(chip, TPM_ACCESS(chip->locality), TPM_ACCESS_RELINQUISH_LOCALITY);
> +
> +	chip->locality = 0;
> +}
> +
> +/**
> + * tpm_tis_request_locality - Request to make the given locality the active one
> + * @chip:	The TPM chip instance
> + * @loc:	The locality to make active/set as current
> + *
> + * Return:
> + *  >= 0 - Success, new active locality returned or locality already active
> + *  < 0  - Error occurred
> + */
> +int tpm_tis_request_locality(struct tpm_chip *chip, int loc)
> +{
> +	ktime_t stop;
> +
> +	if (tpm_tis_check_locality(chip, loc))
> +		return loc;
> +
> +	/* Set the new locality */
> +	tpm_write8(chip, TPM_ACCESS(loc), TPM_ACCESS_REQUEST_USE);
> +
> +	stop = tpm_now_ms() + chip->timeout_b;
> +	do {
> +		if (tpm_tis_check_locality(chip, loc))
> +			return loc;
> +
> +		tpm_mdelay(TPM_TIMEOUT);
> +	} while (tpm_now_ms() < stop);
> +
> +	return -1;
> +}
> +
> +/**
> + * tpm_tis_disable_interrupts - Disable interrupts for the TPM, use polling mode only
> + * @chip:	The TPM chip instance
> + */
> +void tpm_tis_disable_interrupts(struct tpm_chip *chip)
> +{
> +	u32 intmask;
> +
> +	intmask = tpm_read32(chip, TPM_INT_ENABLE(chip->locality));
> +	/* Disable everything to make sure it is in a consistent state */
> +	intmask &= ~(TPM_GLOBAL_INT_ENABLE | TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_STS_VALID_INT | TPM_INTF_DATA_AVAIL_INT);
> +	tpm_write32(chip, TPM_INT_ENABLE(chip->locality), intmask);
> +}
> +
> +/**
> + * tpm_tis_recv - Receive response data from TPM via TIS FIFO
> + * @chip:	The TPM chip instance
> + * @buf:	The response buffer
> + * @count:	Length of the response buffer
> + *
> + * Return:
> + *  = 0 - Success, no response data
> + *  > 0 - Success, value is the response data length
> + *  < 0 - Error occurred
> + */
> +static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, int count)
> +{
> +	int expected, status, size = 0, rc = -EIO;
> +
> +	if (count < TPM_HEADER_SIZE)
> +		goto out;
> +
> +	/* Read first 10 bytes, including tag, paramsize, and result */
> +	size = __tis_recv_data(chip, buf, TPM_HEADER_SIZE);
> +	if (size < TPM_HEADER_SIZE)
> +		goto out;
> +
> +	expected = be32_to_cpu(*((u32 *)(buf + 2)));
> +	if (expected > count)
> +		goto out;
> +
> +	size += __tis_recv_data(chip, &buf[TPM_HEADER_SIZE], expected - TPM_HEADER_SIZE);
> +	if (size < expected) {
> +		rc = -ETIME;
> +		goto out;
> +	}
> +
> +	__tis_wait_for_stat(chip, TPM_STS_VALID, chip->timeout_c);
> +
> +	status = __tis_status(chip);
> +	if (status & TPM_STS_DATA_AVAIL) {
> +		rc = -EIO;
> +		goto out;
> +	}
> +
> +	return size;
> +out:
> +	__tis_cancel(chip);
> +	tpm_tis_release_locality(chip);
> +	return rc;
> +}
> +
> +/**
> + * tpm_tis_send - Send command to TPM via TIS FIFO
> + * @chip:	The TPM chip instance
> + * @buf:	The command buffer
> + * @len:	Length of the command buffer to send
> + *
> + * Return:
> + *  = len - Success, all data sent
> + *  < 0	  - Error occurred
> + */
> +static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, int len)
> +{
> +	int status, burstcnt = 0;
> +	int count = 0;
> +	int rc = 0;
> +
> +	status = __tis_status(chip);
> +	if ((status & TPM_STS_COMMAND_READY) == 0) {
> +		__tis_cancel(chip);
> +		if (__tis_wait_for_stat(chip, TPM_STS_COMMAND_READY, chip->timeout_b) < 0) {
> +			rc = -ETIME;
> +			goto out_err;
> +		}
> +	}
> +
> +	while (count < len - 1) {
> +		burstcnt = __tis_get_burstcount(chip);
> +		for ( ; burstcnt > 0 && count < len - 1; --burstcnt)
> +			tpm_write8(chip, TPM_DATA_FIFO(chip->locality), buf[count++]);
> +
> +		__tis_wait_for_stat(chip, TPM_STS_VALID, chip->timeout_c);
> +		status = __tis_status(chip);
> +		if ((status & TPM_STS_DATA_EXPECT) == 0) {
> +			rc = -EIO;
> +			goto out_err;
> +		}
> +	}
> +
> +	/* Write last byte */
> +	tpm_write8(chip, TPM_DATA_FIFO(chip->locality), buf[count]);
> +	__tis_wait_for_stat(chip, TPM_STS_VALID, chip->timeout_c);
> +	status = __tis_status(chip);
> +	if ((status & TPM_STS_DATA_EXPECT) != 0) {
> +		rc = -EIO;
> +		goto out_err;
> +	}
> +
> +	/* Go and do it */
> +	tpm_write8(chip, TPM_STS(chip->locality), TPM_STS_GO);
> +
> +	return len;
> +
> +out_err:
> +	__tis_cancel(chip);
> +	tpm_tis_release_locality(chip);
> +	return rc;
> +}
> +
> +/**
> + * tpm_tis_transmit - Transmit a TPM FIFO command
> + * @chip:	The TPM chip instance
> + * @buf:	The request and response buffer object
> + * @bufsize:	Entire size available in buffer
> + *
> + * Return:
> + *  = 0 - Success, no returned data
> + *  > 0 - Success, value is the return data length
> + *  < 0 - Error occurred
> + */
> +static int tpm_tis_transmit(struct tpm_chip *chip, u8 *buf, u32 bufsize)
> +{
> +	ktime_t stop;
> +	u32 count;
> +	u8 status;
> +	int rc;
> +
> +	count = be32_to_cpu(*((u32 *) (buf + 2)));
> +	if (count == 0)
> +		return -ENODATA;
> +
> +	if (count > bufsize)
> +		return -E2BIG;
> +
> +	rc = tpm_tis_send(chip, buf, count);
> +	if (rc < 0)
> +		goto out;
> +
> +	stop = tpm_now_ms() + TIS_DURATION;
> +	do {
> +		status = __tis_status(chip);
> +		if ((status & (TPM_STS_DATA_AVAIL | TPM_STS_VALID)) == (TPM_STS_DATA_AVAIL | TPM_STS_VALID))
> +			goto out_recv;
> +
> +		if (status == TPM_STS_COMMAND_READY) {
> +			rc = -ECANCELED;
> +			goto out;
> +		}
> +
> +		tpm_mdelay(TPM_TIMEOUT);
> +		rmb();
> +	} while (tpm_now_ms() < stop);
> +
> +	/* Cancel the command */
> +	__tis_cancel(chip);
> +	rc = -ETIME;
> +	goto out;
> +
> +out_recv:
> +	rc = tpm_tis_recv(chip, buf, bufsize);
> +	if (rc >= 0) {
> +		if (rc > 0 && rc < TPM_HEADER_SIZE)
> +			return -EFAULT;
> +		return rc;
> +	}
> +	/* Else return was an error, nothing to receive */
> +
> +out:
> +	return rc;
> +}
> +
> +/**
> + * tpm_find_interface_and_family - interface FIFO/CRB, family 2.0 or 1.2
> + * @chip:	The TPM chip instance
> + *
> + * Return: TPM family ID enum
> + */
> +static enum tpm_family tpm_find_interface_and_family(struct tpm_chip *chip)
> +{
> +	struct tpm_intf_capability intf_cap;
> +	struct tpm_interface_id intf_id;
> +
> +	/* Sort out whether it is 1.x */
> +	intf_cap.val = tpm_read32(chip, TPM_INTF_CAPS(0));
> +	if ((intf_cap.interface_version == TPM_TIS_INTF_12) ||
> +	    (intf_cap.interface_version == TPM_TIS_INTF_13))
> +		return TPM_FAMILY_12; /* Always TIS */
> +
> +	/* Assume that it is 2.0 but check if the interface is CRB */
> +	intf_id.val = tpm_read32(chip, TPM_INTF_ID(0));
> +	if (intf_id.interface_type == TPM_CRB_INTF_ACTIVE)
> +		return TPM_FAMILY_INVALID;
> +
> +	/* Else TPM 2.0 with TIS interface */
> +	return TPM_FAMILY_20;
> +}
> +
> +/**
> + * tpm1_pcr_extend - send a TPM1 extend command to the device
> + * @chip:	a TPM chip to use
> + * @pcr_idx:	the PCR index to extend for the current locality
> + * @hash:	the SHA1 hash digest to extend
> + *
> + * Return:
> + * * 0		- OK
> + * * -errno	- A system error
> + * * TPM_RC	- A TPM error
> + */
> +int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
> +{
> +	int rc = 0;
> +	struct tpm_buf *buf = tpm_buf_alloc_page();
> +
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	tpm_buf_init(buf, TPM_BUFSIZE);
> +	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
> +
> +	tpm_buf_append_u32(buf, pcr_idx);
> +	tpm_buf_append(buf, hash, TPM_DIGEST_SIZE);
> +
> +	rc = tpm_tis_transmit(chip, buf->data, PAGE_SIZE);
> +
> +	/* Ignoring output */
> +	if (rc > 0)
> +		rc = 0;
> +
> +	tpm_buf_free_page();
> +
> +	return rc;
> +}
> +
> +/**
> + * tpm2_pcr_extend() - send a TPM2 extend command to the device
> + *
> + * @chip:		TPM chip to use.
> + * @pcr_idx:		index of the PCR.
> + * @digests:		list of PCR banks and corresponding digest values to extend.
> + * @digest_count:	count of digests to extend
> + *
> + * Return:
> + * * 0		- OK
> + * * -errno	- A system error
> + * * TPM_RC	- A TPM error
> + */
> +int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> +		    struct tpm_digest *digests, u32 digest_count)
> +{
> +	struct tpm_buf *buf = tpm_buf_alloc_page();
> +	int rc = 0, i;
> +
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	tpm_buf_init(buf, TPM_BUFSIZE);
> +	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> +
> +	tpm_buf_append_handle(buf, pcr_idx);
> +
> +	/* Setup a NULL auth session for the command */
> +	tpm_buf_append_u32(buf, 9);
> +	/* auth handle */
> +	tpm_buf_append_u32(buf, TPM2_RS_PW);
> +	/* nonce */
> +	tpm_buf_append_u16(buf, 0);
> +	/* attributes */
> +	tpm_buf_append_u8(buf, 0);
> +	/* passphrase */
> +	tpm_buf_append_u16(buf, 0);
> +
> +	tpm_buf_append_u32(buf, digest_count);
> +
> +	for (i = 0; i < digest_count; i++) {
> +		tpm_buf_append_u16(buf, digests[i].alg_id);
> +		tpm_buf_append(buf, (const unsigned char *)&digests[i].digest,
> +			       tpm_get_alg_size(digests[i].alg_id));
> +	}
> +
> +	rc = tpm_tis_transmit(chip, buf->data, PAGE_SIZE);
> +
> +	/* Ignoring output */
> +	if (rc > 0)
> +		rc = 0;
> +
> +	tpm_buf_free_page();
> +
> +	return rc;
> +}
> +
> +int early_tpm_init(struct tpm_chip *chip, u64 baseaddr)
> +{
> +	u32 didvid;
> +
> +	memset(chip, 0, sizeof(*chip));
> +	chip->baseaddr = baseaddr;
> +
> +	chip->family = tpm_find_interface_and_family(chip);
> +	if (chip->family == TPM_FAMILY_INVALID)
> +		return TPM_ERR_INVALID_FAMILY;
> +
> +	/* Set default timeouts */
> +	chip->timeout_a = TIS_SHORT_TIMEOUT;
> +	chip->timeout_b = TIS_LONG_TIMEOUT;
> +	chip->timeout_c = TIS_SHORT_TIMEOUT;
> +	chip->timeout_d = TIS_SHORT_TIMEOUT;
> +
> +	/* Get the vendor and device ids */
> +	didvid = tpm_read32(chip, TPM_DID_VID(0));
> +	chip->did = didvid >> 16;
> +	chip->vid = didvid & 0xFFFF;
> +
> +	return TPM_SUCCESS;
> +}
> +
> +int early_tpm_fini(struct tpm_chip *chip)
> +{
> +	tpm_tis_release_locality(chip);
> +	memset(chip, 0, sizeof(*chip));
> +
> +	return TPM_SUCCESS;
> +}
> diff --git a/arch/x86/boot/compressed/tpm.h b/arch/x86/boot/compressed/tpm.h
> new file mode 100644
> index 000000000000..6986593e0100
> --- /dev/null
> +++ b/arch/x86/boot/compressed/tpm.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef BOOT_COMPRESSED_TPM_H
> +#define BOOT_COMPRESSED_TPM_H
> +
> +enum early_tis_defaults {
> +	TIS_MEM_X86_LPC_BASE	= 0xFED40000,
> +	TIS_MEM_X86_LEN		= 0x5000,
> +	TPM_TIMEOUT		= 5, /* ms */
> +	TIS_DURATION		= 120000, /* 120 secs in ms */
> +};
> +
> +enum tpm_family {
> +	TPM_FAMILY_INVALID	= 0,
> +	TPM_FAMILY_12		= 1,
> +	TPM_FAMILY_20		= 2
> +};
> +
> +struct tpm_chip {
> +	enum tpm_family family;
> +	u64 baseaddr;
> +	int locality;
> +	int did;
> +	int vid;
> +
> +	/* in ms */
> +	ktime_t timeout_a;
> +	ktime_t timeout_b;
> +	ktime_t timeout_c;
> +	ktime_t timeout_d;
> +};
> +
> +bool tpm_tis_check_locality(struct tpm_chip *chip, int loc);
> +void tpm_tis_release_locality(struct tpm_chip *chip);
> +int tpm_tis_request_locality(struct tpm_chip *chip, int loc);
> +void tpm_tis_disable_interrupts(struct tpm_chip *chip);
> +int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
> +int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> +		    struct tpm_digest *digests, u32 digest_count);
> +int early_tpm_init(struct tpm_chip *chip, u64 baseaddr);
> +int early_tpm_fini(struct tpm_chip *chip);
> +
> +#endif /* BOOT_COMPRESSED_TPM_H */
> -- 
> 2.43.7
> 

BR, Jarkko

